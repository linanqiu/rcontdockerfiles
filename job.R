library('AzureStor')

access_key <- 'OAweQM4G/JKTCnltQ2YdYS+Q27Auvse/zQv0T9erxWkzN9b3TSLnF/YfW3G/V6BPPzvhHYA5WVtunApccFEBaA=='
bl_endp_key <- storage_endpoint('https://rcontstorage.blob.core.windows.net', key = access_key)

bl_endp_key

list_storage_containers(bl_endp_key)

cont <- storage_container(bl_endp_key, 'rcontstorage-container')
list_storage_files(cont)

dat <- storage_read_csv(cont, 'iris.csv')
dat

library(tidyverse)

dat_summary <- dat %>% group_by(Species) %>% summarize_all(mean)
dat_summary

now <- as.integer(Sys.time())
storage_write_csv(dat_summary, cont, paste0('summary_', now, '.csv'))