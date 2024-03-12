##### Consumer Complaints Data Cleaning ####
## Data Source: DOT Monthly Consumer Report
## Files were already scraped into Excel from DOT PDF and saved as annual files.
## Excel files not included but available upon request.


# Library
library(data.table)
library(readxl)

### Do it per year as the format changed sometimes inbetween years. Loop or function does not work well.
##2019
df<-lapply(excel_sheets("Consumer Complaiint 2019.xlsx"),
           read_excel,
           path = "Consumer Complaiint 2019.xlsx",col_names=FALSE)

for (i in 1:12) {df[[i]]$month<-i}

df<-rbindlist(df)

colnames(df)<-c("airline", "flight problems", "oversales", "reservation", 
                "fares",	"refunds", "baggage", "customer service", "disability", 
                "advertising", "discrimination", "animals",	"other", "total", "month")

# delete NA values
df2019<-na.omit(df)

# delete rows containing "TOTAL" in column "airline"
df2019<-df2019[!grepl("TOTAL", df2019$airline),]
df2019$quarter <- ceiling(as.numeric(df2019$month)/3)#assign quarter
df2019$year<- 2019 # assign year


##2018
df<-lapply(excel_sheets("Consumer Complaiint 2018.xlsx"),
           read_excel,
           path = "Consumer Complaiint 2018.xlsx",col_names=FALSE)

for (i in 1:12) {df[[i]]$month<-i}
df<-rbindlist(df)

colnames(df)<-c("airline", "flight problems", "oversales", "reservation", 
                "fares",	"refunds", "baggage", "customer service", "disability", 
                "advertising", "discrimination", "animals",	"other", "total", "month")

#delete NA values
df2018<-na.omit(df)

#delete rows containing "TOTAL" in column "airline"
df2018<-df2018[!grepl("TOTAL", df2018$airline),]
df2018$quarter <- ceiling(as.numeric(df2018$month)/3)#assign quarter
df2018$year<- 2018 # assign year


##2017
df<-lapply(excel_sheets("Consumer Complaiint 2017.xlsx"),
       read_excel,
       path = "Consumer Complaiint 2017.xlsx",col_names=FALSE)

for (i in 1:12) {df[[i]]$month<-i}
df<-rbindlist(df)

colnames(df)<-c("airline", "flight problems", "oversales", "reservation", 
"fares",	"refunds", "baggage", "customer service", "disability", 
"advertising", "discrimination", "animals",	"other", "total", "month")

#delete NA values
df2017<-na.omit(df)

#delete rows containing "TOTAL" in column "airline"
df2017<-df2017[!grepl("TOTAL", df2017$airline),]
df2017$quarter <- ceiling(as.numeric(df2017$month)/3)#assign quarter
df2017$year<- 2017 # assign year



##2016
df<-lapply(excel_sheets("Consumer Complaiint 2016.xlsx"),
           read_excel,
           path = "Consumer Complaiint 2016.xlsx",col_names=FALSE)

for (i in 1:12) {df[[i]]$month<-i}
df<-rbindlist(df)

colnames(df)<-c("airline", "flight problems", "oversales", "reservation", 
                "fares",	"refunds", "baggage", "customer service", "disability", 
                "advertising", "discrimination", "animals",	"other", "total", "month")

#delete NA values
df2016<-na.omit(df)

#delete rows containing "TOTAL" in column "airline"
df2016<-df2016[!grepl("TOTAL", df2016$airline),]
df2016$quarter <- ceiling(as.numeric(df2016$month)/3)#assign quarter
df2016$year<- 2016 # assign year



##2015
df<-lapply(excel_sheets("Consumer Complaiint 2015.xlsx"),
           read_excel,
           path = "Consumer Complaiint 2015.xlsx",col_names=FALSE)

for (i in 1:12) {df[[i]]$month<-i}
df<-rbindlist(df)

colnames(df)<-c("airline", "flight problems", "oversales", "reservation", 
                "fares",	"refunds", "baggage", "customer service", "disability", 
                "advertising", "discrimination", "animals",	"other", "total", "month")

#delete NA values
df2015<-na.omit(df)

#delete rows containing "TOTAL" in column "airline"
df2015<-df2015[!grepl("TOTAL", df2015$airline),]
df2015$quarter <- ceiling(as.numeric(df2015$month)/3)#assign quarter
df2015$year<- 2015 # assign year




##2014
df<-lapply(excel_sheets("Consumer Complaiint 2014.xlsx"),
           read_excel,
           path = "Consumer Complaiint 2014.xlsx",col_names=FALSE)

for (i in 1:12) {df[[i]]$month<-i}
df<-rbindlist(df)

colnames(df)<-c("airline", "flight problems", "oversales", "reservation", 
                "fares", "refunds", "baggage", "customer service", "disability", 
                "advertising", "discrimination", "animals",	"other", "total", "month")

#delete NA values
df2014<-na.omit(df)

#delete rows containing "TOTAL" in column "airline"
df2014<-df2014[!grepl("TOTAL", df2014$airline),]
df2014$quarter <- ceiling(as.numeric(df2014$month)/3)#assign quarter
df2014$year<- 2014 # assign year




##2013
df<-lapply(excel_sheets("Consumer Complaiint 2013.xlsx"),
           read_excel,
           path = "Consumer Complaiint 2013.xlsx",col_names=TRUE)

for (i in 1:12) {df[[i]]$month<-i}
df<-rbindlist(df)

colnames(df)<-c("airline", "flight problems", "oversales", "reservation", 
                "fares", "refunds", "baggage", "customer service", "disability", 
                "advertising", "discrimination", "animals",	"other", "total", "month")

#delete NA values
df2013<-na.omit(df)

#delete rows containing "TOTAL" in column "airline"
df2013<-df2013[!grepl("TOTAL", df2013$airline),]
df2013$quarter <- ceiling(as.numeric(df2013$month)/3)#assign quarter
df2013$year<- 2013 # assign year




##2012
df<-lapply(excel_sheets("Consumer Complaiint 2012.xlsx"),
           read_excel,
           path = "Consumer Complaiint 2012.xlsx",col_names=FALSE)

for (i in 1:12) {df[[i]]$month<-i}
df<-rbindlist(df)

colnames(df)<-c("airline", "flight problems", "oversales", "reservation", 
                "fares", "refunds", "baggage", "customer service", "disability", 
                "advertising", "discrimination", "animals",	"other", "total", "month")

#delete NA values
df2012<-na.omit(df)

#delete rows containing "TOTAL" in column "airline"
df2012<-df2012[!grepl("TOTAL", df2012$airline),]
df2012$quarter <- ceiling(as.numeric(df2012$month)/3)#assign quarter
df2012$year<- 2012 # assign year




##2011
df<-lapply(excel_sheets("Consumer Complaiint 2011.xlsx"),
           read_excel,
           path = "Consumer Complaiint 2011.xlsx",col_names=FALSE)

for (i in 1:12) {df[[i]]$month<-i}
df<-rbindlist(df)

colnames(df)<-c("airline", "flight problems", "oversales", "reservation", 
                "fares", "refunds", "baggage", "customer service", "disability", 
                "advertising", "discrimination", "animals",	"other", "total", "month")

#delete NA values
df2011<-na.omit(df)

#delete rows containing "TOTAL" in column "airline"
df2011<-df2011[!grepl("TOTAL", df2011$airline),]
df2011$quarter <- ceiling(as.numeric(df2011$month)/3)#assign quarter
df2011$year<- 2011 # assign year




##2010
df<-lapply(excel_sheets("Consumer Complaiint 2010.xlsx"),
           read_excel,
           path = "Consumer Complaiint 2010.xlsx",col_names=FALSE)

for (i in 1:12) {df[[i]]$month<-i}
df<-rbindlist(df)

colnames(df)<-c("airline", "flight problems", "oversales", "reservation", 
                "fares", "refunds", "baggage", "customer service", "disability", 
                "advertising", "discrimination", "animals",	"other", "total", "month")

#delete NA values
df2010<-na.omit(df)

#delete rows containing "TOTAL" in column "airline"
df2010<-df2010[!grepl("TOTAL", df2010$airline),]
df2010$quarter <- ceiling(as.numeric(df2010$month)/3)#assign quarter
df2010$year<- 2010 # assign year

##2009

df<-lapply(excel_sheets("Consumer Complaiint 2009.xlsx"),
           read_excel,
           path = "Consumer Complaiint 2009.xlsx",col_names=FALSE)

for (i in 1:12) {df[[i]]$month<-i}
df<-rbindlist(df)

colnames(df)<-c("airline", "flight problems", "oversales", "reservation", 
                "fares", "refunds", "baggage", "customer service", "disability", 
                "advertising", "discrimination", "animals",	"other", "total", "month")

#delete NA values
df2009<-na.omit(df)

#delete rows containing "TOTAL" in column "airline"
df2009<-df2009[!grepl("TOTAL", df2009$airline),]
df2009$quarter <- ceiling(as.numeric(df2009$month)/3)#assign quarter
df2009$year<- 2009 # assign year




##2008
df<-lapply(excel_sheets("Consumer Complaiint 2008.xlsx"),
           read_excel,
           path = "Consumer Complaiint 2008.xlsx",col_names=FALSE)

for (i in 1:12) {df[[i]]$month<-i}
df<-rbindlist(df)

colnames(df)<-c("airline", "flight problems", "oversales", "reservation", 
                "fares", "refunds", "baggage", "customer service", "disability", 
                "advertising", "discrimination", "animals",	"other", "total", "month")

#delete NA values
df2008<-na.omit(df)

#delete rows containing "TOTAL" in column "airline"
df2008<-df2008[!grepl("TOTAL", df2008$airline),]
df2008$quarter <- ceiling(as.numeric(df2008$month)/3)#assign quarter
df2008$year<- 2008 # assign year



##2007

df<-lapply(excel_sheets("Consumer Complaiint 2007.xlsx"),
           read_excel,
           path = "Consumer Complaiint 2007.xlsx",col_names=FALSE)

for (i in 1:12) {df[[i]]$month<-i}
df<-rbindlist(df)

colnames(df)<-c("airline", "flight problems", "oversales", "reservation", 
                "fares", "refunds", "baggage", "customer service", "disability", 
                "advertising", "discrimination", "animals",	"other", "total", "month")

#delete NA values
df2007<-na.omit(df)

#delete rows containing "TOTAL" in column "airline"
df2007<-df2007[!grepl("TOTAL", df2007$airline),]
df2007$quarter <- ceiling(as.numeric(df2007$month)/3)#assign quarter
df2007$year<- 2007 # assign year


##2006

df<-lapply(excel_sheets("Consumer Complaiint 2006.xlsx"),
           read_excel,
           path = "Consumer Complaiint 2006.xlsx",col_names=FALSE)

for (i in 1:12) {df[[i]]$month<-i}
df<-rbindlist(df)

colnames(df)<-c("airline", "flight problems", "oversales", "reservation", 
                "fares", "refunds", "baggage", "customer service", "disability", 
                "advertising", "discrimination", "animals",	"other", "total", "month")

#delete NA values
df2006<-na.omit(df)

#delete rows containing "TOTAL" in column "airline"
df2006<-df2006[!grepl("TOTAL", df2006$airline),]
df2006$quarter <- ceiling(as.numeric(df2006$month)/3)#assign quarter
df2006$year<- 2006 # assign year

##2005

df<-lapply(excel_sheets("Consumer Complaiint 2005.xlsx"),
           read_excel,
           path = "Consumer Complaiint 2005.xlsx",col_names=FALSE)

for (i in 1:12) {df[[i]]$month<-i}
df<-rbindlist(df)

colnames(df)<-c("airline", "flight problems", "oversales", "reservation", 
                "fares", "refunds", "baggage", "customer service", "disability", 
                "advertising", "discrimination", "animals",	"other", "total", "month")

#delete NA values
df2005<-na.omit(df)

#delete rows containing "TOTAL" in column "airline"
df2005<-df2005[!grepl("TOTAL", df2005$airline),]
df2005$quarter <- ceiling(as.numeric(df2005$month)/3)#assign quarter
df2005$year<- 2005 # assign year


##2004

df<-lapply(excel_sheets("Consumer Complaiint 2004.xlsx"),
           read_excel,
           path = "Consumer Complaiint 2004.xlsx",col_names=FALSE)

for (i in 1:12) {df[[i]]$month<-i}
df<-rbindlist(df)

colnames(df)<-c("airline", "flight problems", "oversales", "reservation", 
                "fares", "refunds", "baggage", "customer service", "disability", 
                "advertising", "discrimination", "animals",	"other", "total", "month")

#delete NA values
df2004<-na.omit(df)

#delete rows containing "TOTAL" in column "airline"
df2004<-df2004[!grepl("TOTAL", df2004$airline),]
df2004$quarter <- ceiling(as.numeric(df2004$month)/3)#assign quarter
df2004$year<- 2004 # assign year


########################################################################
##combine all tables
cctotal<-rbind(df2019, df2018,df2017,df2016,df2015,df2014,df2013,df2012,df2011,df2010,
               df2009,df2008,df2007,df2006,df2005,df2004)

#create final airline namelist 
airlinenames<-data.table(unique(cctotal$airline))


##clean airline names
library(stringr)

cctotal$airline<-str_replace(cctotal$airline,"\\**$","")
cctotal$airline<-str_replace(cctotal$airline,"\\***$","")

cctotal$airline<-data.table(toupper(cctotal$airline))

cctotal$airline<-str_replace(cctotal$airline,"AIRLINES","")
cctotal$airline<-str_replace(cctotal$airline,"AIRWAYS","")
cctotal$airline<-str_replace(cctotal$airline,"AIRLINE","")
cctotal$airline<-str_replace(cctotal$airline,"UNITED EXPRESS","UNITED")
cctotal$airline<-str_replace(cctotal$airline,"VIRGIN AMERICA","VIRGIN")
cctotal$airline<-str_replace(cctotal$airline,"NETWORK","")
cctotal$airline<-str_replace(cctotal$airline,"AMERICAN WEST","AMERICA WEST")
cctotal$airline<-str_replace(cctotal$airline,"OTHER U.S.","OTHER")
cctotal$airline<-str_replace(cctotal$airline,"AIR LINES","")
cctotal$airline<-str_replace(cctotal$airline,"AIRLI NES","")

cctotal$airline<-str_replace(cctotal$airline,"US AIRWAYS","US")
cctotal$airline<-str_replace(cctotal$airline,"INDEPENDENCE AIR","INDEPENDENCE")
cctotal$airline<-str_replace(cctotal$airline,"DELAT","DELTA")
cctotal$airline<-str_replace(cctotal$airline,"\\ AIR","")
cctotal$airline<-str_replace(cctotal$airline,"SPIRI T","SPIRIT")
cctotal$airline<-str_replace(cctotal$airline,"UNI TED","UNITED")
cctotal$airline<-str_replace(cctotal$airline,"\\** AMERICAN US","")
cctotal$airline<-str_replace(cctotal$airline,"\\*** SOUTHWESTTRAN","")
cctotal$airline<-str_replace(cctotal$airline,"SPRIT","SPIRIT")

cctotal$airline<-str_replace(cctotal$airline,"UNITED EXPRESS","UNITED")
cctotal$airline<-str_replace(cctotal$airline,"US EXPRESS","US")

# American Eagle name changed to Envoy
cctotal$airline<-str_replace(cctotal$airline,"AMERICAN EAGLE","ENVOY")

# Pincle name changed to Endeavour
cctotal$airline<-str_replace(cctotal$airline,"PINNACLE","ENDEAVOR")

# Atlantic coast name changed to Indenpendence
cctotal$airline<-str_replace(cctotal$airline,"ATLANTIC COAST","INDEPENDENCE")

# TWA 
cctotal$airline<-str_replace(cctotal$airline,"TRANSWORLD","TWA")
cctotal$airline<-str_replace(cctotal$airline,"TRANS WORLD AIRLINES","TWA")
cctotal$airline<-str_replace(cctotal$airline,"TRANS WORLD EXPRESS","TWA")

# trim empty spaces

cctotal = cctotal[!cctotal$total == "TOTAL"]

cctotal$airline<-str_trim(cctotal$airline)

cctotal$airline<-str_replace(cctotal$airline,"US  EXPRESS","US")


## save file as csv file
write.csv(cctotal, file = "cctotal.csv")

airlinenames<-data.table(unique(cctotal$airline))
unique(airlinenames$V1)


