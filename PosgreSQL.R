library(RPostgreSQL)


# create connection to out PostgreSQL sever

conn <- dbConnect(PostgreSQL(),
                  user = "mnjyoqwy",
                  password = "AL_euAxWP82vgdNjDdpHHHb8VuReVCKd",
                  host = "arjuna.db.elephantsql.com",
                  port = 5432)
conn

dbListTables(conn)

# write table
(students <- data.frame(id = 1:3,
                       firstname = c("John", "William", "Mary")))

dbWriteTable(conn, "students", students)

dbGetQuery(conn, "Select * from students")



# execute create table

query <- "
  CREATE TABLE student_profile (
  id INT,
  major VARCHAR(20),
  submajor VARCHAR(20)
  )
"
query_2 <- " 
  INSERT INTO student_profile VALUES 
  (1, 'Economics', 'Economics'),
  (2, 'Data Science', 'Databases'),
  (3, 'Data Science', 'Machine Learning')
  
"



# create table
dbExecute(conn, query)
dbExecute(conn, query_2)


# list table
dbListTables(conn)

dbGetQuery(conn, "select * from student_profile")

# drop table 

dbExecute(conn, "DROP TABLE student_profile")

dbExecute(conn, "DROP TABLE students")

# close connection
dbDisconnect(conn)

conn

