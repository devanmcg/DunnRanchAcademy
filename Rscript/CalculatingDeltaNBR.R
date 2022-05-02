pacman::p_load(tidyverse, sf, stars)
source('https://raw.githubusercontent.com/devanmcg/rangeR/master/R/CustomGGplotThemes.R')
load('./data/SpatialData/landsat_crs.Rdata')

# Study location polygons
  bbox <- read_sf('./data/SpatialData/BoundingBox', 
                  'DunnRanchBB') %>%
    st_transform(landsat_crs)

# Landsat imagery

  imagery_dir = 'S:/DevanMcG/GIS/SpatialData/DunnRanch'
  dr_nbr <- list.files(imagery_dir, '*_NBR.tif') # Just NBR products

  post_fire_2022_03_26 <- read_stars(paste0(imagery_dir, '/', dr_nbr[1]) ) %>%
                            st_crop(bbox)
  pre_fire_2022_03_01 <- read_stars(paste0(imagery_dir, '/', dr_nbr[2]) ) %>%
                          st_crop(bbox)

  dNBR = pre_fire_2022_03_01 - post_fire_2022_03_26 
  write_stars(dNBR, './data/SpatialData/DunnRanch_dNBR_2022.tiff')
  
  write_stars(post_fire_2022_03_26, './data/SpatialData/DunnRanch_post_2022.tiff')
  write_stars(pre_fire_2022_03_01, './data/SpatialData/DunnRanch_pre_2022.tiff')



    ggplot() + theme_bw() + 
    geom_stars(data = dNBR) +
    scale_fill_viridis_c("NBR")
    
