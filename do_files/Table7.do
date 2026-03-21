clear all
cap log close
set more off

cd "$logs" 
log using "Table7", replace 

*Table 7: Name Fluency and Callback Rates: Experimental Data from Oreopoulos (2011)

cd "$data"
use Oreopoulos.dta, clear

cd "$tables"

*Column 1
dprobit callback indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind, cluster(firmid)
outreg2 using Table7, tex replace keep (indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 2
dprobit callback combined, cluster(firmid)
outreg2 using Table7, tex append keep (indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 3
dprobit callback indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind combined, cluster(firmid)
outreg2 using Table7, tex append keep (indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 4
dprobit callback female ba_quality extracurricular_skills language_skills ma exp_highquality additional_credential reference accreditation legal indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind Name_l combined, cluster(firmid)
outreg2 using Table7, tex append keep (indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Resume Characteristics, Yes)
*Column 5
dprobit callback combined if indian_ind==1|pakistani_ind==1|chinese_ind==1, cluster(firmid)
outreg2 using Table7, tex append keep (indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 6
dprobit callback female ba_quality extracurricular_skills language_skills ma exp_highquality additional_credential reference accreditation legal indian_ind pakistani_ind Name_l combined if indian_ind==1|pakistani_ind==1|chinese_ind==1, cluster(firmid)
outreg2 using Table7, tex append keep (indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Resume Characteristics, Yes)


log close