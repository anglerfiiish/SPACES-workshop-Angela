# Data Wrangling (cleaning, filtering, etc.)
library(tidyverse)
library(ratdat)

class(complete_old)
head(complete_old) #functions, head shows first 6 rows of tbl
tail(complete_old) #functions, tail shows last 6 rows of tbl

head(complete_old, n = 2)
head(complete_old, 2)
head(n = 2, x = complete_old) #if we switch the order of the arguments, then we have to name them.

#Getting help with functions?
?head
??ggplot2

#
summary(complete_old)
str(complete_old)

#The $ operator allows u to pull out one single column from a data frame
complete_old$year
complete_old$species

#Assignment, objects, and values 
# Challenge: What is the value of y after running the following code 
x <- 5
y <- x
x <- 10
y

x <- 5
sqrt(x/2) 

# reading in data from outside of R
surveys <- read_csv("data/cleaned/surveys_complete_77_89.csv")

#we can use the function "select" to select only a few columns
select(surveys, plot_id, species_id, hindfoot_length)
select(surveys, -record_id, -year) #select all columns from surveys excepts for record id and year

select(surveys, 10)

select(surveys, where(is.numeric))

mydata_subset <- select(surveys, plot_id, species_id, hindfoot_length)

#We can use the function "filter" to choose only certain rows. 
filter(surveys, year == 1985) # == means literaly "is equal to"
filter(surveys, year > 1985)

filter(surveys, species_id %in% c("RM", "DO")) #filters the "surveys" dataset to keep only the rows where value of the 'species_id' column is found in the vector of RM and DO

filter(surveys, year <= 1988 & !is.na(hindfoot_length)) # rows of surveys where the year is less than or equal to 1988 and where hindfoot_length is not NA.
filter(surveys, year !=1988) # year is NOT equal to 1988
filter(surveys, year == 1988) # year IS equal to 1988

# Challenge: filter to rows where the year is later than 1988 and the sex is M. save your result to a variable called "males_1980"
filter(surveys, year > 1980, sex =="M")

males_1980 <- filter(surveys, year > 1980, sex =="M")

#Challenge 2: filter to rows where the genus is "Neotoma" and the plot type is either control or long-term krat exclosure

filter(surveys, genus == "Neotoma", plot_type %in% c("Control", "Long-term Krat Exclosure"))

#Challenge 3: use surveys data with only 1980 and 1985, another one iwth only year, month, speciesid, plotid

#--------------------
# The pipe: %>%
filter(select(surveys, -day), month >= 7)

surveys_noday <- select(surveys, -day)       
filter(surveys_noday, month >= 7) 

surveys %>% 
  select(-day) %>%
  filter(month >= 7)
# take the surveys dataset, AND THEN select all but the day column, AND THEN filter rows such that month is >= 7 


#challenge: use the surveys data to make a data frame that has the columns record_id, month, and species_id, with data from the year 1988. use a pipe

surveys %>% 
  filter(year == 1988) %>%
  select(record_id, month, species_id)

#Grouping and summarizing data by group
# group_by()
# summarize() 

surveys %>%
  group_by(sex, species) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE)) # remove values that are na, true!( meaning yes)

# We can define multiple columns in one summarize() function
# For example, I'd like to know if these different weights have anythign to do with sample size

surveys %>%
  group_by(sex, species) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE),
            sample_size = n()) %>%
  arrange(desc(mean_weight))























 
