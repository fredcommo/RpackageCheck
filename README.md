###### This R code check files for indentation errors and lines length in all the R package folders.
The check includes
- DESCRIPTION
- NAMESPACE
- .R in the /R folder
- .Rd in the /man folder
- .Rnw in the /vignettes folder, when exists.

Detected errors are reported as:
filename
line_num error_type

###### Donwload the Rcheck.R file, or source it from Github as follow:

```r
# Install devtools first if needed.
library(devtools)
SourceURL <- "https://raw.github.com/fredcommo/RpackageCheck/master/Rcheck.R"
source_url(SourceURL)

runCheck("path/to/myPackage")
```
