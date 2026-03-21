clear all
cap log close
set more off

cd "$logs" 
log using "prep_BM_Oreop_pooled", replace 

*pooling data from Bertrand and Mullainathan (2004) and Oreopoulos (2011)

*BM data
*rename variables in BM to match Oreopoulos
cd "$data"
use BM.dta, clear

gen first=firstname
gen callback=call
gen race1=black
gen first_combined=combinedsc 
gen lowquality=l
encode id, gen (firmid)
gen skills=(computerskills==1| specialskills==1) 
gen BM=1

save BM_pooled.dta, replace

*Oreopoulos data
*rename variables in Oreopoulos to match BM
cd "$data"
use Oreopoulos.dta, clear

gen race1=(indian_ind==1|pakistani_ind==1|chinese_ind==1)
gen lowquality=(ma==0)
gen college=1
gen skills=(extracurricular_skills==1|language_skills==1)
gen BM=0

*append using BM_pooled to generate combined audit study sample
append using BM_pooled.dta, force
save BM_Oreop_pooled.dta, replace

erase BM_pooled.dta

log close