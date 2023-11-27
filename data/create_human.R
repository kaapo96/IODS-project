# Author: Kaapo Seppänen
# Date: November 27, 2023
# Description: Pre-processing of two data sets from https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets

# reading the two data sets
library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# print out the structure and dimensions of the data
str(hd)
str(gii)

# print out the summaries of the variables
summary(hd)
summary(gii)

colnames(hd)
colnames(gii)
