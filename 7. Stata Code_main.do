##############################################################################
################# PREDICTING OPOR in Airline Industry #################


****** START FROM HERE USING THE SAME 891 Observations
*******************************************************************************
* import file
import delimited "E1_891.csv"

* generate mean varibles
egen lyield_mean = mean(lyield), by(carriercode)
egen lLFP_mean = mean(llfp), by(carriercode)
egen lfleetutil_mean = mean(lfleetutil), by(carriercode)
egen lfueleff_mean = mean(lfueleff), by(carriercode)
egen lpOntime_mean = mean(lpontime), by(carriercode)
egen lmisbagg_mean = mean(lmisbagg), by(carriercode)
egen ltotaldelay_mean = mean(ltotaldelay), by(carriercode)
egen lcomplaint_mean = mean(lcomplaint), by(carriercode)
egen lhetero_mean = mean(lhetero), by(carriercode)
egen lavglandfee_mean = mean(lavglandfee), by(carriercode)
egen lsparsity_mean = mean(lsparsity), by(carriercode)
egen lMKTshare_mean = mean(lmktshare), by(carriercode)

egen ltdomt_cost_mean = mean(ltdomt_cost), by(carriercode)
egen lrevpaxenplaned_mean = mean(lrevpaxenplaned), by(carriercode)
egen lempfte_mean = mean(lempfte), by(carriercode)

* generate within variables
gen lyield_w = lyield - lyield_mean
gen lLFPw = lLFP - lLFP_mean
gen lfleetutil_w = lfleetutil - lfleetutil_mean
gen lfueleff_w = lfueleff - lfueleff_mean
gen lpOntime_w = lpOntime - lpOntime_mean
gen lmisbagg_w = lmisbagg - lmisbagg_mean
gen ltotaldelay_w = ltotaldelay - ltotaldelay_mean
gen lcomplaint_w = lcomplaint - lcomplaint_mean
gen lhetero_w = lhetero - lhetero_mean
gen lavglandfee_w = lavglandfee - lavglandfee_mean
gen lsparsity_w = lsparsity - lsparsity_mean
gen lMKTshare_w = lMKTshare - lMKTshare_mean

gen ltdomt_costw= ltdomt_cost - ltdomt_cost_mean
gen lrevpaxenplaned_w = lrevpaxenplaned - lrevpaxenplaned_mean
gen lempfte_w = lempfte - lempfte_mean

* generate group mean centered variables
sum lyield_mean, meanonly
gen clyield_mean = lyield_mean - r(mean)

sum lLFP_mean, meanonly
gen clLFP_mean= lLFP_mean - r(mean)

sum lfleetutil_mean, meanonly
gen clfleetutil_mean = lfleetutil_mean - r(mean)

sum lfueleff_mean, meanonly
gen clfueleff_mean = lfueleff_mean - r(mean)

sum lpOntime_mean, meanonly
gen clpOntime_mean = lpOntime_mean - r(mean)

sum lmisbagg_mean, meanonly
gen clmisbagg_mean = lmisbagg_mean - r(mean)

sum ltotaldelay_mean, meanonly
gen cltotaldelay_mean = ltotaldelay_mean - r(mean)

sum lcomplaint_mean , meanonly
gen clcomplaint_mean  =  lcomplaint_mean - r(mean)

sum lhetero_mean, meanonly
gen clhetero_mean = lhetero_mean - r(mean)

sum lavglandfee_mean, meanonly
gen clavglandfee_mean = lavglandfee_mean - r(mean)

sum lsparsity_mean, meanonly
gen clsparsity_mean = lsparsity_mean - r(mean)

sum lMKTshare_mean, meanonly
gen clMKTshare_mean = lMKTshare_mean - r(mean)

sum ltdomt_cost_mean, meanonly
gen cltdomt_cost_mean = ltdomt_cost_mean - r(mean)

sum lrevpaxenplaned_mean, meanonly
gen clrevpaxenplaned_mean = lrevpaxenplaned_mean - r(mean)

sum lempfte_mean, meanonly
gen clempfte_mean = lempfte_mean - r(mean)


* check duplicates
duplicates list carriercode occasion

##########################################################################
################### ALL SAMPLE ICC Calculation ###########################

xtmixed opor|| carriercode:, var cov(un) mle 
estat ic
estat icc

##########################################################################
#######  ALL SAMPLE TEST Alternative Covariance Structure ################


qui xtmixed opor clyield_mean lyield_w clLFP_mean lLFPw clfleetutil_mean lfleetutil_w clfueleff_mean lfueleff_w clpOntime_mean lpOntime_w clmisbagg_mean lmisbagg_w cltotaldelay_mean ltotaldelay_w clcomplaint_mean lcomplaint_w clhetero_mean lhetero_w clavglandfee_mean lavglandfee_w clsparsity_mean lsparsity_w clMKTshare_mean lMKTshare_w ltdomt_cost_mean ltdomt_costw lrevpaxenplaned_mean lrevpaxenplaned_w lempfte_mean lempfte_w i.year i.quarter||carriercode:, cov(un) var mle

estimates store ar_none
estat ic

predict pout_xtmixed_arno
cor opor pout_xtmixed_arno //0.6397

gen msemixed_all_arno = (pout_xtmixed_arno - opor)*(pout_xtmixed_arno - opor)
total msemixed_all_arno // 11.62123 

qui xtmixed opor clyield_mean lyield_w clLFP_mean lLFPw clfleetutil_mean lfleetutil_w clfueleff_mean lfueleff_w clpOntime_mean lpOntime_w clmisbagg_mean lmisbagg_w cltotaldelay_mean ltotaldelay_w clcomplaint_mean lcomplaint_w clhetero_mean lhetero_w clavglandfee_mean lavglandfee_w clsparsity_mean lsparsity_w clMKTshare_mean lMKTshare_w ltdomt_cost_mean ltdomt_costw lrevpaxenplaned_mean lrevpaxenplaned_w lempfte_mean lempfte_w i.year i.quarter||carriercode:, cov(un) var mle residuals(ar1, t(occasion))

estimates store ar1
estat ic
predict pout_xtmixed_ar1
cor opor pout_xtmixed_ar1 //0.6365

gen msemixed_all_ar1 = (pout_xtmixed_ar1 - opor)*(pout_xtmixed_ar1 - opor)
total msemixed_all_ar1 // 11.48738


qui xtmixed opor clyield_mean lyield_w clLFP_mean lLFPw clfleetutil_mean lfleetutil_w clfueleff_mean lfueleff_w clpOntime_mean lpOntime_w clmisbagg_mean lmisbagg_w cltotaldelay_mean ltotaldelay_w clcomplaint_mean lcomplaint_w clhetero_mean lhetero_w clavglandfee_mean lavglandfee_w clsparsity_mean lsparsity_w clMKTshare_mean lMKTshare_w ltdomt_cost_mean ltdomt_costw lrevpaxenplaned_mean lrevpaxenplaned_w lempfte_mean lempfte_w i.year i.quarter||carriercode:, cov(un) var mle residuals(ar2, t(occasion))

estimates store ar2
estat ic
predict pout_xtmixed_ar2
cor opor pout_xtmixed_ar2 //0.6369

gen msemixed_all_ar2 = (pout_xtmixed_ar2 - opor)*(pout_xtmixed_ar2 - opor)
total msemixed_all_ar2 // 11.55967 

qui xtmixed opor clyield_mean lyield_w clLFP_mean lLFPw clfleetutil_mean lfleetutil_w clfueleff_mean lfueleff_w clpOntime_mean lpOntime_w clmisbagg_mean lmisbagg_w cltotaldelay_mean ltotaldelay_w clcomplaint_mean lcomplaint_w clhetero_mean lhetero_w clavglandfee_mean lavglandfee_w clsparsity_mean lsparsity_w clMKTshare_mean lMKTshare_w ltdomt_cost_mean ltdomt_costw lrevpaxenplaned_mean lrevpaxenplaned_w lempfte_mean lempfte_w i.year i.quarter||carriercode:, cov(un) var mle residuals(ar3, t(occasion))

estimates store ar3
estat ic
predict pout_xtmixed_ar3
cor opor pout_xtmixed_ar3 //0.6362

gen msemixed_all_ar3 = (pout_xtmixed_ar3 - opor)*(pout_xtmixed_ar3 - opor)
total msemixed_all_ar3 // 11.65049 

qui xtmixed opor clyield_mean lyield_w clLFP_mean lLFPw clfleetutil_mean lfleetutil_w clfueleff_mean lfueleff_w clpOntime_mean lpOntime_w clmisbagg_mean lmisbagg_w cltotaldelay_mean ltotaldelay_w clcomplaint_mean lcomplaint_w clhetero_mean lhetero_w clavglandfee_mean lavglandfee_w clsparsity_mean lsparsity_w clMKTshare_mean lMKTshare_w ltdomt_cost_mean ltdomt_costw lrevpaxenplaned_mean lrevpaxenplaned_w lempfte_mean lempfte_w i.year i.quarter||carriercode:, cov(un) var mle residuals(ar4, t(occasion))

estimates store ar4
estat ic
predict pout_xtmixed_ar4
cor opor pout_xtmixed_ar4 //0.6340

gen msemixed_all_ar4 = (pout_xtmixed_ar4 - opor)*(pout_xtmixed_ar4 - opor)
total msemixed_all_ar4 // 11.79871 


qui xtmixed opor clyield_mean lyield_w clLFP_mean lLFPw clfleetutil_mean lfleetutil_w clfueleff_mean lfueleff_w clpOntime_mean lpOntime_w clmisbagg_mean lmisbagg_w cltotaldelay_mean ltotaldelay_w clcomplaint_mean lcomplaint_w clhetero_mean lhetero_w clavglandfee_mean lavglandfee_w clsparsity_mean lsparsity_w clMKTshare_mean lMKTshare_w ltdomt_cost_mean ltdomt_costw lrevpaxenplaned_mean lrevpaxenplaned_w lempfte_mean lempfte_w i.year i.quarter||carriercode:, cov(un) var mle residuals(ar5, t(occasion))

estimates store ar5
estat ic
predict pout_xtmixed_ar5
cor opor pout_xtmixed_ar5 //0.5771

gen msemixed_all_ar5 = (pout_xtmixed_ar5 - opor)*(pout_xtmixed_ar5 - opor)
total msemixed_all_ar5 // 15.65626 

lrtest ar_none ar1
lrtest ar1 ar2
lrtest ar2 ar3
lrtest ar3 ar4
lrtest ar4 ar5


##############################################################################
#############################  ALL SAMPLE ##################################


* fixed effects
xtset carriercode occasion
qui xtreg opor lyield llfp lfleetutil lfueleff lpontime lmisbagg ltotaldelay lcomplaint lhetero lavglandfee lsparsity lmktshare ltdomt_cost lrevpaxenplaned lempfte i.year i.quarter, fe

predict pout_fe_all
sum pout_fe_all, detail
cor opor pout_fe_all // 0.4570 -> 0.208849 R2


* mixed effects
qui xtmixed opor clyield_mean lyield_w clLFP_mean lLFPw clfleetutil_mean lfleetutil_w clfueleff_mean lfueleff_w clpOntime_mean lpOntime_w clmisbagg_mean lmisbagg_w cltotaldelay_mean ltotaldelay_w clcomplaint_mean lcomplaint_w clhetero_mean lhetero_w clavglandfee_mean lavglandfee_w clsparsity_mean lsparsity_w clMKTshare_mean lMKTshare_w ltdomt_cost_mean ltdomt_costw lrevpaxenplaned_mean lrevpaxenplaned_w lempfte_mean lempfte_w i.year i.quarter||carriercode:, cov(un) var mle

predict pout_xtmixed_all
cor opor pout_xtmixed_all //0.6397 -> 0.4092 R2


* Label
label variable pout_xtmixed_all "Between-Within Predicted OPOR"
label variable pout_fe_all "Fixed Effects Predicted OPOR"

line opor pout_fe_all pout_xtmixed_all occasion if carriercode == 2

* MSE
gen msefe_all = (pout_fe_all - opor)*(pout_fe_all - opor)
gen msemixed_all = (pout_xtmixed_all - opor)*(pout_xtmixed_all - opor)

total msefe_all //  17.46374
total msemixed_all // 11.62123 

egen msefe_all_mean = mean(msefe_all), by(carriercode) 
egen msemixed_all_mean = mean(msemixed_all), by(carriercode) 

list carriercode msefe_all_mean 
list carriercode msemixed_all_mean

export delimited using "C:\Users\Kuang\Desktop\StataOut_all.csv", replace



#####################################################################
##################   IN SAMPLE ##################################
* import file
import delimited "/Users/Kuang/Desktop/E1_2024/E1_891.csv"

* Create Training Dataset. Each carrier is deducted by 8 quarters.
xtset carriercode occasion
by carriercode: gen n1 = _n
by carriercode: gen n2 = _N
by carriercode: gen n3  = _N - 8

* drop those carriers who only have 8 quarters of data
drop if carriercode == 3 | carriercode ==5|carriercode == 7|carriercode == 17

* fixed effects (training <= n3)
qui xtreg opor lyield llfp lfleetutil lfueleff lpontime lmisbagg ltotaldelay lcomplaint lhetero lavglandfee lsparsity lmktshare ltdomt_cost lrevpaxenplaned lempfte i.year i.quarter if n1<= n3, fe

predict pout_fe_in if n1<= n3
cor opor pout_fe_in // 0.5988

* Mixed Effects (training <= n3)
qui xtmixed opor clyield_mean lyield_w clLFP_mean lLFPw clfleetutil_mean lfleetutil_w clfueleff_mean lfueleff_w clpOntime_mean lpOntime_w lmisbagg_mean lmisbagg_w cltotaldelay_mean ltotaldelay_w clcomplaint_mean lcomplaint_w clhetero_mean lhetero_w clavglandfee_mean lavglandfee_w clsparsity_mean lsparsity_w clMKTshare_mean lMKTshare_w ltdomt_cost_mean ltdomt_costw lrevpaxenplaned_mean lrevpaxenplaned_w lempfte_mean lempfte_w i.year i.quarter if n1<= n3||carriercode:, cov(un) var mle

predict pout_xtmixed_in if n1<= n3
cor opor pout_xtmixed_in // 0.8197

* Label
label variable pout_xtmixed_in "Between-Within Out of Sample Forecast"
label variable pout_fe_in "Fixed Effects Out of Sample Forecast"

line opor pout_fe_in  pout_xtmixed_in occasion if carriercode == 2

* check forecast accurary
gen msefe_in = (pout_fe_in - opor)*(pout_fe_in - opor)
gen msemixed_in = (pout_xtmixed_in - opor)*(pout_xtmixed_in - opor)

**** MSE
total msefe_in //  6.774926
total msemixed_in // 2.220595

tabstat msefe_in, statistics(mean) by(carriercode)
tabstat msemixed_in, statistics(mean) by(carriercode)

**** big four 
egen msefe_in_mean = mean(msefe_in), by(carriercode) 
egen msemixed_in_mean = mean(msemixed_in), by(carriercode) 

list carriercode msefe_in_mean 
list carriercode msemixed_in_mean


export delimited using "C:\Users\StataOut_insample.csv", replace

#####################################################################
##################   OUT OF SAMPLE ##################################
* import file
import delimited "E1_891.csv"

* Create Training Dataset. Each carrier is deducted by 8 quarters.
xtset carriercode occasion
by carriercode: gen n1 = _n
by carriercode: gen n2 = _N
by carriercode: gen n3  = _N - 8

* drop those carriers who only have 8 quarters of data
drop if carriercode == 3 | carriercode ==5|carriercode == 7|carriercode == 17

* fixed effects (training <= n3)
qui xtreg opor lyield llfp lfleetutil lfueleff lpontime lmisbagg ltotaldelay lcomplaint lhetero lavglandfee lsparsity lmktshare ltdomt_cost lrevpaxenplaned lempfte i.year i.quarter if n1<= n3, fe

predict pout_fe_8 if n1 > n3
cor opor pout_fe_8 // -0.1619

* Mixed Effects (training <= n3)
qui xtmixed opor clyield_mean lyield_w clLFP_mean lLFPw clfleetutil_mean lfleetutil_w clfueleff_mean lfueleff_w clpOntime_mean lpOntime_w lmisbagg_mean lmisbagg_w cltotaldelay_mean ltotaldelay_w clcomplaint_mean lcomplaint_w clhetero_mean lhetero_w clavglandfee_mean lavglandfee_w clsparsity_mean lsparsity_w clMKTshare_mean lMKTshare_w ltdomt_cost_mean ltdomt_costw lrevpaxenplaned_mean lrevpaxenplaned_w lempfte_mean lempfte_w i.year i.quarter if n1<= n3||carriercode:, cov(un) var mle

predict pout_xtmixed_8 if n1 > n3
cor opor pout_xtmixed_8 // -0.0527

* Re Read file to get all 64 quarters 
label variable pout_xtmixed_8 "Between-Within Out of Sample Forecast"
label variable pout_fe_8 "Fixed Effects Out of Sample Forecast"

line opor pout_fe_8  pout_xtmixed_8 occasion if carriercode == 2

* check forecast accurary
gen msefe_8 = (pout_fe_8 - opor)*(pout_fe_8 - opor)
gen msemixed_8 = (pout_xtmixed_8 - opor)*(pout_xtmixed_8 - opor)

**** MSE
total msefe_8 //   7.904922 
total msemixed_8 // 4.029491 


tabstat msefe_8, statistics(mean) by(carriercode)
tabstat msemixed_8, statistics(mean) by(carriercode)

**** BIG FOUR
egen msefe_8_mean = mean(msefe_8), by(carriercode) 
egen msemixed_8_mean = mean(msemixed_8), by(carriercode) 

list carriercode msefe_8_mean
list carriercode msemixed_8_mean


export delimited using "C:\Users\StataOut_8.csv", replace



#############################################################################
#######################  TEST NON LINEAR RELATIONSHIP  #####################
* import file
import delimited "E1_891.csv"

* Create Training Dataset. Each carrier is deducted by 8 quarters.
xtset carriercode occasion
by carriercode: gen n1 = _n
by carriercode: gen n2 = _N
by carriercode: gen n3  = _N - 8

* drop those carriers who only have 8 quarters of data
drop if carriercode == 3 | carriercode ==5|carriercode == 7|carriercode == 17


* test yield2
gen clyield_mean2 = clyield_mean*clyield_mean
gen clyield_mean3 = clyield_mean*clyield_mean*clyield_mean

gen clLFP_mean2 = clLFP_mean*clLFP_mean
gen clLFP_mean3 = clLFP_mean*clLFP_mean*clLFP_mean

*** run line 11 to line 90 before running the model below

*#### Yield
xtmixed opor clyield_mean clyield_mean2 clyield_mean3 clLFP_mean lLFPw clfleetutil_mean lfleetutil_w clfueleff_mean lfueleff_w clpOntime_mean lpOntime_w clmisbagg_mean lmisbagg_w cltotaldelay_mean ltotaldelay_w clcomplaint_mean lcomplaint_w clhetero_mean lhetero_w clavglandfee_mean lavglandfee_w clsparsity_mean lsparsity_w clMKTshare_mean lMKTshare_w ltdomt_cost_mean ltdomt_costw lrevpaxenplaned_mean lrevpaxenplaned_w lempfte_mean lempfte_w i.year i.quarter||carriercode:, cov(un) var mle

predict pout_yield
cor opor pout_yield  // 0.7636

* Yield and OPOR plot
sum clyield_mean //  -.7753078   .6043071
twoway function  0.33*x - 0.8*x^2 - 0.62*x^3, range(-0.77 .6) ytitle("OPOR") xtitle("Yield")

*#### Load Factor
qui xtmixed opor clyield_mean lyield_w clLFP_mean clLFP_mean2 clLFP_mean3 clfleetutil_mean lfleetutil_w clfueleff_mean lfueleff_w clpOntime_mean lpOntime_w clmisbagg_mean lmisbagg_w cltotaldelay_mean ltotaldelay_w clcomplaint_mean lcomplaint_w clhetero_mean lhetero_w clavglandfee_mean lavglandfee_w clsparsity_mean lsparsity_w clMKTshare_mean lMKTshare_w ltdomt_cost_mean ltdomt_costw lrevpaxenplaned_mean lrevpaxenplaned_w lempfte_mean lempfte_w i.year i.quarter||carriercode:, cov(un) var mle

predict pout_lfp
cor opor pout_lfp  // 0.7634

sum clLFP_mean //   -.1254536    .064841
* Load Factor and OPOR Plot
twoway function -2.6*x - 126*x^2 - 601*x^3, range(-0.125 0.06) ytitle("OPOR") xtitle("Load Factor")




