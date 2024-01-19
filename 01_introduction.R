# U.S. Census Bureau ----

# Website: https://www.hrecht.com/censusapi/index.html
# GitHub: https://github.com/hrecht/censusapi/
# CRAN: https://cran.r-project.org/web/packages/censusapi/index.html

# The `censusapi` R package helps you access to data provided
# by the U.S. Census Bureau's APIs.


# For a description of the over 1,000 Census API endpoints
# see:  https://api.census.gov/data.html

# For technical information on the APIs
# visit: https://www.census.gov/data/developers.html


# The package's main function, `censusapi::getCensus()` is designed
# to work with any new Census API endpoint.

# The package includes functions to retrieve metadata
# to determine which data sets are currently available
# and for each dataset, which variables, geographies,
# and groups can be used.


## Setup ----

# Go to
# https://api.census.gov/data/key_signup.html
# and sign up for a free API key.

# Call
usethis::edit_r_environ()
# to open your .Renviron file and save your key
# as "CENSUS_KEY".

# restart your R session.

# Check to see that the expected key is output in your R console
Sys.getenv("CENSUS_KEY")


## Installation ----

# The package is available on CRAN
# install.packages("censusapi")


## Finding your API ----

# To get started, load the `censusapi` package.
library(censusapi)

# To see a table of the available API endpoints,
# use `censusapi::listCensusApis()`.

# The function returns a data frame that includes
# the name, description and title
# as well as a contact email for each dataset.

apis <- listCensusApis()
colnames(apis)

# This returns information about each endpoint.

# - title: Short written description of each dataset.

# - name: Programmatic name of the dataset, to be
#   used with `censusapi` functions.

# - vintage: Year of the survey, for use with micro-
#   data and aggregate data sets.

# - type: Dataset type, either "Aggregate", "Microdata",
#   or "Timeseries".

# - temporal: Time period of the dataset - not always documented.

# - url: Base URL of the endpoint.

# - modified: Date last modified.

# - description: Long written description of the dataset.

# - contact: Email address for specific questions
#   about the Census Bureau survey.


## Dataset types ----

# There are three types of dataset in the Census Bureau API:
# "Aggregate", "Microdata", and "Timeseries".

# The names are defined by the Census Bureau and included
# in the "type" column of the `censusapi::listCensusApis()` output:
unique(apis$type)
# "Microdata"  "Aggregate"  "Timeseries"


# Use the `base::table()` function to see the 
# number of data sets of each "type":
table(apis$type)
# Aggregate: 615
# Microdata: 715
# Timeseries: 61


# Most users want to work with summary data,
# either aggregate or time series data.

# Summary data contains pre-calculated numbers or
# percentages for a given statistic - 
# like the number of children in a state or the
# median household income.


# Aggregate data sets, like the American Community Survey
# or the Decennial Census, include data for only
# one time period (a `vintage`), usually one year.

# Data sets like the American Community Survey contain
# thousands of these pre-computed variables.


# Time series data sets, such as the Small Area Income
# and Poverty Estimates, the Quarterly Workforce Estimates,
# and International Trade statistics, allow users to
# query data for multiple time periods in a single API call.


# Micro data contains the responses of individuals
# given to a survey. One row represents one person.


## Using `getCensus()` ----

# The main function of the `censusapi` R package is
# `censusapi::getCensus()`, which makes an API call
# to a given endpoint and returns a data frame with
# the results.

# The required arguments are:

# - name: The programmatic name of the endpoint as defined
#   by the Census Bureau, like "timeseries/bds/firms".

# - vintage: The survey year, required for aggregate or 
#   micro data APIs.

# - vars: A list of variables to retrieve.

# - region: The geography level to retrieve,
#   such as state or county, required for most endpoints.


# Some APIs have additional required or optional arguments,
# like "time" or "monthly" for some time series data sets.

# Check the specific documentation for your API,
# available at: https://www.census.gov/data/developers/data-sets.html


## Economic indicators ----

# The U.S. Census Bureau's economic indicator surveys
# provide monthly and quarterly data that are timely,
# realiable, and offer comprehensive measures of the
# U.S. economy.

# The surveys include statistics covering:
# - construction
# - housing
# - international trade
# - retail trade
# - wholesale trade
# - services
# - manufacturing

# The survey data provide measures of economic activity
# that allow analysis of economic performance and
# inform business investment and policy decisions.

# Information on the reliability and use of the data,
# important notes on estimation and sampling
# variance, seasonal adjustment, measures of sampling
# variability, and other information are available
# at the Economic Briefing Room
# https://www.census.gov/data/developers/data-sets/economic-indicators.html


## Census Bureau Index of Economic Activity (IDEA) ----

# The Census Bureau Index of Economic Activity (IDEA)
# is built from 15 of the Census Bureau's primary 
# monthly economic time series.

# The index is constructed by applying the method of 
# principal components analysis (PCA)
# to the time series of monthly growth rates 
# of the seasonally adjusted component series, 
# after standardizing the growth rates 
# to series with mean zero and variance 1 (normalization).

# The 15 monthly time series are:

# - New Residential Construction: resconst
# - Business Inventories: mtis
# - Advance Monthly Retail Sales: marts (Monthly Retail Sales: mrts)
# - Business Formation Statistics: bfs
# - Monthly Wholesale Inventories: mwts
# - International Trade: Goods & Services: ftd
# - Manufacturer's Goods: advm3
# - Construction Spending: vip
# - Advance Wholesale Inventories: mwtsadv
# - Advance International Trade: Goods: ftdadv
# - Advance Retail Inventories: mrtsadv
# - New Residential Sales: ressales
# - Advance Report Durable Goods: advm3
# - Selected Services Revenue: qss
# - Quarterly Profits - Manufacturers: qfr
# - Quarterly Profits - Retailers': qfr
# - Homeownership Rate: hv
# - Rental Vacany Rate: hv


## Download the Economic Indicators ----

# The API Call always starts with
# https://api.census.gov/data/timeseries/eits/

# The documentation is available at
# https://api.census.gov/data/timeseries/eits.html


### New Residential Construction (resconst) ----

resconst <- getCensus(
  name = "timeseries/eits/resconst",
  vars = c("cell_value", "data_type_code", "time_slot_id", "error_data", "category_code", "seasonally_adj"),
  region = "us:*",
  time = "from 1970-01"
)

head(resconst)

colnames(resconst)

library(tidyverse)

df <- resconst |> 
  as_tibble() |> 
  filter(
    data_type_code == "TOTAL", 
    time_slot_id == "0",
    error_data == "no",
    category_code == "UNDERCONST",
    seasonally_adj == "yes", 
    us == "1"
    ) |> 
  select(time, cell_value) |> 
  mutate(
    time = date(paste0(time, "-15")),
    cell_value = as.numeric(cell_value)
    )


ggplot(data = df, mapping = aes(x = time, y = cell_value)) +
  geom_line(linewidth = 1, color = "steelblue") +
  theme_bw()

### Business Inventories: mtis ----


### Advance Monthly Retail Sales: marts ----

marts <- getCensus(
  name = "timeseries/eits/marts",
  vars = c("cell_value", "data_type_code", "time_slot_id", "error_data", "category_code", "seasonally_adj"),
  region = "us:*",
  time = "from 2004-05 to 2012-12")
head(eits)

### Business Formation Statistics: bfs ----


### Monthly Wholesale Inventories: mwts ----


### International Trade: Goods & Services: ftd ----


### Manufacturer's Goods: advm3 ----


### Construction Spending: vip ----


### Advance Wholesale Inventories: mwtsadv ----


### Advance International Trade: Goods: ftdadv ----


### Advance Retail Inventories: mrtsadv ----


### New Residential Sales: ressales -----


### Advance Report Durable Goods: advm3 -----


### Selected Services Revenue: qss ---- 


### Quarterly Profits - Manufacturers: qfr ----


### Quarterly Profits - Retailers': qfr ----


### Homeownership Rate: hv -----


### Rental Vacany Rate: hv ----

