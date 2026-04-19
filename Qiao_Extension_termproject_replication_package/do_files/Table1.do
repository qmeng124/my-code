clear all
cap log close
set more off

cd "$logs" 
log using "Table1", replace 

*Table 1: Sample of Economics PhD Job Candidates: Summary Statistics

cd "$data"
use JMC.dta, clear

cd "$tables"

estpost sum male USUnder elite PriorGrad PhDRanking RR TopRR Pub TopP TeachAw Instructor Top_5_P Top_5_Editor Editor Academia TT Visiting Postdoc GovtThinkTank Industry USJob Repec_imputed combined_total Median_Name name_at_least_t, det

esttab using Table1.tex, replace cells("mean(fmt(3)) p50(fmt(3)) sd(fmt(3)) min(fmt(3)) max(fmt(3))") noobs


log close
