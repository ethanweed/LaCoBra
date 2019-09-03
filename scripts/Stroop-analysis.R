rm(list = ls())

df <- read.csv("/Users/ethan/Documents/GitHub/Stroop/Stroop-raw-over-the-years.csv")
df$ID <- c(1:length(df$Year))

df <- gather(df, key = "Condition", value = "Time", -Year, -ID)
df$Condition <- as.factor(df$Condition)
df$Year <- as.factor(df$Year)


ggplot(data = df, aes(Condition, Time)) +
         geom_point()
ggplot(df, aes(x = Condition, y = Time, color = Condition)) +
        geom_point()  

ga <- mean(df$Time, na.rm = TRUE)



min.mean.sd.max <- function(x) {
  r <- c(min(x), mean(x) - sd(x), mean(x), mean(x) + sd(x), max(x))
  names(r) <- c("ymin", "lower", "middle", "upper", "ymax")
  r
}

Naming_Int <- min.mean.sd.max(subset(df$Time, df$Condition == "Naming_Int"))
Naming_NoInt <- min.mean.sd.max(subset(df$Time, df$Condition == "Naming_NoInt"))
Reading_Int <- min.mean.sd.max(subset(df$Time, df$Condition == "Reading_Int"))
Reading_NoInt <- min.mean.sd.max(subset(df$Time, df$Condition == "Reading_NoInt"))

Name_Int
Naming_NoInt
Reading_Int
Reading_NoInt

ggplot(df, aes(x = Condition, y = Time, color = Condition)) +
  stat_summary(fun.data = min.mean.sd.max, geom = "boxplot", na.rm=TRUE) +
  geom_point() +
  geom_hline(yintercept = ga, linetype = "dotted") +
  theme_classic()

mod <- aov(Time ~ Condition + Error(ID),
           data = df)
summary(aov(Time ~ Condition + Error(ID),
            data = df))

mod1 <- lm(data = df, Time ~ Condition)
summary(mod1)

mod2 <- lmer(data = df, Time ~ Condition + (1|Year) + (1|ID))
summary( mod2)

anova(mod1, mod2)

df_NI <- subset(df, Condition == "Naming_Int")
m_NI <- mean(df_NI$Time)
df_Reading_NoInt <- subset(df, Condition == "Reading_NoInt") 
m_RNI <- mean(df_Reading_NoInt$Time)

m_NI-m_RNI

summary(mod1)

rm(list = ls())

library(tidyverse)

df <- read.csv("/Users/ethan/Documents/GitHub/ethanweed.github.io/r-tutorials/data/nettle_1998.csv", sep = ";")

# Nettle reports the population data in 1000's, probably to save room in the data table, but that is an unusual number to think about population in, so let's convert to millions. While we're at it, let's convert km2 to millions, so that the number doesn't appear in scientific notation on the x-axis
df$Population <- df$Population*1000/1000000
df$Area <- df$Area/1000000


mod1 <- lmer(data = df, Languages ~ Population)
mod2 <- lm(data = df, Languages ~ Population + MGS)
mod3 <- lm(data = df, Languages ~ Population + MGS + Variable_GS)
summary(mod3)

anova(mod2, mod3)
