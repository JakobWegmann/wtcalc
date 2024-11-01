/* Import Globals from xlsx into an executable do File
 */

clear

set type double


********************************************
*** Import Globals from xlsx into an executable do File
********************************************

* Import globals for specific year
import excel ///
    using "${tax_calc_test}/globals_for_tax_system.xlsx", ///
    clear firstrow

drop if variables == ""

tempname fh
file open `fh' using "${tax_calc}/year_dependendent_vars_for_tax_calculator.do" , write replace

file write `fh' "/* Variable values for the tax calculator " _newline
file write `fh' "generated in import_year_dependent_vars.do */" _newline _newline

local num_lines = _N

forvalues i = 1/`num_lines' {
          file write `fh' "quietly gen `= variables[`i']' = . " _newline          
          file write `fh' "quietly tostring `= variables[`i']', replace" _newline _newline
}

file write `fh' _newline _newline

forvalues jahr = 2005/2024 {

    file write `fh' "* Year `jahr'" _newline 

    forvalues i = 1/`num_lines' {
            file write `fh' "quietly replace `= variables[`i']' = "
            file write `fh' `""`= jahr`jahr'[`i']'""'
            file write `fh' " if "
            file write `fh' "jahr == `jahr'" _newline

       }
    file write `fh' _newline 

}

forvalues i = 1/`num_lines' {
          file write `fh' "quietly destring `= variables[`i']', replace" _newline
}


file close `fh'

