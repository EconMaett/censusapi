# censusapi

The [censusapi](https://www.hrecht.com/censusapi/index.html) R package helps you access to data provided by the [U.S. Census Bureau](https://www.census.gov/)'s APIs.

The package is available on [CRAN](https://cran.r-project.org/web/packages/censusapi/index.html) and [GitHub](https://github.com/hrecht/censusapi/).

For a description of the over 1,000 Census API endpoints see [https://api.census.gov/data.html](https://api.census.gov/data.html).


## U.S. Census Bureau Economic Indicators

Visit the [documentation](https://www.census.gov/data/developers/data-sets/economic-indicators.html) for details on how to access the Economic Indicators.

Information on the Census Bureau's Economic Indicators are available at the [Economic Briefing Room](https://www.census.gov/data/developers/data-sets/economic-indicators.html). 


## Census Bureau Index of Economic Activity (IDEA)

The U.S. Census Bureau Index of Economic Activity (IDEA) is constructed from 15 of the Census Bureau's primary monthly economic time series.

The index is constructed by applying the method of [principal components analysis (PCA)](https://en.wikipedia.org/wiki/Principal_component_analysis) to the time series of monthly growth rates of the seasonally adjusted component series, after standardizing the growth rates to series with mean zero and variance 1.

Similar PCA approaches have been used for the construction of other economic indices, including the [Chicago Fed National Activity Index (CFNAI)](https://www.chicagofed.org/research/data/cfnai/current-data) issued by the Federal Reserve Bank of Chicago, and the [Weekly Economic Index (WEI) issued by the Federal Reserve Bank of Dallas](https://www.dallasfed.org/research/wei) (previously [New York](https://www.newyorkfed.org/research/policy/weekly-economic-index)).

While the IDEA is constructed from time series of monthly data, it is calculated and published every business day, and so is updated whenever a new monthly value is released for any of its component series.

Since release dates of data values for a given month vary across the component series, with slight variations in the monthly release date for any one component series, updates to the index are frequent.

It is unavoidably the case that, at almost all updates, some of the component series lack observations for the current (most recent) data month. 
To address this situation, component series that are one month behind are predicted (nowcast) for the current index month, using a multivariate autoregressive time series model.

See the working paper [Building the Census Bureau Index of Economic Activity (IDEA)](https://www.census.gov/library/working-papers/2023/econ/building-the-census-bureau-index-of-economic-activity-workingpaper.html) written by Jose Asturias, William R. Bell, Rebecca Hutchinson, Tucker McElroy, and Katherine J. Thompson.

Additional information on the methodology and FAQs on the IDEA are available at the Census Bureau's [Experimental Data Products](https://www.census.gov/data/experimental-data-products/index-of-economic-activity.html).

## Citation

Recht H (2023). censusapi: Retrieve Data from the Census APIs. R package version 0.8.0, https://github.com/hrecht/censusapi, https://www.hrecht.com/censusapi/. 

