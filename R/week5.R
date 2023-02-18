# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(lubridate)

# Data Import
Adata_tbl <- read_delim(file = "../data/Aparticipants.dat", delim = "-", col_names = c("casenum","parnum","stimver","datadate","qs"))
Anotes_tbl <- read_csv(file = "../data/Anotes.csv")
Bdata_tbl <- read_tsv(file = "../data/Bparticipants.dat", col_names = c("casenum","parnum","stimver","datadate",paste0("q", 1:10)))
Bnotes_tbl <- read_tsv(file = "../data/Bnotes.txt")

# Data Cleaning
Aclean_tbl <- Adata_tbl %>%
  separate(qs, into = paste0("q", 1:5)) %>%
  mutate(datadate = mdy_hms(datadate)) %>%
  mutate(across(q1:q5, as.integer)) %>%
  inner_join(Anotes_tbl, by = "parnum") %>%
  filter(is.na(notes))
ABclean_tbl <- Bdata_tbl %>%
  mutate(datadate = mdy_hms(datadate)) %>%
  mutate(across(q1:q10, as.integer)) %>%
  inner_join(Bnotes_tbl, by = "parnum") %>%
  filter(is.na(notes)) %>%
  select(-notes) %>%
  bind_rows(Aclean_tbl, .id = "lab")