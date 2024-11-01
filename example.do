
* get current directory
global dir `c(pwd)'


* Definition of input parameters
clear
set obs 1
gen inc_partner_a = 60000
gen inc_partner_b = 20000

gen jahr = 2023
la var jahr "Year"

gen ost = 0
label variable ost "Living in eastern or western germany"
gen zkf = 0
label variable zkf "Number of eligible children"    
gen r = 1
label variable r "Kirchenzugehörigkeit"     
gen pvz = 0
label variable pvz "Zuschlag zur sozialen Pflegeversicherung"
gen kvz = 0
label variable kvz "Kassenindividuelle Zusatzbeitrag"
gen priv_ins_pen = 0 
la var priv_ins_pen "Private pension insurance"
gen priv_ins_health = 0 
la var priv_ins_health "Private health insurance"
gen ind_priv_ins_health_emp_supp = 0
la var ind_priv_ins_health_emp_supp ///
    "Indicator if employer contributes to privat health insurance"
gen pkpv = 0
la var pkpv "Money spend on private health insurance"
gen pvs = 0
la var pvs ///
    "Indicator if obs is in Saxony (relevant for health insurance)"
gen lzzfreib = 0
la var lzzfreib "Freibetrag Lohnsteuer"
gen lzzhinzu = 0
la var lzzhinzu "Hinzurechnungsbetrag Lohnsteuer"

do ${dir}/code/year_dependendent_vars_for_tax_calculator.do
do ${dir}/code/program_tax_calculator.do

* Calculate all taxes
all_taxes  
