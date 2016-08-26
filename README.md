# typo

Helping people with fat fingers making typos in various functions.

```
# using stringdist::stringdist to calculate the
# string distances between `dlpyr` and the known available packages
# on CRAN
cran_install( "dlpyr" )

# using agrep to find approximate fuzzy matches between "google" and
# available packages, e.g. finds those which start by "google"
cran_install( "google" ) 
```


You can install:

-   the latest development version from github with

```r
    if (packageVersion("devtools") < 1.6) {
      install.packages("devtools")
    }
    devtools::install_github("romainfrancois/typo")
```
