clear all
cap log close
set more off

cd "$logs" 
log using "Table8", replace 

*Table 8: Name Fluency and Callback Rates by Resume Quality: Experimental Data from Bertrand and Mullainathan (2004) and Oreopoulos (2011)

*Top Panel: Bertrand and Mullainathan (2004)
cd "$data"
use BM.dta, clear

cd "$tables"

*Column 1
dprobit call combined if black==1&h==1, cluster(id)
outreg2 using Table8_top, tex replace keep (combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 2
dprobit call black female college ofjobs yearsexp yearsexp2 honors volunteer military workinschool email computerskills specialskills First_l combined if black==1&h==1, cluster(id)
outreg2 using Table8_top, tex append keep (combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Resume Characteristics, Yes)
*Column 3
dprobit call combined if black==1&l==1, cluster(id)
outreg2 using Table8_top, tex append keep (combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 4
dprobit call black female college ofjobs yearsexp yearsexp2 honors volunteer military workinschool email computerskills specialskills First_l combined if black==1&l==1, cluster(id)
outreg2 using Table8_top, tex append keep (combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Resume Characteristics, Yes)


*Bottom Panel: Oreopoulos (2011)
cd "$data"
use Oreopoulos.dta, clear

cd "$tables"

*Column 5
dprobit callback combined if ma==1 & (indian_ind==1|pakistani_ind==1|chinese_ind==1), cluster(firmid)
outreg2 using Table8_bottom, tex replace keep (combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Ethnicity, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 6
dprobit callback female ba_quality extracurricular_skills language_skills ma exp_highquality additional_credential reference accreditation legal indian_ind pakistani_ind Name_l combined if ma==1 & (indian_ind==1|pakistani_ind==1|chinese_ind==1), cluster(firmid)
outreg2 using Table8_bottom, tex append keep (combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Ethnicity, Yes, Control for Gender, Yes, Control for Resume Characteristics, Yes)
*Column 7
dprobit callback combined if ma==0 & (indian_ind==1|pakistani_ind==1|chinese_ind==1), cluster(firmid)
outreg2 using Table8_bottom, tex append keep (combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Ethnicity, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 8
dprobit callback female ba_quality extracurricular_skills language_skills ma exp_highquality additional_credential reference accreditation legal indian_ind pakistani_ind Name_l combined if ma==0 & (indian_ind==1|pakistani_ind==1|chinese_ind==1), cluster(firmid)
outreg2 using Table8_bottom, tex append keep (combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Ethnicity, Yes, Control for Gender, Yes, Control for Resume Characteristics, Yes)



log close