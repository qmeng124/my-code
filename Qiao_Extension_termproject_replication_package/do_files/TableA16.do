clear all
cap log close
set more off

cd "$logs" 
log using "TableA16", replace 

*Table A16: Name Fluency and Callback Rates: Experimental Data from Bertrand and Mullainathan (2004) and Oreopoulos (2011) – Sample of Low Quality Resumes

*Low Quality Resumes from Bertrand and Mullainathan (2004)
cd "$data"
use BM.dta, clear

cd "$appendix"

*Column 1
dprobit call black if l==1, cluster(id)
outreg2 using TableA16, tex replace keep(black combinedsc) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 2
dprobit call black combinedsc if l==1, cluster(id)
outreg2 using TableA16, tex append keep(black combinedsc) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 3
dprobit call black female college ofjobs yearsexp yearsexp2 honors volunteer military workinschool email computerskills specialskills First_l combinedsc if l==1, cluster(id)
outreg2 using TableA16, tex append keep(black combinedsc) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Resume Characteristics, Yes)


*No Master's from Oreopoulos (2011)
cd "$data"
use Oreopoulos.dta, clear

cd "$appendix"

*Column 4
dprobit callback indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind if ma==0, cluster(firmid)
outreg2 using TableA16, tex append keep(combined indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 5
dprobit callback indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind combined if ma==0, cluster(firmid)
outreg2 using TableA16, tex append keep(combined indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 6
dprobit callback female ba_quality extracurricular_skills language_skills ma exp_highquality additional_credential reference accreditation legal indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind Name_l combined if ma==0, cluster(firmid)
outreg2 using TableA16, tex append keep(combined indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Resume Characteristics, Yes)


*Low Quality/No Master's from Pooled Sample from Bertrand and Mullainathan (2004) and Oreopoulos (2011)
cd "$data"
use BM_Oreop_pooled.dta, clear

cd "$appendix"

*Column 7
dprobit callback race1 if lowquality==1, cluster(firmid)
outreg2 using TableA16, tex append keep(race1 first_combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 8
dprobit callback race1 first_combined if lowquality==1, cluster(firmid)
outreg2 using TableA16, tex append keep(race1 first_combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 9
dprobit callback female race1 college skills First_length first_combined if lowquality==1, cluster(firmid)
outreg2 using TableA16, tex append keep(race1 first_combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Resume Characteristics, Yes)


log close
