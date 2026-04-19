clear all
cap log close
set more off

cd "$logs" 
log using "TableA17", replace 

*Table A17: Name Fluency and Callback Rates: Experimental Data from Nunley et al. (2015)

cd "$data"
use NunleyEtAl.dta, clear

cd "$appendix"

*define controls (see Nunley et al. appendix)
tab month, gen (mth)
tab city, gen (cty)
global X univ1 univ2 univ3 univ4 econ_major fin_major acc_major mgt_major mkt_major hist_major eng_major psych_major bio_major gpa honors no_gap employed underemp u3_current u6_current u12_current u3_past u6_past u12_past intern high_ses mth* cty*

*Column 1
dprobit call_back black, cluster(job_id)
outreg2 using TableA17, tex replace keep(black combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 2
dprobit call_back combined, cluster(job_id)
outreg2 using TableA17, tex append keep(black combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 3
dprobit call_back black combined, cluster(job_id)
outreg2 using TableA17, tex append keep(black combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 4
dprobit call_back black female combined name_length $X, cluster(job_id)
outreg2 using TableA17, tex append keep(black combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Resume Characteristics, Yes)


log close