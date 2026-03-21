clear all
cap log close
set more off

cd "$logs" 
log using "prep_Oreopoulos", replace 


*replication data from Oreopoulos (2011)
cd "$raw_data" 
use oreopoulos-resume-study-replication-data-file.dta

*split names into first and last names
gen first="Ali" if name=="AliSaeed"
gen last="Saeed" if name=="AliSaeed"

replace first="Allen" if name=="AllenWang"
replace last="Wang" if name=="AllenWang"

replace first="Amy" if name=="AmyWang"
replace last="Wang" if name=="AmyWang"

replace first="Bill" if name=="BillZhang"
replace last="Zhang" if name=="BillZhang"

replace first="Alison" if name=="AlisonJohnson"
replace last="Johnson" if name=="AlisonJohnson"

replace first="Arjun" if name=="ArjunKumar"
replace last="Kumar" if name=="ArjunKumar"

replace first="Asif" if name=="AsifSheikh"
replace last="Sheikh" if name=="AsifSheikh"

replace first="Carrie" if name=="CarrieMartin"
replace last="Martin" if name=="CarrieMartin"

replace first="Chaudhry" if name=="ChaudhryMohammad"
replace last="Mohammad" if name=="ChaudhryMohammad"

replace first="Dong" if name=="DongLiu"
replace last="Liu" if name=="DongLiu"

replace first="Emily" if name=="EmilyBrown"
replace last="Brown" if name=="EmilyBrown"

replace first="Eric" if name=="EricWang"
replace last="Wang" if name=="EricWang"

replace first="Fang" if name=="FangWang"
replace last="Wang" if name=="FangWang"

replace first="Fatima" if name=="FatimaSheikh"
replace last="Sheikh" if name=="FatimaSheikh"

replace first="Greg" if name=="GregJohnson"
replace last="Johnson" if name=="GregJohnson"

replace first="Hassan" if name=="HassanKhan"
replace last="Khan" if name=="HassanKhan"

replace first="Hina" if name=="HinaChaudhry"
replace last="Chaudhry" if name=="HinaChaudhry"

replace first="Jack" if name=="JackLi"
replace last="Li" if name=="JackLi"

replace first="James" if name=="JamesLiu"
replace last="Liu" if name=="JamesLiu"

replace first="Jennifer" if name=="JenniferLi"
replace last="Li" if name=="JenniferLi"

replace first="Jill" if name=="JillWilson"
replace last="Wilson" if name=="JillWilson"

replace first="John" if name=="JohnMartin"
replace last="Martin" if name=="JohnMartin"

replace first="Lei" if name=="LeiLi"
replace last="Li" if name=="LeiLi"

replace first="Lukas" if name=="LukasMinsopoulos"
replace last="Minsopoulos" if name=="LukasMinsopoulos"

replace first="Matthew" if name=="MatthewWilson"
replace last="Wilson" if name=="MatthewWilson"

replace first="Maya" if name=="MayaKumar"
replace last="Kumar" if name=="MayaKumar"

replace first="Michael" if name=="MichaelSmith"
replace last="Smith" if name=="MichaelSmith"

replace first="Michelle" if name=="MichelleWang"
replace last="Wang" if name=="MichelleWang"

replace first="Min" if name=="MinLiu"
replace last="Liu" if name=="MinLiu"

replace first="Monica" if name=="MonicaLiu"
replace last="Liu" if name=="MonicaLiu"

replace first="Nicole" if name=="NicoleMinsopoulos"
replace last="Minsopoulos" if name=="NicoleMinsopoulos"

replace first="Na" if name=="NaLi"
replace last="Li" if name=="NaLi"

replace first="Panav" if name=="PanavSingh"
replace last="Singh" if name=="PanavSingh"

replace first="Sana" if name=="SanaKhan"
replace last="Khan" if name=="SanaKhan"

replace first="Priyanka" if name=="PriyankaKaur"
replace last="Kaur" if name=="PriyankaKaur"

replace first="Rahul" if name=="RahulKaur"
replace last="Kaur" if name=="RahulKaur"

replace first="Rabab" if name=="RababSaeed"
replace last="Saeed" if name=="RababSaeed"

replace first="Shreya" if name=="ShreyaSharma"
replace last="Sharma" if name=="ShreyaSharma"

replace first="Samir" if name=="SamirSharma"
replace last="Sharma" if name=="SamirSharma"

replace first="Tara" if name=="TaraSingh"
replace last="Singh" if name=="TaraSingh"

replace first="Tao" if name=="TaoWang"
replace last="Wang" if name=="TaoWang"

replace first="Vivian" if name=="VivianZhang"
replace last="Zhang" if name=="VivianZhang"

replace first="Xiuying" if name=="XiuyingZhang"
replace last="Zhang" if name=="XiuyingZhang"

replace first="Yong" if name=="YongZhang"
replace last="Zhang" if name=="YongZhang"


*merge name fluency measures by first and last names
merge m:1 first using Oreop_first_pronounce.dta
keep if _m==3
drop _m

merge m:1 last using Oreop_last_pronounce.dta
keep if _m==3
drop _m


#delimit cr
*data cleaning
gen indian_ind=name_e=="Indian"
gen pakistani_ind=name_e=="Pakistani"
gen chinese_ind=name_e=="Chinese"
gen chn_cdn_ind=name_e=="Chn-Cdn"
gen greek_ind=name_e=="Greek"
gen british_ind=name_e=="British"
gen ethnic_ind=indian_ind==1|pakistani==1|chinese_ind==1|chn_cdn_ind==1|greek_ind==1
gen combined=first_combined+last_combined

gen First_length=strlen(first)
gen Last_length=strlen(last)
gen Name_length=First_l+Last_l
replace accreditation=0 if accreditation==.
replace reference=0 if reference==.
replace legal=0 if legal==.


*normalize algorithm pronunciation rating
replace combined=(combined-42.61928)/38.65504 
replace first_combined=(first_combined-25.38154)/26.52313
replace last_combined=(last_combined-17.23773)/19.47069 


*label variables
label variable firmid "firm id"
label variable occupation_type "occupation type"
label variable name_ethnicity "name ethnicity"
label variable additional_credential "1=additional required credentials"
label variable name "name"
label variable language_skills "1=fluent in French & other languages"
label variable accreditation "1=accreditation of foreign education"
label variable reference "1=listing Canadian references "
label variable legal "1=permanent resident"
label variable listedaccreditation "1=listed accreditation"
label variable city "city"
label variable ma "1=master's degree"
label variable female "1=female"
label variable certificate "1=certificate"
label variable ba_quality "1=top 200 world ranking university "
label variable exp_highquality "1=high quality work experience"
label variable callback "1=callback"
label variable interview "1=interview"
label variable second_callback "1=second callback"
label variable type "type"
label variable extracurricular_skills "1=listing extracurricular activities"
label variable fall_data "fall data"
label variable same_exp "1=same experience"
label variable first "first name"
label variable last "last name"
label variable indian_ind "1=Indian"
label variable pakistani_ind "1=Pakistani"
label variable chinese_ind "1=Chinese"
label variable chn_cdn_ind "1=Chinese Canadian"
label variable greek_ind "1=Greek"
label variable british_ind "1=British"
label variable ethnic_ind "1=ethnic immigrant"
label variable combined "algorithm rating - full name"
label variable First_length "first name length"
label variable Last_length "last name length"
label variable Name_length "full name length"


cd "$data" 
save Oreopoulos.dta, replace


log close
