############ VARIOUS SCHEDULES CLEANING ###################
### All schedules can be downlaoded direclty from DOT database


#### B1 ASSETS CASH LIABILITY Quarterly #### 

b1 = read.csv("B1.csv", stringsAsFactors =  FALSE)
colnames(b1)

b1 = subset(b1,YEAR >= 2004)
b1 = subset(b1, REGION == "D")

#### subset useful columns 
dlist = c( "CASH","CURR_ASSETS", "PROP_EQUIP", "PROP_EQUIP_NO_TOT", "ASSETS",
           "CURR_LIABILITIES","NON_REC_LIAB", "SH_HLD_EQUITY", "LIAB_SH_HLD_EQUITY",
           "CARRIER_NAME","YEAR","QUARTER")

b1new = b1[,dlist]

### delete cargo airline

b1new =b1new[!grepl("Cargo", b1new$CARRIER_NAME),]
b1new =b1new[!grepl("Parcel", b1new$CARRIER_NAME),]

### name changes
b1new$CARRIER_NAME = toupper(b1new$CARRIER_NAME)

b1new$CARRIER_NAME <- str_replace(b1new$CARRIER_NAME,"AMERICAN EAGLE","ENVOY")
b1new$CARRIER_NAME <- str_replace(b1new$CARRIER_NAME,"ATLANTIC COAST","INDEPENDENCE")
b1new$CARRIER_NAME <- str_replace(b1new$CARRIER_NAME,"PINNACLE","ENDEAVOR")


# remove for extraction of first word
b1new =b1new[!grepl("CONTINENTAL MICRONESIA", b1new$CARRIER_NAME),]


### clean airline names by extracting the first word
library(stringr)
b1new$airline = word(b1new$CARRIER_NAME,1) 

# Add back deleted second word for two airlines
b1new$airline <- str_replace(b1new$airline,"ATLANTIC","ATLANTIC SOUTHEAST")
b1new$airline = gsub("\\AMERICA\\>","AMERICA WEST",b1new$airline)

### change year and quarter column names
colnames(b1new)[grep("YEAR", colnames(b1new))] <-"year"
colnames(b1new)[grep("QUARTER", colnames(b1new))] <-"quarter"
sort(unique(b1new$airline))

b1new$CARRIER_NAME = NULL


### save files
write.csv(b1new, file = "b1final.csv")



########################################### P1A FTEMP Monthly  ########

p1a= read.csv("P1A.csv", stringsAsFactors =  FALSE)
colnames(p1a)

p1a = subset(p1a,YEAR >= 2004)

#### subset useful columns 
dlist = c( "YEAR", "MONTH","CARRIER_NAME","EMPFTE")

p1anew = p1a[,dlist]

### delete cargo airline

p1anew =p1anew[!grepl("Cargo", p1anew$CARRIER_NAME),]
p1anew =p1anew[!grepl("Parcel", p1anew$CARRIER_NAME),]
p1anew$quarter <- ceiling(as.numeric(p1anew$MONTH) / 3)

### name changes
p1anew$CARRIER_NAME = toupper(p1anew$CARRIER_NAME)

p1anew$CARRIER_NAME <- str_replace(p1anew$CARRIER_NAME,"AMERICAN EAGLE","ENVOY")
p1anew$CARRIER_NAME <- str_replace(p1anew$CARRIER_NAME,"ATLANTIC COAST","INDEPENDENCE")
p1anew$CARRIER_NAME <- str_replace(p1anew$CARRIER_NAME,"PINNACLE","ENDEAVOR")


# remove for extraction of first word
p1anew =p1anew[!grepl("CONTINENTAL MICRONESIA", p1anew$CARRIER_NAME),]

# change YEAR column to lower case for further aggregation
colnames(p1anew)[grep("YEAR", colnames(p1anew))] <-"year"

#### clean airline names by extracting the first word
library(stringr)
p1anew$airline = word(p1anew$CARRIER_NAME,1) 
p1anew$airline = toupper(p1anew$airline)

p1anew$airline <- str_replace(p1anew$airline,"ATLANTIC","ATLANTIC SOUTHEAST")
p1anew$airline = gsub("\\AMERICA\\>","AMERICA WEST",p1anew$airline)

# drop UNIQUE column
p1anew$CARRIER_NAME = NULL

# aggreate to quarterly level 
p1a_q = aggregate(. ~airline + year + quarter, p1anew, sum, na.rm=TRUE)

# remove month column
p1a_q$MONTH = NULL


### save files
write.csv(p1anew, file = "p1afinal_month.csv")
write.csv(p1a_q, file = "p1afinal.csv")



#########  P6 Salary Landing Fee QUARTERLY ##########

p6= read.csv("P6.csv", stringsAsFactors =  FALSE)
colnames(p6)

p6 = subset(p6,YEAR >= 2004)
p6= subset(p6, REGION == "D")

dlist = c("SALARIES","LANDING_FEES", "CARRIER_NAME","YEAR","QUARTER")

p6new = p6[,dlist]

### delete cargo airline

p6new =p6new[!grepl("Cargo", p6new$CARRIER_NAME),]
p6new =p6new[!grepl("Parcel", p6new$CARRIER_NAME),]

### name changes
p6new$CARRIER_NAME = toupper(p6new$CARRIER_NAME)
p6new$CARRIER_NAME <- str_replace(p6new$CARRIER_NAME,"AMERICAN EAGLE","ENVOY")
p6new$CARRIER_NAME <- str_replace(p6new$CARRIER_NAME,"ATLANTIC COAST","INDEPENDENCE")
p6new$CARRIER_NAME <- str_replace(p6new$CARRIER_NAME,"PINNACLE","ENDEAVOR")

# remove for extraction of first word
p6new =p6new[!grepl("CONTINENTAL MICRONESIA", p6new$CARRIER_NAME),]

# change YEAR column to lower case for further aggregation
colnames(p6new)[grep("YEAR", colnames(p6new))] <-"year"
colnames(p6new)[grep("QUARTER", colnames(p6new))] <-"quarter"

#### clean airline names by extracting the first word
library(stringr)
p6new$airline = word(p6new$CARRIER_NAME,1) 
p6new$airline = toupper(p6new$airline)

p6new$airline <- str_replace(p6new$airline,"ATLANTIC","ATLANTIC SOUTHEAST")
p6new$airline = gsub("\\AMERICA\\>","AMERICA WEST", p6new$airline)

# drop UNIQUE column
p6new$CARRIER_NAME = NULL

### save files
write.csv(p6new, file = "p6final.csv")



#########  P12 NET_Income OP_Profit_Loss OP_Revenue OP_Expenses Quarterly ##########

p12= read.csv("P12.csv", stringsAsFactors =  FALSE)
colnames(p12)

p12 = subset(p12,YEAR >= 2004)
p12= subset(p12, REGION == "D")


dlist = c("NET_INCOME", "OP_PROFIT_LOSS", "TRANS_REV_PAX","MAIL","TOTAL_PROPERTY",
          "PROP_FREIGHT", "PROP_BAG",  "OP_REVENUES", "OP_EXPENSES", "CARRIER_NAME",
          "YEAR" ,"QUARTER")

p12new = p12[,dlist]


### delete cargo airline

p12new =p12new[!grepl("Cargo", p12new$CARRIER_NAME),]
p12new =p12new[!grepl("Parcel", p12new$CARRIER_NAME),]

### name changes
p12new$CARRIER_NAME = toupper(p12new$CARRIER_NAME)
p12new$CARRIER_NAME <- str_replace(p12new$CARRIER_NAME,"AMERICAN EAGLE","ENVOY")
p12new$CARRIER_NAME <- str_replace(p12new$CARRIER_NAME,"ATLANTIC COAST","INDEPENDENCE")
p12new$CARRIER_NAME <- str_replace(p12new$CARRIER_NAME,"PINNACLE","ENDEAVOR")



# remove for extraction of first word
p12new =p12new[!grepl("CONTINENTAL MICRONESIA", p12new$CARRIER_NAME),]

# change YEAR column to lower case for further aggregation
colnames(p12new)[grep("YEAR", colnames(p12new))] <-"year"
colnames(p12new)[grep("QUARTER", colnames(p12new))] <-"quarter"

#### clean airline names by extracting the first word
library(stringr)
p12new$airline = word(p12new$CARRIER_NAME,1) 
p12new$airline = toupper(p12new$airline)

p12new$airline <- str_replace(p12new$airline,"ATLANTIC","ATLANTIC SOUTHEAST")
p12new$airline = gsub("\\AMERICA\\>","AMERICA WEST", p12new$airline)

# drop UNIQUE column
p12new$CARRIER_NAME = NULL

### save files
write.csv(p12new, file = "p12final.csv")



#########  P12A FUEL COST and GALLON Monthly ##########

p12a= read.csv("P12A.csv", stringsAsFactors =  FALSE)
colnames(p12a)

p12a = subset(p12a,YEAR >= 2004)

dlist = c("YEAR","QUARTER","MONTH", "CARRIER_NAME","TDOMT_GALLONS","TDOMT_COST")

p12anew = p12a[,dlist]
library(dplyr)
glimpse(p12a)


### delete cargo airline
p12anew =p12anew[!grepl("Cargo", p12anew$CARRIER_NAME),]
p12anew =p12anew[!grepl("Parcel", p12anew$CARRIER_NAME),]


### name changes
p12a_q = p12anew
p12a_q$CARRIER_NAME = toupper(p12a_q$CARRIER_NAME)

p12a_q$CARRIER_NAME <- str_replace(p12a_q$CARRIER_NAME,"AMERICAN EAGLE","ENVOY")
p12a_q$CARRIER_NAME <- str_replace(p12a_q$CARRIER_NAME,"ATLANTIC COAST","INDEPENDENCE")
p12a_q$CARRIER_NAME <- str_replace(p12a_q$CARRIER_NAME,"PINNACLE","ENDEAVOR")


# remove for extraction of first word
p12a_q =p12a_q[!grepl("CONTINENTAL MICRONESIA", p12a_q$CARRIER_NAME),]

# change YEAR column to lower case for further aggregation
colnames(p12a_q)[grep("YEAR", colnames(p12a_q))] <-"year"
colnames(p12a_q)[grep("QUARTER", colnames(p12a_q))] <-"quarter"


#### clean airline names by extracting the first word
library(stringr)
p12a_q$airline = word(p12a_q$CARRIER_NAME,1) 
p12a_q$airline = toupper(p12a_q$airline)

p12a_q$airline <- str_replace(p12a_q$airline,"ATLANTIC","ATLANTIC SOUTHEAST")
p12a_q$airline = gsub("\\AMERICA\\>","AMERICA WEST",p12a_q$airline)

# drop UNIQUE column
p12a_q$CARRIER_NAME = NULL

# aggreate to quarterly level 
p12a_agt = aggregate(. ~airline + year + quarter, p12a_q, sum, na.rm=TRUE)

# remove month column
p12a_agt$MONTH = NULL


### save files
write.csv(p12a_q, file = "p12afinal_month.csv")
write.csv(p12a_agt, file = "p12afinal.csv")




#########  T1 Enplaned Passengers Load Factor Monthly ##########

t1= read.csv("T1.csv", stringsAsFactors =  FALSE)

# subset Only US Domestic and Z service class (All included). Refer to T1_Service_Class table
t1= subset(t1, REGION == "D" & SERVICE_CLASS == "Z")
t1 = subset(t1,YEAR >= 2004)

dlist =c("YEAR","QUARTER", "MONTH","CARRIER_NAME","REV_PAX_ENP_110", "REV_PAX_MILES_140",
         "REV_TON_MILES_240", "AVL_TON_MILES_280","AVL_SEAT_MILES_320", "REV_ACRFT_MILES_FLOWN_410",
         "REV_ACRFT_MILES_SCH_430","REV_ACRFT_HRS_AIRBORNE_610","ACRFT_HRS_RAMPTORAMP_630")

t1new = t1[,dlist]

# rename column names
colnames(t1new) = c("year","quarter", "month","CARRIER_NAME","RevPaxEnplaned", "RevPaxMiles",
         "RevTonMiles", "AvlTonMiles","AvlSeatMiles", "RevMilesFlown",
         "RevMileSched","RevAirHours","AirHourRamp2Ramp")

# delete cargo airlines
t1new =t1new[!grepl("Cargo", t1new$CARRIER_NAME),]
t1new =t1new[!grepl("Parcel", t1new$CARRIER_NAME),]
t1new =t1new[!grepl("Alaska Central Express", t1new$CARRIER_NAME),]
t1new =t1new[!grepl("Alaska Seaplane Service", t1new$CARRIER_NAME),]
t1new =t1new[!grepl("Aloha Island Air", t1new$CARRIER_NAME),]
t1new =t1new[!grepl("Frontier Flying Service", t1new$CARRIER_NAME),]
t1new =t1new[!grepl("Frontier Horizon Inc.", t1new$CARRIER_NAME),]

### name changes
t1_q = t1new

t1_q$CARRIER_NAME = toupper(t1_q$CARRIER_NAME)
t1_q$CARRIER_NAME <- str_replace(t1_q$CARRIER_NAME,"AMERICAN EAGLE","ENVOY")
t1_q$CARRIER_NAME <- str_replace(t1_q$CARRIER_NAME,"ATLANTIC COAST","INDEPENDENCE")
t1_q$CARRIER_NAME <- str_replace(t1_q$CARRIER_NAME,"PINNACLE","ENDEAVOR")

# remove for extraction of first word
t1_q =t1_q[!grepl("CONTINENTAL MICRONESIA", t1_q$CARRIER_NAME),]


#### clean airline names by extracting the first word
library(stringr)
t1_q$airline = word(t1_q$CARRIER_NAME,1) 
t1_q$airline = toupper(t1_q$airline)

t1_q$airline <- str_replace(t1_q$airline,"ATLANTIC","ATLANTIC SOUTHEAST")
t1_q$airline = gsub("\\AMERICA\\>","AMERICA WEST",t1_q$airline)

t1_q$CARRIER_NAME = NULL

# aggreate to quarterly level 
t1_agt = aggregate(. ~airline + year + quarter, t1_q, sum, na.rm=TRUE)

# remove month column
t1_agt$month = NULL


### save files
write.csv(t1_q, file = "t1final_month.csv")
write.csv(t1_agt, file = "t1final.csv")



#########  P52 Fleet Utilization and Fleet Heterogeneity Quarterly ##########

p52= read.csv("D:/Documents/Dissertation/2017 Dis Data/5. Schedules/p52.csv", 
              stringsAsFactors =  FALSE)

p52 = subset(p52,YEAR >= 2004)
p52= subset(p52, REGION == "D")

dlist = c("YEAR", "QUARTER","CARRIER_NAME", "AIRCRAFT_GROUP", "TOT_FLY_OPS","TOTAL_AIR_HOURS", "AIR_DAYS_ASSIGN")
p52new = p52[,dlist]


### delete cargo airline

p52new =p52new[!grepl("Cargo", p52new$CARRIER_NAME),]
p52new =p52new[!grepl("Parcel", p52new$CARRIER_NAME),]


### name changes
library(stringr)
p52new$CARRIER_NAME = toupper(p52new$CARRIER_NAME)
p52new$CARRIER_NAME <- str_replace(p52new$CARRIER_NAME,"AMERICAN EAGLE","ENVOY")
p52new$CARRIER_NAME <- str_replace(p52new$CARRIER_NAME,"ATLANTIC COAST","INDEPENDENCE")
p52new$CARRIER_NAME <- str_replace(p52new$CARRIER_NAME,"PINNACLE","ENDEAVOR")

# remove for extraction of first word
p52new =p52new[!grepl("CONTINENTAL MICRONESIA", p52new$CARRIER_NAME),]

# change YEAR column to lower case for further aggregation
colnames(p52new)[grep("YEAR", colnames(p52new))] <-"year"
colnames(p52new)[grep("QUARTER", colnames(p52new))] <-"quarter"


#### clean airline names by extracting the first word
library(stringr)
p52new$airline = word(p52new$CARRIER_NAME,1) 
p52new$airline = toupper(p52new$airline)

p52new$airline <- str_replace(p52new$airline,"ATLANTIC","ATLANTIC SOUTHEAST")
p52new$airline = gsub("\\AMERICA\\>","AMERICA WEST", p52new$airline)
colnames(p52new)

p52new$CARRIER_NAME = NULL


# create fleet heterogeneity Quarterly
library(dplyr)
aircraftype = p52new %>% count(airline, year, quarter, AIRCRAFT_GROUP) %>%
  group_by(airline, year, quarter) %>% 
  mutate(totaln = sum(n)) 

aircraftype$percent = aircraftype$n/aircraftype$totaln
aircraftype$percentsq = aircraftype$percent*aircraftype$percent

type2 = aircraftype %>% group_by(airline, year, quarter) %>%
  mutate(totalpercent = sum (percentsq))

type3 = type2 %>% select(airline, year, quarter, totalpercent)
type4 = type3[!duplicated(type3), ]
type4$hetero = 1- type4$totalpercent


# aggreate 
p52_a = aggregate(. ~airline + year + quarter, p52new, sum, na.rm=TRUE)
p52_a$AIRCRAFT_GROUP = NULL

p52_a = left_join(p52_a, type4, by = c("airline", "year", "quarter"))


### save files
write.csv(p52_a, file = "p52final.csv")

