clear all

/*SET GLOBALS*/
global root "[[location of replication archive]]"

global data    			"$root/data"
global do_files      	"$root/do_files"
global logs   	 		"$root/logs"
global raw_data     	"$root/raw_data"
global tables  			"$root/tables"
global appendix  		"$root/tables/appendix"

set more off, perm


/*INSTALL NEEDED STATA PACKAGES*/
*run using stata 17
*install packages needed: outreg2 estout
cd "$do_files"
do config.do


/*DATA PREPARATION*/
*prepare data from Ge et al (2021)
cd "$do_files"
do prep_JMC.do

*prepare data from Bertrand and Mullainathan (2004)
cd "$do_files"
do prep_BM.do

*prepare data from Oreopoulos (2011)
cd "$do_files"
do prep_Oreopoulos.do

*pool data from Bertrand and Mullainathan (2004) and Oreopoulos (2011)
cd "$do_files"
do prep_BM_Oreop_pooled.do

*prepare data from Nunley et al (2015)
cd "$do_files"
do prep_NunleyEtAl.do


/*TABLES*/
*Table 1: Sample of Economics PhD Job Candidates: Summary Statistics
cd "$do_files"
do Table1.do

*Table 2: Name Fluency and Placement Outcomes: Algorithm Rating
cd "$do_files"
do Table2.do

*Table 3: Name Fluency and Placement Outcomes: Pronunciation Time and Subjective Rating
cd "$do_files"
do Table3.do

*Table 4: Name Fluency and Placement Outcomes by Program Rankings
cd "$do_files"
do Table4.do

*Table 5: Examples of Black/Ethnic Immigrant Names and Callback Rates in Bertrand and Mullainathan (2004) and Oreopoulos (2011)
*see file "Table5.xslx" in "$root/tables"

*Table 6: Name Fluency and Callback Rates: Experimental Data from Bertrand and Mullainathan (2004)
cd "$do_files"
do Table6.do

*Table 7: Name Fluency and Callback Rates: Experimental Data from Oreopoulos (2011)
cd "$do_files"
do Table7.do

*Table 8: Name Fluency and Callback Rates by Resume Quality: Experimental Data from Bertrand and Mullainathan (2004) and Oreopoulos (2011)
cd "$do_files"
do Table8.do

*Table 9: Name Fluency and Callback Rates: Combining Experimental Data from Bertrand and Mullainathan (2004) and Oreopoulos (2011)
cd "$do_files"
do Table9.do

