# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(lubridate)

# Data Import
Adata_tbl <- read_delim(file = "../data/Aparticipants.dat", delim = "-", col_names = c("casenum","parnum","stimver","datadate","qs"))
Anotes_tbl <- read_delim(file = "../data/Anotes.csv", delim = ",")
Bdata_tbl <- read_delim(file = "../data/Bparticipants.dat", delim = "\t", col_names = c("casenum","parnum","stimver","datadate",paste0("q", 1:10)))
Bnotes_tbl <- read_delim(file = "../data/Bnotes.txt", delim = "\t")

# Data Cleaning
Aclean_tbl <- Adata_tbl %>%
  separate(qs, into = paste0("q", 1:5)) %>%
  mutate(datadate = as.POSIXct(datadate, format = "%b %d %Y, %H:%M:%S")) %>%
  mutate(q1 = as.integer(q1), q2 = as.integer(q2), q3 = as.integer(q3), q4 = as.integer(q4), q5 = as.integer(q5)) %>%
  inner_join(Anotes_tbl, by = "parnum") %>%
  filter(is.na(notes))
ABclean_tbl <- Bdata_tbl %>%
  mutate(datadate = as.POSIXct(datadate, format = "%b %d %Y, %H:%M:%S")) %>%
  mutate(q1 = as.integer(q1), q2 = as.integer(q2), q3 = as.integer(q3), q4 = as.integer(q4), q5 = as.integer(q5), q6 = as.integer(q6), q7 = as.integer(q7), q8 = as.integer(q8), q9 = as.integer(q9), q10 = as.integer(q10)) %>%
  inner_join(Bnotes_tbl, by = "parnum") %>%
  filter(is.na(notes)) %>%
  bind_rows(Aclean_tbl, .id = "lab") %>%
  select(-notes)
  