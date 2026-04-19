clear all
cap log close
set more off

cd "$logs" 
log using "TableA4", replace 

*Table A4: Name Fluency and Placement Types: Multinomial Logit Estimates – Alternative Placement Categories
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

*** define alternative placement categories (1=TT; 2=post/visiting; 3=GovtThinktanks; 4=Industry)
gen job_cat1=1 if TT==1 
replace job_cat1=2 if Postdoc==1 | Visiting==1
replace job_cat1=3 if Govt==1
replace job_cat1=4 if Industry==1

label define types1 1 "Academia" 2 "PostDoc/Visiting" 3 "Govt_Thinktank" 4 "Industry"  
label values job_cat1 types1 

*multinomial logit regressions
*Columns 1-3: algorithm rating
mlogit job_cat1 male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, base(2)
outreg2 using TableA4_algorithm, tex replace keep(combined_total) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*Columns 4-6: pronunciation time
mlogit job_cat1 male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length Median_Name region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, base(2)
outreg2 using TableA4_time, tex replace keep(Median_Name) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*Columns 7-9: subjective measure
mlogit job_cat1 male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length name_at_least_two region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, base(2) 
outreg2 using TableA4_subjective, tex replace keep(name_at_least_two) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)


log close
