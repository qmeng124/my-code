clear all
cap log close
set more off

cd "$logs" 
log using "TableA5", replace 

*Table A5: Name Fluency and Placement Quality: Ordered Probit Estimates
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

*define cutoffs for Repec_imputed
gen group=1 if Repec_imp<=50
replace group=2 if Repec_imp>50&Repec_imp<=200
replace group=3 if Repec_imp>200&Repec_imp<=400
replace group=4 if Repec_imp>400&Repec_imp<=800
replace group=5 if Repec_imp==1000 

*ordered probit regressions
*Column 1
oprobit group male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(robust)
outreg2 using TableA5, tex replace keep(combined_total) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 2
oprobit group male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length Median_Name region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(robust)
outreg2 using TableA5, tex append keep(Median_Name) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 3
oprobit group male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length name_at_least_two region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(robust)
outreg2 using TableA5, tex append keep(name_at_least_two) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)


log close
