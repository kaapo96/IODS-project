# Author: Kaapo Seppänen
# Date: November 7, 2023
# Description: Pre-processing of a data set 'learning2014'

# loading the data
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# dim(learning2014) prints out the dimensions of the data, which are 183 observations and 60 variables
dim(learning2014)

# str(learning2014) prints out the structure of the data, i.e. all the variables, their types and first observations
str(learning2014)

# create column 'attitude' by scaling the column "Attitude"
learning2014$attitude <- learning2014$Attitude / 10

# Access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06", "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning 
deep_columns <- select(learning2014, one_of(deep_questions))
# and create column 'deep' by averaging
learning2014$deep <- rowMeans(deep_columns)

# select the columns related to surface learning 
surface_columns <- select(learning2014, one_of(surface_questions))
# and create column 'surf' by averaging
learning2014$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning 
strategic_columns <- select(learning2014, one_of(strategic_questions))
# and create column 'stra' by averaging
learning2014$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(learning2014,one_of(keep_columns))

# change the name of the second column
colnames(learning2014)[2] <- "age"

# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"

# select rows where points is greater than zero
learning2014 <- filter(learning2014, points > 0)

# load readr
library(readr)

# save the dataset
write_csv(learning2014, "data/learning2014.csv")

# read the dataset
learning2014_2 <- read_csv("data/learning2014.csv")

# header of the read file
head(learning2014_2)

# structure of the read file
str(learning2014_2)


