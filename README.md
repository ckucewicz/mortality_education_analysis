# Project Overview and Goals

## Introduction
The University of Chicago’s Mind Bytes Data Visualization Challenge offers an opportunity to showcase data visualization skills by uncovering insights within complex data. This project examines the relationship between youth gun-related deaths and academic achievement. By visualizing this connection, we aim to highlight potential patterns and spark conversations about the broader social factors influencing student outcomes. Learn more about the challenge at: https://mindbytes.uchicago.edu/vis-challenge/.
## Motivation
Gun violence has been a longstanding issue in the Chicagoland area, impacting communities and shaping the experiences of young people.  For this challenge, wanted to explore the relationship between high school graduation and juvenile gun violence rates in each zip codesTo investigate this, we analyzed the relationship between four-year graduation rates and gun-related deaths for youth ages 0-17 by zip code in the Chicago area. 
# Data Understanding and Preparation
For this analysis, we used publicly available data from the City of Chicago’s Public Schools Progress Reports, Population Counts Data, and Cook County’s Medical Examiner’s Office Mortality data, obtained through their respective Open Data platforms.

The medical examiner’s data ranged from 2018 to 2021. We filtered the dataset to include only gun-related incidents and limited the age range to individuals under 18, as we focused on juvenile cases.

For the City of Chicago’s Progress Reports, we analyzed 4-year high school graduation rates from 2018 to 2021.

Since we were interested in studying differences in juvenile gun-related incidents across ZIP codes, we also imported Chicago Population Counts data (2018-2021) and aggregated juvenile gun deaths per 100,000 residents by ZIP code.

Finally, we compared and performed regression analysis on the relationship between average high school graduation rates and juvenile gun-related deaths per 100,000 residents at the ZIP code level.

# Visualization and Key Insights
1. [View the dashboard created on tableau public] (https://public.tableau.com/views/DataVizChallenge_Gun_Violence__Edu/scientificdashboard3?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
2. **Key Findings from the Regression Analysis:**
    1. The relationship between graduation rates and juvenile gun deaths is **inverse**—as graduation rates increase, juvenile gun deaths decrease.
    2. The relationship is **statistically significant** (p = 0.0216, p < 0.05).
    3. For every **1% increase** in the graduation rate, there is an associated **decrease of 0.349 juvenile gun deaths** per 100K youth.
# Recommendations & Next Steps
1. This analysis lays the groundwork for further exploration into the intersection of education and gun violence, raising several critical questions:
    1. What other factors contribute to the relationship between graduation rates and juvenile gun violence?
    2. How do school and community resources impact these outcomes?
    3. What policies could improve educational opportunities while also reducing youth gun violence?
    
    Further research into these areas could help shape policies aimed at both improving educational outcomes and enhancing community safety.
