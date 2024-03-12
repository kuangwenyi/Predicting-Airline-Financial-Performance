######################## COMBINING ALL FILES #########################################
######## Using output files from Schedules Cleaning.R ###############################

library(dplyr)

#### Read in Files from previous 5 steps

otp = read.csv("1. OTP/otptotal.csv")
otp = otp[,-1]

cc = read.csv("3. Consumer Complaints/cctotal_f.csv")
cc = cc[,-1]

mb = read.csv("2. Mishandled Bag/mbtotal.csv")
mb = mb[,-1]

b1 = read.csv("5. Schedules/b1final.csv")
b1 = b1[,-1]

p1a = read.csv("5. Schedules/p1afinal_f.csv")
p1a = p1a[,-1]

p1a_month = read.csv("5. Schedules/p1afinal_month.csv")
p1a_month = p1a_month[,-1]
colnames(p1a_month)[names(p1a_month) == "MONTH"]= "month"

p6 = read.csv("5. Schedules/p6final.csv")
p6 = p6[,-1]

p12 = read.csv("5. Schedules/p12final.csv")
p12 = p12[,-1]

p12a = read.csv("5. Schedules/p12afinal_f.csv")
p12a = p12a[,-1]

p12a_month = read.csv("5. Schedules/p12afinal_month.csv")
p12a_month = p12a_month[,-1]
colnames(p12a_month)[names(p12a_month) == "MONTH"]= "month"

t1 = read.csv("5. Schedules/t1final.csv")
t1 = t1[,-1]
t1_month = read.csv("5. Schedules/t1final_month_f.csv")
t1_month = t1_month[,-1]

p52 = read.csv("5. Schedules/p52final.csv")
p52 = p52[,-1]

sparsity = read.csv("sparsity.csv")
hetero = read.csv("fleet_hetero.csv")
hetero$percent2 = NULL

## count duplicate values based on Month and Quarter. 
## Revised files are marked with _f
test = otp %>% count(airline, year, month)
test2 = test[,c("airline", "n")]
test3 = test2[!duplicated(test2),]

test = t1 %>% count(airline, year, quarter)
test2 = test[,c("airline", "n")]
test3 = test2[!duplicated(test2),]



#### Drop OTP unused variables
dlist = c("X..ONTIME", "X..CANCELLED","X..DIVERTED", "X..AIR.CARRIER.DELAY","X..EXTREME.WEATHER.DELAY",
          "X..NAS.DELAY", "X..SECURITY.DELAY", "X..LATE.ARRIVING.AIRCRAFT.DELAY")
otp[,dlist] = NULL


#### 1. Combined all monthly data into Monthly Format ####
#### P12, P52, P6, B1, sparsity, hetero: only have quarterly data available. 
# Use quarterly for each month
otp_joined = left_join(otp, mb %>% select(-quarter), by = c("airline", "year", "month")) %>%
  left_join(cc%>% select(-quarter), by = c("airline", "year", "month")) %>%
  left_join(p12a_month %>% select(-quarter), by = c("airline", "year", "month")) %>%
  left_join(p1a_month %>% select(-quarter), by = c("airline", "year", "month")) %>%
left_join(t1_month %>% select(-quarter), by = c("airline", "year", "month"))


write.csv(otp_joined, file = "E1_Monthly_2024.csv")



############## 2. Aggregate to quarterly level and make everything quarterly ##################

otp_q = aggregate(. ~airline + year + quarter,otp, sum, na.rm=TRUE)
otp_q$month =NULL
otp_q$totaldelay= otp_q$CANCELLED + otp_q$DIVERTED + otp_q$AIR.CARRIER.DELAY + 
  otp_q$EXTREME.WEATHER.DELAY + otp_q$NAS.DELAY + otp_q$SECURITY.DELAY + 
  otp_q$LATE.ARRIVING.AIRCRAFT.DELAY

# aggregate consumer complaint data
cc_q = aggregate(. ~airline + year + quarter, cc, sum, na.rm=TRUE)
cc_q$month =NULL


# aggregate mishandled baggage data
mb$rank = NULL
mb$enplaned.passengers = as.numeric(mb$enplaned.passengers)
mb$totalbag = as.numeric(mb$totalbag)

mb_q = aggregate(. ~airline + year + quarter, mb, sum, na.rm=TRUE)
mb_q$month =NULL


#### check intersect names
library(stringr)
sort(intersect(str_trim(otp$airline), str_trim(cc$airline)))


##### Merge data
data_quarter = left_join(otp_q, mb_q,by = c("airline","year","quarter")) %>%
  left_join(cc_q,by = c("airline","year","quarter")) %>%
  left_join(b1, by = c("airline","year","quarter")) %>%
  left_join(p12, by = c("airline","year","quarter")) %>%
  left_join(p12a, by = c("airline","year","quarter")) %>%
  left_join(p1a, by = c("airline","year","quarter"))%>%
  left_join(p52, by = c("airline","year","quarter")) %>%
  left_join(p6, by = c("airline","year","quarter")) %>%
  left_join(t1, by = c("airline","year","quarter")) %>%
  left_join(sparsity, by = c("airline","year","quarter")) %>%
  left_join(hetero, by = c("airline","year","quarter"))

# create another file
essay15 = data_quarter

essay15$LFP= essay15$RevPaxMiles/essay15$AvlSeatMiles

essay15$yieldPAX = essay15$TRANS_REV_PAX/essay15$RevPaxMiles*1000 # unit in dollars

essay15$fleetutil = (essay15$TOTAL_AIR_HOURS/24)/essay15$AIR_DAYS_ASSIGN # both in days

essay15$AvgLandingFee = essay15$LANDING_FEES/essay15$GrandTotalFlights*1000 # unit in dollars

essay15$FuelEff = essay15$AvlSeatMiles/essay15$TDOMT_GALLONS # both measures are in 000


essay15$FuelEff[is.infinite(essay15$FuelEff)] = 0

essay15$FuelEff


colnames(essay15)

# create YearQ index
essay15$YearQ = paste(essay15$year, essay15$quarter,sep="")

### add LCC dummy for six Low-cost carriers
dlist = c("ALLEGIANT", "FRONTIER", "JETBLUE", "SOUTHWEST", "SPIRIT", "VIRGIN")
essay15$LCC = ifelse(essay15$airline %in% dlist, 1, 0)

### add recession dummy from 2008Q1 to 2009Q2
essay15$recession = ifelse(essay15$YearQ >= 20081 & essay15$YearQ <= 20092, 1, 0)



### add GDP and Fare
# per capita
percapita_gdp = read.csv("pgdp2022.csv")
colnames(percapita_gdp) = c("date", "percpita_gdp")
rowfake = c("2021", "99999","2021")
percapita_gdp = rbind(percapita_gdp,rowfake)

percapita_gdp$year = rep(2004:2021, each = 4)
percapita_gdp$quarter = rep(1:4,each = 1)
percapita_gdp = percapita_gdp[,-1]

percapita_gdp$percpita_gdp = as.numeric(percapita_gdp$percpita_gdp)

# percent change
percent_gdp = read.csv("pgdp_percent_2022.csv")
colnames(percent_gdp) = c("date", "percent_gdp")
rowfake = c("2021","1")
percent_gdp = rbind(percent_gdp,rowfake)


percent_gdp$year = rep(2004:2021, each = 4)
percent_gdp$quarter = rep(1:4,each = 1)
percent_gdp = percent_gdp[,-1]

# fare
library(readxl)
fare = read_excel("fare2022.xlsx")
colnames(fare) = c("year", "quarter","avg_fare", "adj_avg_fare", "percent_chg_fare")

# bind to essay 15
essay16 = left_join(essay15, percapita_gdp, by =c("year","quarter")) %>%
  left_join(percent_gdp, by =c("year","quarter")) %>%
  left_join(fare, by =c("year","quarter"))


## create Carrier Code
arlinename = as.data.frame(sort(unique(essay16$airline))) %>% 
  mutate(Carriercode = seq(1:n()))

colnames(arlinename) = c("airline", "Carriercode")

essay17 = merge(essay16, arlinename, by = "airline")

## create Occasion
occasionseq = as.data.frame(sort(unique(essay17$YearQ))) %>%
  mutate(occasion = seq(1:n()))

colnames(occasionseq) = c("YearQ", "Occasion")

essay18 = merge(essay17, occasionseq, by = "YearQ")

essay18[is.na(essay18)] = 0

essay18_f = essay18[!(essay18$yieldPAX >50),]

### save final file for future use
write.csv(essay18,file = "E1_Quarterly_2024.csv")

colnames(essay18)


### sum occasion for each carrier
library(dplyr)
occasion_e1 = essay18 %>% group_by(Carriercode, airline) %>% 
  summarise(occavalue = max(Occasion))

write.csv(occasion_e1, file = "E1_occasion_2024.csv")

write.csv(arlinename, file = "E1_Airlinelist_2024.csv")



