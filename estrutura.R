library(microdatasus)
library(tidyverse)

cadger <- cadger %>% 
            mutate(CNES = as.factor(CNES))

cnes_es <- fetch_datasus(year_start = 2021, year_end = 2021, month_start = 7, month_end = 7, uf = "ES",
                      information_system = "CNES-ST") %>% 
                      left_join(cadger, by = "CNES")

