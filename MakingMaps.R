pacman::p_load(tidyverse, sf, geonames, 
               grid, gridExtra)
source('https://raw.githubusercontent.com/devanmcg/rangeR/master/R/CustomGGplotThemes.R')

epa <- read_sf('S:/DevanMcG/GIS/SpatialData/US/EPAecoregions/L3', 
               'us_eco_l3_state_boundaries')
aea <- st_crs(epa)

load('C:/Users/devan.mcgranahan/GithubProjects/GreatPlainsFire/gis/Robjects/us_sf.Rdata')
us_sf <- us_sf %>%
  st_transform(aea) %>%
  st_simplify()

us_states <- 
  epa %>%
  select(STATE_NAME) %>%
  mutate(area = st_area(.)) %>%
  group_by(STATE_NAME) %>%
  summarize(area = sum(area)) %>%
  ungroup() %>%
  select(-area)  %>%
  st_simplify()

mo <- filter(us_states, STATE_NAME == "Missouri")

drp <- read_sf('./data/SpatialData/TNC', 
               'Dunn_Ranch_boundary')  %>%
        st_transform(aea)

mo_roads <- read_sf('S:/DevanMcG/GIS/SpatialData/US/USGS/roads', 
                 'roadtrl010g') %>%
            st_transform(aea) %>%
            st_intersection(mo)
  

# Find map points 
pacman::p_load(geonames)
options(geonamesUsername="devanmcg")

points <- tibble(feature=c("town", "town", "town", "town", "capital", "city", "city"),
                 name=c("Eagleville", "Bethany", "Grant City", "Hatfield", "Springfield", "Kansas City", "St Louis"), 
                 state=c("MO")) 
map_points <- 
  points %>%
  split(.$name) %>%
  purrr::map( ~ GNsearch(name_equals = .x$name, 
                         country = "US", 
                         adminCode1=.x$state, 
                         featureClass="P")) %>%
  map_dfr(~ (.))  %>%
  full_join(points) %>%
  mutate(state = adminName1, 
         long=as.numeric(lng), 
         lat = as.numeric(lat)) %>%
  select(feature, name, state, long, lat) %>%
  st_as_sf(coords = c('long', 'lat'), 
           crs = 4326) %>%
  st_transform(aea) 

map_points <- 
  map_points %>%
    slice(-2) %>%
    filter(!is.na(feature)) 

  mo_roads %>%
  filter(st_intersects(., 
                       map_points %>%
                         filter(feature == "town") %>%
                         st_union()  %>%  
                         st_cast('POLYGON') %>%
                         st_buffer(5000), 
                       sparse = FALSE ) ) %>%
st_write('./data/SpatialData/area/roads.shp')
  
 area_roads <- read_sf('./data/SpatialData/area', 
               'roads')

mapping <- lst(us = us_states %>% st_simplify(), 
               pts = map_points, 
               mo = mo,
               roads = area_roads,
               drp = drp)
# save(mapping, file = './paper/figures/mapping.Rdata')



 
# Make maps

load('./paper/figures/mapping.Rdata')

region_map <-
  ggplot() + theme_map(14)  +
  geom_sf(data = mapping$us, 
          fill = 'grey90', 
          color = NA) + 
  # geom_sf(data = mapping$gp_l1, 
  #         fill = 'lightblue') +
  geom_sf(data = mapping$mo,
          fill = 'lightblue', 
          color = "darkgrey") +
  geom_sf(data = mapping$us, 
          fill = NA, 
          color = "grey50") +
  geom_sf(data = mapping$drp %>% st_union() %>% st_centroid() , 
          shape = 23, 
          fill = "darkblue", 
          col = "white", 
          stroke = 1.2
          ) +
  geom_segment(aes(x = 159690 - 500000,
                     y = 1943588 - 500000,
                     xend = 159100, yend = 1943100 ), 
               size = 1.5, 
               color = "darkblue",
               arrow = arrow(length = unit(5, "mm")) )


local_map <-
  ggplot() + theme_map(14)  +
  # geom_sf(data = mapping$mo,
  #         fill = 'lightblue', 
  #         color = "darkgrey") + 
  geom_sf(data = mapping$drp, 
          fill = "lightgreen", 
          col = "darkgreen", 
          size = 1.25) +
    geom_sf(data = mapping$roads, 
            aes(size = PRE_TYPE),
            show.legend = FALSE) +
    scale_size_manual(values = c(1.5,0.5, 1)) +
  geom_sf(data = mapping$pts %>% filter(feature == 'town'), 
         shape = 21, 
          size = 3,
         stroke = 2,
          fill = "white", 
         col = "darkred", 
          show.legend = FALSE) +
  geom_sf_text(data = mapping$pts  %>% filter(feature == 'town'),
               aes(label = name),
               nudge_y = c(1000, -2000, 1500, 2000),
               nudge_x = c(-4500, -4500, 5500, -000), 
               color = "darkred", 
               size = 5, 
               fontface = "bold", 
               show.legend = FALSE) +
    geom_sf_label(data =mapping$roads,
                 aes(label = NAME),
                 nudge_y = c(1000, -4000, -000, 15000, 1000),
                 nudge_x = c(-3000, 0, -5000, 3000, 1000),
                 show.legend = FALSE) +
    geom_errorbarh(aes(
                        xmin = 166215.6-20000, 
                        xmax = 166215.6-10000, 
                        y =  1918765+12000), 
                 height = 2000, 
                 size = 1, 
                 color = "grey60") +
    geom_text(aes(x = 166215.6-15000, 
                  y =  1918765+14000), 
              label = "10 km (6.2 mi)", 
              color = "grey60")
  
  
  
v1<-viewport(width = 1, height = 1, x = 0.5, y = 0.5) #plot area for the main map
v2<-viewport(width = 0.45, height = 0.45, x = 0.25, y = 0.15) #plot area for the inset map
print(local_map,vp=v1) 
print(region_map,vp=v2)



ggplot() + theme_bw(14) +
  geom_sf(data = us_sf) + 
  theme(plot.margin = unit(c(0,0,0,0), "lines"), 
        strip.text = element_text(size = 12))
  