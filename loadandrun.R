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
    
    cat(a,' out of ',n)
    data_individual <<- fulldata[a, ] #load one line, corresponding to one individual
    data_individual[is.na(data_individual)] <- '' #remove all NA
    dados_grafico()
    rmarkdown::render(input = "MyReport.Rmd", output_file = 'myreport.pdf', output_dir = "reports")
    myfilename <- as.character(  #Generate a file name base on each individual first and last name
      str_glue(
        str_replace_all(data_individual[1], " ", "."),
        str_replace_all(data_individual[2], " ", "."),
        "pdf", .sep="."))
    file.rename( '~/reports/myreport.pdf', str_glue('~/relatorios/',myfilename)) #change the file name to the individual name. I chose to to it like this because there are issues with the character encoding if the sistem is not in UTF8
    a <- a+1
    
  }
}
