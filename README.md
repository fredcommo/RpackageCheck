###### This R code check files for indentation errors and lines length in all the R package folders. The check includes 'DESCRIPTION', 'NAMESPACE', .R in the /R folder, .Rd in the /man folder, and .Rnw in the /vignettes folder, when exists.
###### detected errors are indicated as <filename> <#line> <error type>

###### Donwload the Rcheck.R file, or source it from Github as follow:

```r
# Install devtools first if needed.
library(devtools)
SourceURL <- "https://raw.github.com/fredcommo/RpackageCheck/master/Rcheck.R"
source_url(SourceURL)

runCheck("path/to/myPackage")
```
