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

clear all
cap log close
set more off

cd "$logs" 
log using "Table2_Weighted_Plot_dprobit_NoCI", replace 

cd "$data"
use JMC.dta, clear

cd "$tables"


clonevar raw_first = combined_first
clonevar raw_last = combined_last


tempname memhold
tempfile plotdata

postfile `memhold' w coef using `plotdata', replace

* 记录开始时间
di "======================================================="
di ">>> 开始批量回归任务！总共需要跑 101 次回归。"
di ">>> 开始时间: $S_TIME"
di "======================================================="
di ""


forvalues i = 0(1)100 {
    
    local w = `i' / 100
    
   
    if mod(`i', 10) == 0 {
        di "-------------------------------------------------------"
        di ">>> 进度: `i'% | 当前权重 w = `w' | 时间: $S_TIME <<<"
        di "-------------------------------------------------------"
    }
    else {
        di "    ... 正在运行第 `i' 次回归 (w = `w') ..."
    }
    
    * 第一步：用原始分加权相加
    capture drop combined_w_raw
    gen combined_w_raw = `w' * raw_first + (1 - `w') * raw_last
    
    * 第二步：计算新变量的均值和标准差
    quietly sum combined_w_raw
    local w_mean = r(mean)
    local w_sd = r(sd)
    
    * 第三步：整体标准化
    capture drop combined_w_std
    gen combined_w_std = (combined_w_raw - `w_mean') / `w_sd'
    
    * 第四步：跑回归 (使用 dprobit)
    quietly dprobit Academia combined_w_std male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Top_5_Editor Editor Name_length region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind*, vce(r)
    
    * 第五步：从 dprobit 的隐藏矩阵中提取边际效应
    matrix ME = e(dfdx)
    local beta = ME[1, "combined_w_std"]
    
    * 第六步：写入数据 (只写入 w 和 beta，不再需要标准误和置信区间)
    post `memhold' (`w') (`beta')
}

postclose `memhold'

* 记录结束时间
di ""
di "======================================================="
di ">>> 所有 101 次回归已完成！"
di ">>> 结束时间: $S_TIME"
di ">>> 正在生成图表..."
di "======================================================="

* ==========================================
* 4. 画图部分 (更新：散点 + 二次拟合线 + Turning Point)
* ==========================================
use `plotdata', clear

twoway ///
    (scatter coef w, mcolor(gs10) msize(small) msymbol(O)) /// 1. 浅灰色小点：101个真实估计值
    (qfit coef w, lcolor(blue) lwidth(medthick)), /// 2. 蓝色实线：二次拟合线 (Quadratic fit)
    title("Sensitivity of Academia Placement Effects to Name Fluency Weights", size(medsmall)) /// 3. 更新标题
    xtitle("Weight (w) for First Name") ///
    ytitle("Estimated Marginal Effect of Full-Name Fluency") /// 4. 精确的纵轴名称
    ylabel(-0.06(0.02)0.02, format(%9.3f) angle(0)) /// 
    yscale(range(-0.06 0.02)) /// 
    xline(0.55, lpattern(dash) lcolor(red) lwidth(thin)) /// 5. 在 w=0.55 处添加红色竖虚线
    text(-0.01 0.56 "Turning point: w ≈ 0.55", placement(e) color(red) size(small)) /// 6. 添加 Turning point 注释文本
    legend(order(1 "101 Estimates" 2 "Quadratic Fit") position(6) rows(1)) /// 调整图例显示
    graphregion(color(white)) ///
    name(coef_plot_noci_flat, replace)

graph export "MarginalEffect_vs_Weight_Plot_NoCI_Flat.png", replace width(2000)

di ">>> 图表已成功保存为 MarginalEffect_vs_Weight_Plot_NoCI_Flat.png！"
* ==========================================
* 5. 内部元分析 (Internal Meta-Analysis)
* ==========================================
di ""
di "======================================================="
di ">>> 开始进行内部元分析 (Internal Meta-Analysis)"
di ">>> 检验权重设定 (w) 是否系统性地影响了边际效应的估计"
di "======================================================="

* 确保当前使用的是刚才 postfile 生成的包含 101 次回归结果的数据
* 生成 w 的二次项，用于检验非线性关系
gen w_sq = w^2

* --------------------------------------------------
* 设定 1：线性元回归 (Linear Specification)
* --------------------------------------------------
quietly reg coef w
est store Model_Linear

* --------------------------------------------------
* 设定 2：二次项元回归 (Quadratic Specification)
* --------------------------------------------------
quietly reg coef w w_sq
est store Model_Quadratic

* --------------------------------------------------
* 结果展示与导出 (Word & Excel)
* --------------------------------------------------
di ""
di ">>> 正在将内部元分析结果导出为标准的 Word 和 Excel 表格..."

* 切换到表格保存目录 (如果你前面定义了 $tables 宏，请取消注释下面这行)
* cd "$tables"

* ================= 使用 outreg2 导出原生 .doc 和 .xls =================
* 1. 导出为原生 Word 格式 (.doc)
outreg2 [Model_Linear Model_Quadratic] using "Internal_Meta_Analysis.doc", replace word ///
    title("Internal Meta-Analysis of Name Fluency Weights and Academia Placement Effects") ///
    ctitle("Linear Model", "Quadratic Model") ///
    dec(3) alpha(0.01, 0.05, 0.10) symbol(***, **, *) ///
    addtext(Dependent Variable, Marginal Effect)

* 2. 导出为原生 Excel 格式 (.xls)
outreg2 [Model_Linear Model_Quadratic] using "Internal_Meta_Analysis.xls", replace excel ///
    title("Internal Meta-Analysis of Name Fluency Weights and Academia Placement Effects") ///
    ctitle("Linear Model", "Quadratic Model") ///
    dec(3) alpha(0.01, 0.05, 0.10) symbol(***, **, *) ///
    addtext(Dependent Variable, Marginal Effect)


* ================= 备选：使用 esttab 在控制台完美打印 =================
di ""
di ">>> 控制台预览："
* 注意：这里改成了 esttab，它是专门用来输出美观表格的命令
esttab Model_Linear Model_Quadratic, ///
    title("Internal Meta-Analysis of Name Fluency Weights and Academia Placement Effects") ///
    mtitles("Linear Model" "Quadratic Model") ///
    b(3) se(3) nogaps ///  <-- nogaps 可以让表格更紧凑，b(3) se(3) 保留三位小数
    star(* 0.10 ** 0.05 *** 0.01) ///
    stats(r2 N, fmt(3 0) labels("R-squared" "Observations")) ///
    varlabels(w "Weight (w)" w_sq "Weight Squared (w^2)" _cons "Constant") ///
    addnotes("Standard errors in parentheses.") ///
    label

di "======================================================="
di ">>> 内部元分析完成！"
di ">>> Word 表格已保存为: Internal_Meta_Analysis.doc"
di ">>> Excel 表格已保存为: Internal_Meta_Analysis.xls"
di "======================================================="


cd "$data"
use JMC.dta, clear

cd "$tables"

*normalize algorithm rating
replace combined_first=(combined_first-38.2247)/33.66213
replace combined_last=(combined_last-40.75375)/32.19882
replace combined_total=(combined_t-78.97844)/44.58245

*==============================================================================
* 分组回归: Top_5_Editor == 1 (有顶刊编辑经验)
*==============================================================================

*probit regressions
*Column 1
dprobit Academia male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if Top_5_Editor==1, vce(r)
* 注意：这里删除了 noaster，下同
outreg2 using Table2_probit, tex replace keep(combined_total) onecol dec(3) addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*Column 2
dprobit TT male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if Top_5_Editor==1, vce(r)
outreg2 using Table2_probit, tex append keep(combined_total) onecol dec(3) addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*tobit regressions
*Column 3
tobit Repec_imp male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if Top_5_Editor==1, ul(1000) vce(r)
outreg2 using Table2_tobit, tex replace keep(combined_total) onecol dec(3) nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)


*==============================================================================
* 分组回归: Top_5_Editor == 0 (无顶刊编辑经验)
*==============================================================================

*probit regressions
*Column 4
dprobit Academia male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if Top_5_Editor==0, vce(r)
outreg2 using Table2_probit, tex append keep(combined_total) onecol dec(3) addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*Column 5
dprobit TT male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if Top_5_Editor==0, vce(r)
outreg2 using Table2_probit, tex append keep(combined_total) onecol dec(3) addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*tobit regressions
*Column 6
tobit Repec_imp male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Top_5_Pub Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if Top_5_Editor==0, ul(1000) vce(r)
outreg2 using Table2_tobit, tex append keep(combined_total) onecol dec(3) nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)



*Table 3: Name Fluency and Placement Outcomes by Advisor Top 5 Publication

cd "$data"
use JMC.dta, clear

cd "$tables"

*normalize algorithm rating
replace combined_first=(combined_first-38.2247)/33.66213
replace combined_last=(combined_last-40.75375)/32.19882
replace combined_total=(combined_t-78.97844)/44.58245

*==============================================================================
* 分组回归 1: Top_5_Publication != 0 (导师有顶刊发表，即发文量不为0)
*==============================================================================

*probit regressions
*Column 1
* 注意：这里删除了自变量中的 Top_5_Pub，并将条件改为了 if Top_5_Publication!=0
dprobit Academia male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if Top_5_Publication!=0, vce(r)
outreg2 using Table3_probit, tex replace keep(combined_total) onecol dec(3) addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*Column 2
dprobit TT male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if Top_5_Publication!=0, vce(r)
outreg2 using Table3_probit, tex append keep(combined_total) onecol dec(3) addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*tobit regressions
*Column 3
tobit Repec_imp male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if Top_5_Publication!=0, ul(1000) vce(r)
outreg2 using Table3_tobit, tex replace keep(combined_total) onecol dec(3) nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)


*==============================================================================
* 分组回归 2: Top_5_Publication == 0 (导师无顶刊发表，即发文量为0)
*==============================================================================

*probit regressions
*Column 4
dprobit Academia male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if Top_5_Publication==0, vce(r)
outreg2 using Table3_probit, tex append keep(combined_total) onecol dec(3) addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*Column 5
dprobit TT male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if Top_5_Publication==0, vce(r)
outreg2 using Table3_probit, tex append keep(combined_total) onecol dec(3) addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

*tobit regressions
*Column 6
tobit Repec_imp male elite PriorGradExp RR TopRR Pub TopPub TeachAward Instructor Editor Name_length combined_total region_ind2-region_ind7 subfield_ind2-subfield_ind4 JM16_17 program_ind* if Top_5_Publication==0, ul(1000) vce(r)
outreg2 using Table3_tobit, tex append keep(combined_total) onecol dec(3) nocons addtext(Control for Name Length, Yes, Other Controls, Yes, Subfield/Program FE, Yes, Region/JM Cycle FE, Yes)

log close
