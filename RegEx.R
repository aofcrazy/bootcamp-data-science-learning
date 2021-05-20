## Regular Expresstion in R

state.name

## Start with A
grep("^A", state.name, value = T)


## End with e
grep("e$", state.name, value = T)


## Start with N end with e
grep("N[a-zA-Z ]+e$", state.name, value = T)

## Match state.name that has " " white space 
grep("\\s", state.name, value = T)

## grepl sibling
state.name[grepl("S", state.name, ignore.case = T)]


##sub
sub("A", "Hello", state.name)

