pacman::p_load(tidyverse, gridExtra, cowplot)
pacman::p_load_gh('devanmcg/wesanderson')

load('./data/FireBehavior2022.Rdata')


# Temperature data 

temps_gg <-
  FireBehavior2022$PeakTemps %>%
    mutate(logger = as.factor(logger)) %>% 
    ggplot(aes(x = level, 
               color = logger)) + theme_bw(14) +
    geom_errorbar(aes(ymin = TempMean - TempSE, 
                      ymax = TempMean + TempSE), 
                  position = position_dodge(0.2), 
                  width = 0.2, 
                  lwd = 1) +
    geom_point(aes(y = TempMean, 
                   fill = logger, 
                   shape = logger), 
               color = 'grey40', 
               size = 3,
               stroke = 1.5,
               position = position_dodge(0.2)) +
    scale_shape_manual(values = c(21, 24, 22), 
                       guide = 'none') + 
    scale_fill_manual(values = wes_palette('Zissou1')[c(1,4,5)], 
                      guide = 'none') +
    scale_color_manual(values = wes_palette('Zissou1')[c(1,4,5)], 
                       guide = 'none') +
    labs(x = "Thermocouple level", 
         y = "Degrees C\n(mean +/- S.E.)", 
         title = "Maximum temperatures") + 
    facet_wrap(~date) +
    theme(axis.text.x = element_text(color = "black"))
  
ros_gg <- 
  FireBehavior2022$ROS %>%
    mutate(logger = as.factor(logger)) %>%
    ggplot() + theme_bw(14) + 
    geom_point(aes(x = date, 
                   y = ros, 
                   fill = logger, 
                   shape = logger), 
               color = 'grey40', 
               size = 3,
               stroke = 1.5,
               position = position_dodge(0.2)) +
    scale_shape_manual(values = c(21, 24, 22), 
                       guide = 'none') + 
    scale_fill_manual(values = wes_palette('Zissou1')[c(1,4,5)], 
                      guide = 'none') +
    labs(x = "Burn date", 
         y = "Rate of spread\n(m/min)", 
         title = "Rate of spread") + 
    theme(axis.text.x = element_text(color = "black"))

  
cowplot::plot_grid(temps_gg, ros_gg, 
                  nrow = 1, 
                  rel_widths= c(0.6, 0.4))
  