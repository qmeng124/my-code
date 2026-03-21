clear all
cap log close
set more off

cd "$logs" 
log using "Table9", replace 

*Table 9: Name Fluency and Callback Rates: Combining Experimental Data from Bertrand and Mullainathan (2004) and Oreopoulos (2011)

cd "$data"
use BM_Oreop_pooled.dta, clear

cd "$tables"

*Top Panel: All Applicants
*Column 1
dprobit callback race1, cluster(firmid)
outreg2 using Table9_top, tex replace keep(race1 first_combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Education, No, Control for Skills, No)
*Column 2
dprobit callback first_combined, cluster(firmid)
outreg2 using Table9_top, tex append keep(race1 first_combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Education, No, Control for Skills, No)
*Column 3
dprobit callback race1 first_combined, cluster(firmid)
outreg2 using Table9_top, tex append keep(race1 first_combined) onecol dec(3) noaster addtext(Control for Name Length, No, Control for Gender, No, Control for Education, No, Control for Skills, No)
*Column 4
dprobit callback female race1 college skills First_length first_combined, cluster(firmid)
outreg2 using Table9_top, tex append keep(race1 first_combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Education, Yes, Control for Skills, Yes)


*Bottom Panel: Black/Immigrant (Ind/Pak/Chn)
*Column 5
dprobit callback female college skills First_length first_combined if race1==1, cluster(firmid)
outreg2 using Table9_bottom, tex replace keep(race1 first_combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Education, Yes, Control for Skills, Yes)
*Column 6
dprobit callback female college skills First_length first_combined if race1==1&lowquality==0, cluster(firmid)
outreg2 using Table9_bottom, tex append keep(race1 first_combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Education, Yes, Control for Skills, Yes)
*Column 7
dprobit callback female college skills First_length first_combined if race1==1&lowquality==1, cluster(firmid)
outreg2 using Table9_bottom, tex append keep(race1 first_combined) onecol dec(3) noaster addtext(Control for Name Length, Yes, Control for Gender, Yes, Control for Education, Yes, Control for Skills, Yes)


log close