#####################################################################
##################   Monte Carlo Analysis ###########################



#####################################################################
##################   80% TRAINING ##################################
* use the same dataset that was split and used in DNN and XGB. 

* import file
import delimited "train_cv.csv"

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

* set up data for analysis
xtset carriercode occasion

* fixed effects 
qui xtreg opor lyield llfp lfleetutil lfueleff lpontime lmisbagg ltotaldelay lcomplaint lhetero lavglandfee lsparsity lmktshare ltdomt_cost lrevpaxenplaned lempfte  year_2004 year_2005 year_2006 year_2007 year_2008 year_2009 year_2010 year_2011 year_2012 year_2013 year_2014 year_2015 year_2016 year_2017 year_2018 year_2019 quarter_1 quarter_2 quarter_3 quarter_4, fe

predict pout_fe_cv
cor opor pout_fe_cv // 0.5846

* Mixed Effects
qui xtmixed opor clyield_mean lyield_w clLFP_mean lLFPw clfleetutil_mean lfleetutil_w clfueleff_mean lfueleff_w clpOntime_mean lpOntime_w lmisbagg_mean lmisbagg_w cltotaldelay_mean ltotaldelay_w clcomplaint_mean lcomplaint_w clhetero_mean lhetero_w clavglandfee_mean lavglandfee_w clsparsity_mean lsparsity_w clMKTshare_mean lMKTshare_w ltdomt_cost_mean ltdomt_costw lrevpaxenplaned_mean lrevpaxenplaned_w lempfte_mean lempfte_w year_2004 year_2005 year_2006 year_2007 year_2008 year_2009 year_2010 year_2011 year_2012 year_2013 year_2014 year_2015 year_2016 year_2017 year_2018 year_2019 quarter_1 quarter_2 quarter_3 quarter_4 ||carriercode:, cov(un) var mle

predict pout_xtmixed_cv
cor opor pout_xtmixed_cv // 0.7489

* Label
label variable pout_xtmixed_cv "Between-Within Out of Sample Forecast"
label variable pout_fe_cv "Fixed Effects Out of Sample Forecast"

line opor pout_fe_cv  pout_xtmixed_cv occasion if carriercode == 2

* check forecast accurary
gen msefe_cv = (pout_fe_cv - opor)*(pout_fe_cv - opor)
gen msemixed_cv = (pout_xtmixed_cv - opor)*(pout_xtmixed_cv - opor)

**** MSE
total msefe_cv //    5.465475 
total msemixed_cv //  3.266029

tabstat msefe_cv, statistics(mean) by(carriercode)
tabstat msemixed_cv, statistics(mean) by(carriercode)

**** Big Four
egen msefe_cv_mean = mean(msefe_cv), by(carriercode)
egen msemixed_cv_mean = mean(msemixed_cv), by(carriercode)

list msefe_cv_mean carriercode
list msemixed_cv_mean carriercode

* save
export delimited using "StataTrain_cv.csv", replace



#####################################################################
##################   20% TESTING ##################################
* use the same dataset that was split and used in DNN and XGB. 

* import file
import delimited "test_cv.csv"

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

* set up data for analysis
xtset carriercode occasion

* fixed effects 
qui xtreg opor lyield llfp lfleetutil lfueleff lpontime lmisbagg ltotaldelay lcomplaint lhetero lavglandfee lsparsity lmktshare ltdomt_cost lrevpaxenplaned lempfte  year_2004 year_2005 year_2006 year_2007 year_2008 year_2009 year_2010 year_2011 year_2012 year_2013 year_2014 year_2015 year_2016 year_2017 year_2018 year_2019 quarter_1 quarter_2 quarter_3 quarter_4, fe

predict pout_fe_cv_test
cor opor pout_fe_cv_test // 0.4525

* Mixed Effects
qui xtmixed opor clyield_mean lyield_w clLFP_mean lLFPw clfleetutil_mean lfleetutil_w clfueleff_mean lfueleff_w clpOntime_mean lpOntime_w lmisbagg_mean lmisbagg_w cltotaldelay_mean ltotaldelay_w clcomplaint_mean lcomplaint_w clhetero_mean lhetero_w clavglandfee_mean lavglandfee_w clsparsity_mean lsparsity_w clMKTshare_mean lMKTshare_w ltdomt_cost_mean ltdomt_costw lrevpaxenplaned_mean lrevpaxenplaned_w lempfte_mean lempfte_w year_2004 year_2005 year_2006 year_2007 year_2008 year_2009 year_2010 year_2011 year_2012 year_2013 year_2014 year_2015 year_2016 year_2017 year_2018 year_2019 quarter_1 quarter_2 quarter_3 quarter_4 ||carriercode:, cov(un) var mle

predict pout_xtmixed_cv_test
cor opor pout_xtmixed_cv_test // 0.8658

* Label
label variable pout_xtmixed_cv_test "Between-Within Out of Sample Forecast"
label variable pout_fe_cv_test "Fixed Effects Out of Sample Forecast"

line opor pout_fe_cv_test  pout_xtmixed_cv_test occasion if carriercode == 2

* check forecast accurary
gen msefe_cv_test = (pout_fe_cv_test - opor)*(pout_fe_cv_test - opor)
gen msemixed_cv_test = (pout_xtmixed_cv_test - opor)*(pout_xtmixed_cv_test - opor)

**** MSE
total msefe_cv_test //    5.383981 
total msemixed_cv_test //   .3887789


**** Big Four
egen msefe_cv_test_mean = mean(msefe_cv_test), by(carriercode)
egen msemixed_cv_test_mean = mean(msemixed_cv_test), by(carriercode)

list msefe_cv_test_mean carriercode
list msemixed_cv_test_mean carriercode

* save
export delimited using "StataTest_cv.csv", replace






