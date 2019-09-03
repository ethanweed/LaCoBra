
rm(list = ls())

df <- read.csv("/Users/ethan/Documents/GitHub/Stroop/Stroop-raw-over-the-years.csv")

library(ggplot2)

# Convert from wide format to long format
library(tidyverse)

df_long <- gather(df, key = "Condition", value = "Time", -Year)

# Set up plot structure
p <- ggplot(df_long, aes(x = Condition, y = Time))
#p <- ggplot(df_long, aes(x = Condition, y = Time, color = Condition))
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

# Violin plots with points and boxplots flipped (X-wing plots?)
p + geom_boxplot() +
  geom_violin() +
  geom_point() + 
  coord_flip()

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

ggarrange(p1, p2, p3, p4,
  labels = c("2015", "2016", "2017", "2018"),
  ncol = 2, nrow = 2)



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

ggarrange(p1, p2, p3, p4,
  labels = c("2015", "2016", "2017", "2018"),
  ncol = 2, nrow = 2)


# Is the number of participants an explanation for the differences in density?
as.data.frame(table(df$Year))

ggplot(df_long, aes(x = Condition, y = Time, color = Condition)) +
  geom_violin() +
  geom_point() +
  coord_flip()








##################

rm(list = ls())
df <- read.csv("/Users/ethan/Documents/GitHub/ethanweed.github.io/r-tutorials/data/cdi_data_wordbank.csv", sep = ";")
df <- subset(df, df$age < 12)
df <- na.omit(df)

head(df)
ggplot(df, aes(age, comprehension, color = gender)) +
  geom_smooth(method = lm)

summary(df$age)


mod1 <- lm(comprehension ~ age, data = df)
mod2 <- lm(comprehension ~ age + gender, data = df)

anova(mod1, mod2)

mod1 <- lmer(comprehension ~ age, data = df)
mod2 <- lm(comprehension ~ age + gender, data = df)
mod3 <- lm(comprehension ~ age + gender + language, data = df)

anova(mod1, mod2, mod3)

ggplot(df, aes(age, comprehension, color = language)) +
  geom_smooth(method = lm)

ggplot(df, aes(age, comprehension, color = mom_ed)) +
  geom_smooth(method = lm)

d <- subset(df, language == "Danish" | language =="English (American)")
dan <- subset(df, language == "Danish")
eng <- subset(df, language == "English (American)")

#linear
ggplot(d, aes(age, comprehension, color = language)) +
  geom_smooth(method = lm) +
  geom_point()

#quadratic
ggplot(d, aes(age, comprehension, color = language)) +
  geom_smooth(method = lm, formula = y ~ x + I(x^2)) +
  geom_point()


p1 <- ggplot(dan, aes(age, comprehension, color = mom_ed))+
  geom_smooth(method = lm)
p2 <- ggplot(eng, aes(age, comprehension, color = mom_ed))+
  geom_smooth(method = lm)


library(ggpubr)

ggarrange(p1, p2, ncol = 1, nrow = 2)

geom_s