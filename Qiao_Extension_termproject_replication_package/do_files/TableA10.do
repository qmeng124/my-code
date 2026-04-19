clear all
cap log close
set more off

cd "$logs" 
log using "TableA10", replace 

*Table A10: Name Fluency and Placement Outcomes: Accounting for Common Names
cd "$data"
use JMC.dta, clear

cd "$appendix"

*normalize algorithm rating
replace combined_first=(combined_first-38.2247)/33.66213
replace combined_last=(combined_last-40.75375)/32.19882
replace combined_total=(combined_t-78.97844)/44.58245

*generate interaction between common first and last names
gen common_firstlast=common50_first==1&common50_last==1

*all candidates
*probt regressions
*Column 1
dprobit Academia male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor common50_first common50_last common_firstlast Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA10_probit, tex replace keep(common50_first common50_last common_firstlast combined_total) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Country/JM Cycle FE, Yes)
*Column 2
dprobit TT male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor common50_first common50_last common_firstlast Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA10_probit, tex append keep(common50_first common50_last common_firstlast combined_total) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Country/JM Cycle FE, Yes)
*Column 3
tobit Repec_imp male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor common50_first common50_last common_firstlast Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, ul(1000) vce(r)
outreg2 using TableA10_tobit, tex replace keep(common50_first common50_last common_firstlast combined_total) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Country/JM Cycle FE, Yes)


*candidates from U.S. and Canada
*probt regressions
*Column 4
dprobit Academia male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor common50_first common50_last common_firstlast Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if region==1, vce(r)
outreg2 using TableA10_probit, tex append keep(common50_first common50_last common_firstlast combined_total) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Country/JM Cycle FE, Yes)
*Column 5
dprobit TT male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor common50_first common50_last common_firstlast Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if region==1, vce(r)
outreg2 using TableA10_probit, tex append keep(common50_first common50_last common_firstlast combined_total) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Country/JM Cycle FE, Yes)
*Column 6
tobit Repec_imp male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor common50_first common50_last common_firstlast Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if region==1, ul(1000) vce(r)
outreg2 using TableA10_tobit, tex append keep(common50_first common50_last common_firstlast combined_total) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Country/JM Cycle FE, Yes)


log close