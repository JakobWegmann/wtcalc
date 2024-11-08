/* Drops all stata_test programs. */

cap program drop stata_test_drop
program define stata_test_drop
    
    * Drop old programs
    forvalues i = 1(1)99{
        cap program drop stata_test_`i'
        * if _rc != 0 continue, break
    }

end
