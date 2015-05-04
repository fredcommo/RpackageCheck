# indentPattern <- "^(?:\\s{4})*\\s{1,3}\\S"

.check <- function(fileName, pattern = "^(?:\\s{4})*\\s{1,3}\\S|^(?:\\s{4})*\\s{1,3}$"){
    
    if(length(fileName) == 0){
        cat("No file.\n")
        return(NULL)
    }

    cat("Checking", fileName, "...\n")
    foo <- readLines(fileName)
    check <- sapply(1:length(foo), function(ii){
        
        out <- NULL
        
        if(nchar(foo[ii])>80){
            cat("** Line", ii, "> 80 char.\n")
            out <- TRUE
        }
        
        if(grepl("[\t]", foo[ii]))
            if(grepl(pattern, foo[ii])){
                cat("** line", ii, "is indented with tab(s)\n")
                out <- TRUE
            }
        
        if(grepl(pattern, foo[ii])){
                cat("** line", ii, "not indented with a multiple of 4 spaces\n")
                out <- TRUE
            }
        
        return(out)
    })
    
    check <- do.call(c, check)
    if(is.null(check))
        cat("No error detected\n")
    
    cat("\n")
}

runCheck <- function(packagePath){

    cat("############################\n")    
    cat("Checking DESCRIPTION file...\n")
    cat("############################\n")    
    path <- file.path(packagePath, "DESCRIPTION")
    .check(path)
    
    cat("############################\n")    
    cat("Checking NAMESPACE file...\n")
    cat("############################\n")    
    path <- file.path(packagePath, "NAMESPACE")
    .check(path)
    
    cat("############################\n")    
    cat("Checking R code files...\n")
    cat("############################\n")    
    path <- file.path(packagePath, "R")
    lf <- list.files(path, full.names = TRUE)
    for(f in lf)
        .check(f)
    
    cat("############################\n")    
    cat("Checking Rd files in man...\n")
    cat("############################\n")    
    path <- file.path(packagePath, "man")
    lf <- list.files(path, full.names = TRUE)
    for(f in lf)
        .check(f)
    
    cat("############################\n")    
    cat("Checking Rnw files in vignettes...\n")
    cat("############################\n")
    path <- file.path(packagePath, "vignettes")
    f <- list.files(path, full.names = TRUE, pattern = ".Rnw")
    .check(f)
}
