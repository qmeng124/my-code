clear all
cap log close
set more off

cd "$logs" 
log using "prep_NunleyEtAl", replace 


*replication data from Nunley et al. (2015)
cd "$raw_data" 
use bejeap_deidentified_data.dta

*merge name fluency measures by name
merge 1:1 id using NunleyEtAl_pronounce.dta
keep if _m==3
drop _m

*label variables
label variable id "id"
label variable job_id "job id"
label variable job_title "job title"
label variable deshawn "1=Deshawn"
label variable deandre "1=Deandre"
label variable cody "1=Cody"
label variable jake "1=Jake"
label variable claire "1=Claire"
label variable amy "1=Amy"
label variable ebony "1=Ebony"
label variable aaliyah "1=Aaliya"
label variable econ_major "1=economics major"
label variable fin_major "1=finance major"
label variable acc_major "1=accounting major"
label variable mgt_major "1=management major"
label variable mkt_major "1=marketing major"
label variable hist_major "1=history major"
label variable eng_major "1=engineering major"
label variable psych_major "1=psychology major"
label variable bio_major "1=biology major"
label variable honors "1=BA with honors"
label variable no_gap "1=no gap in work history"
label variable call_back "1=callback"
label variable month "month"
label variable ind_banking "1=banking"
label variable ind_finance "1=finance"
label variable ind_insurance "1=insurance"
label variable ind_management "1=management"
label variable ind_marketing "1=marketing"
label variable ind_sales "1=sales"
label variable high_ses "1=high SES"
label variable intern "1=internship experience"
label variable city "city"
label variable black "1=black"
label variable white "1=white"
label variable female "1=female"
label variable male "1=male"
label variable employed "1=employed"
label variable u3_current "1=3-month back-end gap"
label variable u6_current "1=6-month back-end gap"
label variable u12_current "1=12-month back-end gap"
label variable u3_past "1=3-month front-end gap"
label variable u6_past "1=6-month front-end gap"
label variable u12_past "1=12-month front-end gap"
label variable underemp "1=underemployment"
label variable univ1 "1=university 1"
label variable univ2 "1=university 2"
label variable univ3 "1=university 3"
label variable univ4 "1=university 4"
label variable gpa "1=GPA reported"


cd "$data" 
save NunleyEtAl.dta, replace


log close