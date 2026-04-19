clear all
cap log close
set more off

cd "$logs" 
log using "TableA6", replace 

*Table A6: Name Fluency and Placement Outcomes: Controlling for Advisor Match
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

*Top Panel: algorithm rating
*probit regressions
*Column 1
dprobit Academia country_match_foreign_comm country_match_US_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA6_top_probit, tex replace keep(combined_total) onecol dec(3) noaster nocons addtext(Control for Country Match, Yes, Control for Language Match, No, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 2
dprobit Academia language_match_English_comm language_match_NonEnglish_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA6_top_probit, tex append keep(combined_total) onecol dec(3) noaster nocons addtext(Control for Country Match, No, Control for Language Match, Yes, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 3
dprobit TT country_match_foreign_comm country_match_US_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA6_top_probit, tex append keep(combined_total) onecol dec(3) noaster nocons addtext(Control for Country Match, Yes, Control for Language Match, No, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 4
dprobit TT language_match_English_comm language_match_NonEnglish_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA6_top_probit, tex append keep(combined_total) onecol dec(3) noaster nocons addtext(Control for Country Match, No, Control for Language Match, Yes, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*tobit regressions
*Column 5
tobit Repec_imp country_match_foreign_comm country_match_US_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, ul(1000) vce(r)
outreg2 using TableA6_top_tobit, tex replace keep(combined_total) onecol dec(3) noaster nocons addtext(Control for Country Match, No, Control for Language Match, Yes, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 6
tobit Repec_imp language_match_English_comm language_match_NonEnglish_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, ul(1000) vce(r)
outreg2 using TableA6_top_tobit, tex append keep(combined_total) onecol dec(3) noaster nocons addtext(Control for Country Match, No, Control for Language Match, Yes, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)


*Middle Panel: pronunciation time
*probit regressions
*Column 7
dprobit Academia country_match_foreign_comm country_match_US_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length Median_Name region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA6_mid_probit, tex replace keep(Median_Name) onecol dec(3) noaster nocons addtext(Control for Country Match, Yes, Control for Language Match, No, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 8
dprobit Academia language_match_English_comm language_match_NonEnglish_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length Median_Name region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA6_mid_probit, tex append keep(Median_Name) onecol dec(3) noaster nocons addtext(Control for Country Match, No, Control for Language Match, Yes, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 9
dprobit TT country_match_foreign_comm country_match_US_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length Median_Name region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA6_mid_probit, tex append keep(Median_Name) onecol dec(3) noaster nocons addtext(Control for Country Match, Yes, Control for Language Match, No, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 10
dprobit TT language_match_English_comm language_match_NonEnglish_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length Median_Name region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA6_mid_probit, tex append keep(Median_Name) onecol dec(3) noaster nocons addtext(Control for Country Match, No, Control for Language Match, Yes, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*tobit regressions
*Column 11
tobit Repec_imp country_match_foreign_comm country_match_US_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length Median_Name region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, ul(1000) vce(r)
outreg2 using TableA6_mid_tobit, tex replace keep(Median_Name) onecol dec(3) noaster nocons addtext(Control for Country Match, Yes, Control for Language Match, No, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 12
tobit Repec_imp language_match_English_comm language_match_NonEnglish_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length Median_Name region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, ul(1000) vce(r)
outreg2 using TableA6_mid_tobit, tex append keep(Median_Name) onecol dec(3) noaster nocons addtext(Control for Country Match, No, Control for Language Match, Yes, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)


*Bottom Panel: pronunciation time
*probit regressions
*Column 13
dprobit Academia country_match_foreign_comm country_match_US_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length name_at_least_two region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA6_bottom_probit, tex replace keep(name_at_least_two) onecol dec(3) noaster nocons addtext(Control for Country Match, Yes, Control for Language Match, No, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 14
dprobit Academia language_match_English_comm language_match_NonEnglish_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length name_at_least_two region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA6_bottom_probit, tex append keep(name_at_least_two) onecol dec(3) noaster nocons addtext(Control for Country Match, No, Control for Language Match, Yes, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 15
dprobit TT country_match_foreign_comm country_match_US_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length name_at_least_two region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA6_bottom_probit, tex append keep(name_at_least_two) onecol dec(3) noaster nocons addtext(Control for Country Match, Yes, Control for Language Match, No, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 16
dprobit TT language_match_English_comm language_match_NonEnglish_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length name_at_least_two region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
outreg2 using TableA6_bottom_probit, tex append keep(name_at_least_two) onecol dec(3) noaster nocons addtext(Control for Country Match, No, Control for Language Match, Yes, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*tobit regressions
*Column 17
tobit Repec_imp country_match_foreign_comm country_match_US_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length name_at_least_two region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, ul(1000) vce(r)
outreg2 using TableA6_bottom_tobit, tex replace keep(name_at_least_two) onecol dec(3) noaster nocons addtext(Control for Country Match, Yes, Control for Language Match, No, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)
*Column 18
tobit Repec_imp language_match_English_comm language_match_NonEnglish_comm male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length name_at_least_two region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, ul(1000) vce(r)
outreg2 using TableA6_bottom_tobit, tex append keep(name_at_least_two) onecol dec(3) noaster nocons addtext(Control for Country Match, No, Control for Language Match, Yes, Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)


log close