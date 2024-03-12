######################## Cleaning T100 Data #########################################

# Database name: Database Name: Air Carrier Statistics (Form 41 Traffic)- U.S. Carriers

library(dplyr)
library(stringr)

#### Read in Files

t100 = read.csv("T100_Total.csv")

# check column names
colnames(t100)

#### select useful columns

test1 = unique(t100$CARRIER_NAME)
test2 = unique(t100$UNIQUE_CARRIER_NAME)


#### subset useful columns 
dlist = c( "DEPARTURES_PERFORMED", "REGION" , "ORIGIN" , "AIRCRAFT_TYPE",
           "AIR_TIME",
           "CARRIER_NAME","YEAR","QUARTER")

t100new = t100[,dlist]

### delete cargo airline

t100new = t100new[!grepl("Cargo", t100new$CARRIER_NAME),]
t100new = t100new[!grepl("Parcel", t100new$CARRIER_NAME),]

### name changes
t100new$CARRIER_NAME = toupper(t100new$CARRIER_NAME)

t100new$CARRIER_NAME <- str_replace(t100new$CARRIER_NAME,"AMERICAN EAGLE","ENVOY")
t100new$CARRIER_NAME <- str_replace(t100new$CARRIER_NAME,"ATLANTIC COAST","INDEPENDENCE")
t100new$CARRIER_NAME <- str_replace(t100new$CARRIER_NAME,"PINNACLE","ENDEAVOR")


# remove for extraction of first word
t100new = t100new[!grepl("CONTINENTAL MICRONESIA", t100new$CARRIER_NAME),]


### clean airline names by extracting the first word
t100new$airline = word(t100new$CARRIER_NAME,1) 

# Add back deleted second word for two airlines
t100new$airline = str_replace(t100new$airline,"ATLANTIC","ATLANTIC SOUTHEAST")
t100new$airline = gsub("\\AMERICA\\>","AMERICA WEST",t100new$airline)

### change year and quarter column names
colnames(t100new)[grep("YEAR", colnames(t100new))] <-"year"
colnames(t100new)[grep("QUARTER", colnames(t100new))] <-"quarter"

sort(unique(t100new$airline))

t100new$CARRIER_NAME = NULL

# extract only domestic flights belonging to region D
t100new = t100new[t100new$REGION == "D",] 

### save files
write.csv(t100new, file = "T100_cleaned.csv")

###########################################################
t100new = read.csv("T100_cleaned.csv")
t100new$X = NULL

### Create Total Number of Flights for each quarter for each carrier
colnames(t100new)

nflight = t100new %>% group_by(year, quarter, airline, ORIGIN) %>% 
  summarise(TotalFlights = sum(DEPARTURES_PERFORMED))

nflight_grand = nflight %>% group_by(year, quarter, airline) %>% 
  summarise(GrandTotalFlights = sum(TotalFlights))


nflight = nflight %>% left_join(nflight_grand, by = c("year","quarter","airline"))

nflight$Percent = nflight$TotalFlights/nflight$GrandTotalFlights * nflight$TotalFlights/nflight$GrandTotalFlights

# Sparsity
sparsity = nflight %>% group_by(year, quarter, airline) %>% 
  summarise(sparsity = sum(Percent)) %>% 
  left_join(nflight_grand, by = c("year","quarter","airline"))

write.csv(sparsity, file = "sparsity.csv", row.names = F)

#### create Aircraft Types

aircraft_type = t100new %>% group_by(year, quarter, airline, AIRCRAFT_TYPE) %>% 
  summarise(TotalAirTime = sum(AIR_TIME))

aircraft_type_grand = t100new %>% group_by(year, quarter, airline) %>% 
  summarise(GrandTotal = sum(AIR_TIME))

aircraft_type = aircraft_type %>% left_join(aircraft_type_grand, 
                                            by = c("year","quarter","airline"))

aircraft_type$Percent = aircraft_type$TotalAirTime/aircraft_type$GrandTotal * aircraft_type$TotalAirTime/aircraft_type$GrandTotal


# heterogeneity

fleet_hetero = aircraft_type %>% group_by(year, quarter, airline) %>% 
  summarise(percent2= sum(Percent))
fleet_hetero$heterogeneity  = 1 - fleet_hetero$percent2

write.csv(fleet_hetero, file = "fleet_hetero.csv", row.names = F)


  
  
  
  
  
  
  
  