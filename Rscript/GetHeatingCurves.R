pacman::p_load(tidyverse)

FilePath = 'S:/FireScience/ThermocoupleRawData/March_data/workshop2022/'
MinTemp = '40'
ExcludeColumns = c("logger", "timestamp")


  tc_files <- list.files(FilePath)

  # Add R object for results to global environment 
  HeatingCurves <- tibble() 
  
    for(i in 1:length(tc_files)){ # loop through files (main work loop)
      # get i-th file from the file path
      message(paste0("Loading file ", tc_files[i]), '...')
        rd1 <- 
          paste0(FilePath, tc_files[i]) %>%
          read_csv(col_names = FALSE, show_col_types = FALSE)
      message(paste0("...file ", tc_files[i], ' loaded.'))
      # Prepare data for pivoting
        tcs <- dim(rd1)[2] - length(ExcludeColumns)
        colnames(rd1) <- c(ExcludeColumns, seq(1, tcs, 1))
      # Pivot logger data into long format
      rd <-
        rd1 %>%
          pivot_longer(values_to = 'degC', 
                       names_to = 'TC', 
                       -paste(ExcludeColumns)) %>%
            group_by(TC) %>%
            mutate(obs = seq(1, n(), 1)) %>%
            ungroup() 
  #
  # Allow user to select channels to input
  #
    # Show all channels 
    #x11() 
   dl_plot <-
      rd %>%
        group_by(TC) %>%
        slice( which(row_number() %% 10 == 1)) %>%
        ggplot() + theme_bw(14) + 
          geom_line(aes(x = obs, 
                        y = degC)) + 
        labs(title = paste0("Logger ", unique(rd$logger))) + 
          facet_wrap(~TC, scales = "free_y")
    print(dl_plot)
    # Prompt channel selection 
      channels <- readline(prompt = message("Select channels to import (see graphics device) by entering numbers of desired channels separated by commas, or...\n Enter: select all channels\n 0: None (and skip to next file)\n Q: quit (then select Cancel to avoid closing R altogether)")) # \nTo *exclude* certain channels, precede channel number with negative sign (-)."))
      
      if(channels == "Q") { 
        quit(save = 'ask') 
        } else {
      if(channels == "") { 
          selections <- unique(rd$TC) 
          } else {
           selections <- ifelse(channels %in% c('0', 'O'), 'NULL', channels) 
           selections <- unlist(strsplit(selections, ",")) %>% 
                                  trimws()  
                 } 
               }

       # message(Directions) # Give the directions via the console for each file
    if(selections != "NULL") {
     for(j in 1:length(selections)) { # loop through multi-channel data on logger file
       tc = as.numeric(selections[j] ) 
        rd_j <- filter(rd, TC == unique(rd$TC)[tc])
      # User interaction section. 
      # Open external window
        x11(width=16, height=6)
      plot(degC ~ obs, 
           data = rd_j %>% filter(degC < 1000) %>% slice( which(row_number() %% 5 == 1)) ,  
           type = 'l', las = 1, 
           main = paste0('Logger ', unique(rd_j$logger),', sensor ', unique(rd_j$TC)) )  
      pts <- identify(rd_j$obs,
                      rd_j$degC, 
                      labels = "^", 
                      col = "red") ; dev.off() 
      # perform check on incorrect/empty input
      if(FSA::is.odd(length(pts)) || length(pts) == 0) {
        
        oops <- readline(prompt = message("Looks like that didn't go right.\nWant to try that channel again?\n 1: Yes, re-do that channel\n 0: No, skip to next channel\n Q: quit (then select Cancel to avoid closing R altogether)") ) 
        
        if(oops == "Q") { 
          quit(save = 'ask') 
        } else{
          if(oops == "1") { 
          # Allow user to re-do a channel 
          x11()
          plot(degC ~ obs, 
               rd_j,  
               type = 'l', las = 1, 
               main = paste0('Logger ', unique(rd_j$logger),', sensor ', unique(rd_j$TC)) ) 
          pts <- identify(rd$obs, 
                          rd$degC, 
                          labels = "^", 
                          col = "red") ; dev.off() 
        } else{ next }# skip to next channel 
      } # close non-Q oops handling
        } # close check on incorrect/empty input
      
      # Proceed with processing logger data 
      # process user-defined events
      # identify beginning and end points of rough windows
      events <- 
        pts %>%
        as_tibble(rownames = "click") %>%
        rename(obs = value) %>%
        mutate( click = as.numeric(click), 
                rough_endpt = ifelse(FSA::is.odd(click), "start", "stop"), 
                logger = unique(rd_j$logger), 
                tc = unique(rd_j$TC)) %>%
        group_by(rough_endpt) %>%
        mutate(event = seq(1:n())) %>%
        ungroup() %>%
        select(-click) 
      
      rough_windows <- tibble()
      for(e in 1:length(unique(events$event))) { # Loop through fire events on channel
        event = filter(events, event == e) 
        filter(rd_j, between(obs, event$obs[1], event$obs[2])) %>%
          mutate(logger = unique(rd_j$logger),
                 event = e) %>%
          select(logger, TC, event,obs, timestamp, degC) %>%
          bind_rows(rough_windows) -> rough_windows
      } # close events loop
      
      rough_windows <- filter(rough_windows, degC >= MinTemp) 
      
      # rough_windows %>%
      #   ggplot() + theme_bw(14) +
      #   geom_line(aes(x = obs, y = degC)) +
      #   facet_wrap(~event, scales = 'free_x') +
      #   labs(title = paste0('Logger ', unique(rd_j$logger),', sensor ', unique(rd_j$TC)), 
      #        subtitle = "User-identified rough windows of flame front passage")
      
      maxes <- 
        rough_windows %>%
        group_by(event, obs) %>%
        summarize(Max = max(degC), 
                  .groups = 'drop_last') %>%
        slice(which.max(Max)) %>%
        ungroup() 
      hc <- tibble() 
      for(e in 1:max(maxes$event)) { # loop through events, take out max C rows
        m = filter(maxes, event == e)$obs
        rough_windows %>%
          filter(event == e ,  
                 obs <= m) %>%
             bind_rows(hc) -> hc
      } # close max loop
     HeatingCurves <- bind_rows(HeatingCurves, hc)
    } # close multi-channel loop
      message("Finished with that file.")
      } # closes main work loop 
      # return(HeatingCurves)
  } # closes ExcludeCOlumns check

 
# save(HeatingCurves, file = './data/HeatingCurves.Rdata') 


