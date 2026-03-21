clear all
cap log close
set more off

cd "$logs" 
log using "Table6", replace 

*Table 6: Name Fluency and Callback Rates: Experimental Data from Bertrand and Mullainathan (2004)

cd "$data"
use BM.dta, clear

cd "$tables"

*Column 1
dprobit call black, cluster(id)
outreg2 using Table6, tex replace keep (black combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 2
dprobit call combined, cluster(id)
outreg2 using Table6, tex append keep (black combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 3
dprobit call black combined, cluster(id)
outreg2 using Table6, tex append keep (black combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 4
dprobit call black female college ofjobs yearsexp yearsexp2 honors volunteer military workinschool email computerskills specialskills First_l combined, cluster(id)
outreg2 using Table6, tex append keep (black combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Resume Characteristics, Yes)
*Column 5
dprobit call combined if black==1, cluster(id)
outreg2 using Table6, tex append keep (black combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Resume Characteristics, No)
*Column 6
dprobit call black female college ofjobs yearsexp yearsexp2 honors volunteer military workinschool email computerskills specialskills First_l combined if black==1, cluster(id)
outreg2 using Table6, tex append keep (black combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Resume Characteristics, Yes)


log close