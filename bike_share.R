# Get working directory
getwd()

# Load required libraries
library(dplyr)
library(ggplot2)
library(car)
library(MASS)

# Load the dataset
bike_data <- read.csv("bike_sharing_data.csv")

# Check the column names
colnames(bike_data)

# Remove missing values
bike_data <- na.omit(bike_data)

# Randomly sample 1000 observations
set.seed(123) # for reproducibility
bike_data <- bike_data[sample(nrow(bike_data), 1000),]

# Distribution of the dependent variable (bike sharing demand)
ggplot(bike_data, aes(x=cnt)) + 
  geom_histogram(binwidth=100, color="black", fill="white") +
  labs(x="Bike Sharing Demand", y="Count", title="Distribution of Bike Sharing Demand")

# Calculate the correlation coefficients between count and weather variables
cor(bike_data[,c("cnt","t1","t2","hum","wind_speed")])

# Scatter plot of cnt vs temperature
ggplot(bike_data, aes(x=t1, y=cnt)) +
  geom_point(color="black") +
  labs(x="Temperature", y="Bike Sharing Demand", title="Scatter Plot of Bike Sharing Demand vs Temperature")

# Simple linear regression model with temperature as the predictor
lm_model <- lm(cnt ~ t1, data=bike_data)
summary(lm_model)

# Residual plots for linear regression model
par(mfrow=c(2,2))
plot(lm_model, pch=16, col="black")

# Scatter plot of cnt vs humidity
ggplot(bike_data, aes(x=hum, y=cnt)) +
  geom_point(color="black") +
  labs(x="Humidity", y="Bike Sharing Demand", title="Scatter Plot of Bike Sharing Demand vs Humidity")

# Multiple linear regression model with temperature and humidity as predictors
mlm_model <- lm(cnt ~ t1 + hum, data=bike_data)
summary(mlm_model)

# ANOVA with season as the factor
bike_data$season <- factor(bike_data$season)
ggplot(bike_data, aes(x=season, y=cnt)) +
  geom_boxplot(color="black") +
  labs(x="Season", y="Bike Sharing Demand", title="Box Plot of Bike Sharing Demand by Season")

anova_model <- aov(cnt ~ season, data=bike_data)
summary(anova_model)

# ANCOVA with temperature as the covariate and season as the factor
ggplot(bike_data, aes(x=t1, y=cnt, color=season)) +
  geom_point() +
  labs(x="Temperature", y="Bike Sharing Demand", title="Scatter Plot of Bike Sharing Demand vs Temperature by Season")

ancova_model <- lm(cnt ~ t1 + season, data=bike_data)
summary(ancova_model)

# One-sample proportion test with holiday periods
prop.test(sum(bike_data$is_holiday), nrow(bike_data), p=0.5, alternative="two.sided")

# Two-sample proportion test with weekends
bike_data_clean <- na.omit(bike_data)
prop.test(table(bike_data_clean$is_weekend, bike_data_clean$cnt > 500), alternative="two.sided")

# Inspect unique values of cnt variable
table(bike_data$cnt)

# Recode cnt variable as binary with a threshold of 500 rentals
bike_data$cnt_binary <- ifelse(bike_data$cnt > 500, 1, 0)

# Logistic regression model with holiday periods and weekends as predictors
logit_model <- glm(cnt_binary ~ is_holiday + is_weekend, data=bike_data, family="binomial")

# Summary of the logistic regression model
summary(logit_model)

# Create a grid of values for the predictors
x_grid <- data.frame(is_holiday = rep(c(0, 1), each = 100),
                     is_weekend = rep(c(0, 1), times = 100),
                     stringsAsFactors = FALSE)

# Predict the probabilities for the grid values using the logistic regression model
y_grid <- predict(logit_model, newdata = x_grid, type = "response")

# Combine the grid values and predicted probabilities into a data frame
plot_data <- data.frame(x_grid, y_grid)

# Create the plot using ggplot2
ggplot(bike_data, aes(x=t1, y=cnt)) + 
  geom_point(alpha=0.5) +
  geom_smooth(method="lm", se=FALSE, aes(linewidth = 1)) + # use linewidth instead of size
  labs(x="Temperature (C)", y="Bike Sharing Demand", title="Relationship Between Temperature and Bike Sharing Demand")

# Residual plots for logistic regression model
par(mfrow=c(2,2))
plot(logit_model, pch=16, col="black")

