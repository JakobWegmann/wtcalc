/* Tests for Tax calculator. 
Apply tests with: 

global dir `c(pwd)'
stata_test, dir(${dir}/code/tests)

*/


cap mkdir ${dir}/code/tests/temp_testing

clear all

do ${dir}/code/program_tax_calculator.do


***************************** Tests ********************************************


***************************** Compare with data provided by Finanzamt
* 2024 April not working because of KVZ (source of mistake unknown)

program stata_test_1, rclass
    return local description "Check with test data by Finanzministerium"    

    local failure = 0

    do ${dir}/code/program_tax_calculator.do

    forvalues jahr = 2023/2023 {
        // Load data from Finanzamt
        #delimit;
        import excel using
             "${dir}/data/test_data/Testfälle2010_to_2024.xls" 
            , clear cellrange(A10) sheet(`jahr') firstrow;
        #delimit cr;

        /* Rename and Recode variables so they are easier to understand and
           comparable to own calculation */
        rename *, lower 

        * Lohnzahlnugszeitraum
        label define lohnzahlungszeitraum 1 "Jahr" 2 "Monat" 3 "Woche" 4 "Tag"
        label values lzz lohnzahlungszeitraum

        * Pensions
        * krv is 0 when public insured in west, 1 when public insured in east
        * and 2 when privately insured (then west/east is irrelevant)
        gen ost = .
        replace ost = 0 if krv == 0
        replace ost = 1 if krv == 1
        la var ost ///
            "Indicator if east or west (relevant for assessment limit public pension)"
        gen priv_ins_pen = krv == 2
        la var priv_ins_pen "Private pension insurance" 

        * Private health insurance (Kranken- und Pfelgeversicherung)
        gen priv_ins_health = inlist(pkv,1,2)
        la var priv_ins_health "Indicator for being privately insured"
        gen ind_priv_ins_health_emp_supp = pkv == 2
        la var ind_priv_ins_health_emp_supp ///
            "Indicator for employer support for private insurance"
        la var pkpv ///
            "Money spend on private health insurance"
        drop pkv

        // Keep only cases covered by program
        // cap drop if pkpv != 0 // Beiträge private Kranken- oder Pflegeversicherung
        // cap drop if pkv != 0 // Only keep gesetzlich Versicherte
        // keep if inrange(stkl,1,6) 
        cap drop if ajahr == 1 // Individual is 65  /!\ Can it be dropped as a restriction?
        cap drop if alter1 == 1 // Individual is 65
        cap drop if entsch != 0 // Entschädigungen
        cap drop if jfreib != 0 // Jahresfreibetrag
        cap drop if jhinzu != 0 // Jahreshinzurechungsbetrag
        cap drop if jre4 != 0 // Sonstige Bezüge
        cap drop if jre4ent != 0 // Entschädigungen in Sonstige Bezüge
        cap drop if jvbez != 0 // Versorgungsbezüge in Sonstige Bezüge
        // cap drop if lzzfreib != 0 //Lohnsteuerabzugsmerkmal Freibetrag
        // cap drop if lzzhinzu != 0 //Lohnsteuerabzugsmerkmal Hinzurechnungsbetrag
        // cap drop if pvs == 1 // Ignore Sachsen
        cap drop if sonstb != 0 // Sonstige Bezüge
        cap drop if sonstent != 0 // Entschädigungen in Sonstige Bezüge
        cap drop if sterbe != 0 // Sterbegeld bei Versorungsbezügen
        cap drop if vbez != 0 // Versorgungsbezüge
        cap drop if vbezm != 0 // Versorgungsbezüge
        cap drop if vbezs != 0 // Versorgungsbezüge
        cap drop if vbs != 0 // Versorgungsbezüge
        cap drop if vkapa != 0 // Versorgungsbezüge
        cap drop if vmt != 0 // Versorgungsbezüge
        cap drop if zmvb != 0 // Versorgungsbezüge


        * Rename outcome variables from Finanzamt suffix t to signal that 
        * those variables are not calculated in the tax calculator 
        local input_variables lzz re4 ost zkf stkl r pvz kvz af f ///
            priv_ins_pen priv_ins_health ind_priv_ins_health_emp_supp ///
            pkpv pvs lzzfreib lzzhinzu

        ds
        local all_variables = r(varlist)
        local variables_to_compare: list all_variables - input_variables
        disp "`variables_to_compare'"

        foreach var of varlist `variables_to_compare'{
            rename `var' `var'_t
        }

        * Apply own program to the data set
        order lzz re4 ost zkf stkl r pvz

        disp `jahr'
        gen jahr = `jahr'
        do ${dir}/code/year_dependendent_vars_for_tax_calculator.do

        * kvz introduced in 2014
        capture confirm variable kvz
        if !_rc {
                di in red "kvz exists"
           }
           else {
                gen kvz = .
           }

        * Calculate taxes
        LST

        local output_variables lstlzz solzlzz bk 

        gen wrong = !inrange(lstlzz_t - lstlzz, -200, 200)
        sort wrong stkl re4

        order wrong lzz re4 lstlzz_t lstlzz ///
            solzlzz_t solzlzz bk_t bk /*vkvlzz_t vkvlzz*/

        * Exact to one euro (vkvlzz is in euro, but consciously ignored as 
        * these are not informative test cases)
        foreach var of varlist `output_variables'{
            cap assert inrange(`var'_t - `var',-200,200)
            if _rc != 0 local failure = 1
        }
    }
    
    cap assert `failure' == 0
    return scalar result = _rc

end




****************** Prüftabelle Allgemeine Lohnsteuer 
* 2013 and 2017 is not available on the BMF homepage. 
* 2015 does not work, mistake is not identifiable

program stata_test_2, rclass
    return local description ///
        "Check with Prüftabelle Allgemeine Lohnsteuer from Programmablaufplan"    

    // Call do File with input values
    do ${dir}/code/program_tax_calculator.do

    local failure = 0

    foreach jahr of numlist 2005/2012 2014 2016 2018/2023  {

        // Load data from Finanzamt
        #delimit;
        import excel using
             "${dir}/data/test_data/prueftabelle_allgemeine_lohnsteuer.xlsx" 
            , clear sheet(`jahr') firstrow;
        #delimit cr;
            

        rename Jahresbruttolohn bruttolohn_y
        
        * Dealing with converting errors in Excel
        if inrange(`jahr',2004,2007) | inlist(`jahr',2010) | inrange(`jahr',2011,2024) {
            replace bruttolohn_y = bruttolohn_y * 1000 
        }


        rename I stkl_1
        rename II stkl_2
        rename III stkl_3
        rename IV stkl_4
        rename V stkl_5
        rename VI stkl_6


        local steuerklassen 1 2 3 4 5 6
        foreach stkl of local steuerklassen{
            replace stkl_`stkl' = stkl_`stkl' * 1000 ///
                 if mod(stkl_`stkl',1) > 0
        }

        greshape long stkl_, i(bruttolohn_y) j(stkl)
        rename stkl_ lstlzz_t
        la var lstlzz_t "Tax as in official tabulation"

        gen lzz = 1
        label variable lzz "Berechnungszeitraum"
        gen jahr = `jahr'
        gen zkf = 0
        label variable zkf "Number of eligible children"    

        gen r = 0
        label variable r "Kirchenzugehörigkeit"     

        gen ost = 0
        label variable ost "Living in eastern or western germany"

        *Zuschlag für Kinderlose zur Pflegeversicherung not for stkl == 2
        gen pvz = 1
        replace pvz = 0 if stkl == 2

        gen af = 1
        la var af "Indicator for IV with Faktor"
        gen f = 1
        la var f "Faktor for IV with Faktor"

        gen priv_ins_pen = 0 
        la var priv_ins_pen "Private pension insurance"

        gen priv_ins_health = 0 
        la var priv_ins_pen "Private health insurance"

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

        quietly: do ${dir}/code/year_dependendent_vars_for_tax_calculator.do
        
        gen kvz = 0
        replace kvz = durchschn_zusatzbeitrag if inrange(jahr,2016,2024)
        label variable kvz "Kassenindividuelle Zusatzbeitrag"
        gen re4 = bruttolohn_y * 100
        
        LST

        gen lstlzz_in_eur = lstlzz / 100 
        gen wrong = !inrange(lstlzz_t - lstlzz_in_eur, -2, 2)
        sort wrong stkl bruttolohn_y
        order wrong bruttolohn_y stkl lstlzz_t lstlzz_in_eur

        cap assert inrange(lstlzz_t - lstlzz_in_eur, -2, 2)
        if _rc != 0 local failure = 1
        disp `failure'   
        
        }
    
    cap assert `failure' == 0
    return scalar result = _rc

end




****************** Prüftabelle Besondere Lohnsteuer
* Before 2009 for Stkl3 estimation is at low incomes 10€ off. Therefore,
* the threshold is set higher. Apart from this mistake, the calculation is
* never off by more than 1€
* 2024 April not working because of KVZ (source of mistake unknown)

program stata_test_3, rclass
    return local description ///
        "Check with Prüftabelle Besondere Lohnsteuer from Programmablaufplan"

    /* Beamte, therefore KRV == 2 and PKV == 1 */

    do ${dir}/code/program_tax_calculator.do

    local failure = 0

    foreach jahr of numlist 2005/2012 2014 2016 2018/2023  {

        // Load data from Finanzamt
        #delimit;
        import excel using
             "${dir}/data/test_data/prueftabelle_besondere_lohnsteuer.xlsx" 
            , clear sheet(`jahr') firstrow;
        #delimit cr;
            
        rename Jahresbruttolohn bruttolohn_y
        
        * Dealing with converting errors in Excel
        if inrange(`jahr',2004,2009) | inlist(`jahr',2010) | inrange(`jahr',2011,2024) {
            replace bruttolohn_y = bruttolohn_y * 1000 
        }

        rename I stkl_1
        rename II stkl_2
        rename III stkl_3
        rename IV stkl_4
        rename V stkl_5
        rename VI stkl_6

        local steuerklassen 1 2 3 4 5 6
        foreach stkl of local steuerklassen{
            replace stkl_`stkl' = stkl_`stkl' * 1000 ///
                 if mod(stkl_`stkl',1) > 0
        }

        greshape long stkl_, i(bruttolohn_y) j(stkl)
        rename stkl_ lstlzz_t
        la var lstlzz_t "Tax as in official tabulation"

        gen lzz = 1
        label variable lzz "Berechnungszeitraum"
        gen jahr = `jahr'
        gen zkf = 0
        label variable zkf "Number of eligible children"    


        gen r = 0
        label variable r "Kirchenzugehörigkeit"     

        gen ost = 0
        label variable ost "Living in eastern or western germany"

        *Zuschlag für Kinderlose zur Pflegeversicherung not for stkl == 2
        gen pvz = 1
        replace pvz = 0 if stkl == 2

        gen af = 1
        la var af "Indicator for IV with Faktor"
        gen f = 1
        la var f "Faktor for IV with Faktor"

        gen priv_ins_pen = 1 
        la var priv_ins_pen "Private pension insurance"

        gen priv_ins_health = 1 
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
        
        gen kvz = 0
        replace kvz = durchschn_zusatzbeitrag if inrange(jahr,2016,2024)
        label variable kvz "Kassenindividuelle Zusatzbeitrag"
        gen re4 = bruttolohn_y * 100
        
        LST

        gen lstlzz_in_eur = lstlzz / 100
        gen wrong = !inrange(lstlzz_t - lstlzz_in_eur, -10, 10)
        sort wrong stkl bruttolohn_y
        order wrong bruttolohn_y stkl lstlzz_t lstlzz_in_eur

        cap assert inrange(lstlzz_t - lstlzz_in_eur, -10, 10)
        if _rc != 0 local failure = 1
        disp `failure'   
        
        }
    
    cap assert `failure' == 0
    return scalar result = _rc

end



  


***************************** Compare for a single value
program stata_test_4, rclass
    return local description "Compare for one specific value (2021)"    

    clear
    set obs 1
    gen bruttolohn_y = 90071
    gen re4 = bruttolohn_y * 100

    gen lzz = 1
    label variable lzz "Berechnungszeitraum"

    gen ost = 1
    label variable ost "Living in eastern or western germany"
    gen zkf = 0
    label variable zkf "Number of eligible children"    
    gen stkl = 5
    label variable stkl "Lohnsteuerklasse"  
    gen r = 1
    label variable r "Kirchenzugehörigkeit"     
    gen pvz = 0
    label variable pvz "Zuschlag zur sozialen Pflegeversicherung"
    gen kvz = 1.2
    label variable kvz "Kassenindividuelle Zusatzbeitrag"
    gen af = 0
    la var af "Indicator for IV with Faktor"
    gen f = 1
    la var f "Faktor for IV with Faktor"
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
    gen jahr = 2021
    do ${dir}/code/year_dependendent_vars_for_tax_calculator.do

    * Load parameters
    // MPARA
    * Calculate taxes
    // MBERECH
    LST             

    order bruttolohn_y lstlzz ///
        solzlzz bk 

    local failure = 0
    disp `failure'
    * Lohnsteuer
    cap assert inrange(29029 * 100 - lstlzz,-0.1,0.1)
    if _rc != 0 local failure = 1
    disp `failure'

    * Soli
    cap assert inrange(1436.687 * 100 - solzlzz,-0.1,0.1)
    if _rc != 0 local failure = 1
    disp `failure'

    * Bemessungsgrundlage Kirchensteuer
    cap assert inrange(29029 * 100 - bk,-0.1,0.1)
    if _rc != 0 local failure = 1
    disp `failure'

    cap assert `failure' == 0
    return scalar result = _rc
end



***************************** Repeated function calling
program stata_test_5, rclass
    return local description ///
        "Test for robustness of results to repeated function calling."

    /*
    General test whether results differ when function was previously 
    called with another Lstkl. Basically tests whether for some Lstkl 
    some variables are internally overwritten/deleted.    
    */

    local failure = 0

    forvalues year = 2005/2023{

        foreach stkl_first of num 1/5 {

            clear
            set obs 1
            gen re4 = 1000
            replace re4 = re4 * 100 //re4 is in cents

            gen lzz = 1
            label variable lzz "Berechnungszeitraum"
            gen ost = 0
            label variable ost "Living in eastern or western germany"
            gen zkf = 0
            label variable zkf "Number of eligible children"
            gen stkl = `stkl_first'
            label variable stkl "Lohnsteuerklasse"
            gen r = 0
            label variable r "Kirchenzugehörigkeit"

            gen pvz = 0
            label variable pvz "Zuschlag zur sozialen Pflegeversicherung"
            gen kvz = 1.1
            label variable kvz "Kassenindividuelle Zusatzbeitrag"
            gen af = 0
            la var af "Indicator for IV with Faktor"
            gen f = 1
            la var f "Faktor for IV with Faktor"
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
            gen jahr = `year'
            do ${dir}/code/year_dependendent_vars_for_tax_calculator.do

            * Calculate taxes
            LST
            drop lstlzz solzlzz bk vsp ztabfb

            ds
            global all_vars  `r(varlist)'

            tempfile stkl_`stkl_first'
            save `stkl_`stkl_first''


            foreach stkl_second of num 1/5 {

                preserve
                replace stkl = `stkl_second'

                LST

                drop lstlzz solzlzz bk vsp ztabfb


                replace stkl = `stkl_first'

                LST

                tempfile stkl_`stkl_first'`stkl_second'
                save `stkl_`stkl_first'`stkl_second''


                rename * *_`stkl_first'`stkl_second'
                rename re4_`stkl_first'`stkl_second' re4

                merge 1:1 re4 using `stkl_`stkl_first''

                gen re4_`stkl_first'`stkl_second' = re4

                foreach var in $all_vars {
                    cap assert `var' == `var'_`stkl_first'`stkl_second'            
                    if _rc != 0 local failure = 1
                    disp `failure'        
                }

                restore
            }
        }
    }
    
    cap assert `failure' == 0
    return scalar result = _rc
end





***************************** Compare with own excessively tested data
program stata_test_6, rclass
    return local description "Check with own excessively tested data (2021)"    

    * Calculate Lohnsteuer for every possible combination of dependend variables
    clear
    set obs 200
    gen bruttolohn_y = 0 + _n * 1000
    gen re4 = bruttolohn_y * 100
    gen jahr = 2021
    // Call do File with input values
    do ${dir}/code/year_dependendent_vars_for_tax_calculator.do
    do ${dir}/code/program_tax_calculator.do
    label variable re4 "Bruttolohn (yearly)"

    forvalues ost = 0/1 {

        forvalues children = 0/3 {    

            foreach steuerklasse in 3 4 5 {

                forvalues kirche = 0/1 {

                    preserve
                    gen lzz = 1
                    label variable lzz "Berechnungszeitraum"

                    gen ost = `ost'
                    label variable ost "Living in eastern or western germany"
                    gen zkf = `children'
                    label variable zkf "Number of eligible children"    
                    gen stkl = `steuerklasse'
                    label variable stkl "Lohnsteuerklasse"  
                    gen r = `kirche'
                    label variable r "Kirchenzugehörigkeit"     
                    gen pvz = 0
                    replace pvz = 1 if zkf == 0
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
                    gen af = 1
                    la var af "Indicator for IV with Faktor"
                    gen f = 1
                    la var f "Faktor for IV with Faktor"

                    * Load parameters
                    // MPARA
                    * Calculate taxes
                    // MBERECH
                    LST
                    * Drop Fixed Parameters
                    // #delimit; 
                    // drop anp sap min_vrsrge_pausch soli_satz mindest_soli
                    //  mindest_lst_w1stlk5 lst_w1stlk5_rate lst_w2stlk5_rate
                    //  lst_w3stlk5_rate bbgrv bbgkvpv kvsatzan pvsatzan
                    //  pvsatzag rvsatzan w1stlk5 w2stlk5 w3stlk5 tbsorv solzfrei;
                    // #delimit cr

                    save "${dir}/data/test_data/east`ost'_child`children'_stkl`steuerklasse'_kirche`kirche'_year2021.dta" ///
                        , replace
                     restore
                }  
            }       
        }   
    } 


    local failure = 0
    * Compare with own excessively tested data
    forvalues ost = 0/1 {

        forvalues children = 0/3 {    

            foreach steuerklasse in 3 4 5 {

                forvalues kirche = 0/1 {

                    use "${dir}/data/test_data/east`ost'_child`children'_stkl`steuerklasse'_kirche`kirche'_year2021.dta", clear
                    // Save list of all variables that should be compared to the data
                    // set with the true values
                    ds
                    // local all_variables = r(varlist)
                    // local not_calculated  bruttolohn_y pvz kvz efa lstlzz 
                    // local all_calculated_variables:list all_variables /// 
                    //     - not_calculated
                    rename bruttolohn_y bruttolohn_y_true
                    // True data is data that was extensively checked
                    merge 1:1 bruttolohn_y_true using ///
                        ${dir}/data/test_data/east`ost'_child`children'_stkl`steuerklasse'_kirche`kirche'_true.dta
                    rename st_true lstlzz_true // when data was generated, variable had different name

                    disp "ost `ost' children `children' steuerklasse `steuerklasse' kirche `kirche'"


                    local output_variables lstlzz solzlzz bk
                    // foreach var of local output_variables {
             
                    //     gen jw = solzj * 100
                    //     UPANTEIL,tax(jw)
 
                    // }


                    // Stata is inprecise, so only rough check
                    foreach var of varlist `output_variables'{
                        replace `var'_true = `var'_true * 100
                        cap assert inrange(`var'_true - `var', -2, 2)
                        if _rc != 0 local failure = 1

                    disp `failure'
                    }

                }  
            }       
        }   
    } 
    cap assert `failure' == 0
    return scalar result = _rc
end


***************************** Compare Einkommensteuer (couple) for a single value
program stata_test_7, rclass
    return local description "Check function eink_steur"    

    clear
    local failure = 0
    set obs 1
    gen inc_partner_a = 60000
    gen inc_partner_b = 20000
    
    gen ost = 1
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

    gen jahr = 2021
    do ${dir}/code/year_dependendent_vars_for_tax_calculator.do

    * Calculate Einkommensteuer and Faktor
    eink_steur             

    * Lohnsteuer
    cap assert inrange(11670  - lstlzz_couple,-0.1,0.1)
    if _rc != 0 local failure = 1
    disp `failure'

    cap assert inrange(0.907 - f,-0.01,0.01)
    if _rc != 0 local failure = 1
    disp `failure'

    cap assert `failure' == 0
    return scalar result = _rc

end
*/


***************************** Compare all taxes for a single value
program stata_test_8, rclass
    return local description "Check function all_taxes"    

    clear
    local failure = 0
    set obs 1
    gen inc_partner_a = 60000
    gen inc_partner_b = 20000
    
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

    gen jahr = 2021
    do ${dir}/code/year_dependendent_vars_for_tax_calculator.do

    * Calculate Einkommensteuer and Faktor
    all_taxes             

    * Test cases
    cap assert inrange(7062  - lstlzz_stkl3_a,-0.1,0.1)
    if _rc != 0 local failure = 1
    disp `failure'

    cap assert inrange(17214  - lstlzz_stkl5_a,-0.1,0.1)
    if _rc != 0 local failure = 1
    disp `failure'

    cap assert inrange(11670  - lstlzz_couple,-0.1,0.1)
    if _rc != 0 local failure = 1
    disp `failure'

    cap assert inrange(0.907 - f,-0.01,0.01)
    if _rc != 0 local failure = 1
    disp `failure'

    cap assert `failure' == 0
    return scalar result = _rc

end


***** Test with Prüftabelle Faktorverfahren

/*
    Unfortunately, the test data is not useable as it only tests special cases
 
    The test data has no different variable names for the two partners so they
    have to be assigned first. To keep the order of the variables they are
    merged in the following order: results. partner b, partner a

*/



** Results

// #delimit;
// import excel using
//      "data/test_datalle_FaktorFV.xlsx" 
//     , 
//     sheet(2021) firstrow cellrange(AI10:BD3010) 
//     clear ;
// #delimit cr;

// rename *, lower  
// gen lfdnr = _n 


// tempfile results
// save `results'

// ** Partner B

// // Load data from Finanzamt for partner B
// #delimit;
// import excel using
//      "data/test_datalle_FaktorFV.xlsx" 
//     , 
//     sheet(2021) firstrow cellrange(Q10:AG3010) 
//     clear ;
// #delimit cr;

// rename *, lower  
// foreach var of varlist * {
//     rename `var' `var'_b
// }
// gen lfdnr = _n 

// merge 1:1 lfdnr using `results',  assert(match master)
// assert _merge == 3
// drop _merge

// tempfile data_results_partner_b
// save `data_results_partner_b'


// ** Partner A

// // Load data from Finanzamt for partner A 
// #delimit;
// import excel using
//      "data/test_datalle_FaktorFV.xlsx" 
//     , 
//     sheet(2021) firstrow cellrange(A10:P3010) 
//     clear ;
// #delimit cr;

// rename *, lower  
// foreach var of varlist * {
//     rename `var' `var'_a
// }

// rename lfdnr_a lfdnr

// merge 1:1 lfdnr using `data_results_partner_b',  assert(match master)
// assert _merge == 3
// drop _merge


// save $data_tpp/to_delete, replace


// use $data_tpp/to_delete, clear


// /* Excluding test cases not covered by code */

// foreach partner in a b{
//     rename krv_`partner' ost_`partner'
// } 



// foreach partner in a {
//     // Keep only cases covered by program
//     drop if ost_`partner' == 2 
//     drop if ost_`partner' == .
//     drop if alter1_`partner' == 1 // Individual is 65
//     cap drop if entsch_`partner' != 0 // Entschädigungen
//     cap drop if jfreib_`partner' != 0 // Jahresfreibetrag
//     cap drop if jhinzu_`partner' != 0 // Jahreshinzurechungsbetrag
//     cap drop if jre4_`partner' != 0 // Sonstige Bezüge
//     cap drop if jre4ent_`partner' != 0 // Entschädigungen in Sonstige Bezüge
//     cap drop if jvbez_`partner' != 0 // Versorgungsbezüge in Sonstige Bezüge
//     drop if lzzfreib_`partner' != 0 //Lohnsteuerabzugsmerkmal Freibetrag
//     drop if lzzhinzu_`partner' != 0 //Lohnsteuerabzugsmerkmal Hinzurechnungsbetrag
//     drop if pkpv_`partner' != 0 // Beiträge private Kranken- oder Pflegeversicherung
//     drop if pkv_`partner' != 0 // Only keep gesetzlich Versicherte
//     drop if pvs_`partner' == 1 // Ignore Sachsen
//     cap drop if sonstb_`partner' != 0 // Sonstige Bezüge
//     cap drop if sonstent_`partner' != 0 // Entschädigungen in Sonstige Bezüge
//     cap drop if sterbe_`partner' != 0 // Sterbegeld bei Versorungsbezügen
//     drop if vbez_`partner' != 0 // Versorgungsbezüge
//     drop if vbezm_`partner' != 0 // Versorgungsbezüge
//     drop if vbezs_`partner' != 0 // Versorgungsbezüge
//     cap drop if vbs_`partner' != 0 // Versorgungsbezüge
//     cap drop if vkapa_`partner' != 0 // Versorgungsbezüge
//     cap drop if vmt_`partner' != 0 // Versorgungsbezüge
//     cap drop if zmvb_`partner' != 0 // Versorgungsbezüge
// } 


