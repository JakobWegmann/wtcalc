/* Tests for Kurzarbeit. Since 2021 BA offers tables with the actual amount of
   Kurzarbeitergeld, test for these are not yet implemented */

   
clear all
// Create do files with year dependent globals
do ${dir}/code/program_tax_calculator.do
clear
***************************** Tests ********************************************
/* Compare with "Verordnung über die pauschalierten Nettoentgelte für das
   Kurzarbeitergeld" */

// 2015 is not working, mistake impossible to find

program stata_test_1, rclass
    return local description "Check with official tables"

    local failure = 0

    foreach year of numlist 2007 2008 2010/2014 2016/2020 {   
        // Load data 
        #delimit;
        import excel using
             "${dir}/data/test_data/testfälle_kurzarbeit.xlsx" 
            , clear cellrange(A6) sheet(`year') firstrow;
        #delimit cr; 

        * Cleaning up first column
        rename A bruttoentgelt 

        // Drop first two lines
        drop if bruttoentgelt == "monatlich"
        drop if bruttoentgelt == "Euro"

        // Drop last line
        drop if bruttoentgelt == "und mehr"

        * Cleaning up second column: Calculation for low incomes not implemented
        rename B ind_low_income
        label variable ind_low_income "Indicator for low income"
        label define ind_low_income 1 "Normal income" 2 "Low income"
        label values ind_low_income ind_low_income
        drop if ind_low_income == 2
        drop ind_low_income

        * Stkl VI not implemented
        drop VI

        * Stkl I and IV are identical 
        rename II   nettoentgelt_stkl_2_true
        rename III  nettoentgelt_stkl_3_true
        rename IIV  nettoentgelt_stkl_4_true
        rename V    nettoentgelt_stkl_5_true

        * Cleaning up numeric variables
        replace bruttoentgelt = subinstr(bruttoentgelt,",-","",1) 
        replace bruttoentgelt = subinstr(bruttoentgelt,".","",1) 
        replace bruttoentgelt = subinstr(bruttoentgelt," ","",1) 
        local stkls 2 3 4 5 
        foreach stkl of local stkls{
            replace nettoentgelt_stkl_`stkl'_true ///
                = subinstr(nettoentgelt_stkl_`stkl'_true,".","",1) 
            replace nettoentgelt_stkl_`stkl'_true ///
                = subinstr(nettoentgelt_stkl_`stkl'_true," ","",1) 
        }
        destring *, replace dpcomma

        *** Defining additional variables needed for tax calculator

        gen jahr = `year'
        gen lzz = 2

        * Load year dependent input
        do ${dir}/code/year_dependendent_vars_for_tax_calculator.do

        local stkls 2 3 4 5
        foreach stkl of local stkls{
            kurzarbeitgeld, stkl(`stkl')
        }

        keep bruttoentgelt nettoentgelt_stkl*
        
        gen indic = !inrange(                      ///
                nettoentgelt_stkl3                 ///
                - nettoentgelt_stkl_3_true         ///
                , -1, 1)
        order indic nettoentgelt_stkl3 nettoentgelt_stkl_3_true

        local stkls 3 4 5
        foreach stkl of local stkls{
            disp "Year `year' Steuerklasse `stkl'"
            // Application of Beitragsbemessungsgrenze in 2017 is not propoerly
            // documented, so highest observations are ignored
            assert inrange(                             ///
                nettoentgelt_stkl`stkl'                 ///
                - nettoentgelt_stkl_`stkl'_true         ///
                , -1, 1)                                ///
                if _n != _N 
            if _rc != 0 local failure = 1    
        }
    }

    cap assert `failure' == 0
    return scalar result = _rc

end


