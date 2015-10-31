###### This R code check indentation errors and lines length in all the R package folders.

Files check includes:
- DESCRIPTION
- NAMESPACE
- .R files in the /R folder
- .Rd files in the /man folder
- .Rnw files in the /vignettes folder, when exists.

Detected errors are reported as:
filename
line_num error_type

Set 'saveLog = TRUE' to save the results in 'myPkg_checkFormating_log.txt'

###### Donwload the Rcheck.R file, or source it from Github as follow:

```r
# Install devtools first if needed.
library(devtools)
SourceURL <- "https://raw.github.com/fredcommo/RpackageCheck/master/Rcheck.R"
source_url(SourceURL)

runCheck("path/to/myPackage")
```
