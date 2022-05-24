pacman::p_load(tidyverse, sf, stars)
pacman::p_load_gh('devanmcg/wesanderson')
source('https://raw.githubusercontent.com/devanmcg/rangeR/master/R/CustomGGplotThemes.R')
load('./data/SpatialData/landsat_crs.Rdata')

burns <- read_sf('./data/SpatialData/BurnUnits', 
                 'DunnRanchBurnUnits') %>%
          st_transform(landsat_crs)

# # Convert stars to sf and combine 

dNBR <- 
bind_rows(
  read_stars('./data/SpatialData/DunnRanch_pre_2022.tiff') %>%
            st_crop(burns) %>%
    setNames('signal') %>%
    st_as_sf() %>%
    st_intersection(burns) %>%
    select(-id) %>%
    mutate(period = 'pre'), 
  read_stars('./data/SpatialData/DunnRanch_post_2022.tiff') %>%
            st_crop(burns) %>%
    setNames('signal') %>%
    st_as_sf() %>%
    st_intersection(burns) %>%
    select(-id) %>%
    mutate(period = 'post') , 
  read_stars('./data/SpatialData/DunnRanch_dNBR_2022.tiff') %>%
            st_crop(burns) %>%
    setNames('signal') %>%
    st_as_sf() %>%
    st_intersection(burns) %>%
    select(-id) %>%
    mutate(period = 'delta')
) 
  
  # save(dNBR, file = './data/dNBR.Rdata')

bi_nbr_gg <- 
  dNBR %>%
    filter(Unit == "Bison", 
           period != "delta") %>%
  mutate(period = recode(period, 
                         "pre" = "Pre-burn", 
                         "post" = "Post-burn")) %>%
    ggplot() + theme_map() +
    geom_sf(aes(fill = signal), 
            color = 'NA') +
    facet_wrap(~period) +
    scale_fill_viridis_c("NBR") +
  theme(plot.margin = unit(c(0,0,0,0), "lines"), 
        strip.text = element_text(size = 12)) 
bb
bi_dnbr_gg <- 
  dNBR %>%
    filter(Unit == "Bison", 
           period == "delta") %>%
  mutate(period = recode(period, 
                         "delta" = "Severity")) %>%
    ggplot() + theme_map() +
    geom_sf(aes(fill = signal), 
            color = 'NA') +
  facet_wrap(~period) +
    scale_fill_gradientn("Change\n(dNBR)", colors = wes_palette(name = "Zissou1", type = "continuous"))  +
  theme(plot.margin = unit(c(0,0,0,0), "lines"), 
        strip.text = element_text(size = 12))  

gb_nbr_gg <- 
  dNBR %>%
  filter(Unit != "Bison", 
         period != "delta") %>%
  mutate(period = recode(period, 
                         "pre" = "Pre-burn", 
                         "post" = "Post-burn")) %>%
  ggplot() + theme_map() +
  geom_sf(aes(fill = signal), 
          color = 'NA') +
  geom_sf(data = burns %>% 
            filter(Unit != "Bison"), 
          fill = NA, 
          size = 1) +
  facet_wrap(~period) +
  scale_fill_viridis_c("Normalized\nBurn\nRatio") +
  theme(plot.margin = unit(c(0,0,0,0), "lines"), 
        strip.text = element_text(size = 12)) 

gb_dnbr_gg <- 
  dNBR %>%
  filter(Unit != "Bison", 
         period == "delta", 
         Burned == 'Y') %>%
  mutate(period = recode(period, 
                         "delta" = "Severity")) %>%
  ggplot() + theme_map() +
  geom_sf(data = burns %>% 
            filter(Unit != "Bison"), 
          fill = NA, 
          size = 1) +
  geom_sf(aes(fill = signal), 
          color = 'NA') +
    facet_wrap(~period) +
  scale_fill_gradientn("Change\n(dNBR)", colors = wes_palette(name = "Zissou1", type = "continuous")) +
    theme(plot.margin = unit(c(0,0,0,0), "lines"), 
          strip.text = element_text(size = 12)) 


nbr <- ggpubr::ggarrange(gb_nbr_gg, 
                          bi_nbr_gg, 
                          nrow = 2,
                          common.legend = TRUE, 
                          legend = 'left')

dnbr <- ggpubr::ggarrange(gb_dnbr_gg, 
                         bi_dnbr_gg, 
                         nrow = 2,
                         common.legend = TRUE, 
                         legend = 'right')

cowplot::plot_grid(nbr, dnbr, 
                   nrow = 1, 
                   rel_widths = c(2,1)) 