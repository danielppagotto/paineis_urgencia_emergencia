library(microdatasus)
library(tidyverse)
library(arrow)


estabelecimentos_es <- read_parquet("parquet_cadger.parquet")

estabelecimentos_es <- read_delim("estabelecimentos_es.csv", 
                                  ";", escape_double = FALSE, trim_ws = TRUE) %>% 
                       mutate(CNES = as.factor(CNES))

cnes_es <- fetch_datasus(year_start = 2021, year_end = 2021, month_start = 7, month_end = 7, uf = "ES",
                      information_system = "CNES-ST") %>% janitor::clean_names()

cnes_tratado <- cnes_es %>% 
                      select(cnes, codufmun, vinc_sus, atividad, 
                             tp_unid, nivate_a, nivate_h, qtleitp1,
                             qtleitp2, qtleitp3, leithosp, urgemerg, dt_atual,
                             competen) %>% 
                      left_join(estabelecimentos_es, by = c("cnes"="CNES")) %>% 
                      janitor::clean_names()


unidades_urg <- cnes_tratado %>% 
                  filter(tp_unid == "42" | tp_unid == "20" |
                         tp_unid == "21" | tp_unid == "73")

