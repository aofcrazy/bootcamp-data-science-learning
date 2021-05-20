### Package 

library(tidyverse)
library(readxl)
library(rjson)
library(rvest)
library(RSQLite)
library(lubridate)

## read data into RStudio
## 1. CSV file

student1 <- read_csv("student1.csv")
student2 <- read_delim("student2.txt", delim = ";")
student3 <- read_delim("student3.txt", delim = "\t")

## Excel files
student4 <- read_excel("student4.xlsx", "Sheet1")
student5 <- read_excel("student4.xlsx", 2)
student6 <- read_excel("student4.xlsx", 3, skip = 3)

## combine files (Appending files)

student_list <- list(student1,
                     student2,
                     student3,
                     student4,
                     student5,
                     student6)

student_all <- bind_rows(student_list)
 
## Load json files
## JavaScript Object Notation

employee <- fromJSON(file = "employees.json")

employee <- data.frame(employee)

new_employee <- fromJSON(file = "new_employee.json")

new_employee <- data.frame(new_employee)


all_employee <- bind_rows(list(employee, new_employee))        


## load HTML Files
library(rvest)
school_website <- read_html("https://gist.githubusercontent.com/toyeiei/93246c33992805b69b5f84d9ec99fae4/raw/58d656b2b0e51cc6eb1ca5d8bba19f580909e5dd/school_website.html")


school_website %>%
    html_nodes("h2") %>%
    html_text()

teachers <- school_website %>%
    html_nodes("ul li") %>%
    html_text()

companies <- school_website %>%
    html_nodes("ol li") %>%
    html_text()

our_cool_teacher <- data.frame(teachers, companies)
    
## XML Files
emails <- read_xml("https://gist.githubusercontent.com/toyeiei/7495caf051daec2d45d70cb2c3daa251/raw/aaccdae3a6f2c34e9b2c326bdb9b578565c06d37/test_email.xml")



email_content <- emails %>% 
    xml_nodes("content") %>% 
    xml_text()

email_from <- emails %>%
    xml_nodes("from") %>%
    xml_text()

email_date <- emails %>%
    xml_nodes("date") %>%
    xml_text()

email_df <- data.frame(email_content, email_from, email_date)


## SQLite

library(RSQLite)

## create connection
con <- dbConnect(SQLite(), "chinook.db")

dbListTables(con)
dbListFields(con, "customers")


customers <- dbGetQuery(con, "SELECT * FROM CUSTOMERS")


#Check missing Value (NA) in each column in dataframe
x <- c(100, NA, 1000, NA, 29)

sum(is.na(x))

count_NA <- function(x) {
    sum(is.na(x))
}

## apply count_NA to every column in customers
lapply(customers, count_NA)
sapply(customers, count_NA)


## get customers USA
 
country <- "United Kingdom"

dbGetQuery(con, 
           "Select firstname, country from customers where country = ? ", 
           params = country)
 
# Create function to filter country for MARKETING TEAM

get_data_by_country <- function(country) {
    country <- toupper(country)
    dbGetQuery(con, 
               "SELECT firstname, lastname, email,
               country FROM customers where UPPER(country) = ?",
               params = country)
}


# Create function to filter country for MARKETING TEAM
# get text input from user
getDataMkt <- function() {
    country <- toupper(readline("Select Country: "))
    dbGetQuery(con, 
               "SELECT firstname, lastname, email,
               country FROM customers where UPPER(country) = ?",
               params = country)
}

## close connect
dbDisconnect(con)


## read SPSS File (.sav)

library(haven)
staffsurvey <- read_sav("staffsurvey.sav")
View(staffsurvey)




















