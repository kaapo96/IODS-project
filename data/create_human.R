# Author: Kaapo Seppänen
# Date: November 27, 2023
# Description: Pre-processing of two data sets from https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets

# load the required libraries
library(readr)
library(dplyr)

# reading the two data sets
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# print out the structure and dimensions of the data
str(hd)
str(gii)

# print out the summaries of the variables
summary(hd)
summary(gii)

# rename variables
names(hd) <- c("HDI.Rank", "Country", "HDI", "Life.Exp", "Edu.Exp", "Edu.Mean", "GNI", "GNI.Minus.Rank")
names(gii) <- c("GII.Rank", "Country", "GII", "Mat.Mor", "Ado.Birth", "Parli.F", "Edu2.F", "Edu2.M", "Labo.F", "Labo.M")

# create a variable for the ratio of female and male populations with secondary education in each country
gii <- mutate(gii, Edu2.FM = Edu2.F / Edu2.M)

# create a variable for the ratio of labor force participation of females and males in each country
gii <- mutate(gii, Labo.FM = Labo.F / Labo.M)

# join the two data sets by country
human <- inner_join(hd, gii, by = "Country")

# print out the summary of the joined data set
str(human)

# write data to file
write_csv(human, "data/human.csv")



