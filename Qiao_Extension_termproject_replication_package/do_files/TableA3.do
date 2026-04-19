clear all
cap log close
set more off

cd "$logs" 
log using "TableA3", replace 

*Table A3: Name Fluency and Placement Types: Multinomial Logit Estimates
cd "$data"
use JMC.dta, clear

cd "$appendix"

*normalize algorithm rating
replace combined_first=(combined_first-38.2247)/33.66213
replace combined_last=(combined_last-40.75375)/32.19882
replace combined_total=(combined_t-78.97844)/44.58245

*normalize pronunciation time
replace Median_First=(Median_F-1.29353)/.3379583
replace Median_Last=(Median_L-1.231449)/.4062648
replace Median_Name=(Median_N-2.524979)/.5371972

*** define placement categories (1=TT; 2=post/visiting; 3=GovtThinktanks; 4=Industry)
gen job_cat=1 if TT==1 | Postdoc==1 | Visiting==1
replace job_cat=2 if Govt==1
replace job_cat=3 if Industry==1

label define types 1 "Academia" 2 "Govt_Thinktank" 3 "Industry"  
label values job_cat types 

*multinomial logit regressions
*Columns 1-2: algorithm rating
mlogit job_cat male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, base(2) 
outreg2 using TableA3_algorithm, tex replace keep(combined_total) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*Columns 3-4: pronunciation time
mlogit job_cat male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length Median_Name region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, base(2) 
outreg2 using TableA3_time, tex replace keep(Median_Name) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*Columns 5-6: subjective measure
mlogit job_cat male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length name_at_least_two region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, base(2) 
outreg2 using TableA3_subjective, tex replace keep(name_at_least_two) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)


log close
