clear all
cap log close
set more off

cd "$logs" 
log using "prep_JMC", replace 


*data on economics PhD job market candidate characteristics and placement outcomes from Ge et al (2021)
*JMC_id identifies each JMC
cd "$raw_data" 
use JMC_raw.dta

*merge name fluency measures by JMC_id
merge 1:1 JMC_id using JMC_pronounce.dta
keep if _m==3
drop _m


**generate name fluency/length measures for full names as the sum of first and last name measures
*algorithm rating based on neural network score weights
gen combined_total=combined_first+combined_last

*pronunciation time rating
gen Median_Name=Median_Last+Median_First

*subjective rating
gen name_at_least_two=first_at_least_two==1|last_at_least_two==1

*alternative algorithm rating based on arithmetic mean of letter/phoneme-based sub-ratings
gen Algorithm_Total_new=algorithm_last_new+algorithm_first_new

*name length
gen Name_length=First_length+Last_length


*label variables
label variable JMC_id "JMC id"
label variable PhD_School "PhD program" 
label variable JM16_17 "1=16-17 JM cycle" 
label variable country "country" 
label variable region "1=US/Canada;2=Latin America;3=Western Europe;4=Eastern Europe;5=South Asia and Middle East;6=East and Southeast Asia;7=Australia and Africa" 
label variable male "1=male" 
label variable elite "1=elite US undergrad" 
label variable USUnder "1=US undergrad" 
label variable PriorGradExp "1=prior grad degree" 
label variable PhDRanking "PhD program ranking" 
label variable subfield_code "1=theory;2=macro/finance;3=econometrics;4=applied micro"
label variable RR "no. of R&Rs" 
label variable TopRR "no. of top 5 R&Rs" 
label variable Pub "no. of pubs" 
label variable TopPub "no. of top 5 pubs" 
label variable TeachAward "1=teaching award" 
label variable Instructor "1=instructor experience" 
label variable Academia "1=academia" 
label variable TT "1=tenure track " 
label variable Postdoc "1=postdoc" 
label variable Visiting "1=visiting" 
label variable GovtThinkTank "1=government/think tank" 
label variable Industry "1=industry" 
label variable Repec "RePEc ranking" 
label variable Repec_imputed "imputed RePEc ranking" 
label variable USJob "1=US job" 
label variable Editor "1=editor exp" 
label variable Top_5_Editor "1=top 5 journal editor exp" 
label variable Top_5_Publication "advisor no. of top 5 pubs" 
label variable ethn_chinese "1=ethnically Chinese" 
label variable country_match_foreign_comm "1=foreign country match with committee members" 
label variable country_match_US_comm "1=US country match with committee members" 
label variable language_match_English_comm "1=English language match with committee members" 
label variable language_match_NonEnglish_comm "1=non-English language match with committee members"  
label variable combined_total "algorithm rating - full name" 
label variable Median_Name "pronunciation time rating - full name" 
label variable name_at_least_two "subjective rating - full name" 
label variable Algorithm_Total_new "alt algorithm rating - full name" 
label variable Name_length "full name length"


*generate dummies for PhD programs, regions and subfields
tab PhD_School, gen(program_ind)
tab region, gen(region_ind)
tab subfield_code, gen(subfield_ind)


cd "$data"
save JMC.dta, replace


log close