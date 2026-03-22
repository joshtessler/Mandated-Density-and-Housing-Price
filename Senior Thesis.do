/*
File Name:		Senior Thesis
File Purpose:	Summerization and Reggressions for Senior Thesis 
File Author:	Josh Tessler
Date Created:	10/26/2025
Last Updated:	3/21/2025
*/

/*
Uses the following packages:
ssc install drdid, all replace
ssc install csdid, all replace
*/

clear

*Uses data set from the directory
use "C:\Users\jztes\OneDrive\Desktop\Thesis\Master Data.dta"

*------------------------Summery Statistitcs-----------------------------------
*Looking at differance between near and far tracts
*Area characteristics
estpost sum area people household income density renter if disnear == 1
est store a

estpost sum area people household income density renter if disfar == 1
est store b

estpost ttest area people household income density renter, by(disnear)
est store abd

*Race characteristics
estpost sum white black indian asian hawaiian tworace twomore if disnear == 1
est store c

estpost sum white black indian asian hawaiian tworace twomore if disfar == 1
est store d

estpost ttest white black indian asian hawaiian tworace twomore, by(disnear)
est store cdd

*Commuting characteristics    
estpost sum car publictransit cycle walk wfh commute if disnear == 1
est store e

estpost sum car publictransit cycle walk wfh commute if disfar == 1
est store f

estpost ttest car publictransit cycle walk wfh commute, by(disnear)
est store efd

*Looking at differances between current and future TOD locations
*Area characteristics
estpost sum area people household income density renter if future == 1 & disnear == 1
est store g

estpost sum area people household income density renter if future == 0 & disnear == 1
est store h

estpost ttest area people household income density renter, by(future)
est store ghd

*Race characteristics
estpost sum white black indian asian hawaiian tworace twomore if future == 1 & disnear == 1
est store i

estpost sum white black indian asian hawaiian tworace twomore if future == 0 & disnear == 1
est store j

estpost ttest white black indian asian hawaiian tworace twomore, by(future)
est store ijd

*Commuting characteristics
estpost sum car publictransit cycle walk wfh commute if future == 1 & disnear == 1
est store k

estpost sum car publictransit cycle walk wfh commute if future == 0 & disnear == 1
est store l

estpost ttest car publictransit cycle walk wfh commute, by(future)
est store kld

*Summary statistics of regression varables
*Commuting characteristics of pre vs post 2020
estpost sum car publictransit cycle walk wfh commute if disnear == 1 & year<2020
est store r

estpost sum car publictransit cycle walk wfh commute if disnear == 1 & year>2020
est store s

gen pre = 0
replace pre = 1 if year<2020
estpost ttest car publictransit cycle walk wfh commute, by(pre)
est store rsd
drop pre

*Basic regression varables summery
estpost sum laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore
est store m

*Near vs Far track analysis with regression varables
estpost sum laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore if disnear == 1
est store n

estpost sum laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore if disfar == 1
est store o

estpost ttest laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore, by(disnear)
est store nod

*Current vs future track analysis with regression varables
estpost sum laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore if future == 1 & disnear == 1
est store p

estpost sum laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore if future == 0 & disnear == 1
est store q

estpost ttest laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore, by(future)
est store pqd

*---------------------------Graphing individual tracts--------------------------
collapse (mean) hpi, by(name disnear year)

*Fruitville Project (2004, 2019, 2022)
twoway (line hpi year if name == "Fruitvale" & disnear == 1, mcolor(blue)) (line hpi year if name == "Fruitvale" & disnear == 0, mcolor(red)), ytitle("Housing Price Index") legend(lab (1 "Near") lab(2 "Far")) title("Fruitvale Change in Housing Price Index") tline(2004) tline(2019) tline(2022)

*Millbrae (2016)
twoway (line hpi year if name == "Millbrae" & disnear == 1, mcolor(blue)) (line hpi year if name == "Millbrae" & disnear == 0, mcolor(red)), ytitle("Housing Price Index") legend(lab (1 "Near") lab(2 "Far")) title("Millbrae Change in Housing Price Index") tline(2016)

*South Hayward (2017)
twoway (line hpi year if name == "South Hayward" & disnear == 1, mcolor(blue)) (line hpi year if name == "South Hayward" & disnear == 0, mcolor(red)), ytitle("Housing Price Index") legend(lab (1 "Near") lab(2 "Far")) title("South Hayward Change in Housing Price Index") tline(2017)

*Walnut Creek (2019, 2022)
twoway (line hpi year if name == "Walnut Creek" & disnear == 1, mcolor(blue)) (line hpi year if name == "Walnut Creek" & disnear == 0, mcolor(red)), ytitle("Housing Price Index") legend(lab (1 "Near") lab(2 "Far")) title("Walnut Creek Change in Housing Price Index") tline(2019) tline(2022)

*Pleasant Hill/Contra Costa Centre (2008, 2020)
twoway (line hpi year if name == "Pleasant Hill/Contra Costa Centre" & disnear == 1, mcolor(blue)) (line hpi year if name == "Pleasant Hill/Contra Costa Centre" & disnear == 0, mcolor(red)), ytitle("Housing Price Index") legend(lab (1 "Near") lab(2 "Far")) title("Pleasant Hill Change in Housing Price Index") tline(2008) tline(2020)

*Balboa Park (2010)
twoway (line hpi year if name == "Balboa Park" & disnear == 1, mcolor(blue)) (line hpi year if name == "Balboa Park" & disnear == 0, mcolor(red)), ytitle("Housing Price Index") legend(lab (1 "Near") lab(2 "Far")) title("Balboa Park Change in Housing Price Index") tline(2010)

*Ashby (2023)
twoway (line hpi year if name == "Ashby" & disnear == 1, mcolor(blue)) (line hpi year if name == "Ashby" & disnear == 0, mcolor(red)), ytitle("Housing Price Index") legend(lab (1 "Near") lab(2 "Far")) title("Ashby Change in Housing Price Index") tline(2023)

*Castro Valley (1993)
twoway (line hpi year if name == "Castro Valley" & disnear == 1, mcolor(blue)) (line hpi year if name == "Castro Valley" & disnear == 0, mcolor(red)), ytitle("Housing Price Index") legend(lab (1 "Near") lab(2 "Far")) title("Castro Valley Change in Housing Price Index") tline(1993)

*Coliseum (2019)
twoway (line hpi year if name == "Coliseum" & disnear == 1, mcolor(blue)) (line hpi year if name == "Coliseum" & disnear == 0, mcolor(red)), ytitle("Housing Price Index") legend(lab (1 "Near") lab(2 "Far")) title("Coliseum Change in Housing Price Index") tline(2019)

*Dublin/Pleasanton (2008)
twoway (line hpi year if name == "Dublin/Pleasanton" & disnear == 1, mcolor(blue)) (line hpi year if name == "Dublin/Pleasanton" & disnear == 0, mcolor(red)), ytitle("Housing Price Index") legend(lab (1 "Near") lab(2 "Far")) title("Dublin/Pleasanton Change in Housing Price Index") tline(2008)

*Hayward (1998)
twoway (line hpi year if name == "Hayward" & disnear == 1, mcolor(blue)) (line hpi year if name == "Hayward" & disnear == 0, mcolor(red)), ytitle("Housing Price Index") legend(lab (1 "Near") lab(2 "Far")) title("Hayward Change in Housing Price Index") tline(1998)

*MacArthur (2019, 2020)
twoway (line hpi year if name == "MacArthur" & disnear == 1, mcolor(blue)) (line hpi year if name == "MacArthur" & disnear == 0, mcolor(red)), ytitle("Housing Price Index") legend(lab (1 "Near") lab(2 "Far")) title("MacArthur Change in Housing Price Index") tline(2019) tline(2020)

*Richmond (2018)
twoway (line hpi year if name == "Richmond" & disnear == 1, mcolor(blue)) (line hpi year if name == "Richmond" & disnear == 0, mcolor(red)), ytitle("Housing Price Index") legend(lab (1 "Near") lab(2 "Far")) title("Richmond Change in Housing Price Index") tline(2018)

*San Leandro (2017, 2019)
twoway (line hpi year if name == "San Leandro" & disnear == 1, mcolor(blue)) (line hpi year if name == "San Leandro" & disnear == 0, mcolor(red)), ytitle("Housing Price Index") legend(lab (1 "Near") lab(2 "Far")) title("San Leandro Change in Housing Price Index") tline(2017) tline(2019)

*West Dublin/Pleasanton (2011, 2014, 2019)
twoway (line hpi year if name == "West Dublin/Pleasanton" & disnear == 1, mcolor(blue)) (line hpi year if name == "West Dublin/Pleasanton" & disnear == 0, mcolor(red)), ytitle("Housing Price Index") legend(lab (1 "Near") lab(2 "Far")) title("West Dublin/Pleasanton Change in Housing Price Index") tline(2011) tline(2014) tline(2019)

*----------------------------Other Graphs---------------------------------------
*Near-Far
clear
use "C:\Users\jztes\OneDrive\Desktop\Thesis\Master Data.dta"
gen event_time = year - inter3
keep if event_time >= -20 & event_time <= 20
collapse (mean) hpi, by(event_time disnear)
sort disnear event_time
twoway (line hpi event_time if disnear==1, lwidth(medthick)) (line hpi event_time if disnear==0, lwidth(medthick)), xline(0) xlabel(-20(5)20) ylabel(, angle(horizontal)) xtitle("Years Relative to Policy") ytitle("Housing Price Index") legend(label(1 "Near Station") label(2 "Far from Station")) title("Policy Impact on Housing Prices, Far Tracts as Control")
drop event_time

*Build-Future
clear
use "C:\Users\jztes\OneDrive\Desktop\Thesis\Master Data.dta"
gen event_time = year - inter3
keep if event_time >= -20 & event_time <= 20
collapse (mean) hpi, by(event_time future)
sort future event_time
twoway (line hpi event_time if future==1, lwidth(medthick)) (line hpi event_time if future==0, lwidth(medthick)), xline(0) xlabel(-20(5)20) ylabel(, angle(horizontal)) xtitle("Years Relative to Policy") ytitle("Housing Price Index") legend(label(1 "Near Station") label(2 "Far from Station")) title("Policy Impact on Housing Prices, Future Stations as Control")
drop event_time

*----------------------------Reasbalishing data set-------------------------------
clear
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
keep if event_time >= -5 & event_time <= 5
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
estat event, window(-5 5)
csdid_plot

*Built-Future Analysis
csdid hpi laghpi housing ahousing office commercial commute density income white black indian asian hawaiian tworace twomore if disnear == 1 ,  i(tractid) t(year) g(inter3) method(reg)
estat event, window(-5 5)
csdid_plot

*-------------------------Exporting Tables---------------------------------------
*--------------Summary statistics comparison tables------------------------------
esttab a b abd using Near_Far_Area.doc, rtf label cells("mean(fmt(2))" "b(fmt(2))") mtitles("Near" "Far" "Difference") collabels(none) stats(tracts, label("Obs")) replace
esttab c d cdd using Near_Far_Race.doc, rtf label cells("mean(fmt(2))" "b(fmt(2))") mtitles("Near" "Far" "Difference") collabels(none) stats(N, label("Obs")) replace
esttab e f efd using Near_Far_Commuting.doc, rtf label cells("mean(fmt(2))" "b(fmt(2))") mtitles("Near" "Far" "Difference") collabels(none) stats(N, label("Obs")) replace

esttab g h ghd using Pre_Post_Area.doc, rtf label cells("mean(fmt(2))" "b(fmt(2))") mtitles("Built" "Future" "Difference") collabels(none) stats(N, label("Obs")) replace
esttab i j ijd using Pre_Post_Race.doc, rtf label cells("mean(fmt(2))" "b(fmt(2))") mtitles("Built" "Future" "Difference") collabels(none) stats(N, label("Obs")) replace
esttab k l kld using Pre_Post_Commuting.doc, rtf label cells("mean(fmt(2))" "b(fmt(2))") mtitles("Built" "Future" "Difference") collabels(none) stats(N, label("Obs")) replace

esttab r s rsd using Pre_Post_2020.doc, rtf label cells("mean(fmt(2))" "b(fmt(2))") mtitles("Built" "Future" "Difference") collabels(none) stats(N, label("Obs")) replace
esttab n o nod using Near_Far_Regression.doc, rtf label cells("mean(fmt(2))" "b(fmt(2))") mtitles("Near" "Far" "Difference") collabels(none) stats(N, label("Obs")) replace
esttab p q pqd using Pre_Post_Regression.doc, rtf label cells("mean(fmt(2))" "b(fmt(2))") mtitles("Built" "Future" "Difference") collabels(none) stats(N, label("Obs")) replace

*------------------------Regression Table----------------------------------------
*Near-Far
esttab s1 s2 s3 s4 using "HPI_Near_Far", rtf se label stats(tracts r2 r2_a,label("Obs" "R Squared" "Adjusted R Squared")) replace

*Build-Future
esttab u1 u2 u3 u4 using "HPI_Build_Future", rtf se label stats(N r2 r2_a,label("Obs" "R Squared" "Adjusted R Squared")) replace
