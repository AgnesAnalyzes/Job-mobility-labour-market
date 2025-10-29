*** Master Thesis*************
*** Event History Analyses ***
*** Date: 10.07.2019**********
*** Part-time ****************

*********************************************************

use "/Users/agnesmolnar/Documents/UPF/Master Thesis/New Order/Part-time.dta", clear

*generate origin state (PT) Two-States
   gen org = 0
   gen des = 1 if pgemplst[_n+1]==5		/* transition into full-time gen des = 1 if pgemplst[_n+1]==1  / trans in Inactivity: gen des = 1 if pgemplst[_n+1]==5*/ 			
   gen tf = fin - start 
 

   stset tf, f(des) 									/*describe survival-time data*/

   stsum 											/*summarize survival-time data*/

   stci, by(org des training) emean 						/*calculate the mean survival time*/
   
   ltable tf des, intervals(12) 
   
   sts list if mismatch == 0 /*list survivor function*/
 
  *Kaplan Meyer
 
	sts graph, by(gender) ci title("")  
	sts list, by (gender)
	
**Job quality KM
 sts graph if gender==1, by(training) ci title("")  
 sts graph if gender==2, by(training) ci title("")  
 sts list, by (training)
 stsum, by (training)
 
 sts graph, by(mismatch) ci title("")  
 sts graph if gender==1, by(mismatch) ci title("")  
 sts graph if gender==2, by(mismatch) ci title("") 
  stsum, by (mismatch)
  
 sts graph, by(lowpay) ci title("") 
 stsum, by (lowpay)
 
 gen openend=prospect 
 sts graph, by(openend) ci title("")
 sts graph if gender==1, by(openend) ci title("")  
 sts graph if gender==2, by(openend) ci title("")
 
stsum, by (prospect)
 
 

 *Covariates
 
 rename l11102 region								/*Region*/
 recode region (1=0) (2=1)
 
 rename pgallbet firmsize							/*Firm size*/
 recode firmsize (-1 -2 5=.)
 
 gen edu_gr=pgcasmin								/*Education*/
 recode edu_gr (0/3=1) (4/5=2) (6/7=3) (8/9=4) 
 replace edu_gr= . if edu_gr== -1
 

 replace pgegp88= . if pgegp88== -2 
 replace pgegp88= . if pgegp88== -1
 replace pgegp88= . if pgegp88== 10
 replace pgegp88= . if pgegp88== 11
 replace pgegp88= . if pgegp88== 5
 replace pgegp88= . if pgegp88== 6
 
 gen sector=pgnace2
 recode sector (1/3=1) (5/33 35/39=2) (41/43 45=3) (45/47 55 56=4) (49/53=5) (64/66 68=6) (84=7) (85=8) (86/88=9) (58/63 69/75 77/82 90/99=10)
 replace sector= . if sector== -8
 replace sector= . if sector== -2
 replace sector= . if sector== -1
 
 gen age_coho=d11101								/*generate age groups*/
 recode age_coho (min/24=1) (25/34=2) (35/max=3)

 gen marry=pgfamstd									/*marry, 1=marries, not married=0*/
 replace marry= . if marry== -5
 replace marry= . if marry== -3
 replace marry= . if marry== -1
 replace marry= . if marry== 6
 replace marry= . if marry== 7
 replace marry= . if marry== 8
 recode marry (1/2=1) (3/5=0)
 
 gen childhh=d11107
 recode childhh (3/8=3)
 
** Job quality

*Training
 drop _merge
 merge m:m pid using "/Users/agnesmolnar/Desktop/training pid.dta"
 
 drop training
 gen training=plg0292_h
 recode training (-2=0) (1 2 3 4 5 6=1)
 replace training=. if plg0292_h== -1
 replace training= . if plg0292_h== -5
 
 *Hourlywage

drop lowpay
gen highpay=hourlywage
recode highpay (0/9.99999999999999999999999=0) (10/max=1)			/*1=high quality, 0=low quality*/
replace highpay = . if lowpay < 0

 sts graph, by(highpay) ci title("")  
 sts graph if gender==1, by(highpay) ci title("")  
 sts graph if gender==2, by(highpay) ci title("") 

replace pguebstd = . if pguebstd == -2 			/*create missing to avoid negative values in hourly wage*/
replace pguebstd = . if pguebstd == -1
replace pguebstd = . if pguebstd == -3

*Workintensity

gen workint=pguebstd
recode workint (0=0) (0.1/max=1)	

*Type of contract
replace contract= . if contract == -1 
replace contract= . if contract == -2
replace contract= . if contract == 3
replace contract= . if contract == -6
gen prospect=contract
recode prospect (2=0) (1=1)	

drop mismatch
gen mismatch=pgerljob
recode mismatch (2=0) (1 4=1)			/*0=mismatch 1=no mismatch*/


 
 
 
 
 display 2*(e(ll)-e(ll_0))							/*likelihood ratio test*/
 
 * percentage change in the rate, changes its value*/
 
 drop if gender==2			/*drop women*/
 drop if gender==1			/*drop men*/
 
 streg, dist(e) nohr
 streg i.age_coho region i.firmsize i.edu_gr i.pgegp88 ib2.sector marry i.childhh, dist(e) nohr
  streg i.age_coho region i.firmsize i.edu_gr i.pgegp88 ib2.sector marry i.childhh lowpay, dist(e) nohr
 streg i.age_coho region i.firmsize i.edu_gr i.pgegp88 ib2.sector marry i.childhh training, dist(e) nohr 	/**fit parametric survival model*/
 streg i.age_coho region i.firmsize i.edu_gr i.pgegp88 ib2.sector marry i.childhh mismatch, dist(e) nohr
  streg i.age_coho region i.firmsize i.edu_gr i.pgegp88 ib2.sector marry i.childhh prospect, dist(e) nohr
 streg i.age_coho region i.firmsize i.edu_gr i.pgegp88 ib2.sector marry i.childhh i.fulltimeexp0, dist(e) nohr

 display exp(_b[_cons])
 

 streg d11101 i.firmsize region d11109 ib2.sector d11107 plg0292_h, dist(e) nohr 	/**fit parametric survival model*/
 streg d11101 i.firmsize d11109 ib2.sector marry i.childhh nomism, dist(e) nohr
 streg d11101 i.firmsize i.edu_gr ib2.sector i.childhh i.fulltimeexp0, dist(e) nohr
 
 recode plg0292_h (-2=0) (1 2 3 4 5 6=1)
 replace plg0292_h=. if plg0292_h== -1
 replace plg0292_h= . if plg0292_h== -5
 
 tab pgemplst plg0292_h, row 	
