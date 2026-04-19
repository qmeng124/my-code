clear all
cap log close
set more off

cd "$logs" 
log using "TableA12", replace 

*Table A12: Name Fluency and Callback Rates: Experimental Data from Bertrand and Mullainathan (2004)

cd "$data"
use BM.dta, clear

cd "$appendix"

*Column 1
dprobit call black, cluster(id)
outreg2 using TableA12, tex replace onecol dec(3) noaster 
*Column 2
dprobit call combined, cluster(id)
outreg2 using TableA12, tex append onecol dec(3) noaster 
*Column 3
dprobit call black combined, cluster(id)
outreg2 using TableA12, tex append onecol dec(3) noaster 
*Column 4
dprobit call black female college ofjobs yearsexp yearsexp2 honors volunteer military workinschool email computerskills specialskills First_l combined, cluster(id)
outreg2 using TableA12, tex append onecol dec(3) noaster 
*Column 5
dprobit call combined if black==1, cluster(id)
outreg2 using TableA12, tex append onecol dec(3) noaster 
*Column 6
dprobit call black female college ofjobs yearsexp yearsexp2 honors volunteer military workinschool email computerskills specialskills First_l combined if black==1, cluster(id)
outreg2 using TableA12, tex append onecol dec(3) noaster

log close