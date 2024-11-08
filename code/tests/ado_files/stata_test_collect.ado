/* Collect all test programs and run them individually. */

cap program drop stata_test_collect
program define stata_test_collect, rclass

    local fail 0

    forvalues i = 1(1)99{
        
        disp "Now running subtest `i'"
        cap qui stata_test_`i'
        
        * Exit if unrecognized command (quick fix)
        if _rc == 199 {
            noi di as error ///
                "Test does not exist OR unrecognized command in subtest, quit test"            
            continue, break
        }

        noi di as result _skip(4) "Subtest `i': " r(description)
        
        cap noi assert inlist(r(result), 0, 9)
        if _rc != 0{
            noi di as error "Unexpected result returned from test"
            error
        }

        if r(result) == 0{
            noi di as result _skip(4) "Subtest `i' passed"
        }
    
        * Fail test if assert is wrong
        if r(result) == 9{
            noi di as error _skip(4) "Subtest `i' failed"
            local fail 1
        }
        
        noi di " "        
    }

    return scalar fail = `fail'

end
