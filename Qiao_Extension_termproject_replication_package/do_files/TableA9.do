clear all
cap log close
set more off

cd "$logs" 
log using "TableA9", replace 

*Table A9: Name Fluency and Placement Outcomes: Country Fixed Effects
cd "$data"
use JMC.dta, clear

cd "$appendix"

*normalize algorithm rating
replace combined_first=(combined_first-38.2247)/33.66213
replace combined_last=(combined_last-40.75375)/32.19882
replace combined_total=(combined_t-78.97844)/44.58245

*generate country fixed effects
tab country, gen(country_ind)

*probit regressions
*Column 1
dprobit Academia male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total subfield_ind2-subfield_ind4 JM16_17 country_ind* program_ind*, vce(r)
outreg2 using TableA9_probit, tex replace keep(combined_total) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Country/JM Cycle FE, Yes)
*Column 2
dprobit TT male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total subfield_ind2-subfield_ind4 JM16_17 country_ind* program_ind*, vce(r)
outreg2 using TableA9_probit, tex append keep(combined_total) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Country/JM Cycle FE, Yes)

*tobit regressions
*Column 3
tobit Repec_imp male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total subfield_ind2-subfield_ind4 JM16_17 country_ind* program_ind*, ul(1000) vce(r)
outreg2 using TableA9_tobit, tex replace keep(combined_total) onecol dec(3) noaster nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Country/JM Cycle FE, Yes)


log close