README
================
Linoja
2024-11-08

# countmissingvalues

## Package Introduction and Description

The `countmissingvalues` package provides a function designed to help
users count missing values within a dataset by specified groups. This
function is particularly useful for gaining insights into the
distribution of missing data across different groups, helping to
facilitate data cleaning and preprocessing tasks.

### Key Functionality

The main function, `countmissingvalues()`, takes a dataset, a grouping
column, and an optional parameter to control the structure of the
output. The function groups data based on the specified column and
calculates the count of missing values for all other columns, providing
an organized view of missing data patterns.

## Installation Instructions

To install the `countmissingvalues` package from GitHub, you’ll need to
use the `devtools` package. Here’s how to do it:

``` r
# Install devtools if it's not already installed
install.packages("devtools")
```

    ## Error in install.packages : Updating loaded packages

``` r
# Install countmissingvalues package from GitHub
devtools::install_github("stat545ubc-2024/countmissingvalues")
```

    ## Using GitHub PAT from the git credential store.

    ## Skipping install of 'countmissingvalues' from a github remote, the SHA1 (df517005) has not changed since last install.
    ##   Use `force = TRUE` to force installation

### Demonstrated Usage

Once installed, you can start using the countmissingvalues() function as
shown below. The function’s parameters include:

data: A data frame or tibble containing the dataset. group_col: The
column to group by when counting missing values. .groups (optional):
Controls grouping in the output, defaulting to “drop”.

### Example Dataset

For demonstration, you can use the R’s built-in airquality dataset,
which contains air quality measurements in New York for several months.
Since airquality is built into R, users don’t need to upload or install
additional datasets to run the examples below.

Examples 1. Basic Usage Count missing values in the airquality dataset,
grouped by Month:

``` r
library(countmissingvalues)
count_all_missing_by_group(airquality, Month)
```

    ## # A tibble: 5 × 6
    ##   Month Ozone Solar.R  Wind  Temp   Day
    ##   <int> <int>   <int> <int> <int> <int>
    ## 1     5     5       4     0     0     0
    ## 2     6    21       0     0     0     0
    ## 3     7     5       0     0     0     0
    ## 4     8     5       3     0     0     0
    ## 5     9     1       0     0     0     0

2.  Using the Pipe Syntax The function supports piping, allowing you to
    pass the dataset directly into the function:

``` r
airquality |> countmissingvalues::count_all_missing_by_group(Month)
```

    ## # A tibble: 5 × 6
    ##   Month Ozone Solar.R  Wind  Temp   Day
    ##   <int> <int>   <int> <int> <int> <int>
    ## 1     5     5       4     0     0     0
    ## 2     6    21       0     0     0     0
    ## 3     7     5       0     0     0     0
    ## 4     8     5       3     0     0     0
    ## 5     9     1       0     0     0     0

3.  Keeping Grouped Output To retain the grouping in the output tibble,
    set .groups = “keep”:

``` r
count_all_missing_by_group(airquality, Month, .groups = "keep")
```

    ## # A tibble: 5 × 6
    ## # Groups:   Month [5]
    ##   Month Ozone Solar.R  Wind  Temp   Day
    ##   <int> <int>   <int> <int> <int> <int>
    ## 1     5     5       4     0     0     0
    ## 2     6    21       0     0     0     0
    ## 3     7     5       0     0     0     0
    ## 4     8     5       3     0     0     0
    ## 5     9     1       0     0     0     0

### License

This package is licensed under the MIT License.
