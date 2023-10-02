# Bike_Sharing

## Research Scenario: 
The research scenario for this project is to investigate the factors that impact bike sharing demand in London. Specifically, the aim is to understand how weather conditions, holiday periods, weekends, and seasons affect the number of bike rentals in the city. 

## Research Question: 
What factors impact the demand for bike sharing in London?

## Introduction:
Bike sharing has become a popular mode of transportation in many cities around the world. In London, bike sharing is also gaining popularity, and this research aims to understand the factors that impact the demand for bike sharing in the city. This research will use a dataset of bike sharing records in London to identify the key factors that influence bike sharing demand.

## Data Preparation and Cleaning:
The dataset used in this research includes records of bike sharing in London, with attributes such as timestamp, count of bikes rented, temperature, humidity, wind speed, and binary variables for holiday, weekend, and season. Before conducting any analysis, the dataset was cleaned to remove any missing values and duplicates. The dataset was also randomly sampled to include 1000 observations.

## Description of columns used in analysis:
1. Timestamp - timestamp field for grouping the data
2. cnt - the count of new bike shares
3. t1 - real temperature in Celsius
4. t2 - temperature in Celsius "feels like"
5. hum - humidity in percentage
6. windspeed - wind speed in km/h
7. weather_code - category of the weather code
8. 1 = Clear; mostly clear but have some values with haze/fog/patches of fog/ fog in vicinity
9. 2 = scattered clouds / few clouds
10. 3 = Broken clouds
11. 4 = Cloudy
12. 7 = Rain/ light Rain shower/ Light rain
13. 10 = rain with thunderstorm
14. 26 = snowfall
15. is_holiday - boolean field - 1 is_holiday / 0 non is_holiday
16. is_weekend - boolean field - 1 if the day is weekend
17. season - category (0-spring ; 1-summer; 2-fall; 3-winter)
