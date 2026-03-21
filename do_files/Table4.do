clear all
cap log close
set more off

cd "$logs" 
log using "Table4", replace 

*Table 4: Name Fluency and Placement Outcomes by Program Rankings

cd "$data"
use JMC.dta, clear

cd "$tables"

*normalize algorithm rating
replace combined_first=(combined_first-38.2247)/33.66213
replace combined_last=(combined_last-40.75375)/32.19882
replace combined_total=(combined_t-78.97844)/44.58245

*top ranked (top 20) vs. lower ranked (outside of top 50)
gen top20PhD=PhDR<=20
gen nontop50PhD=PhDR>50

*probit regressions
*top ranked
*Column 1
dprobit Academia male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if top20Ph==1, vce(r)
outreg2 using Table4_probit, tex replace keep(combined_total) onecol dec(3) noaster addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 2
dprobit TT male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if top20Ph==1, vce(r)
outreg2 using Table4_probit, tex append keep(combined_total) onecol dec(3) noaster addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*lower ranked
*Column 4
dprobit Academia male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if nontop50Ph==1, vce(r)
outreg2 using Table4_probit, tex append keep(combined_total) onecol dec(3) noaster addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 5
dprobit TT male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if nontop50Ph==1, vce(r)
outreg2 using Table4_probit, tex append keep(combined_total) onecol dec(3) noaster addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)


*tobit regressions
*top ranked
*Column 3
tobit Repec_imp male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if top20Ph==1, ul(1000) vce(r)
outreg2 using Table4_tobit, tex replace keep(combined_total) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*lower ranked
*Column 6
tobit Repec_imp male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if nontop50Ph==1, ul(1000) vce(r)
outreg2 using Table4_tobit, tex append keep(combined_total) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)



log close