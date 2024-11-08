/* Collects and executes all test-files in project directory. */

cap program drop stata_test
program stata_test

    syntax, [DIRectory(string)]

    quietly{
    cap ssc install filelist 
    cap fdzinstall filelist

    * Set root to standard directory if not specified
    if "`directory'" == "" local directory $root
    if "`directory'" == ""{
        noi di as error "No directory specified. Either supply a directory via the directory option or specify \$root."
        error 
    }
    
    noi di as result "Root dir searched for tests is: `directory'. " _newline

    * Temporary folder for any test-files
    global tempdata_test `directory'/temp_testing/
    cap mkdir $tempdata_test
    noi di as error "File folder: $tempdata_test"

    * Search for do-files following test_ pattern and save in temporary dataset
    tempfile testlist
    filelist , directory("`directory'") pattern(test_*.do) save(`testlist') replace

    use  `testlist', clear
    local n_tests = _N
    local passed = 0

    forvalues i=1/`n_tests' {
        preserve

            qui keep if _n == `i'
            local f = dirname + "/" + filename
            
            noi di as result "Executing Test `i': `f'"
            
            stata_test_drop
            noi run "`f'"
            noi stata_test_collect

            if r(fail) == 0 noi di as result "Test passed"
            if r(fail) == 0 local ++passed

            if r(fail) == 1 noi di as error "Test not passed"

            noi di ""
        restore
    }

    if `passed' == `n_tests'{
    noi di as result "******************************************" ///
            _newline "********* Passed `passed' out of `n_tests' tests ********" ///
            _newline "******************************************"
    }
    
    if `passed' < `n_tests'{
    noi di as error "******************************************" ///
            _newline "********* Passed `passed' out of `n_tests' tests ********" ///
            _newline "******************************************"
    }

    if `passed' > `n_tests'{
        noi di as error result "Passed > Number of tests. Error"
        error
    }

    * Delete temp testing data
    local datafiles: dir "$tempdata_test" files "*.dta"
    foreach datafile of local datafiles {
        rm $tempdata_test/`datafile'
    }
    rmdir $tempdata_test
    
    } // quietly
end
