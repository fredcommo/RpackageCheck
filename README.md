#### Donwload the Rcheck.R file
#### Or source it from Github:

```r
# Install devtools first if needed.
library(devtools)
SourceURL <- "https://raw.github.com/fredcommo/RpackageCheck/master/Rcheck.R"
source_url(SourceURL)

runCheck("path/to/myPackage")
```
