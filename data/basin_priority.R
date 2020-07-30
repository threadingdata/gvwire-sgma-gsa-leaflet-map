# Scrape 2019 Process Document
library(tidyverse)
library(tabulizer)

`%nin%` <- Negate(`%in%`)

sgma_doc <- 'sgma_bp_process_document.pdf'
df <- tabulizer::extract_tables(sgma_doc, pages = 53:78)

basin_priority <- df %>% 
  map(~ .x %>% data.frame) %>% 
  bind_rows %>%
  filter(X4 %nin% c('Area', '(Square', 'Miles)')) %>% 
  set_names(c('sub_basin_number', 'sub_basin_name', 'acres', 
              'sq_miles', 'priority', 'phase')) %>%
  mutate(acres = str_remove(acres, ',') %>% as.numeric,
         sq_miles = str_remove(sq_miles, ',') %>% as.numeric)

#basin_priority %>% 
#  write_csv('basin_priorities.csv')
