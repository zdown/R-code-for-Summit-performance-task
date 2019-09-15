setwd("C:/Users/zdowning/Desktop/Summit Performance Task")


#### INSTALL PACKAGES #### 
library(plyr) 

#### READ DATA SETS #### 

wa_roster <-
  read.csv(
    file.choose(),
    stringsAsFactors = FALSE,
    strip.white = TRUE,
    na.strings = c("NA", "")
  ) 
View(wa_roster)

ca_roster <-
  read.csv(
    file.choose(),
    stringsAsFactors = FALSE,
    strip.white = TRUE,
    na.strings = c("NA", "")
  ) 
View(ca_roster)

wa_demographics <-
  read.csv(
    file.choose(),
    stringsAsFactors = FALSE,
    strip.white = TRUE,
    na.strings = c("NA", "")
  ) 
View(wa_demographics)

ca_demographics <-
  read.csv(
    file.choose(),
    stringsAsFactors = FALSE,
    strip.white = TRUE,
    na.strings = c("NA", "")
  ) 
View(ca_demographics)

#### Re-order columns ####
wa_demographics <- wa_demographics[c("ID", "GENDER", "RACE_ETHNICITY", "IEP")]

wa_roster <- wa_roster[c("ID", "STUDENT_NUMBER", "NAME", "LAST_NAME", "FIRST_NAME", "GRADE_LEVEL")]


#### Match the names of the columns in each file type ####
colnames(wa_demographics)
colnames(ca_demographics)

colnames(ca_demographics)
names(ca_demographics)[1:4] <-
  c(
    "ID",
    "GENDER",
    "RACE_ETHNICITY",
    "IEP"
  ) 
colnames(ca_demographics)
colnames(wa_demographics)

colnames(wa_roster)
colnames(ca_roster)

colnames(ca_roster)
names(ca_roster)[1:6] <-
  c(
    "ID",
    "STUDENT_NUMBER",
    "SITE_NAME",
    "LAST_NAME",
    "FIRST_NAME",
    "GRADE_LEVEL"
  ) 
colnames(ca_roster)
colnames(wa_roster)

colnames(wa_roster)
names(wa_roster)[1:6] <-
  c(
    "ID",
    "STUDENT_NUMBER",
    "SITE_NAME",
    "LAST_NAME",
    "FIRST_NAME",
    "GRADE_LEVEL"
  ) 
colnames(wa_roster)
colnames(ca_roster)

#### remove the student number column from WA demographics and ID column from CA demographics ####

wa_roster_final <- wa_roster
View(wa_roster_final)

wa_roster_final <-
  subset(wa_roster_final, select = -c(STUDENT_NUMBER))

ca_roster_final <- ca_roster
View(ca_roster_final)

ca_roster_final <-
  subset(ca_roster_final, select = -c(ID))

#### rename columns again to match ####

colnames(wa_roster_final)
names(wa_roster_final)[1:5] <-
  c(
    "ID",
    "SITE_NAME",
    "LAST_NAME",
    "FIRST_NAME",
    "GRADE_LEVEL"
  ) 

colnames(ca_roster_final)
names(ca_roster_final)[1:5] <-
  c(
    "ID",
    "SITE_NAME",
    "LAST_NAME",
    "FIRST_NAME",
    "GRADE_LEVEL"
  ) 

colnames(wa_roster_final)
colnames(ca_roster_final)

#### combine roster and demographics data frames ####

combo_roster_final <- rbind(ca_roster_final,wa_roster_final) 
View(combo_roster_final)

plyr::count(combo_roster_final$SITE_NAME)

combo_demographics <- rbind(ca_demographics,wa_demographics) 
View(combo_demographics)


#### vlookup/outer join to create single dataframe ####

summit_data_final = merge(combo_demographics[, c("ID", "GENDER", "RACE_ETHNICITY", "IEP")], 
                  combo_roster_final[, c("ID", "SITE_NAME", "LAST_NAME", "FIRST_NAME", "GRADE_LEVEL")],all.x = TRUE) 


View(summit_data_final)


#### check column data for weird things ####

plyr::count(summit_data_final$SITE_NAME)

plyr::count(summit_data_final$GENDER)

plyr::count(summit_data_final$GRADE_LEVEL)

plyr::count(summit_data_final$IEP)

plyr::count(summit_data_final$RACE_ETHNICITY)

#### export final file ####

write.csv(summit_data_final,           
          file = "summit_data_final_9.15.19.csv",
          row.names = FALSE, na = "")

