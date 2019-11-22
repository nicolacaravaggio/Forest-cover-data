*======================================================================
* Economic Growth and the Forest Development Path
* A re-assessment of the Environmental Kuznets Curve for Deforestation
* ---------------------------------------------------------------------
* Nicola Caravaggio
* nicola.caravaggio@uniroma3.it
* ---------------------------------------------------------------------
* Università degli Studi di Roma Tre
*======================================================================

clear all
use "C:\Users\Nicola Caravaggio\OneDrive\Desktop\Paper EKCd\data.dta"
tsset id year 

*========================
* Descriptive Statistics
*========================

preserve
drop if def_rate >= .
drop if ln_gdp >= .
drop if ln_agr >= .
drop if ln_pop >= .
drop if ln_trade >= .
* Low-Income Economies
summarize def_rate ln_gdp gdp_wdi agr ln_agr pop ln_pop tra_gdp ln_trade if inc_lev == 4
* Middle-Income Economies
summarize def_rate ln_gdp gdp_wdi agr ln_agr pop ln_pop tra_gdp ln_trade if inc_lev == 3 | inc_lev == 2
* High-Income Economies
summarize def_rate ln_gdp gdp_wdi agr ln_agr pop ln_pop tra_gdp ln_trade if inc_lev == 1
restore

*===================================
* Test for Heteroskedasticity
*-----------------------------------
* Modified Wald Test (Greene, 2000)
*===================================

* Low-Income Economies
preserve
*drop if country == "Eritrea"
*drop if country == "Ethiopia"
xtreg def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade if inc_lev == 4, fe
xttest3
restore

* Middle-Income Economies
preserve
*drop if country == "Myanmar"
*drop if country == "Serbia"
xtreg def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade if inc_lev == 3 | inc_lev == 2, fe
xttest3
restore

* High-Income Economies
xtreg def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade if inc_lev == 1, fe
xttest3

*=============================
* Test for Serial Correlation
*-----------------------------
* Wooldridge (2002)
*=============================

* Low-Income Economies 
preserve
*drop if country == "Eritrea"
*drop if country == "Ethiopia"
keep if inc_lev == 4
xtserial def_rate ln_gdp ln_gdp2, output
xtserial def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade, output
xtserial def_rate
xtserial ln_gdp
xtserial ln_gdp2
xtserial ln_agr
xtserial ln_pop
xtserial ln_trade
restore

* Middle-Income Economies
preserve
*drop if country == "Myanmar"
*drop if country == "Serbia"
keep if inc_lev == 3 | inc_lev == 2
xtserial def_rate ln_gdp ln_gdp2, output
xtserial def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade, output
xtserial def_rate
xtserial ln_gdp
xtserial ln_gdp2
xtserial ln_agr
xtserial ln_pop
xtserial ln_trade
restore

* High-Income Economies
preserve
keep if inc_lev == 1
xtserial def_rate ln_gdp ln_gdp2, output
xtserial def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade, output
xtserial def_rate
xtserial ln_gdp
xtserial ln_gdp2
xtserial ln_agr
xtserial ln_pop
xtserial ln_trade
restore

*=====================================
* Test for Cross-Sectional Dependency
*-------------------------------------
* Pesaran (2004) CD test
*=====================================

* Low-Income Economies 
preserve
keep if inc_lev == 4
drop if country == "Eritrea"
drop if country == "Ethiopia"
xtcd def_rate 
xtcd ln_gdp
xtcd ln_gdp2
xtcd ln_agr
xtcd ln_pop
xtcd ln_trade
restore
* Middle-Income Economies
preserve
keep if inc_lev == 3 | inc_lev == 2
drop if country == "Belarus"
drop if country == "Bosnia and Herzegovina"
drop if country == "Croatia"
drop if country == "Georgia"
drop if country == "Kazakhstan"
drop if country == "Myanmar"
drop if country == "Russian Federation"
drop if country == "Serbia"
drop if country == "Ukraine"
drop if country == "Uzbekistan"
xtcd def_rate 
xtcd ln_gdp
xtcd ln_gdp2
xtcd ln_agr
xtcd ln_pop
xtcd ln_trade
restore
* High-Income Economies
preserve
keep if inc_lev == 1
xtcd def_rate 
xtcd ln_gdp
xtcd ln_gdp2
xtcd ln_agr
xtcd ln_pop
xtcd ln_trade
restore

*==================================
* Stationarity: Unit Root
*----------------------------------
* Method: Fisher, ADF (Choi, 2001)
*==================================

* Low-Income Economies 
preserve
drop if country == "Eritrea"
drop if country == "Ethiopia"
* 	Deforestation Rates
xtunitroot fisher def_rate 		if inc_lev == 4, dfuller lags(1)
xtunitroot fisher d.def_rate 	if inc_lev == 4, dfuller lags(1)
xtunitroot fisher def_rate 		if inc_lev == 4, dfuller trend lags(1)
xtunitroot fisher d.def_rate 	if inc_lev == 4, dfuller trend lags(1)
xtunitroot fisher def_rate 		if inc_lev == 4, dfuller lags(2)
xtunitroot fisher d.def_rate 	if inc_lev == 4, dfuller lags(2)
xtunitroot fisher def_rate 		if inc_lev == 4, dfuller trend lags(2)
xtunitroot fisher d.def_rate 	if inc_lev == 4, dfuller trend lags(2)
* 	GDP per capita
xtunitroot fisher ln_gdp 		if inc_lev == 4, dfuller lags(1)
xtunitroot fisher d.ln_gdp 		if inc_lev == 4, dfuller lags(1)
xtunitroot fisher ln_gdp 		if inc_lev == 4, dfuller trend lags(1)
xtunitroot fisher d.ln_gdp 		if inc_lev == 4, dfuller trend lags(1)
xtunitroot fisher ln_gdp 		if inc_lev == 4, dfuller lags(2)
xtunitroot fisher d.ln_gdp 		if inc_lev == 4, dfuller lags(2)
xtunitroot fisher ln_gdp 		if inc_lev == 4, dfuller trend lags(2)
xtunitroot fisher d.ln_gdp 		if inc_lev == 4, dfuller trend lags(2)
* 	GDP per capita^2
xtunitroot fisher ln_gdp2 		if inc_lev == 4, dfuller lags(1)
xtunitroot fisher d.ln_gdp2 	if inc_lev == 4, dfuller lags(1)
xtunitroot fisher ln_gdp2 		if inc_lev == 4, dfuller trend lags(1)
xtunitroot fisher d.ln_gdp2 	if inc_lev == 4, dfuller trend lags(1)
xtunitroot fisher ln_gdp2 		if inc_lev == 4, dfuller lags(2)
xtunitroot fisher d.ln_gdp2 	if inc_lev == 4, dfuller lags(2)
xtunitroot fisher ln_gdp2 		if inc_lev == 4, dfuller trend lags(2)
xtunitroot fisher d.ln_gdp2 	if inc_lev == 4, dfuller trend lags(2)
* 	Agricultural Area
xtunitroot fisher ln_agr 		if inc_lev == 4, dfuller lags(1)
xtunitroot fisher d.ln_agr 		if inc_lev == 4, dfuller lags(1)
xtunitroot fisher ln_agr 		if inc_lev == 4, dfuller trend lags(1)
xtunitroot fisher d.ln_agr 		if inc_lev == 4, dfuller trend lags(1)
xtunitroot fisher ln_agr 		if inc_lev == 4, dfuller lags(2)
xtunitroot fisher d.ln_agr 		if inc_lev == 4, dfuller lags(2)
xtunitroot fisher ln_agr 		if inc_lev == 4, dfuller trend lags(2)
xtunitroot fisher d.ln_agr 		if inc_lev == 4, dfuller trend lags(2)
* 	Population Density
xtunitroot fisher ln_pop 		if inc_lev == 4, dfuller lags(1)
xtunitroot fisher d.ln_pop 		if inc_lev == 4, dfuller lags(1)
xtunitroot fisher ln_pop 		if inc_lev == 4, dfuller trend lags(1)
xtunitroot fisher d.ln_pop 		if inc_lev == 4, dfuller trend lags(1)
xtunitroot fisher ln_pop 		if inc_lev == 4, dfuller lags(2)
xtunitroot fisher d.ln_pop 		if inc_lev == 4, dfuller lags(2)
xtunitroot fisher ln_pop 		if inc_lev == 4, dfuller trend lags(2)
xtunitroot fisher d.ln_pop 		if inc_lev == 4, dfuller trend lags(2)
* 	Trade Openness
xtunitroot fisher ln_trade 		if inc_lev == 4, dfuller lags(1)
xtunitroot fisher d.ln_trade 	if inc_lev == 4, dfuller lags(1)
xtunitroot fisher ln_trade 		if inc_lev == 4, dfuller trend lags(1)
xtunitroot fisher d.ln_trade 	if inc_lev == 4, dfuller trend lags(1)
xtunitroot fisher ln_trade 		if inc_lev == 4, dfuller lags(2)
xtunitroot fisher d.ln_trade 	if inc_lev == 4, dfuller lags(2)
xtunitroot fisher ln_trade 		if inc_lev == 4, dfuller trend lags(2)
xtunitroot fisher d.ln_trade 	if inc_lev == 4, dfuller trend lags(2)
restore

* Middle-Income Economies 
preserve
drop if country == "Myanmar"
drop if country == "Serbia"
* 	Deforestation Rates
xtunitroot fisher def_rate 		if inc_lev == 3 | inc_lev == 2, dfuller lags(1)
xtunitroot fisher d.def_rate 	if inc_lev == 3 | inc_lev == 2, dfuller lags(1)
xtunitroot fisher def_rate 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(1)
xtunitroot fisher d.def_rate 	if inc_lev == 3 | inc_lev == 2, dfuller trend lags(1)
xtunitroot fisher def_rate 		if inc_lev == 3 | inc_lev == 2, dfuller lags(2)
xtunitroot fisher d.def_rate 	if inc_lev == 3 | inc_lev == 2, dfuller lags(2)
xtunitroot fisher def_rate 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(2)
xtunitroot fisher d.def_rate 	if inc_lev == 3 | inc_lev == 2, dfuller trend lags(2)
* 	GDP per capita
xtunitroot fisher ln_gdp 		if inc_lev == 3 | inc_lev == 2, dfuller lags(1)
xtunitroot fisher d.ln_gdp 		if inc_lev == 3 | inc_lev == 2, dfuller lags(1)
xtunitroot fisher ln_gdp 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(1)
xtunitroot fisher d.ln_gdp 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(1)
xtunitroot fisher ln_gdp 		if inc_lev == 3 | inc_lev == 2, dfuller lags(2)
xtunitroot fisher d.ln_gdp 		if inc_lev == 3 | inc_lev == 2, dfuller lags(2)
xtunitroot fisher ln_gdp 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(2)
xtunitroot fisher d.ln_gdp 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(2)
* 	GDP per capita^2
xtunitroot fisher ln_gdp2 		if inc_lev == 3 | inc_lev == 2, dfuller lags(1)
xtunitroot fisher d.ln_gdp2 	if inc_lev == 3 | inc_lev == 2, dfuller lags(1)
xtunitroot fisher ln_gdp2 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(1)
xtunitroot fisher d.ln_gdp2 	if inc_lev == 3 | inc_lev == 2, dfuller trend lags(1)
xtunitroot fisher ln_gdp2 		if inc_lev == 3 | inc_lev == 2, dfuller lags(2)
xtunitroot fisher d.ln_gdp2 	if inc_lev == 3 | inc_lev == 2, dfuller lags(2)
xtunitroot fisher ln_gdp2 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(2)
xtunitroot fisher d.ln_gdp2 	if inc_lev == 3 | inc_lev == 2, dfuller trend lags(2)
* 	Agricultural Area
xtunitroot fisher ln_agr 		if inc_lev == 3 | inc_lev == 2, dfuller lags(1)
xtunitroot fisher d.ln_agr 		if inc_lev == 3 | inc_lev == 2, dfuller lags(1)
xtunitroot fisher ln_agr 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(1)
xtunitroot fisher d.ln_agr 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(1)
xtunitroot fisher ln_agr 		if inc_lev == 3 | inc_lev == 2, dfuller lags(2)
xtunitroot fisher d.ln_agr 		if inc_lev == 3 | inc_lev == 2, dfuller lags(2)
xtunitroot fisher ln_agr 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(2)
xtunitroot fisher d.ln_agr 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(2)
* 	Population Density
xtunitroot fisher ln_pop 		if inc_lev == 3 | inc_lev == 2, dfuller lags(1)
xtunitroot fisher d.ln_pop 		if inc_lev == 3 | inc_lev == 2, dfuller lags(1)
xtunitroot fisher ln_pop 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(1)
xtunitroot fisher d.ln_pop 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(1)
xtunitroot fisher ln_pop 		if inc_lev == 3 | inc_lev == 2, dfuller lags(2)
xtunitroot fisher d.ln_pop 		if inc_lev == 3 | inc_lev == 2, dfuller lags(2)
xtunitroot fisher ln_pop 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(2)
xtunitroot fisher d.ln_pop 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(2)
* 	Trade Openness
xtunitroot fisher ln_trade 		if inc_lev == 3 | inc_lev == 2, dfuller lags(1)
xtunitroot fisher d.ln_trade 	if inc_lev == 3 | inc_lev == 2, dfuller lags(1)
xtunitroot fisher ln_trade 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(1)
xtunitroot fisher d.ln_trade 	if inc_lev == 3 | inc_lev == 2, dfuller trend lags(1)
xtunitroot fisher ln_trade 		if inc_lev == 3 | inc_lev == 2, dfuller lags(2)
xtunitroot fisher d.ln_trade 	if inc_lev == 3 | inc_lev == 2, dfuller lags(2)
xtunitroot fisher ln_trade 		if inc_lev == 3 | inc_lev == 2, dfuller trend lags(2)
xtunitroot fisher d.ln_trade 	if inc_lev == 3 | inc_lev == 2, dfuller trend lags(2)
restore

* High-Income Economies 
* 	Deforestation Rates
xtunitroot fisher def_rate 		if inc_lev == 1, dfuller lags(1)
xtunitroot fisher d.def_rate 	if inc_lev == 1, dfuller lags(1)
xtunitroot fisher def_rate 		if inc_lev == 1, dfuller trend lags(1)
xtunitroot fisher d.def_rate 	if inc_lev == 1, dfuller trend lags(1)
xtunitroot fisher def_rate 		if inc_lev == 1, dfuller lags(2)
xtunitroot fisher d.def_rate 	if inc_lev == 1, dfuller lags(2)
xtunitroot fisher def_rate 		if inc_lev == 1, dfuller trend lags(2)
xtunitroot fisher d.def_rate 	if inc_lev == 1, dfuller trend lags(2)
* 	GDP per capita
xtunitroot fisher ln_gdp 		if inc_lev == 1, dfuller lags(1)
xtunitroot fisher d.ln_gdp 		if inc_lev == 1, dfuller lags(1)
xtunitroot fisher ln_gdp 		if inc_lev == 1, dfuller trend lags(1)
xtunitroot fisher d.ln_gdp 		if inc_lev == 1, dfuller trend lags(1)
xtunitroot fisher ln_gdp 		if inc_lev == 1, dfuller lags(2)
xtunitroot fisher d.ln_gdp 		if inc_lev == 1, dfuller lags(2)
xtunitroot fisher ln_gdp 		if inc_lev == 1, dfuller trend lags(2)
xtunitroot fisher d.ln_gdp 		if inc_lev == 1, dfuller trend lags(2)
* 	GDP per capita^2
xtunitroot fisher ln_gdp2 		if inc_lev == 1, dfuller lags(1)
xtunitroot fisher d.ln_gdp2 	if inc_lev == 1, dfuller lags(1)
xtunitroot fisher ln_gdp2 		if inc_lev == 1, dfuller trend lags(1)
xtunitroot fisher d.ln_gdp2 	if inc_lev == 1, dfuller trend lags(1)
xtunitroot fisher ln_gdp2 		if inc_lev == 1, dfuller lags(2)
xtunitroot fisher d.ln_gdp2 	if inc_lev == 1, dfuller lags(2)
xtunitroot fisher ln_gdp2 		if inc_lev == 1, dfuller trend lags(2)
xtunitroot fisher d.ln_gdp2 	if inc_lev == 1, dfuller trend lags(2)
* 	Agricultural Area
xtunitroot fisher ln_agr 		if inc_lev == 1, dfuller lags(1)
xtunitroot fisher d.ln_agr 		if inc_lev == 1, dfuller lags(1)
xtunitroot fisher ln_agr 		if inc_lev == 1, dfuller trend lags(1)
xtunitroot fisher d.ln_agr 		if inc_lev == 1, dfuller trend lags(1)
xtunitroot fisher ln_agr 		if inc_lev == 1, dfuller lags(2)
xtunitroot fisher d.ln_agr 		if inc_lev == 1, dfuller lags(2)
xtunitroot fisher ln_agr 		if inc_lev == 1, dfuller trend lags(2)
xtunitroot fisher d.ln_agr 		if inc_lev == 1, dfuller trend lags(2)
* 	Population Density
xtunitroot fisher ln_pop 		if inc_lev == 1, dfuller lags(1)
xtunitroot fisher d.ln_pop 		if inc_lev == 1, dfuller lags(1)
xtunitroot fisher ln_pop 		if inc_lev == 1, dfuller trend lags(1)
xtunitroot fisher d.ln_pop 		if inc_lev == 1, dfuller trend lags(1)
xtunitroot fisher ln_pop 		if inc_lev == 1, dfuller lags(2)
xtunitroot fisher d.ln_pop 		if inc_lev == 1, dfuller lags(2)
xtunitroot fisher ln_pop 		if inc_lev == 1, dfuller trend lags(2)
xtunitroot fisher d.ln_pop 		if inc_lev == 1, dfuller trend lags(2)
* 	PTrade Openness
xtunitroot fisher ln_trade 		if inc_lev == 1, dfuller lags(1)
xtunitroot fisher d.ln_trade 	if inc_lev == 1, dfuller lags(1)
xtunitroot fisher ln_trade 		if inc_lev == 1, dfuller trend lags(1)
xtunitroot fisher d.ln_trade 	if inc_lev == 1, dfuller trend lags(1)
xtunitroot fisher ln_trade 		if inc_lev == 1, dfuller lags(2)
xtunitroot fisher d.ln_trade 	if inc_lev == 1, dfuller lags(2)
xtunitroot fisher ln_trade 		if inc_lev == 1, dfuller trend lags(2)
xtunitroot fisher d.ln_trade 	if inc_lev == 1, dfuller trend lags(2)

*==================================
* Stationarity: Unit Root with CSD
*----------------------------------
* Method: Pesaran (2003)
*==================================

* Low-Income Economies 
preserve
drop if country == "Eritrea" 
drop if country == "Ethiopia"
* 	Deforestation Rates
pescadf def_rate 	if inc_lev == 4, lags(0) 			
pescadf d.def_rate 	if inc_lev == 4, lags(0) 		
pescadf def_rate 	if inc_lev == 4, lags(0) trend 
pescadf d.def_rate 	if inc_lev == 4, lags(0) trend 	
pescadf def_rate 	if inc_lev == 4, lags(1) 			
pescadf d.def_rate 	if inc_lev == 4, lags(1) 		
pescadf def_rate 	if inc_lev == 4, lags(1) trend 
pescadf d.def_rate 	if inc_lev == 4, lags(1) trend 	
pescadf def_rate 	if inc_lev == 4, lags(2) 			
pescadf d.def_rate 	if inc_lev == 4, lags(2) 		
pescadf def_rate 	if inc_lev == 4, lags(2) trend 
pescadf d.def_rate 	if inc_lev == 4, lags(2) trend 
* 	GDP per capita
pescadf ln_gdp 		if inc_lev == 4, lags(0) 			
pescadf d.ln_gdp 	if inc_lev == 4, lags(0) 		
pescadf ln_gdp 		if inc_lev == 4, lags(0) trend 
pescadf d.ln_gdp 	if inc_lev == 4, lags(0) trend 	
pescadf ln_gdp 		if inc_lev == 4, lags(1) 			
pescadf d.ln_gdp 	if inc_lev == 4, lags(1) 		
pescadf ln_gdp 		if inc_lev == 4, lags(1) trend 
pescadf d.ln_gdp 	if inc_lev == 4, lags(1) trend 	
pescadf ln_gdp 		if inc_lev == 4, lags(2) 			
pescadf d.ln_gdp 	if inc_lev == 4, lags(2) 		
pescadf ln_gdp 		if inc_lev == 4, lags(2) trend 
pescadf d.ln_gdp 	if inc_lev == 4, lags(2) trend 	
* 	GDP per capita^2
pescadf ln_gdp2 	if inc_lev == 4, lags(0) 			
pescadf d.ln_gdp2 	if inc_lev == 4, lags(0) 		
pescadf ln_gdp2 	if inc_lev == 4, lags(0) trend 
pescadf d.ln_gdp2 	if inc_lev == 4, lags(0) trend 	
pescadf ln_gdp2		if inc_lev == 4, lags(1) 			
pescadf d.ln_gdp2 	if inc_lev == 4, lags(1) 		
pescadf ln_gdp2 	if inc_lev == 4, lags(1) trend 
pescadf d.ln_gdp2 	if inc_lev == 4, lags(1) trend 	
pescadf ln_gdp2 	if inc_lev == 4, lags(2) 			
pescadf d.ln_gdp2 	if inc_lev == 4, lags(2) 		
pescadf ln_gdp2 	if inc_lev == 4, lags(2) trend 
pescadf d.ln_gdp2 	if inc_lev == 4, lags(2) trend 	
* 	Agricultural Area
pescadf ln_agr 		if inc_lev == 4, lags(0) 			
pescadf d.ln_agr 	if inc_lev == 4, lags(0) 		
pescadf ln_agr 		if inc_lev == 4, lags(0) trend 
pescadf d.ln_agr 	if inc_lev == 4, lags(0) trend 	
pescadf ln_agr 		if inc_lev == 4, lags(1) 			
pescadf d.ln_agr 	if inc_lev == 4, lags(1) 		
pescadf ln_agr 		if inc_lev == 4, lags(1) trend 
pescadf d.ln_agr 	if inc_lev == 4, lags(1) trend 	
pescadf ln_agr 		if inc_lev == 4, lags(2) 			
pescadf d.ln_agr 	if inc_lev == 4, lags(2) 		
pescadf ln_agr 		if inc_lev == 4, lags(2) trend 
pescadf d.ln_agr 	if inc_lev == 4, lags(2) trend 
* 	Population Density
pescadf ln_pop 		if inc_lev == 4, lags(0) 			
pescadf d.ln_pop 	if inc_lev == 4, lags(0) 		
pescadf ln_pop 		if inc_lev == 4, lags(0) trend 
pescadf d.ln_pop 	if inc_lev == 4, lags(0) trend 	
pescadf ln_pop 		if inc_lev == 4, lags(1) 			
pescadf d.ln_pop 	if inc_lev == 4, lags(1) 		
pescadf ln_pop 		if inc_lev == 4, lags(1) trend 
pescadf d.ln_pop 	if inc_lev == 4, lags(1) trend 	
pescadf ln_pop 		if inc_lev == 4, lags(2) 			
pescadf d.ln_pop 	if inc_lev == 4, lags(2) 		
pescadf ln_pop 		if inc_lev == 4, lags(2) trend 
pescadf d.ln_pop 	if inc_lev == 4, lags(2) trend 
* 	Trade Openness
pescadf ln_trade 	if inc_lev == 4, lags(0) 			
pescadf d.ln_trade 	if inc_lev == 4, lags(0) 		
pescadf ln_trade 	if inc_lev == 4, lags(0) trend 
pescadf d.ln_trade 	if inc_lev == 4, lags(0) trend 	
pescadf ln_trade	if inc_lev == 4, lags(1) 			
pescadf d.ln_trade  if inc_lev == 4, lags(1) 		
pescadf ln_trade 	if inc_lev == 4, lags(1) trend 
pescadf d.ln_trade 	if inc_lev == 4, lags(1) trend 	
pescadf ln_trade 	if inc_lev == 4, lags(2) 			
pescadf d.ln_trade  if inc_lev == 4, lags(2) 		
pescadf ln_trade 	if inc_lev == 4, lags(2) trend 
pescadf d.ln_trade 	if inc_lev == 4, lags(2) trend 	
restore

* Middle-Income Economies 
preserve
drop if country == "Myanmar"
drop if country == "Serbia"
* 	Deforestation Rates
pescadf def_rate 	if inc_lev == 3 | inc_lev == 2, lags(0) 			
pescadf d.def_rate 	if inc_lev == 3 | inc_lev == 2, lags(0) 		
pescadf def_rate 	if inc_lev == 3 | inc_lev == 2, lags(0) trend 
pescadf d.def_rate  if inc_lev == 3 | inc_lev == 2, lags(0) trend 	
pescadf def_rate  	if inc_lev == 3 | inc_lev == 2, lags(1) 			
pescadf d.def_rate  if inc_lev == 3 | inc_lev == 2, lags(1) 		
pescadf def_rate 	if inc_lev == 3 | inc_lev == 2, lags(1) trend 
pescadf d.def_rate 	if inc_lev == 3 | inc_lev == 2, lags(1) trend 	
pescadf def_rate 	if inc_lev == 3 | inc_lev == 2, lags(2) 			
pescadf d.def_rate 	if inc_lev == 3 | inc_lev == 2, lags(2) 		
pescadf def_rate 	if inc_lev == 3 | inc_lev == 2, lags(2) trend 
pescadf d.def_rate 	if inc_lev == 3 | inc_lev == 2, lags(2) trend 
* 	GDP per capita
pescadf ln_gdp 		if inc_lev == 3 | inc_lev == 2, lags(0) 			
pescadf d.ln_gdp 	if inc_lev == 3 | inc_lev == 2, lags(0) 		
pescadf ln_gdp 		if inc_lev == 3 | inc_lev == 2, lags(0) trend 
pescadf d.ln_gdp 	if inc_lev == 3 | inc_lev == 2, lags(0) trend 	
pescadf ln_gdp 		if inc_lev == 3 | inc_lev == 2, lags(1) 			
pescadf d.ln_gdp 	if inc_lev == 3 | inc_lev == 2, lags(1) 		
pescadf ln_gdp 		if inc_lev == 3 | inc_lev == 2, lags(1) trend 
pescadf d.ln_gdp 	if inc_lev == 3 | inc_lev == 2, lags(1) trend 	
pescadf ln_gdp 		if inc_lev == 3 | inc_lev == 2, lags(2) 			
pescadf d.ln_gdp 	if inc_lev == 3 | inc_lev == 2, lags(2) 		
pescadf ln_gdp 		if inc_lev == 3 | inc_lev == 2, lags(2) trend 
pescadf d.ln_gdp 	if inc_lev == 3 | inc_lev == 2, lags(2) trend 	
* 	GDP per capita ^2
pescadf ln_gdp2 	if inc_lev == 3 | inc_lev == 2, lags(0) 			
pescadf d.ln_gdp2 	if inc_lev == 3 | inc_lev == 2, lags(0) 		
pescadf ln_gdp2 	if inc_lev == 3 | inc_lev == 2, lags(0) trend 
pescadf d.ln_gdp2 	if inc_lev == 3 | inc_lev == 2, lags(0) trend 	
pescadf ln_gdp2 	if inc_lev == 3 | inc_lev == 2, lags(1) 			
pescadf d.ln_gdp2	if inc_lev == 3 | inc_lev == 2, lags(1) 		
pescadf ln_gdp2 	if inc_lev == 3 | inc_lev == 2, lags(1) trend 
pescadf d.ln_gdp2 	if inc_lev == 3 | inc_lev == 2, lags(1) trend 	
pescadf ln_gdp2 	if inc_lev == 3 | inc_lev == 2, lags(2) 			
pescadf d.ln_gdp2 	if inc_lev == 3 | inc_lev == 2, lags(2) 		
pescadf ln_gdp2 	if inc_lev == 3 | inc_lev == 2, lags(2) trend 
pescadf d.ln_gdp2 	if inc_lev == 3 | inc_lev == 2, lags(2) trend 	
* 	Agricultural Area
pescadf ln_agr 		if inc_lev == 3 | inc_lev == 2, lags(0) 			
pescadf d.ln_agr 	if inc_lev == 3 | inc_lev == 2, lags(0) 		
pescadf ln_agr 		if inc_lev == 3 | inc_lev == 2, lags(0) trend 
pescadf d.ln_agr 	if inc_lev == 3 | inc_lev == 2, lags(0) trend 	
pescadf ln_agr 		if inc_lev == 3 | inc_lev == 2, lags(1) 			
pescadf d.ln_agr 	if inc_lev == 3 | inc_lev == 2, lags(1) 		
pescadf ln_agr 		if inc_lev == 3 | inc_lev == 2, lags(1) trend 
pescadf d.ln_agr 	if inc_lev == 3 | inc_lev == 2, lags(1) trend 	
pescadf ln_agr 		if inc_lev == 3 | inc_lev == 2, lags(2) 			
pescadf d.ln_agr 	if inc_lev == 3 | inc_lev == 2, lags(2) 		
pescadf ln_agr 		if inc_lev == 3 | inc_lev == 2, lags(2) trend 
pescadf d.ln_agr 	if inc_lev == 3 | inc_lev == 2, lags(2) trend 
* 	Population Density
pescadf ln_pop 		if inc_lev == 3 | inc_lev == 2, lags(0) 			
pescadf d.ln_pop 	if inc_lev == 3 | inc_lev == 2, lags(0) 		
pescadf ln_pop 		if inc_lev == 3 | inc_lev == 2, lags(0) trend 
pescadf d.ln_pop 	if inc_lev == 3 | inc_lev == 2, lags(0) trend 	
pescadf ln_pop 		if inc_lev == 3 | inc_lev == 2, lags(1) 			
pescadf d.ln_pop 	if inc_lev == 3 | inc_lev == 2, lags(1) 		
pescadf ln_pop 		if inc_lev == 3 | inc_lev == 2, lags(1) trend 
pescadf d.ln_pop 	if inc_lev == 3 | inc_lev == 2, lags(1) trend 	
pescadf ln_pop 		if inc_lev == 3 | inc_lev == 2, lags(2) 			
pescadf d.ln_pop 	if inc_lev == 3 | inc_lev == 2, lags(2) 		
pescadf ln_pop 		if inc_lev == 3 | inc_lev == 2, lags(2) trend 
pescadf d.ln_pop 	if inc_lev == 3 | inc_lev == 2, lags(2) trend 
* 	Trade Openness
pescadf ln_trade 	if inc_lev == 3 | inc_lev == 2, lags(0) 			
pescadf d.ln_trade 	if inc_lev == 3 | inc_lev == 2, lags(0) 		
pescadf ln_trade 	if inc_lev == 3 | inc_lev == 2, lags(0) trend 
pescadf d.ln_trade 	if inc_lev == 3 | inc_lev == 2, lags(0) trend 	
pescadf ln_trade	if inc_lev == 3 | inc_lev == 2, lags(1) 			
pescadf d.ln_trade  if inc_lev == 3 | inc_lev == 2, lags(1) 		
pescadf ln_trade 	if inc_lev == 3 | inc_lev == 2, lags(1) trend 
pescadf d.ln_trade 	if inc_lev == 3 | inc_lev == 2, lags(1) trend 	
pescadf ln_trade 	if inc_lev == 3 | inc_lev == 2, lags(2) 			
pescadf d.ln_trade  if inc_lev == 3 | inc_lev == 2, lags(2) 		
pescadf ln_trade 	if inc_lev == 3 | inc_lev == 2, lags(2) trend 
pescadf d.ln_trade 	if inc_lev == 3 | inc_lev == 2, lags(2) trend 	
restore

* High-Income Economies 
* 	Deforestation Rates
pescadf def_rate 	if inc_lev == 1, lags(0) 			
pescadf d.def_rate 	if inc_lev == 1, lags(0) 		
pescadf def_rate 	if inc_lev == 1, lags(0) trend 
pescadf d.def_rate 	if inc_lev == 1, lags(0) trend 	
pescadf def_rate 	if inc_lev == 1, lags(1) 			
pescadf d.def_rate 	if inc_lev == 1, lags(1) 		
pescadf def_rate 	if inc_lev == 1, lags(1) trend 
pescadf d.def_rate 	if inc_lev == 1, lags(1) trend 	
pescadf def_rate 	if inc_lev == 1, lags(2) 			
pescadf d.def_rate 	if inc_lev == 1, lags(2) 		
pescadf def_rate 	if inc_lev == 1, lags(2) trend 
pescadf d.def_rate 	if inc_lev == 1, lags(2) trend 
* 	GDP per capita
pescadf ln_gdp 		if inc_lev == 1, lags(0) 			
pescadf d.ln_gdp 	if inc_lev == 1, lags(0) 		
pescadf ln_gdp 		if inc_lev == 1, lags(0) trend 
pescadf d.ln_gdp	if inc_lev == 1, lags(0) trend 	
pescadf ln_gdp 		if inc_lev == 1, lags(1) 			
pescadf d.ln_gdp	if inc_lev == 1, lags(1) 		
pescadf ln_gdp 		if inc_lev == 1, lags(1) trend 
pescadf d.ln_gdp 	if inc_lev == 1, lags(1) trend 	
pescadf ln_gdp 		if inc_lev == 1, lags(2) 			
pescadf d.ln_gdp 	if inc_lev == 1, lags(2) 		
pescadf ln_gdp 		if inc_lev == 1, lags(2) trend 
pescadf d.ln_gdp 	if inc_lev == 1, lags(2) trend 	
* 	GDP per capita^2
pescadf ln_gdp2 	if inc_lev == 1, lags(0) 			
pescadf d.ln_gdp2 	if inc_lev == 1, lags(0) 		
pescadf ln_gdp2 	if inc_lev == 1, lags(0) trend 
pescadf d.ln_gdp2 	if inc_lev == 1, lags(0) trend 	
pescadf ln_gdp2 	if inc_lev == 1, lags(1) 			
pescadf d.ln_gdp2 	if inc_lev == 1, lags(1) 		
pescadf ln_gdp2 	if inc_lev == 1, lags(1) trend 
pescadf d.ln_gdp2 	if inc_lev == 1, lags(1) trend 	
pescadf ln_gdp2 	if inc_lev == 1, lags(2) 			
pescadf d.ln_gdp2 	if inc_lev == 1, lags(2) 		
pescadf ln_gdp2 	if inc_lev == 1, lags(2) trend 
pescadf d.ln_gdp2 	if inc_lev == 1, lags(2) trend 
pescadf ln_agr 		if inc_lev == 1, lags(0) 			
pescadf d.ln_agr 	if inc_lev == 1, lags(0) 		
pescadf ln_agr 		if inc_lev == 1, lags(0) trend 
pescadf d.ln_agr 	if inc_lev == 1, lags(0) trend 	
pescadf ln_agr 		if inc_lev == 1, lags(1) 			
pescadf d.ln_agr 	if inc_lev == 1, lags(1) 		
pescadf ln_agr 		if inc_lev == 1, lags(1) trend 
pescadf d.ln_agr 	if inc_lev == 1, lags(1) trend 	
pescadf ln_agr 		if inc_lev == 1, lags(2) 			
pescadf d.ln_agr 	if inc_lev == 1, lags(2) 		
pescadf ln_agr 		if inc_lev == 1, lags(2) trend 
pescadf d.ln_agr 	if inc_lev == 1, lags(2) trend 
* 	Population Density
pescadf ln_pop 		if inc_lev == 1, lags(0) 			
pescadf d.ln_pop 	if inc_lev == 1, lags(0) 		
pescadf ln_pop 		if inc_lev == 1, lags(0) trend 
pescadf d.ln_pop 	if inc_lev == 1, lags(0) trend 	
pescadf ln_pop 		if inc_lev == 1, lags(1) 			
pescadf d.ln_pop 	if inc_lev == 1, lags(1) 		
pescadf ln_pop 		if inc_lev == 1, lags(1) trend 
pescadf d.ln_pop 	if inc_lev == 1, lags(1) trend 	
pescadf ln_pop 		if inc_lev == 1, lags(2) 			
pescadf d.ln_pop 	if inc_lev == 1, lags(2) 		
pescadf ln_pop 		if inc_lev == 1, lags(2) trend 
pescadf d.ln_pop 	if inc_lev == 1, lags(2) trend 
* 	Trade Openness
pescadf ln_trade 	if inc_lev == 1, lags(0) 			
pescadf d.ln_trade 	if inc_lev == 1, lags(0) 		
pescadf ln_trade 	if inc_lev == 1, lags(0) trend 
pescadf d.ln_trade 	if inc_lev == 1, lags(0) trend 	
pescadf ln_trade	if inc_lev == 1, lags(1) 			
pescadf d.ln_trade  if inc_lev == 1, lags(1) 		
pescadf ln_trade 	if inc_lev == 1, lags(1) trend 
pescadf d.ln_trade 	if inc_lev == 1, lags(1) trend 	
pescadf ln_trade 	if inc_lev == 1, lags(2) 			
pescadf d.ln_trade  if inc_lev == 1, lags(2) 		
pescadf ln_trade 	if inc_lev == 1, lags(2) trend 
pescadf d.ln_trade 	if inc_lev == 1, lags(2) trend 	

*=====================================================
* Cointegration Tests
*-----------------------------------------------------
* Kao (1999), Pedroni (1999, 2004), Westerlund (2005)
*=====================================================

* Low-Income Economies 
preserve
drop if country == "Eritrea" 
drop if country == "Ethiopia"
*	Method: Kao
xtcointtest kao def_rate ln_gdp ln_gdp2 								if inc_lev == 4
xtcointtest kao def_rate ln_gdp ln_gdp2		 							if inc_lev == 4, lags(aic)
xtcointtest kao def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade 			if inc_lev == 4
xtcointtest kao def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade		 	if inc_lev == 4, lags(aic)
*	Method: Pedroni
xtcointtest pedroni def_rate ln_gdp ln_gdp2	 							if inc_lev == 4
xtcointtest pedroni def_rate ln_gdp ln_gdp2 							if inc_lev == 4, trend
xtcointtest pedroni def_rate ln_gdp ln_gdp2 							if inc_lev == 4, lags(aic)
xtcointtest pedroni def_rate ln_gdp ln_gdp2								if inc_lev == 4, trend lags(aic)
xtcointtest pedroni def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade	 	if inc_lev == 4
xtcointtest pedroni def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade 		if inc_lev == 4, trend
xtcointtest pedroni def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade 		if inc_lev == 4, lags(aic)
xtcointtest pedroni def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade		if inc_lev == 4, trend lags(aic)
*	Method: Westerlund
xtcointtest westerlund def_rate ln_gdp ln_gdp2							if inc_lev == 4
xtcointtest westerlund def_rate ln_gdp ln_gdp2							if inc_lev == 4, trend
xtcointtest westerlund def_rate ln_gdp ln_gdp2							if inc_lev == 4, allpanels
xtcointtest westerlund def_rate ln_gdp ln_gdp2							if inc_lev == 4, trend allpanels
xtcointtest westerlund def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade	if inc_lev == 4
xtcointtest westerlund def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade	if inc_lev == 4, trend
xtcointtest westerlund def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade	if inc_lev == 4, allpanels
xtcointtest westerlund def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade	if inc_lev == 4, trend allpanels
restore

* Middle-Income Economies 
preserve
drop if country == "Myanmar"
drop if country == "Serbia"
*	Method: Kao	
xtcointtest kao def_rate ln_gdp ln_gdp2 								if inc_lev == 3 | inc_lev == 2
xtcointtest kao def_rate ln_gdp ln_gdp2		 							if inc_lev == 3 | inc_lev == 2, lags(aic)
xtcointtest kao def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade 			if inc_lev == 3 | inc_lev == 2
xtcointtest kao def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade		 	if inc_lev == 3 | inc_lev == 2, lags(aic)
*	Method: Pedroni
xtcointtest pedroni def_rate ln_gdp ln_gdp2	 							if inc_lev == 3 | inc_lev == 2
xtcointtest pedroni def_rate ln_gdp ln_gdp2 							if inc_lev == 3 | inc_lev == 2, trend
xtcointtest pedroni def_rate ln_gdp ln_gdp2 							if inc_lev == 3 | inc_lev == 2, lags(aic)
xtcointtest pedroni def_rate ln_gdp ln_gdp2								if inc_lev == 3 | inc_lev == 2, trend lags(aic)
xtcointtest pedroni def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade	 	if inc_lev == 3 | inc_lev == 2
xtcointtest pedroni def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade 		if inc_lev == 3 | inc_lev == 2, trend
xtcointtest pedroni def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade 		if inc_lev == 3 | inc_lev == 2, lags(aic)
xtcointtest pedroni def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade		if inc_lev == 3 | inc_lev == 2, trend lags(aic)
*	Method: Westerlund
xtcointtest westerlund def_rate ln_gdp ln_gdp2							if inc_lev == 3 | inc_lev == 2
xtcointtest westerlund def_rate ln_gdp ln_gdp2							if inc_lev == 3 | inc_lev == 2, trend
xtcointtest westerlund def_rate ln_gdp ln_gdp2							if inc_lev == 3 | inc_lev == 2, allpanels
xtcointtest westerlund def_rate ln_gdp ln_gdp2							if inc_lev == 3 | inc_lev == 2, trend allpanels
xtcointtest westerlund def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade	if inc_lev == 3 | inc_lev == 2
xtcointtest westerlund def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade	if inc_lev == 3 | inc_lev == 2, trend
xtcointtest westerlund def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade	if inc_lev == 3 | inc_lev == 2, allpanels
xtcointtest westerlund def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade	if inc_lev == 3 | inc_lev == 2, trend allpanels
restore

* High-Income Economies 
*	Method: Kao
xtcointtest kao def_rate ln_gdp ln_gdp2 								if inc_lev == 1
xtcointtest kao def_rate ln_gdp ln_gdp2		 							if inc_lev == 1, lags(aic)
xtcointtest kao def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade 			if inc_lev == 1
xtcointtest kao def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade		 	if inc_lev == 1, lags(aic)
*	Method: Pedroni
xtcointtest pedroni def_rate ln_gdp ln_gdp2	 							if inc_lev == 1
xtcointtest pedroni def_rate ln_gdp ln_gdp2 							if inc_lev == 1, trend
xtcointtest pedroni def_rate ln_gdp ln_gdp2 							if inc_lev == 1, lags(aic)
xtcointtest pedroni def_rate ln_gdp ln_gdp2								if inc_lev == 1, trend lags(aic)
xtcointtest pedroni def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade	 	if inc_lev == 1
xtcointtest pedroni def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade 		if inc_lev == 1, trend
xtcointtest pedroni def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade 		if inc_lev == 1, lags(aic)
xtcointtest pedroni def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade		if inc_lev == 1, trend lags(aic)
*	Method: Westerlund
xtcointtest westerlund def_rate ln_gdp ln_gdp2							if inc_lev == 1
xtcointtest westerlund def_rate ln_gdp ln_gdp2							if inc_lev == 1, trend
xtcointtest westerlund def_rate ln_gdp ln_gdp2							if inc_lev == 1, allpanels
xtcointtest westerlund def_rate ln_gdp ln_gdp2							if inc_lev == 1, trend allpanels
xtcointtest westerlund def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade	if inc_lev == 1
xtcointtest westerlund def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade	if inc_lev == 1, trend
xtcointtest westerlund def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade	if inc_lev == 1, allpanels
xtcointtest westerlund def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade	if inc_lev == 1, trend allpanels

*==================================================
* MODEL 1
*--------------------------------------------------
* Methodology: 
* - Panel Data, Fixed Effects
* - Driscoll & Kraay (1988) robust standard errors
*==================================================

* Low-Income Economies 
preserve
keep if inc_lev == 4
*drop if country == "Eritrea" 
*drop if country == "Ethiopia"
eststo: xtscc def_rate ln_gdp ln_gdp2, fe lag(2)
restore
* Middle-Income Economies
preserve
keep if inc_lev == 3 | inc_lev == 2
*drop if country == "Myanmar"
*drop if country == "Serbia"
eststo: xtscc def_rate ln_gdp ln_gdp2, fe lag(2)
restore
* High-Income Economies
preserve
keep if inc_lev == 1
eststo: xtscc def_rate ln_gdp ln_gdp2, fe lag(2)
restore
* Tabulation
esttab, label se(3) star(* 0.1 ** 0.05 *** 0.01) ///
title(EKC for deforestation (Driscoll & Kraay standard errors)) ///
nonumbers mtitles ("Low""Middle""High")
eststo clear

*==================================================
* MODEL 2
*--------------------------------------------------
* Methodology: 
* - Panel Data, Fixed Effects
* - Driscoll & Kraay (1988) robust standard errors
*==================================================

* Low-Income Economies 
preserve
keep if inc_lev == 4
*drop if country == "Eritrea" 
*drop if country == "Ethiopia"
eststo: xtscc def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade, fe lag(2)
restore
* Middle-Income Economies
preserve
keep if inc_lev == 3 | inc_lev == 2
*drop if country == "Myanmar"
*drop if country == "Serbia"
eststo: xtscc def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade, fe lag(2)
restore
* High-Income Economies
preserve
keep if inc_lev == 1
eststo: xtscc def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade, fe lag(2)
restore
* Tabulation
esttab, label se(3) star(* 0.1 ** 0.05 *** 0.01) ///
title(EKC for deforestation (Driscoll & Kraay standard errors)) ///
nonumbers mtitles ("Low""Middle""High")
eststo clear

*======================================================
* MODEL 3
*------------------------------------------------------
* Methodology: 
* - Pooled Mean Group estimation (Pesaran et al, 1999)
* - ARDL with cross-sectional means
*======================================================

set more off
set matsize 800
set emptycells drop
* Low-Income Economies, ARDL (1,1,1,1,1,1) 
preserve
drop if country == "Eritrea" 
drop if country == "Ethiopia"
keep if inc_lev == 4
xtset year id
bys year: egen def_rate_bar = mean(def_rate)
bys year: egen ln_gdp_bar = mean(ln_gdp)
bys year: egen ln_gdp2_bar = mean(ln_gdp2)
bys year: egen ln_gdp3_bar = mean(ln_gdp3)
bys year: egen ln_agr_bar = mean(ln_agr)
bys year: egen ln_pop_bar = mean(ln_pop)
xtset id year
eststo: xtpmg d.def_rate d.ln_gdp d.ln_gdp2 d.ln_agr d.ln_pop d.ln_trade, ///
lr(l.def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade) mg replace
restore
* Middle-Income Economies, ARDL (1,1,1,1,1,1)
preserve
drop if country == "Myanmar"
drop if country == "Serbia"
keep if inc_lev == 2 | inc_lev == 3
xtset year id
bys year: egen def_rate_bar = mean(def_rate)
bys year: egen ln_gdp_bar = mean(ln_gdp)
bys year: egen ln_gdp2_bar = mean(ln_gdp2)
bys year: egen ln_gdp3_bar = mean(ln_gdp3)
bys year: egen ln_agr_bar = mean(ln_agr)
bys year: egen ln_pop_bar = mean(ln_pop)
xtset id year
eststo: xtpmg d.def_rate d.ln_gdp d.ln_gdp2 d.ln_agr d.ln_pop d.ln_trade, ///
lr(l.def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade) mg replace
restore
* High-Income Economies, ARDL (1,1,1,1,1,1)
preserve
keep if inc_lev == 1
xtset year id
bys year: egen def_rate_bar = mean(def_rate)
bys year: egen ln_gdp_bar = mean(ln_gdp)
bys year: egen ln_gdp2_bar = mean(ln_gdp2)
bys year: egen ln_gdp3_bar = mean(ln_gdp3)
bys year: egen ln_agr_bar = mean(ln_agr)
bys year: egen ln_pop_bar = mean(ln_pop)
xtset id year
eststo: xtpmg d.def_rate d.ln_gdp d.ln_gdp2 d.ln_agr d.ln_pop d.ln_trade, ///
lr(l.def_rate ln_gdp ln_gdp2 ln_agr ln_pop ln_trade) mg replace
restore
* Tabulation
esttab, label se(3) star(* 0.1 ** 0.05 *** 0.01) ///
title(EKC for deforestation (PMG with cross-sectional means)) ///
nonumbers mtitles ("Low""Middle""High")
eststo clear

*==============
* Scatter Plot
*==============

* Generate models' coordinates
preserve
keep if year == 2015
gen for_land = for / land
label var for_land "Forest Area (% Land)"
* Model 1
scalar tp1 = log(200)
display tp1
scalar model1 = 0.0123*(tp1) -0.00116*(tp1^2) -0.0197
display model1
gen y_model1 = 0.075
gen x_model1 = tp1
gen model1 = "Model 1: US$ 200"
* Model 2
scalar tp2 = log(796.32)
display tp2
scalar model2 = 0.00962*(tp4) -0.00072*(tp4^2) -0.0195
display model2
gen y_model2 = 0.075
gen x_model2 = tp2
gen model2 = "Model 2: US$ 796"
* Model 3
scalar tp3 = log(3789.54)
display tp3
scalar model3 = 0.0272*(tp8) -0.000165*(tp8^2) -0.0966
display model3
gen y_model3 = 0.075
gen x_model3 = tp3
gen model3c= "Model 3: US$ 3,790"
* Regions
gen reg = 1 if region == 1
replace reg = 2 if region == 2 | region == 3
replace reg = 3 if region == 4
replace reg = 4 if region == 5 | region == 6
* Scatter plot
twoway (lowess def_rate ln_gdp, bwidth(0.5) lcolor(red)) ///
(scatter def_rate ln_gdp if reg == 1 [w = for_land], msize(tiny) mcolor("130 112 87") msymbol(circle) mfcolor(%70) mlcolor(%0)) ///
(scatter def_rate ln_gdp if reg == 2 [w = for_land], msize(tiny) mcolor(midgreen) msymbol(circle) mfcolor(%70) mlcolor(%0)) ///
(scatter def_rate ln_gdp if reg == 3 [w = for_land], msize(tiny) mcolor("232 180 11") msymbol(circle) mfcolor(%70) mlcolor(%0)) ///
(scatter def_rate ln_gdp if reg == 4 [w = for_land], msize(tiny) mcolor("54 147 193") msymbol(circle) mfcolor(%70) mlcolor(%0)) ///
(scatter def_rate ln_gdp if reg == 1, msymbol(none) mlabel(id) mlabsize(tiny) mlabcolor("66 54 37") mfcolor(%70) mlcolor(%0) mlabposition(1)) ///
(scatter def_rate ln_gdp if reg == 2, msymbol(none) mlabel(id) mlabsize(tiny) mlabcolor("27 132 6") mfcolor(%70) mlcolor(%0) mlabposition(1)) ///
(scatter def_rate ln_gdp if reg == 3, msymbol(none) mlabel(id) mlabsize(tiny) mlabcolor(dkorange) mfcolor(%70) mlcolor(%0) mlabposition(1)) ///
(scatter def_rate ln_gdp if reg == 4, msymbol(none) mlabel(id) mlabsize(tiny) mlabcolor(navy) mfcolor(%70) mlcolor(%0) mlabposition(4)) ///
(scatter y_model1 x_model1 if _n == 1, mcolor("65 193 244") mlcolor(%0) msize(small) msymbol(none) mlabel(model1) mlabsize(vsmall) mlabcolor(black) mlabposition(5)) ///
(scatter y_model2 x_model2 if _n == 1, mcolor("65 193 244") mlcolor(%0) msize(small) msymbol(none) mlabel(model2) mlabsize(vsmall) mlabcolor(black) mlabposition(5)) ///
(scatter y_model3 x_model3 if _n == 1, mcolor("65 193 244") mlcolor(%0) msize(small) msymbol(none) mlabel(model3) mlabsize(vsmall) mlabcolor(black) mlabposition(5)) ///
, ///
xline(5.29, lcolor(black%50) lpattern(shortdash) lwidth(vthin)) ///
xline(6.68, lcolor(black%50) lpattern(shortdash) lwidth(vthin)) ///
xline(8.24, lcolor(black%50) lpattern(shortdash) lwidth(vthin)) ///
ytitle("2015 Total Forest Deforestation Rates", size(vsmall)) ///
ylabel(-0.05(0.025)0.075, labsize(small) tlength(vsmall)) ///
xtitle("2015 GDP per capita (constant US$ 2010) (ln)", size(vsmall)) ///
xlabel(5(1)12, labsize(small) tlength(vsmall) grid) ///
legend(order(1 "LOWESS" 2 "Africa" 3 "Asia and Oceania" 4 "Latin America" 5 "Europe and North America") ///
rows(2) rowgap(minuscule) colgap(minuscule) size(vsmall)) ///
scheme(s2mono)

expand 4
sort id reg
replace def_rate =. if mod(_n,4) > 0
recode reg (1=2) (2=3) (3=4) (4=1) if mod(_n,4) == 1
recode reg (1=3) (2=4) (3=1) (4=2) if mod(_n,4) == 2
recode reg (1=4) (2=1) (3=2) (4=3) if mod(_n,4) == 3

twoway (lowess def_rate ln_gdp, bwidth(0.5) lcolor(red)) ///
(scatter def_rate ln_gdp if reg == 1 [w = for_land], msize(tiny) mcolor("130 112 87") msymbol(circle) mfcolor(%70) mlcolor(%0)) ///
(scatter def_rate ln_gdp if reg == 2 [w = for_land], msize(tiny) mcolor(midgreen) msymbol(circle) mfcolor(%70) mlcolor(%0)) ///
(scatter def_rate ln_gdp if reg == 3 [w = for_land], msize(tiny) mcolor("232 180 11") msymbol(circle) mfcolor(%70) mlcolor(%0)) ///
(scatter def_rate ln_gdp if reg == 4 [w = for_land], msize(tiny) mcolor("54 147 193") msymbol(circle) mfcolor(%70) mlcolor(%0)) ///
(scatter def_rate ln_gdp if reg == 1, msymbol(none) mlabel(id) mlabsize(tiny) mlabcolor("66 54 37") mfcolor(%70) mlcolor(%0) mlabposition(5)) ///
(scatter def_rate ln_gdp if reg == 2, msymbol(none) mlabel(id) mlabsize(tiny) mlabcolor("27 132 6") mfcolor(%70) mlcolor(%0) mlabposition(1)) ///
(scatter def_rate ln_gdp if reg == 3, msymbol(none) mlabel(id) mlabsize(tiny) mlabcolor(dkorange) mfcolor(%70) mlcolor(%0) mlabposition(1)) ///
(scatter def_rate ln_gdp if reg == 4, msymbol(none) mlabel(id) mlabsize(tiny) mlabcolor(navy) mfcolor(%70) mlcolor(%0) mlabposition(4)) ///
(scatter y_model1 x_model1 if _n == 1, mcolor("65 193 244") mlcolor(%0) msize(small) msymbol(none) mlabel(model1) mlabsize(vsmall) mlabcolor(black) mlabposition(5)) ///
(scatter y_model2 x_model2 if _n == 1, mcolor("65 193 244") mlcolor(%0) msize(small) msymbol(none) mlabel(model2) mlabsize(vsmall) mlabcolor(black) mlabposition(5)) ///
(scatter y_model3 x_model3 if _n == 1, mcolor("65 193 244") mlcolor(%0) msize(small) msymbol(none) mlabel(model3) mlabsize(vsmall) mlabcolor(black) mlabposition(5)) ///
, ///
xline(5.29, lcolor(black%50) lpattern(shortdash) lwidth(vthin)) ///
xline(6.68, lcolor(black%50) lpattern(shortdash) lwidth(vthin)) ///
xline(8.24, lcolor(black%50) lpattern(shortdash) lwidth(vthin)) ///
ytitle("2015 Total Forest Deforestation Rates", size(vsmall)) ///
ylabel(-0.05(0.025)0.075, labsize(small) tlength(vsmall)) ///
xtitle("2015 GDP per capita (constant US$ 2010) (ln)", size(vsmall)) ///
xlabel(5(1)12, labsize(small) tlength(vsmall) grid) ///
legend(order(1 "LOWESS" 2 "Africa" 3 "Asia and Oceania" 4 "Latin America" 5 "Europe and North America") ///
rows(2) rowgap(minuscule) colgap(minuscule) size(vsmall)) ///
scheme(s2mono)
graph export "C:\Users\Nicola Caravaggio\OneDrive\Desktop\Paper EKCd\Stuff\Figs\def_rate_2015_TPs.pdf", as(pdf) replace
graph export "C:\Users\Nicola Caravaggio\OneDrive\Desktop\Paper EKCd\Stuff\Figs\def_rate_2015_TPs.png", as(png) replace
restore
