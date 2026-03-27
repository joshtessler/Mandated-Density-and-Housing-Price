/*
File Name:		Ten Year Test
File Purpose:	Reggressions for Senior Thesis with 10 year before and after controls
File Author:	Josh Tessler
Date Created:	3/26/2025
Last Updated:	3/26/2025
*/

/*
Uses the following packages:
ssc install drdid, all replace
ssc install csdid, all replace
*/

clear

*Uses data set from the directory
use "C:\Users\jztes\OneDrive\Desktop\Thesis\Master Data.dta"

/*
Table Key:
	s= regression, Near-Far
	u= regression, Build-Future
	inter1= Near-Far inter varable
	inter2= Build-Future inter varable
	inter3= fist year of tod construction
*/

*------------------------Regression Analysis-----------------------------------
*Restricting time frame to 5 years before and after polcy implimentation polcy 
bysort tract (year): egen treatment_year = min(cond(tod==1, year, .))
gen event_time = year - treatment_year
keep if event_time >= -10 & event_time <= 10
drop if missing(treatment_year)

*Baseline model
eststo s1: reg hpi laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore inter1 if past == 1, robust
bysort tract: gen tag = _n==1
sum tag if e(sample)
scalar n_tracts = r(sum)
estadd scalar tracts = n_tracts
drop tag

eststo u1: reg hpi laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore inter2 if disnear == 1, robust
bysort tract: gen tag = _n==1
sum tag if e(sample)
scalar n_tracts = r(sum)
estadd scalar tracts = n_tracts
drop tag

*With Tract Fixed effects
xtset tractid
eststo s2: xtreg hpi laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore inter1 if past == 1, fe robust
bysort tract: gen tag = _n==1
sum tag if e(sample)
scalar n_tracts = r(sum)
estadd scalar tracts = n_tracts
drop tag

eststo u2: xtreg hpi laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore inter2 if disnear == 1, fe robust
bysort tract: gen tag = _n==1
sum tag if e(sample)
scalar n_tracts = r(sum)
estadd scalar tracts = n_tracts
drop tag

*With Yearly Fixed effects
xtset year
eststo s3:xtreg hpi laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore inter1 if past == 1, fe robust
bysort tract: gen tag = _n==1
sum tag if e(sample)
scalar n_tracts = r(sum)
estadd scalar tracts = n_tracts
drop tag

eststo u3:xtreg hpi laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore inter2 if disnear == 1, fe robust
bysort tract: gen tag = _n==1
sum tag if e(sample)
scalar n_tracts = r(sum)
estadd scalar tracts = n_tracts
drop tag

*With Both Yearly and Tracted Fixed effects
xtset tractid year
eststo s4:xtreg hpi laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore inter1 if past == 1, fe robust
bysort tract: gen tag = _n==1
sum tag if e(sample)
scalar n_tracts = r(sum)
estadd scalar tracts = n_tracts
drop tag

eststo u4:xtreg hpi laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore inter2 if disnear == 1, fe robust
bysort tract: gen tag = _n==1
sum tag if e(sample)
scalar n_tracts = r(sum)
estadd scalar tracts = n_tracts
drop tag

*With CDS diff-in-diff, Yearly, and Tracted Fixed effects
*Resetting data
clear
use "C:\Users\jztes\OneDrive\Desktop\Thesis\Master Data.dta"

*Near-Far Analysis
csdid hpi laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore if past == 1, i(tractid) t(year) g(inter3) method(reg)
estat event, window(-10 10)
csdid_plot

*Built-Future Analysis
csdid hpi laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore if disnear == 1 ,  i(tractid) t(year) g(inter3) method(reg)
estat event, window(-10 10)
csdid_plot

*------------------------------Ploting Graphs------------------------------------
*Near-Far
esttab s1 s2 s3 s4 using "HPI_Near_Far_Ten", rtf se label stats(tracts r2 r2_a,label("Obs" "R Squared" "Adjusted R Squared")) replace

*Build-Future
esttab u1 u2 u3 u4 using "HPI_Build_Future_Ten", rtf se label stats(N r2 r2_a,label("Obs" "R Squared" "Adjusted R Squared")) replace
