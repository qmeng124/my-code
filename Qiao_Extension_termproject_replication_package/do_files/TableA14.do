clear all
cap log close
set more off

cd "$logs" 
log using "TableA14", replace 

*Table A14: Name Fluency and Callback Rates: Experimental Data from Oreopoulos (2011) – Sample of Ethnic Immigrant Applicants

cd "$data"
use Oreopoulos.dta, clear

cd "$appendix"

*Column 1
dprobit callback female ba_quality extracurricular_skills language_skills ma exp_highquality additional_credential reference accreditation legal Name_l combined if indian_ind==1, cluster(firmid)
outreg2 using TableA14, tex replace keep (combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Resume Characteristics, Yes)
*Column 2
dprobit callback female ba_quality extracurricular_skills language_skills ma exp_highquality additional_credential reference accreditation legal Name_l combined if pakistani_ind==1, cluster(firmid)
outreg2 using TableA14, tex append keep (combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Resume Characteristics, Yes)
*Column 3
dprobit callback female ba_quality extracurricular_skills language_skills ma exp_highquality additional_credential reference accreditation legal Name_l combined if chinese_ind==1, cluster(firmid)
outreg2 using TableA14, tex append keep (combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Resume Characteristics, Yes)


log close