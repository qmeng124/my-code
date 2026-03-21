clear all
cap log close
set more off

cd "$logs" 
log using "Table2", replace 

*Table 2: Name Fluency and Placement Outcomes: Algorithm Rating

cd "$data"
use JMC.dta, clear

cd "$tables"

*normalize algorithm rating
replace combined_first=(combined_first-38.2247)/33.66213
replace combined_last=(combined_last-40.75375)/32.19882
replace combined_total=(combined_t-78.97844)/44.58245

*probit regressions
*Column 1
dprobit Academia male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using Table2_probit, tex replace keep(male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor combined_total) onecol dec(3) noaster addtext(Control for Name Length, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 2
dprobit Academia male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor First_length Last_length combined_first combined_last region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using Table2_probit, tex append keep(male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor combined_first combined_last) onecol dec(3) noaster addtext(Control for Name Length, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 3
dprobit TT male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using Table2_probit, tex append keep(male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor combined_total) onecol dec(3) noaster addtext(Control for Name Length, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 4
dprobit TT male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor First_length Last_length combined_first combined_last region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using Table2_probit, tex append keep(male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor combined_first combined_last) onecol dec(3) noaster addtext(Control for Name Length, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*tobit regressions
*Column 5
tobit Repec_imp male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, ul(1000) vce(r)
outreg2 using Table2_tobit, tex replace keep(male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor combined_total) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 6
tobit Repec_imp male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor First_length Last_length combined_first combined_last region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, ul(1000) vce(r)
outreg2 using Table2_tobit, tex append keep(male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor combined_first combined_last) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)


log close