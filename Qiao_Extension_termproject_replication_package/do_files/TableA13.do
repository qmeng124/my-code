clear all
cap log close
set more off

cd "$logs" 
log using "TableA13", replace 

*Table A13: Name Fluency and Callback Rates: Experimental Data from Oreopoulos (2011)

cd "$data"
use Oreopoulos.dta, clear

cd "$appendix"

*Column 1
dprobit callback indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind, cluster(firmid)
outreg2 using TableA13, tex replace onecol dec(3) noaster
*Column 2
dprobit callback combined, cluster(firmid)
outreg2 using TableA13, tex append onecol dec(3) noaster
*Column 3
dprobit callback indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind combined, cluster(firmid)
outreg2 using TableA13, tex append onecol dec(3) noaster
*Column 4
dprobit callback female ba_quality extracurricular_skills language_skills ma exp_highquality additional_credential reference accreditation legal indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind Name_l combined, cluster(firmid)
outreg2 using TableA13, tex append onecol dec(3) noaster
*Column 5
dprobit callback female ba_quality extracurricular_skills language_skills ma exp_highquality additional_credential reference accreditation legal indian_ind pakistani_ind chinese_ind chn_cdn greek_ind british_ind First_length Last_length first_c last_c, cluster(firmid)
outreg2 using TableA13, tex append onecol dec(3) noaster
*Column 6
dprobit callback combined if indian_ind==1|pakistani_ind==1|chinese_ind==1, cluster(firmid)
outreg2 using TableA13, tex append onecol dec(3) noaster
*Column 7
dprobit callback female ba_quality extracurricular_skills language_skills ma exp_highquality additional_credential reference accreditation legal indian_ind pakistani_ind Name_l combined if indian_ind==1|pakistani_ind==1|chinese_ind==1, cluster(firmid)
outreg2 using TableA13, tex append onecol dec(3) noaster


log close