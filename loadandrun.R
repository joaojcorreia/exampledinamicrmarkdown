library(tidyverse)
library(tidyr)
library(xlsx) #to load the excel
library(rmarkdown) #to make the rmarkdown


fulldata <- read.xlsx ('MyData.xlsx', 1) #read the excel and store the data-frame as full data


#Loop to make all the reports#

{
  
  n <- nrow(fulldata) #find out how many records you have
  a <- 1
  
  
  while(a <= n ){
    
    cat(a,' out of ',n) #print out the report number
    data_individual <<- fulldata[a, ] #load one line, corresponding to one individual
    data_individual[is.na(data_individual)] <- '' #remove all NA
    rmarkdown::render(input = "MyReport.Rmd", 
                      output_file =  as.character(  #Generate a file name base on each individual first and last name
                          str_glue(
                            str_replace_all(data_individual[1], " ", "."),
                            str_replace_all(data_individual[2], " ", "."),
                            "pdf", .sep=".")), output_dir = "reports")
      a <- a+1
    
  }
}
