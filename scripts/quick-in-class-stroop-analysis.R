rm(list = ls())

library(tidyverse)

df <- read.csv("/Users/ethan/Google Drive/Teaching/2019_LaCoBra/experiments/Stroop task/Stroop_2019_a.csv", sep = ";")

df$Participant.ID <- NULL
df$Other.notes. <- NULL
df$Non.native.speaker. <- NULL

df_long <- gather(df, key = "Condition", value = "Time")





ggplot(df_long, aes(x = Condition, y = Time, color = Condition)) +
  geom_boxplot() +
  geom_jitter()


