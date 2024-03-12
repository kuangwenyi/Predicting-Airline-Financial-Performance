##### Mishandled Bags Data Cleaning ####
## Data Source: DOT Monthly Consumer Report
## Files were already scraped into Excel from DOT PDF and saved as annual files.
## Excel files not included but available upon request.

# library
library(data.table)
library(readxl)


### Do it per year as the format changed sometimes inbetween years. Loop or function does not work well.

#2019
# numbers of bags enplaned instead of number of passengers enplaned
# skip 2019 data
df<-rbindlist(lapply(excel_sheets("Mishandled Baggage 2019.xlsx"),
                     read_excel,
                     path = "Mishandled Baggage 2019.xlsx",col_names=FALSE,
                     range = cell_cols("A:E")))

colnames(df)<-c("rank","airline","enplaned passengers",	"totalbag",
                "pper 1000")

df2019<-na.omit(df)
df2019<-df2019[!df2019$rank=="RANK"]

df2019$month<-rep(1:12, each=10)#assign month
df2019$quarter <- ceiling(as.numeric(df2019$month)/3)#assign quarter

df2019$year<- 2019

#2018

df<-rbindlist(lapply(excel_sheets("Mishandled Baggage 2018.xlsx"),
                     read_excel,
                     path = "Mishandled Baggage 2018.xlsx",col_names=FALSE,
                     range = cell_cols("A:E")))

colnames(df)<-c("rank","airline","totalbag","enplaned passengers",	
                "pper 1000")

df2018<-na.omit(df)
df2018<-df2018[!df2018$rank=="RANK"]

df2018$month<-rep(1:12, c(12,13,13,12,12,12,12,12,12,12,12,11))#assign month
df2018$quarter <- ceiling(as.numeric(df2018$month)/3)#assign quarter
df2018$year<- 2018



#2017
df<-rbindlist(lapply(excel_sheets("Mishandled Baggage 2017.xlsx"),
                     read_excel,
                     path = "Mishandled Baggage 2017.xlsx",col_names=FALSE,
                     range = cell_cols("A:E")))

colnames(df)<-c("rank","airline","totalbag","enplaned passengers",	
                "pper 1000")

df2017<-na.omit(df)
df2017<-df2017[!df2017$rank=="RANK"]
df2017$month<-rep(1:12, each=12)#assign month
df2017$quarter <- ceiling(as.numeric(df2017$month)/3)#assign quarter
df2017$year<- 2017


#2016
df<-rbindlist(lapply(excel_sheets("Mishandled Baggage 2016.xlsx"),
       read_excel,
       path = "Mishandled Baggage 2016.xlsx",skip=0))
       
df = df[,1:5]
colnames(df)<-c("rank","airline","totalbag","enplaned passengers","pper 1000")

df2016<-na.omit(df)
df2016$month<-rep(1:12, each=12)#assign month
df2016$quarter <- ceiling(as.numeric(df2016$month)/3)#assign quarter
df2016$year<- 2016


#2015
df<-rbindlist(lapply(excel_sheets("Mishandled Baggage 2015.xlsx"),
                     read_excel,
                     path = "Mishandled Baggage 2015.xlsx",col_names=FALSE,
                     range = cell_cols("A:E")))

colnames(df)<-c("rank","airline","totalbag","enplaned passengers",	
                "pper 1000")
df2015<-na.omit(df)

df2015<-df2015[!df2015$rank=="RANK"]
df2015$month<-rep(1:12, each=13)#assign month
df2015$quarter <- ceiling(as.numeric(df2015$month)/3)#assign quarter
df2015$year<- 2015


#2014
df<-rbindlist(lapply(excel_sheets("Mishandled Baggage 2014.xlsx"),
                     read_excel,
                     path = "Mishandled Baggage 2014.xlsx",skip=0))
df = df[,1:5]

colnames(df)<-c("rank","airline","totalbag","enplaned passengers",	
                "pper 1000")

df2014<-na.omit(df)

df2014<-df2014[!df2014$rank=="RANK"]

df2014$month<-rep(1:12, each=12)#assign month
df2014$quarter <- ceiling(as.numeric(df2014$month)/3)#assign quarter
df2014$year<- 2014



#2013
df<-rbindlist(lapply(excel_sheets("Mishandled Baggage 2013.xlsx"),
                     read_excel,
                     path = "Mishandled Baggage 2013.xlsx",col_names=FALSE), 
              fill= T)

df = df[,1:5]

colnames(df)<-c("rank","airline","totalbag","enplaned passengers",	
                "pper 1000")

df2013<-na.omit(df)
df2013<-df2013[!df2013$rank=="RANK"]
df2013$month<-rep(1:12, each=16)#assign month
df2013$quarter <- ceiling(as.numeric(df2013$month)/3)#assign quarter
df2013$year<- 2013


#2012
df<-rbindlist(lapply(excel_sheets("Mishandled Baggage 2012.xlsx"),
                     read_excel,
                     path = "Mishandled Baggage 2012.xlsx",col_names=FALSE,
                     range = cell_cols("A:E")))

colnames(df)<-c("rank","airline","totalbag","enplaned passengers",	
                "pper 1000")

df2012<-na.omit(df)

df2012<-df2012[!df2012$rank=="RANK"]
df2012$month<-rep(1:12, each=15)#assign month
df2012$quarter <- ceiling(as.numeric(df2012$month)/3)#assign quarter
df2012$year<- 2012




#2011
df<-rbindlist(lapply(excel_sheets("Mishandled Baggage 2011.xlsx"),
                     read_excel,
                     path = "Mishandled Baggage 2011.xlsx",col_names=FALSE,
                     range = cell_cols("A:E")))

colnames(df)<-c("rank","airline","totalbag","enplaned passengers",	
                "pper 1000")
df2011<-na.omit(df)

df2011<-df2011[!df2011$rank=="RANK"]
df2011$month<-rep(1:12, each=16)#assign month
df2011$quarter <- ceiling(as.numeric(df2011$month)/3)#assign quarter
df2011$year<- 2011



#2010
df<-rbindlist(lapply(excel_sheets("Mishandled Baggage 2010.xlsx"),
                     read_excel,
                     path = "Mishandled Baggage 2010.xlsx",col_names=FALSE,
                     range = cell_cols("A:E")))

colnames(df)<-c("rank","airline","totalbag","enplaned passengers",	
                "pper 1000")
df2010<-na.omit(df)

df2010$month<-rep(1:12, each=18)#assign month
df2010$quarter <- ceiling(as.numeric(df2010$month)/3)#assign quarter
df2010$year<- 2010



#2009
df<-rbindlist(lapply(excel_sheets("Mishandled Baggage 2009.xlsx"),
                     read_excel,
                     path = "Mishandled Baggage 2009.xlsx",col_names=FALSE,
                     range = cell_cols("A:E")))

colnames(df)<-c("rank","airline","totalbag","enplaned passengers",	
                "pper 1000")
df2009<-na.omit(df)
df2009<-df2009[!df2009$rank=="RANK"]

df2009$month<-rep(1:12, each=19)#assign month
df2009$quarter <- ceiling(as.numeric(df2009$month)/3)#assign quarter
df2009$year<- 2009





#2008
df<-rbindlist(lapply(excel_sheets("Mishandled Baggage 2008.xlsx"),
                     read_excel,
                     path = "Mishandled Baggage 2008.xlsx",col_names=FALSE,
                     range = cell_cols("A:E")))

colnames(df)<-c("rank","airline","totalbag","enplaned passengers",	
                "pper 1000")
df2008<-na.omit(df)

df2008$month<-rep(1:12, c(19,20,19,19,19,19,19,19,19,19,19,19))#assign month
df2008$quarter <- ceiling(as.numeric(df2008$month)/3)#assign quarter
df2008$year<- 2008





#2007 
df<-rbindlist(lapply(excel_sheets("Mishandled Baggage 2007.xlsx"),
                     read_excel,
                     path = "Mishandled Baggage 2007.xlsx",col_names=FALSE,
                     range = cell_cols("A:E")))

colnames(df)<-c("rank","airline","totalbag","enplaned passengers",	
                "pper 1000")
df2007<-na.omit(df)

df2007$month<-rep(1:12, each=20)#assign month
df2007$quarter <- ceiling(as.numeric(df2007$month)/3)#assign quarter
df2007$year<- 2007



#2006
df<-rbindlist(lapply(excel_sheets("Mishandled Baggage 2006.xlsx"),
                     read_excel,
                     path = "Mishandled Baggage 2006.xlsx",col_names=FALSE,
                     range = cell_cols("A:E")))

colnames(df)<-c("rank","airline","totalbag","enplaned passengers",	
                "pper 1000")
df2006<-na.omit(df)

df2006$month<-rep(1:12, c(19,19,19,20,20,20,20,20,20,20,20,20))#assign month
df2006$quarter <- ceiling(as.numeric(df2006$month)/3)#assign quarter
df2006$year<- 2006



#2005
df<-rbindlist(lapply(excel_sheets("Mishandled Baggage 2005.xlsx"),
                     read_excel,
                     path = "Mishandled Baggage 2005.xlsx",col_names=FALSE,
                     range = cell_cols("A:E")))

colnames(df)<-c("rank","airline","totalbag","enplaned passengers",	
                "pper 1000")
df2005<-na.omit(df)

df2005$month<-rep(1:12, c(19,19,19,19,20,20,20,20,20,20,20,20))#assign month
df2005$quarter <- ceiling(as.numeric(df2005$month)/3)#assign quarter
df2005$year<- 2005


#2004
df<-rbindlist(lapply(excel_sheets("Mishandled Baggage 2004.xlsx"),
                     read_excel,
                     path = "Mishandled Baggage 2004.xlsx",col_names=FALSE,
                     range = cell_cols("A:E")))

colnames(df)<-c("rank","airline","totalbag","enplaned passengers",	
                "pper 1000")
df2004<-na.omit(df)

df2004$month<-rep(1:12, each=19)#assign month
df2004$quarter <- ceiling(as.numeric(df2004$month)/3)#assign quarter
df2004$year<- 2004



##combine all tables (excluding 2019)
mbtotal<-rbind(df2019, df2018,df2017,df2016,df2015,df2014,df2013,df2012,df2011,df2010,
               df2009,df2008,df2007,df2006,df2005,df2004)


##clean airline names
library(stringr)

mbtotal$airline<-str_replace(mbtotal$airline,"\\**$","")


mbtotal$airline<-data.table(toupper(mbtotal$airline))

mbtotal$airline<-str_replace(mbtotal$airline,"AIRLINES","")
mbtotal$airline<-str_replace(mbtotal$airline,"AIRWAYS","")
mbtotal$airline<-str_replace(mbtotal$airline,"AIRLINE","")
mbtotal$airline<-str_replace(mbtotal$airline,"UNITED EXPRESS","UNITED")
mbtotal$airline<-str_replace(mbtotal$airline,"VIRGIN AMERICA","VIRGIN")
mbtotal$airline<-str_replace(mbtotal$airline,"NETWORK","")
mbtotal$airline<-str_replace(mbtotal$airline,"AMERICAN WEST","AMERICA WEST")
mbtotal$airline<-str_replace(mbtotal$airline,"OTHER U.S.","OTHER")
mbtotal$airline<-str_replace(mbtotal$airline,"AIR LINES","")
mbtotal$airline<-str_replace(mbtotal$airline,"AIRLI NES","")

mbtotal$airline<-str_replace(mbtotal$airline,"US AIRWAYS","US")
mbtotal$airline<-str_replace(mbtotal$airline,"INDEPENDENCE AIR","INDEPENDENCE")
mbtotal$airline<-str_replace(mbtotal$airline,"DELAT","DELTA")
mbtotal$airline<-str_replace(mbtotal$airline,"\\ AIR","")
mbtotal$airline<-str_replace(mbtotal$airline,"SPIRI T","SPIRIT")
mbtotal$airline<-str_replace(mbtotal$airline,"UNI TED","UNITED")
mbtotal$airline<-str_replace(mbtotal$airline,"\\** AMERICAN US","")
mbtotal$airline<-str_replace(mbtotal$airline,"\\** SOUTHWESTTRAN","")
mbtotal$airline<-str_replace(mbtotal$airline,"SPRIT","SPIRIT")

mbtotal$airline<-str_replace(mbtotal$airline,"UNITED EXPRESS","UNITED")
mbtotal$airline<-str_replace(mbtotal$airline,"US EXPRESS","US")

# American Eagle name changed to Envoy
mbtotal$airline<-str_replace(mbtotal$airline,"AMERICAN EAGLE","ENVOY")

# Pincle name changed to Endeavour
mbtotal$airline<-str_replace(mbtotal$airline,"PINNACLE","ENDEAVOR")

# Atlantic coast name changed to Indenpendence
mbtotal$airline<-str_replace(mbtotal$airline,"ATLANTIC COAST","INDEPENDENCE")

# TWA 
mbtotal$airline<-str_replace(mbtotal$airline,"TRANSWORLD","TWA")
mbtotal$airline<-str_replace(mbtotal$airline,"TRANS WORLD AIRLINES","TWA")
mbtotal$airline<-str_replace(mbtotal$airline,"TRANS WORLD EXPRESS","TWA")


# trim empty spaces
mbtotal$airline<-str_trim(mbtotal$airline)

unique(mbtotal$airline)


## save file as csv file
write.csv(mbtotal, file = "mbtotal.csv")

#create final airline namelist 
airlinenames<-data.table(unique(mbtotal$airline))


##find the best service providers 
rank1<- subset(mbtotal,rank==1)
rank1n<-data.table(rank1)
rank1n[,.N,by = airline][order(-N)]

