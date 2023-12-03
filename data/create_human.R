# Author: Kaapo Seppänen
# Date: December 3, 2023
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
# str(human)

# write data to file
# write_csv(human, "data/human.csv")

# ----------------------------------------------------------------
# Part 2
# ----------------------------------------------------------------

# print out structure and dimensions
str(human)

# The data combines several indicators from most countries in the world

# "Country" = Country name

# Health and knowledge

# "GNI" = Gross National Income per capita
# "Life.Exp" = Life expectancy at birth
# "Edu.Exp" = Expected years of schooling 
# "Mat.Mor" = Maternal mortality ratio
# "Ado.Birth" = Adolescent birth rate

# Empowerment

# "Parli.F" = Percetange of female representatives in parliament
# "Edu2.F" = Proportion of females with at least secondary education
# "Edu2.M" = Proportion of males with at least secondary education
# "Labo.F" = Proportion of females in the labour force
# "Labo.M" " Proportion of males in the labour force

# "Edu2.FM" = Edu2.F / Edu2.M
# "Labo.FM" = Labo2.F / Labo2.M

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))

# filter out all rows with NA values
human <- filter(human, complete.cases(human))

# look at the last 10 observations of human
tail(human, n = 10)

# define the last indice we want to keep
last <- nrow(human) - 7

# choose everything until the last 7 observations
human <- human[1:last, ]

# write data to file
write_csv(human, "data/human.csv")


