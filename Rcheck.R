# indentPattern <- "^(?:\\s{4})*\\s{1,3}\\S"

.check <- function(fileName, pattern = "^(?:\\s{4})*\\s{1,3}\\S|^(?:\\s{4})*\\s{1,3}$"){
    
    if(length(fileName) == 0){
        message("No file.")
        return(NULL)
    }

    message("Checking ", gsub(".*/", "", fileName), " ...")
    foo <- readLines(fileName)
    check <- sapply(1:length(foo), function(ii){
        
        out <- NULL
        
        if(nchar(foo[ii])>80){
            message("** Line #", ii, " >80 char.")
            out <- TRUE
        }
        
        if(grepl("[\t]", foo[ii]))
            if(grepl(pattern, foo[ii])){
                message("** line #", ii, " is indented with tab(s).")
                out <- TRUE
            }
        
        if(grepl(pattern, foo[ii])){
                message("** line #", ii, " not indented with a multiple of 4 spaces.")
                out <- TRUE
            }
        
        return(out)
    })
    
    check <- do.call(c, check)
    if(is.null(check))
        message("No error detected")
    
    message()
}

runCheck <- function(packagePath){

    message("############################")    
    message("Checking DESCRIPTION file...")
    message("############################")    
    path <- file.path(packagePath, "DESCRIPTION")
    .check(path)
    
    message("############################")    
    message("Checking NAMESPACE file...")
    message("############################")    
    path <- file.path(packagePath, "NAMESPACE")
    .check(path)
    
    message("############################")    
    message("Checking R code files...")
    message("############################")    
    path <- file.path(packagePath, "R")
    lf <- list.files(path, full.names = TRUE)
    for(f in lf)
        .check(f)
    
    message("############################")    
    message("Checking Rd files in man...")
    message("############################")    
    path <- file.path(packagePath, "man")
    lf <- list.files(path, full.names = TRUE)
    for(f in lf)
        .check(f)
    
    message("############################")    
    message("Checking vignette.Rnw...")
    message("############################")
    path <- file.path(packagePath, "vignettes")
    f <- list.files(path, full.names = TRUE, pattern = ".Rnw")
    .check(f)
}
