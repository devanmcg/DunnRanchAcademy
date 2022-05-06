pacman::p_load(tidyverse, lubridate)

D = 1   # Distance between thermocouples (m)

ROS <- 
  HeatingCurves %>%
  group_by(logger, event, TC) %>%
  slice(which.max(degC)) %>%
  ungroup() %>%
  mutate(timestamp = as.POSIXct(timestamp), 
         date = format(timestamp, '%d %b'), 
         time = format(timestamp, '%H:%M:%S')) %>%
  filter(TC %in% c('1', '2', '3')) %>%
  mutate(timestamp = format(timestamp, "%H:%M:%S"), 
         ArrivalTime = seconds(hms(timestamp)) ) %>%
  select(date, logger, ArrivalTime) %>%
  group_by(date, logger) %>%
  arrange(ArrivalTime, .by_group = TRUE) %>% 
  mutate(position = order(order(ArrivalTime, decreasing=FALSE)), 
         position = recode(position, "1"="a", "2"="b", "3"="c"), 
         ArrivalTime = as.numeric(ArrivalTime) /60 ) %>%
  spread(position, ArrivalTime)  %>%
  ungroup %>% 
  mutate( theta_rad = atan((2*c - b - a) / (sqrt(3)*(b - a))), 
          ros = case_when(
            a == b ~ (sqrt(3) / 2) / (c - a) , 
            a != b ~  (D*cos(theta_rad) / (b - a) ) 
          )) %>%
  select(-a, -b, -c, -theta_rad)


PeakTemps <- 
  HeatingCurves %>%
    group_by(logger, TC, event) %>%
    slice(which.max(degC)) %>%
    ungroup() %>%
    mutate(timestamp = as.POSIXct(timestamp), 
           date = format(timestamp, '%d %b'), 
           time = format(timestamp, '%H:%M:%S'), 
           time = seconds(hms(time)) ) %>%
    group_by(date, logger) %>%
    mutate(time = min(time), 
           time = hms::as_hms(time),
           level = case_when(
      TC %in% c('1', '2', '3') ~ 'flame', 
      TC %in% c('4', '5', '6') ~ 'surface'
    )) %>%
    group_by(date, logger, time, level) %>%
    summarize(TempMean = mean(degC), 
              TempSE = sd(degC) / sqrt(n()), 
              .groups = 'drop') 

FireBehavior2022 <- lst(PeakTemps, ROS)
# save(FireBehavior2022, file = './data/FireBehavior2022.Rdata')

  
  
