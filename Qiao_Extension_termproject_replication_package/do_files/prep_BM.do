clear all
cap log close
set more off

cd "$logs" 
log using "prep_BM", replace 


*replication data from Bertrand and Mullainathan (2004)
cd "$raw_data" 
use lakisha_aer.dta

*merge name fluency measures by name (only first names are availble in BM's replication data)
merge m:1 firstname using BM_pronounce.dta
keep if _m==3
drop _m

*data cleaning
gen black=race=="b"
gen white=race=="w"
gen female=sex=="f"
gen First_length=strlen(firstname)
gen yearsexp2=yearsexp^2
gen college=(education==4)

*normalize algorithm pronunciation rating
replace combined=(combined-28.76169)/(29.56694)

*label variables
label variable black "1=black"
label variable white "1=white"
label variable female "1=female"
label variable First_length "first name length"
label variable yearsexp2 "years of work experience squared"
label variable college "1=college educated"

cd "$data" 
save BM.dta, replace


log close