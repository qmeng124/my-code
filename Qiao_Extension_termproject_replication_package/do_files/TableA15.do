clear all
cap log close
set more off

cd "$logs" 
log using "TableA15", replace 

*Table A15: Name Fluency and Callback Rates by Gender: Experimental Data from Bertrand and Mullainathan (2004) and Oreopoulos (2011)

*Top Panel: Bertrand and Mullainathan (2004)
cd "$data"
use BM.dta, clear

cd "$appendix"

*Column 1
dprobit call black college ofjobs yearsexp yearsexp2 honors volunteer military workinschool email computerskills specialskills First_l combined if female==0, cluster(id)
outreg2 using TableA15_top, tex replace keep(combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Race, Yes, Control for Resume Characteristics, Yes)
*Column 2
dprobit call black college ofjobs yearsexp yearsexp2 honors volunteer military workinschool email computerskills specialskills First_l combined if female==1, cluster(id)
outreg2 using TableA15_top, tex append keep(combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Race, Yes, Control for Resume Characteristics, Yes)
*Column 3
dprobit call black college ofjobs yearsexp yearsexp2 honors volunteer military workinschool email computerskills specialskills First_l combined if female==0 & black==1, cluster(id)
outreg2 using TableA15_top, tex append keep(combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Race, No, Control for Resume Characteristics, Yes)
*Column 4
dprobit call black college ofjobs yearsexp yearsexp2 honors volunteer military workinschool email computerskills specialskills First_l combined if female==1 & black==1, cluster(id)
outreg2 using TableA15_top, tex append keep(combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Race, No, Control for Resume Characteristics, Yes)


*Bottom Panel: Oreopoulos (2011)
cd "$data"
use Oreopoulos.dta, clear

cd "$appendix"

*Column 5
dprobit callback female ba_quality extracurricular_skills language_skills ma exp_highquality additional_credential reference accreditation legal indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind Name_l combined if female==0, cluster(firmid)
outreg2 using TableA15_bottom, tex replace keep(combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Ethnicity, Yes, Control for Resume Characteristics, Yes)
*Column 6
dprobit callback female ba_quality extracurricular_skills language_skills ma exp_highquality additional_credential reference accreditation legal indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind Name_l combined if female==1, cluster(firmid)
outreg2 using TableA15_bottom, tex append keep(combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Ethnicity, Yes, Control for Resume Characteristics, Yes)
*Column 7
dprobit callback female ba_quality extracurricular_skills language_skills ma exp_highquality additional_credential reference accreditation legal indian_ind pakistani_ind Name_l combined if female==0 & (indian_ind==1|pakistani_ind==1|chinese_ind==1), cluster(firmid)
outreg2 using TableA15_bottom, tex append keep(combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Ethnicity, Yes, Control for Resume Characteristics, Yes)
*Column 8
dprobit callback female ba_quality extracurricular_skills language_skills ma exp_highquality additional_credential reference accreditation legal indian_ind pakistani_ind Name_l combined if female==1 & (indian_ind==1|pakistani_ind==1|chinese_ind==1), cluster(firmid)
outreg2 using TableA15_bottom, tex append keep(combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Ethnicity, Yes, Control for Resume Characteristics, Yes)


log close
