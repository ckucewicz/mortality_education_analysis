# Cleaning ----------------------------------------------------------------
rm(list = ls())
graphics.off()
cat("\014")


# Loading packages --------------------------------------------------------
library(tidyverse)
library(RSocrata)
library(janitor)
library(censusapi)

# Accessing data ----------------------------------------------------------
setwd("~/shine/work/meo/viz_uchicago")
# df_case_archive_orig <- read.socrata("https://datacatalog.cookcountyil.gov/resource/cjeq-bs86.csv") |> clean_names()
# write.csv(df_case_archive_orig, "df_case_archive_orig.csv")

df_case_archive_orig <- read.csv("df_case_archive_orig.csv") |> clean_names()

df_gun <- df_case_archive_orig |> 
  subset(gunrelated == 'true') |> 
  filter(age < 18) |> 
  mutate(year = format(as.Date(incident_date), "%Y"))

df_zip_gun <- df_gun |> 
  group_by(incident_zip) |> 
  summarise(instances = round(n())) |> 
  filter(!(incident_zip %in% c("00000", "99999", ""))) |> 
  rename(zip = incident_zip)

df_year_gun <-  df_gun |> 
  group_by(year) |> 
  filter(year < 2025 & year > 2011) |> 
  summarize(instances = n())

# City Demographic Data ---------------------------------------------------
chicago <- read.socrata("https://data.cityofchicago.org/resource/85cm-7uqa.csv") |> 
  filter(geography_type != "Citywide") |> 
  select(geography, population_age_0_17, year) |> 
  rename(zip = geography,juve_pop = population_age_0_17)

chicago_year <- chicago |> 
  group_by(year) |> 
  summarise(juve_population = sum(juve_pop)) |> 
  mutate(year = as.character(year))

chicago_zip <- chicago |> 
  group_by(zip) |> 
  summarise(juve_population = sum(juve_pop))

# School data -------------------------------------------------------------
# Year 2013-2014 ----------------------------------------------------------
sy1314 <- read.socrata("https://data.cityofchicago.org/resource/2m8w-izji.csv") |> clean_names()

sy1314_zip <- sy1314 |>
  group_by(zip) |>
  summarise(avg_4year_grad_rate_1314 = round(mean(x_4_year_graduation_rate_percentage_2013, na.rm = TRUE),1))

# Year 2015-2016 ----------------------------------------------------------
sy1516 <- read.socrata("https://data.cityofchicago.org/resource/fvrx-esxp.csv") |> clean_names()

# Year 2016-2017 ----------------------------------------------------------
sy1617 <- read.socrata("https://data.cityofchicago.org/resource/cp7s-7gxg.csv") |> clean_names()

sy1617_zip <- sy1617 |>
  group_by(zip) |>
  summarise(avg_4year_grad_rate_1617 = round(mean(graduation_4_year_school_pct_year_2, na.rm = TRUE),1))

# # Year 2017-2018 ----------------------------------------------------------
# sy1718 <- read.socrata("https://data.cityofchicago.org/resource/wkiz-8iya.csv") |> clean_names()
# 
# sy1718_zip <- sy1718 |>
#   group_by(zip) |>
#   summarise(avg_4year_grad_rate_1617 = round(mean(graduation_4_year_school_pct_year_2, na.rm = TRUE),1))

# Year 2018-2019 ----------------------------------------------------------
sy1819 <- read.socrata("https://data.cityofchicago.org/resource/kh4r-387c.csv")

sy1819_zip <- sy1819 |> 
  group_by(zip) |> 
  summarise(avg_4year_grad_rate_1819 = round(mean(graduation_rate_school, na.rm = TRUE),1))


# Year 2019-2020 ----------------------------------------------------------
sy1920 <- read.socrata("https://data.cityofchicago.org/resource/83yd-jxxw.csv") |> clean_names()

sy1920_zip <- sy1920 |> 
  group_by(zip) 


# Year 2021-2022 ----------------------------------------------------------
sy2122 <- read.socrata("https://data.cityofchicago.org/resource/ngix-dc87.csv")

sy2122_zip <- sy2122 |> 
  group_by(zip) |> 
  summarise(avg_4year_grad_rate_2122 = round(mean(graduation_4_year_school, na.rm = TRUE),1))

# Year 2022-2023 ----------------------------------------------------------
sy2223 <- read.socrata("https://data.cityofchicago.org/resource/d7as-muwj.csv")

sy2223_zip <- sy2223 |> 
  group_by(zip) |> 
  summarise(avg_4year_grad_rate_2223 = round(mean(graduation_4_year_school, na.rm = TRUE),1))

# Year 2023-2024 ----------------------------------------------------------
sy2324 <- read.socrata("https://data.cityofchicago.org/resource/2dn2-x66j.csv")

sy2324_zip <- sy2324 |> 
  group_by(zip) |> 
  summarise(avg_4year_grad_rate_2324 = round(mean(graduation_4_year_school, na.rm = TRUE),1))

# Calculating Gun Rates ---------------------------------------------------
zip_gun_rate <- df_zip_gun |> 
  full_join(chicago_zip, relationship = "one-to-one") |> 
  mutate(instance_per_100k = round((instances/juve_population)*100000,2)) |> 
  filter(!is.na(instance_per_100k))

write.csv(zip_gun_rate,"zip_gun_rate.csv")

# Calculating Graduation Rates --------------------------------------------
rate_datasets <- list(sy1314_zip, sy1617_zip, sy1819_zip, sy2122_zip, sy2324_zip)

zip_grad_rate <- reduce(rate_datasets, full_join, by = "zip") |> 
  mutate(across(where(is.numeric), ~ ifelse(is.nan(.), NA, .)))

write.csv(zip_grad_rate,"zip_grad_rate.csv")

zip_grad_rate_avg <- zip_grad_rate |> 
  mutate(
    average_grad_rate = round(
      rowMeans(
        across(starts_with("avg_4year_grad_rate_")), 
        na.rm = TRUE),2)) |> 
  select(zip, average_grad_rate) |> 
  mutate(across(where(is.numeric), ~ ifelse(is.nan(.), NA, .)))

write.csv(zip_grad_rate_avg,"zip_grad_rate_avg.csv")

