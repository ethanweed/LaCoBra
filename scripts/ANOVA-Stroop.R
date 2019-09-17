# Load packages for data handling and plotting
library(tidyverse)

# clear global environment (get rid of any old variables that might be hangning around)
rm(list = ls())

# read in the data
df <- read.csv("/Users/ethan/Documents/GitHub/ethanweed.github.io/r-tutorials/data/Stroop-raw-over-the-years.csv")

# make a new dataframe with the same data in the "long" format.
#df <- gather(df, key = "Condition", value = "Time", -Year)

column_means <- colMeans(df)
mean_naming_int <- column_means[2]

df$points <- seq(1:nrow(df))

p1 <- ggplot(data = df, aes(x = points, y = Reading_NoInt)) +
  geom_point() + 
  theme_classic() +
  geom_hline(yintercept = column_means[1]) +
  ylim(0, 18)

p2 <- ggplot(data = df, aes(x = points, y = Naming_Int)) +
  geom_point() + 
  theme_classic() +
  geom_hline(yintercept = column_means[2]) +
  ylim(0, 18)

p3 <- ggplot(data = df, aes(x = points, y = Naming_NoInt)) +
  geom_point() + 
  theme_classic() +
  geom_hline(yintercept = column_means[3]) +
  ylim(0, 18)
              
p4 <- ggplot(data = df, aes(x = points, y = Reading_Int)) +
  geom_point() + 
  theme_classic() +
  geom_hline(yintercept = column_means[4])+
  ylim(0, 18)

library(ggpubr)

ggarrange(p1, p2, p3, p4, ncol = 2, nrow = 2)

ggplot(df, aes(points, Reading_NoInt, color = 'Reading_NoInt')) +
  geom_point() +
  geom_point(aes(points, Naming_Int, color = 'Naming_Int')) +
  geom_point(aes(points, Naming_NoInt, color = 'Naming_NoInt')) +
  geom_point(aes(points, Reading_Int, color = 'Reading_Int')) +
  geom_hline(yintercept = column_means[1], color = 'black', linetype = 'dashed') +
  geom_hline(yintercept = column_means[2], color = 'black') +
  geom_hline(yintercept = column_means[3], color = 'black', linetype = 'dashed') +
  geom_hline(yintercept = column_means[4], color = 'black') +
  geom_text(aes(x = 110, y = column_means[1], label = "RNI")) +
  geom_text(aes(x = 110, y = column_means[2], label = "NI")) +
  geom_text(aes(x = 110, y = column_means[3], label = "NNI")) +
  geom_text(aes(x = 110, y = column_means[4], label = "RI")) +
  theme_classic() +
  theme(legend.position="none") +
  labs(y = 'Time')

df_long <- gather(df, key = "Condition", value = "Time", -Year, -points)
df_long$Task <- ifelse(df_long$Condition == 'Reading_Int' | df_long$Condition == 'Reading_NoInt', "Reading", "Naming")
df_long$Interference <- ifelse(df_long$Condition == 'Reading_Int' | df_long$Condition == 'Naming_Int', 'Interference', 'No_Interference')

summary(aov(Time ~ Condition,
            data = df_long))

summary(aov(Time ~ Task,
            data = df_long))

summary(aov(Time ~ Interference,
            data = df_long))


summary(aov(Time ~ Task + Interference,
            data = df_long))

summary(aov(Time ~ Task + Interference + (Task*Interference),
            data = df_long))
