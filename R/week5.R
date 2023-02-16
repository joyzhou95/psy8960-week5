# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(lubridate)

# Data Import
Adata_tbl <- read_delim(file = "../data/Aparticipants.dat", delim = "-", col_names = c("casenum","parnum","stimver","datadate","qs"))
Anotes_tbl <- read_delim(file = "../data/Anotes.csv", delim = ",")
Bdata_tbl <- read_delim(file = "../data/Bparticipants.dat", delim = "\t", col_names = c("casenum","parnum","stimver","datadate",paste0("q", 1:10)))
Bnotes_tbl <- read_delim(file = "../data/Bnotes.txt", delim = "\t")

