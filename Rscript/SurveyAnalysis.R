---
title: "AAR: Fire Science Methods Workshop"
subtitle: 'aka Dunn Ranch Academy aka Nerd TREX'
author: DAM
date: "`r Sys.Date()`"
output:
  html_document:
  keep_md: false
toc: false
toc_float: false
theme: united
highlight: tango
---
  

```{r setup, include=FALSE, message=FALSE, warning=FALSE}
knitr::opts_chunk$set(echo = FALSE, message=FALSE, warning=FALSE)
pacman::p_load(tidyverse)
pacman::p_load_gh('devanmcg/wesanderson')
```

```{r data_wrangling}
raw_data <- 
  readxl::read_xlsx('../data/EvaluationResponses.xlsx', 
                    'AllData') %>%
    select(-Progress, -Duration, -Finished) 

questions <- 
  raw_data %>%
  slice(1) 

responses <- 
  raw_data %>%
  slice(-1) 

shorts <- readxl::read_xlsx('../data/EvaluationResponses.xlsx', 
                  'ShortResponses')

joined_data <- 
  full_join(
    questions %>%
      select(-ResponseId) %>%
      t() %>%
      as.data.frame() %>%
      rownames_to_column() %>%
      as_tibble() %>%
      set_names( c("Code", "Prompt")) %>%
      separate(Code, into = c('Category', "Question"), remove = F) , 
    responses %>%
      column_to_rownames("ResponseId") %>%
      t() %>%
      as.data.frame() %>%
      rownames_to_column("Code") %>%
      as_tibble() , 
        by = "Code") %>%
    pivot_longer(names_to = "respondent", 
                 values_to = "response", 
                 cols = c(R_2qkfkU8937VXLDD:R_sGwJKv06to27bd7)) %>%
  mutate(type = case_when(
    Code %in% c('1.6', '2.6', '3.5', '3.6', '6.7') ~ "text", 
    Category %in% c('4', '5') ~ "text", 
    Code %in% c('3.1', '3.2') ~ "choices",
    TRUE ~ 'likert'
  )) 
```

```{r likert_gg}

  joined_data %>%
   filter(type == 'likert') %>%
    full_join(select(shorts, -Prompt), by = "Code") %>%
    filter(response != is.na(.)) %>%
    group_by(Category, Question, Code, ShortPrompt, response) %>%
    summarize(count = n(), 
              .groups = 'drop') %>%
    mutate(response = recode(response,
                        'Strongly disagree' = '-2',
                        'Disagree' = '-1', 
                        'Neither agree nor disagree' = '0', 
                        'Agree' = '1', 
                        'Strongly agree' = '2', 
                        'Not applicable' = '3', 
                        "Don't know" = '4' ), 
           Category = factor(Category, levels = c('1', '2', '3', '6')), 
           Category = recode(Category, 
                             '1' = 'Planning' , 
                             '2' = 'Leadership', 
                             '3' = 'Obstacles', 
                             '6' = 'Workshop assessment')) %>%
    filter(!response %in% c('3', '4')) %>% 
    mutate(response = factor(response, levels = c('-2', '-1', '0', '1', '2'))) %>%
    ggplot() + theme_bw(16) + 
      geom_vline(xintercept = 0, lty = 3, color = "darkgrey") + 
      geom_point(aes(x = response, 
                     y = ShortPrompt, 
                     size = count, 
                     fill = response), 
                 pch = 21, 
                 color = 'black', 
                 stroke = 1.25) + 
    facet_wrap(~Category, scales = "free_y", ncol = 1) +
    scale_fill_manual(values = wes_palette("Zissou1"), guide = "none") +
    scale_alpha_continuous(guide = 'none') + 
    scale_size_continuous(range = c(3, 8), guide = 'none') + 
    scale_y_discrete(limits=rev) +
    labs(y = ' ', x = ' ') +
    scale_x_discrete(breaks = c('-2', '-1', '0', '1', '2'), 
            labels = c("Strongly\ndisagree", 'Disagree', 'Neutral', 'Agree', 'Strongly\nagree')) +
    theme(axis.text = element_text(color = 'black'), 
          panel.grid.major.x = element_blank())
  
```

```{r obstacles_gg}
  joined_data %>%
    filter(type == 'choices') %>%
    left_join(select(shorts, -Prompt), by = "Code") %>%
    separate_rows(response, sep = ',') %>%
    mutate(response = trimws(response)) %>% 
    filter(response != 'etc)') %>%
    group_by(Category, Question, Code, ShortPrompt, response) %>%
    summarize(count = n(), 
              .groups = 'drop') %>%
    mutate(Category = factor(Category, levels = c('1', '2', '3', '6')), 
           Category = recode(Category, 
                             '1' = 'Planning' , 
                             '2' = 'Leadership', 
                             '3' = 'Obstacles', 
                             '6' = 'Workshop assessment')) %>%
    ggplot() + theme_bw(16) + 
    geom_bar(aes(x = reorder(response, count, min), 
                   y = count, 
                 fill = ShortPrompt), 
             stat = 'identity') + 
    facet_wrap(~ShortPrompt, scales = "free_y", ncol = 1) +
    coord_flip() + 
    labs(y = ' ', x = ' ') +
    scale_fill_manual(values = wes_palette("Zissou1")[c(1,2)], guide = "none") +
    theme(axis.text = element_text(color = 'black'), 
          panel.grid.major.y = element_blank())
```
  
