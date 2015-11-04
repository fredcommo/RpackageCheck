# indentPattern <- "^(?:\\s{4})*\\s{1,3}\\S"

.printMessage <- function(txt){
    hash <- "############################"
    msg <- sprintf("Checking %s.", txt)
    return(sprintf("%s\n%s\n%s", hash, msg, hash))
}
.check <- function(fileName, logFile = NULL,
                   pattern = "^(?:\\s{4})*\\s{1,3}\\S|^(?:\\s{4})*\\s{1,3}$"){

    if(length(fileName) == 0){
        message("No file.")
        return(NULL)
    }
        
    msg <- sprintf("Checking %s %s", gsub(".*/", "", fileName), "...")
    message(msg)
    
    if(!is.null(logFile))
        cat(msg, file = logFile, sep = "\n", append = TRUE)
    
    foo <- readLines(fileName)
    check <- sapply(1:length(foo), function(ii){
        
        out <- NULL
        
        if(nchar(foo[ii])>80){
            msg <- sprintf("** Line #%s %s", ii, ">80 char.")
            message(msg)
            if(!is.null(logFile))
                cat(msg, file = logFile, sep = "\n", append = TRUE)
            out <- TRUE
        }
        
        if(grepl("[\t]", foo[ii]))
            if(grepl(pattern, foo[ii])){
                msg <- sprintf("** line #%s %s", ii, "is indented with tab(s).")
                message(msg)
                if(!is.null(logFile))
                    cat(msg, file = logFile, sep = "\n", append = TRUE)
                out <- TRUE
            }
        
        if(grepl(pattern, foo[ii])){
            msg <- sprintf("** line #%s %s", ii, "not indented with a multiple of 4 spaces.")
            message(msg)
            if(!is.null(logFile))
                cat(msg, file = logFile, sep = "\n", append = TRUE)
            out <- TRUE
        }
        
        return(out)
    })
    
    check <- do.call(c, check)
    if(is.null(check)){
        msg <- "No error detected"
        message(msg)
        if(!is.null(logFile))
            cat(msg, file = logFile, sep = "\n", append = TRUE)
    }
    if(!is.null(logFile))
        cat("\n", file = logFile, sep = "\n", append = TRUE)
}

runCheck <- function(packagePath, saveLog = TRUE){
    
    # Init log file
    if(saveLog){
        logPath <- dirname(packagePath)
        pkg <- basename(packagePath)
        logFile <- file.path(logPath, sprintf("%s_checkFormating_log.txt", pkg))
        msg <- sprintf("### Rpackage %s code formating ###\n", pkg)
        cat(msg, file = logFile, sep = "\n")
    }
    
    # Checking DESCRIPTION file
    msg <- .printMessage("DESCRIPTION")
    if(saveLog){
        cat(msg, file = logFile, sep = "\n", append = TRUE)
    }
    cat(msg)
    .check(file.path(packagePath, "DESCRIPTION"), logFile)
    message()

    # Checking NAMESPACE file
    msg <- .printMessage("NAMESPACE")
    if(saveLog){
        cat(msg, file = logFile, sep = "\n", append = TRUE)
    }
    cat(msg)
    .check(file.path(packagePath, "NAMESPACE"), logFile)
    message()

    # Checking R code files
    msg <- .printMessage("R code files...")
    if(saveLog){
        cat(msg, file = logFile, sep = "\n", append = TRUE)
    }
    cat(msg)
    path <- file.path(packagePath, "R")
    lf <- list.files(path, full.names = TRUE)
    for(f in lf){
        .check(f, logFile)
        message()
    }
    
    # Checking Rd files in man
    msg <- .printMessage("Rd files in man...")
    if(saveLog){
        cat(msg, file = logFile, sep = "\n", append = TRUE)
    }
    cat(msg)

    path <- file.path(packagePath, "man")
    lf <- list.files(path, full.names = TRUE)
    for(f in lf){
        .check(f, logFile)
        message()
    }

    # Checking vignette.Rnw
    msg <- .printMessage("vignette.Rnw...")
    if(saveLog){
        cat(msg, file = logFile, sep = "\n", append = TRUE)
    }
    cat(msg)

    path <- file.path(packagePath, "vignettes")
    f <- list.files(path, full.names = TRUE, pattern = ".Rnw")
    .check(f, logFile)
    message()
    cat("log saved at:\n", logFile)
    message()
}
# indentPattern <- "^(?:\\s{4})*\\s{1,3}\\S"

# .check <- function(fileName, pattern = "^(?:\\s{4})*\\s{1,3}\\S|^(?:\\s{4})*\\s{1,3}$"){
#     
#     if(length(fileName) == 0){
#         message("No file.")
#         return(NULL)
#     }
# 
#     message("Checking ", gsub(".*/", "", fileName), " ...")
#     foo <- readLines(fileName)
#     check <- sapply(1:length(foo), function(ii){
#         
#         out <- NULL
#         
#         if(nchar(foo[ii])>80){
#             message("** Line #", ii, " >80 char.")
#             out <- TRUE
#         }
#         
#         if(grepl("[\t]", foo[ii]))
#             if(grepl(pattern, foo[ii])){
#                 message("** line #", ii, " is indented with tab(s).")
#                 out <- TRUE
#             }
#         
#         if(grepl(pattern, foo[ii])){
#                 message("** line #", ii, " not indented with a multiple of 4 spaces.")
#                 out <- TRUE
#             }
#         
#         return(out)
#     })
#     
#     check <- do.call(c, check)
#     if(is.null(check))
#         message("No error detected")
#     
#     message()
# }
# 
# runCheck <- function(packagePath){
# 
#     message("############################")    
#     message("Checking DESCRIPTION file...")
#     message("############################")    
#     path <- file.path(packagePath, "DESCRIPTION")
#     .check(path)
#     
#     message("############################")    
#     message("Checking NAMESPACE file...")
#     message("############################")    
#     path <- file.path(packagePath, "NAMESPACE")
#     .check(path)
#     
#     message("############################")    
#     message("Checking R code files...")
#     message("############################")    
#     path <- file.path(packagePath, "R")
#     lf <- list.files(path, full.names = TRUE)
#     for(f in lf)
#         .check(f)
#     
#     message("############################")    
#     message("Checking Rd files in man...")
#     message("############################")    
#     path <- file.path(packagePath, "man")
#     lf <- list.files(path, full.names = TRUE)
#     for(f in lf)
#         .check(f)
#     
#     message("############################")    
#     message("Checking vignette.Rnw...")
#     message("############################")
#     path <- file.path(packagePath, "vignettes")
#     f <- list.files(path, full.names = TRUE, pattern = ".Rnw")
#     .check(f)
# }
