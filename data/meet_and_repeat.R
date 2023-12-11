# Author: Kaapo Seppänen
# Date: December 11, 2023
# Description: Pre-processing of two data sets from https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/

# load the required libraries
library(readr)
library(dplyr)

# reading the two data sets
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# print out the column names of the data
names(BPRS)
names(RATS)

# print out the structure and dimensions of the data
str(BPRS)
str(RATS)

# print out the summaries of the variables
summary(BPRS)
summary(RATS)

# convert the categorical variables of both data sets to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# convert the data sets to long form
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>%
  mutate(week = as.integer(substr(weeks,5,5))) %>%
  arrange(week) #order by week variable
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD, 3, 4))) %>%
  arrange(Time) #order by Time variable

# print out the column names of the data
names(BPRSL)
names(RATSL)

# print out the structure and dimensions of the data
str(BPRSL)
str(RATSL)

# print out the summaries of the variables
summary(BPRSL)
summary(RATSL)

# In both cases, pivoting to the long data format has created a single time variable by "gluing"
# the original time variables in a sequence. This makes it easier to access data corresponding to
# a specific time.

# write data to file
write_csv(BPRSL, "data/BPRSL.csv")
write_csv(RATSL, "data/RATSL.csv")


