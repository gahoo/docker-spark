options(repos=c(CRAN='https://mirrors.ustc.edu.cn/CRAN'))
install.packages('sparklyr')
library(sparklyr)
install.packages('remotes')
remotes::install_github("apache/arrow", subdir = "r", ref = "apache-arrow-0.13.0")
