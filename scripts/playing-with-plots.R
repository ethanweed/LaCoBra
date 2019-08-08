
rm(list = ls())

df <- read.csv("/Users/ethan/Documents/GitHub/LaCoBra/data/Stroop-raw-over-the-years.csv")

library(ggplot2)

# Convert from wide format to long format
library(tidyverse)

df_long <- gather(df, key = "Condition", value = "Time", -Year)

# Set up plot structure
p <- ggplot(df_long, aes(x = Condition, y = Time))
p

# Basic barplot
p + geom_bar(stat = "identity")

# Horizontal bar plot
p + geom_bar(stat = "identity") +
  coord_flip()

# Basic scatterplot
p + geom_point()

# Boxplots
p + geom_boxplot()

# Boxplots with points
p + geom_boxplot() + 
  geom_point()

# Violin plots with points
p + geom_violin() +
  geom_point()

# Violin plots with points and boxplots
p + geom_boxplot() +
  geom_violin() +
  geom_point()

# Histograms of a single condition

## First, make a new dataframe
df_readingNoInt <- data.frame("Time" = df$Reading_NoInt)

# Plot a histogram
ggplot(df_readingNoInt, aes(Time)) +
         geom_histogram()

# Look at differences over the years

## Add Year to our new dataframe and make it a factor, so we can use it to sort the data
df_readingNoInt$Year <- as.factor(df$Year)

# make a historgram by year
ggplot(df_readingNoInt, aes(Time, fill = Year)) +
  geom_histogram(binwidth = 0.1)

# add density to the histogram
ggplot(df_readingNoInt, aes(Time, fill = Year)) +
  geom_histogram(binwidth = 0.1) +
  geom_density()

# make density plots without the histogram counts
ggplot(df_readingNoInt, aes(Time, fill = Year)) +
  geom_density()


# make density plots without the histogram counts
ggplot(df_readingNoInt, aes(Time, fill = Year)) +
  geom_density(alpha = 0.5)

# make individual plots for different years
ggplot(subset(df_readingNoInt, Year == 2016), aes(Time, fill = Year)) +
  geom_density(alpha = 0.5)



# make a grid of all four years
p1 <- ggplot(subset(df_readingNoInt, Year == 2015), aes(Time, fill = Year)) +
  geom_density(alpha = 0.5) +
  xlim(1.5, 6.5)

p2 <- ggplot(subset(df_readingNoInt, Year == 2016), aes(Time, fill = Year)) +
  geom_density(alpha = 0.5) +
  xlim(1.5, 6.5)

p3 <- ggplot(subset(df_readingNoInt, Year == 2017), aes(Time, fill = Year)) +
  geom_density(alpha = 0.5) +
  xlim(1.5, 6.5)

p4 <- ggplot(subset(df_readingNoInt, Year == 2018), aes(Time, fill = Year)) +
  geom_density(alpha = 0.5) +
  xlim(1.5, 6.5)

library(ggpubr)

figure <- ggarrange(p1, p2, p3, p4,
                    labels = c("2015", "2016", "2017", "2018"),
                    ncol = 2, nrow = 2)
figure


# adjust y-axis to make it easier to compare plots
p1 <- ggplot(subset(df_readingNoInt, Year == 2015), aes(Time, fill = Year)) +
  geom_density(alpha = 0.5) +
  xlim(1.5, 6.5) +
  ylim(0, 1.25)

p2 <- ggplot(subset(df_readingNoInt, Year == 2016), aes(Time, fill = Year)) +
  geom_density(alpha = 0.5) +
  xlim(1.5, 6.5) +
  ylim(0, 1.25)

p3 <- ggplot(subset(df_readingNoInt, Year == 2017), aes(Time, fill = Year)) +
  geom_density(alpha = 0.5) +
  xlim(1.5, 6.5) +
  ylim(0, 1.25)

p4 <- ggplot(subset(df_readingNoInt, Year == 2018), aes(Time, fill = Year)) +
  geom_density(alpha = 0.5) +
  xlim(1.5, 6.5) +
  ylim(0, 1.25)

figure <- ggarrange(p1, p2, p3, p4,
                    labels = c("2015", "2016", "2017", "2018"),
                    ncol = 2, nrow = 2)
figure

# Is the number of participants an explanation for the differences in density?
as.data.frame(table(df$Year))

