clear all
cap log close
set more off

cd "$logs" 
log using "TableA1", replace 

*Table A1: Name Fluency and Placement Outcomes: Alternative Algorithm Rating

cd "$data"
use JMC.dta, clear

cd "$appendix"

*normalize alternative algorithm rating (based on arithmetic average of the letter-based and phoneme-based sub-rating schemes)
replace algorithm_first=(algorithm_f-27.19463)/34.70678
replace algorithm_last=(algorithm_l-28.53206)/33.32195
replace Algorithm_Total=(Algorithm_Total-55.72669)/45.19394

*probit regressions
*Column 1
dprobit Academia male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length Algorithm_Total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA1_probit, tex replace keep(Algorithm_Total) onecol dec(3) noaster addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 2
dprobit Academia male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor First_length Last_length algorithm_first algorithm_last region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA1_probit, tex append keep(algorithm_first algorithm_last) onecol dec(3) noaster addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 3
dprobit TT male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length Algorithm_Total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA1_probit, tex append keep(Algorithm_Total) onecol dec(3) noaster addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 4
dprobit TT male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor First_length Last_length algorithm_first algorithm_last region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA1_probit, tex append keep(algorithm_first algorithm_last) onecol dec(3) noaster addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*tobit regressions
*Column 5
tobit Repec_imp male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length Algorithm_Total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, ul(1000) vce(r)
outreg2 using TableA1_tobit, tex replace keep(Algorithm_Total) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 6
tobit Repec_imp male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor First_length Last_length algorithm_first algorithm_last region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, ul(1000) vce(r)
outreg2 using TableA1_tobit, tex append keep(algorithm_first algorithm_last) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)



log close