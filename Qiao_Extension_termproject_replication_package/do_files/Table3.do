clear all
cap log close
set more off

cd "$logs" 
log using "Table3", replace 

*Table 3: Name Fluency and Placement Outcomes: Pronunciation Time and Subjective Rating

cd "$data"
use JMC.dta, clear

cd "$tables"

*normalize pronunciation time
replace Median_First=(Median_F-1.29353)/.3379583
replace Median_Last=(Median_L-1.231449)/.4062648
replace Median_Name=(Median_N-2.524979)/.5371972

*probit regressions
*Column 1
dprobit Academia male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length Median_Name region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using Table3_probit, tex replace keep(Median_Name) onecol dec(3) noaster addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 2
dprobit Academia male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length name_at_least_two region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using Table3_probit, tex append keep(name_at_least_two) onecol dec(3) noaster addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 3
dprobit TT male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length Median_Name region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using Table3_probit, tex append keep(Median_Name) onecol dec(3) noaster addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 4
dprobit TT male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length name_at_least_two region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using Table3_probit, tex append keep(name_at_least_two) onecol dec(3) noaster addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*tobit regressions
*Column 5
tobit Repec_imp male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length Median_Name region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, ul(1000) vce(r)
outreg2 using Table3_tobit, tex replace keep(Median_Name) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 6
tobit Repec_imp male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length name_at_least_two region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, ul(1000) vce(r)
outreg2 using Table3_tobit, tex append keep(name_at_least_two) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)



log close