![StataMin](https://img.shields.io/badge/stata-2017-blue) ![issues](https://img.shields.io/github/issues/JakobWegmann/wtcalc) ![license](https://img.shields.io/github/license/JakobWegmann/wtcalc) ![Stars](https://img.shields.io/github/stars/JakobWegmann/wtcalc) ![version](https://img.shields.io/github/v/release/JakobWegmann/wtcalc) ![release](https://img.shields.io/github/release-date/JakobWegmann/wtcalc)


[Project](#project) | [Usage](#usage) | [Examples](#examples) | [Tests](#tests) | [Special thanks](#special-thanks) | [Feedback](#feedback) 

---




# wtcalc
(30 Oct 2024)

## Project

The repository includes code to calculate for Germany
* Withholding taxes for all 7 withholding tax classes (2005 to 2024)
* Unemployment benefits (2005 to 2024)
* Short time work allowances (2005 to 2024)
* Parental leave benefits (2007 to 2024)


Notes: 
* The calculation is in Stata, so the code can be used in the protected work environments of the [statistical administrative office](https://www.forschungsdatenzentrum.de/en), the [IAB](https://fdz.iab.de/en/startseite-en/) or the [FDZ-RV](https://www.eservice-drv.de/FdzPortalWeb/).
* As far as official test data is available, the code is thoroughly tested to match exactly the official tabulations. The test data and test routines are part of the repository.
* The naming of the functions follows, as far as possible, the naming conventions of the [calculation guide](https://www.bundesfinanzministerium.de/Web/DE/Themen/Steuern/Steuerarten/Lohnsteuer/Programmablaufplan/programmablaufplan.html) provided by the ministry of finance, so they are not self-explanatory. Variable labels always explain the underlying concepts. 
* All calculations follow the exact rounding rules so that the results can be compared to official tabulations. By law, not only the final result is rounded but there are also many rounding steps in previous steps of the calculation. Therefore, calculation marginal incentives requires some caution.
* For the calculation if withholding taxes, severance payments and the reduced rate for individuals older than 64 (§ 24a EStG) are not implemented.
* For parental leave benefits, the calculation for lower incomes is imprecise as the rules for Mini- and Midijobs is not implemented.


## Usage

To run the calculations, two do-files are necessary:
* `program_tax_calculator.do` includes all programs
* `year_dependendent_vars_for_tax_calculator.do` includes the yearly policy variables as globals. The file is automatically created by `import_year_dependent_vars.do` which translates the tabulated information included in the excel file `globals_for_tax_system.xlsx` into a do file.

### Withholding tax calculator

The core function is `LST` which yields as an output the withholding taxes in the respective year. 

Additional programs provide further functionalities, in particular helpful are:

* `eink_steur`: Returning income taxes as well as the induced factors for IV with factors
* `all_taxes`: Returning the output from `eink_steur` and the induced taxes for all possible withhold tax classes for married individuals
* `sozialversicherung`: Returning the social security contributions of a regular employed

### Wage replacements

* `unemp_benefit`: Calculates unemployment benefits ("Arbeitslosengeld I") on a daily basis
* `parental_benefit`: Calculates parental leave benefits on a monthly basis
* `short_time_allowance`: Calculates short time work allowances on a monthly basis


## Examples

The code is written to directly calculate taxes with inputs provided in a data set. For example, the German Taxpayer Panel includes all information as separate variables. Therefore, to illustrate the functionality of the calculator, the examples create sample data sets with one household. Typically, the required input variables would be obtained from the real data.

### Calculation of withholding taxes

```stata
* Definition of input parameters
clear
set obs 1
gen inc_partner_a = 60000
gen inc_partner_b = 20000
gen jahr = 2023
la var jahr "Year"
gen ost = 0
label variable ost "Indicator for Eastern Germany"
gen zkf = 0
label variable zkf "Number of children"    
gen r = 1
label variable r "Individual pays church taxes"     
gen pvz = 0
label variable pvz "Additional contribution to compulsory long-term care insurance (due to age/child)"
gen kvz = 0
label variable kvz "Additional contribution to compulsory health care insurance"
gen priv_ins_pen = 0 
la var priv_ins_pen "Private pension insurance"
gen priv_ins_health = 0 
la var priv_ins_health "Indicator for being privately insured"
gen ind_priv_ins_health_emp_supp = 0
la var ind_priv_ins_health_emp_supp ///
    "Indicator if employer contributes to privat health insurance"
gen pkpv = 0
la var pkpv "Money spend on private health insurance"
gen pvs = 0
la var pvs ///
    "Indicator if obs is in Saxony (relevant for health insurance)"
gen lzzfreib = 0
la var lzzfreib "Allowance wothholding tax"
gen lzzhinzu = 0
la var lzzhinzu "Additional amoung withholding tax"

* Get current directory
global dir `c(pwd)'

* Load programs and parameters
do ${dir}/code/year_dependendent_vars_for_tax_calculator.do
do ${dir}/code/program_tax_calculator.do

* Calculate all taxes
all_taxes  
```

The returned outputs are for both partners
* Withholding tax without Solidaritätszuschlag in cents for each possible withholding tax class for married individuals
* Withheld Solidaritätszuschlag (a surtax) in cents for each possible withholding tax class for married individuals

and for the couple
* The induced factor for IV with factor
* Income tax without Solidaritätszuschlag
* Solidaritätszuschlag

This is not efficient, if you are only interested in one specific (withholding) tax. For example, if you want to know the withholding tax for an individual in withholding tax class 1, the following code is faster:

```stata
* Definition of input parameters

clear
set obs 1
gen re4 = 30000 * 100
la var re4 "Yearly gross income in cents"
gen jahr = 2023
la var jahr "Year"
gen stkl = 1
la var stkl "Withholding tax class"
gen lzz = 1
la var lzz "Level of input and putput data: 1 year, 2 month, 3 week, 4 day"
gen ost = 0
la var ost "Indicator for Eastern Germany"
gen zkf = 2
la var zkf "Number of children"
gen r = 0
la var r "Individual pays church taxes"     
gen pvz = 0
la var pvz "Additional contribution to compulsory long-term care insurance (due to age/child)"
gen kvz = 0
la var kvz "Additional contribution to compulsory health care insurance"
gen priv_ins_pen = 0 
la var priv_ins_pen "Private pension insurance"
gen priv_ins_health = 0
la var priv_ins_health "Indicator for being privately insured"
gen ind_priv_ins_health_emp_supp = 0
la var ind_priv_ins_health_emp_supp ///
    "Indicator if employer contributes to private health insurance"
    gen pkpv = 0
la var pkpv "Money spend on private health insurance"
gen pvs = 0
la var pvs ///
    "Indicator if obs is in Saxony (relevant for compulsory health insurance)"
    gen lzzfreib = 0
la var lzzfreib "Allowance wothholding tax"
gen lzzhinzu = 0
la var lzzhinzu "Additional amoung withholding tax"
gen af = 1
la var af "Indicator for IV with Faktor"
gen f = 1
la var f "Faktor for IV with Faktor"

* Get current directory
global dir `c(pwd)'

* Load programs and parameters
do ${dir}/program_tax_calculator.do
do ${dir}/year_dependendent_vars_for_tax_calculator.do

* Calculate withholding taxes
LST
```


### Calculation of wage replacement

For wage replacements, most of the input variables are defined by law so that less input is required. For example, unemployment benefit does only depend on the reference income ("Bruttoentgelt"), the withholding tax class and an indicator whether a child lives in the household. So the following code suffices:

```stata
clear 
set obs 1
gen bruttoentgelt = 30 //typically the daily income before unemployment
gen lzz = 4
la var lzz "Level of input and putput data: 1 year, 2 month, 3 week, 4 day"
gen jahr = 2021
label variable jahr "Year"

* Get current directory
global dir `c(pwd)'

* Load programs and parameters
do ${dir}/program_tax_calculator.do
do ${dir}/year_dependendent_vars_for_tax_calculator.do

unemp_benefit,stkl(3) has_child("Yes")
```

## Tests

[Julian Budde](https://github.com/buddejul) programmed the excellent `stata_test` that allows, similar to [pytest](https://docs.pytest.org/en/stable/), to systematically test code. The core idea is that the user provides for various inputs the expected outputs, so that an error is raised when the calculated output is not equal to the expected output. 


Transfer the ado files `stata_test.ado`, `stata_test_collect.ado` and `stata_test_drop.ado` to your ado folder. 

Then with 

```stata
global dir `c(pwd)'
stata_test, dir(${dir}/code/tests) 
```

all tests are run and it is ensured that the calculation of withholding taxes and short-time work is correct for all years that test data is available.

For unemployment benefits and parental leave benefits no official test data is available. However, the calculation of unemployment benefits was excessively tested on admin data. 

## Special thanks

Lenard Simon and Tim Bayer for extensive help. Julian Budde for the excellent program `stata_test`.

## Feedback

Please write an email to jakob.wegmann@uni-bonn.de or open an issue for questions, errors, missing features,...
