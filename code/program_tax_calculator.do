/* Programs to calculate net income, payroll tax, soli and
 Kirchensteuerbemesungsgrundlage */


cap program drop MPARA

program define MPARA		///
	/* 
	Inputs 
	*/

	* Rente
	gen 	bbgrv 	= bbgrv_west
	replace bbgrv 	= bbgrv_ost if ost == 1 & jahr > 2009 & jahr != .
	la var bbgrv "Beitragsbemessungsgrenze Rente"

	la var rvsatzan "Rente Beitragssatz Arbeitnehmer"
	la var tbsorv "Teilbetragssatz Vorsorgepauschale RV"
	
	* Krankenvesicherung
	la var bbgkvpv "Beitragsbemessungsgrenze KV"
	
	gen kvsatzan = .
	replace kvsatzan 	= kvz/2/100 + kvsatzan_pre 	if jahr >= 2019 & jahr != .
	replace kvsatzan 	= kvz/100 + kvsatzan_pre 	if inrange(jahr,2015,2018)
	replace kvsatzan 	= kvsatzan_pre 				if inrange(jahr,2009,2014)
	la var kvsatzan "Beitragssatz Arbeitnehmer KV"	 

	gen kvsatzag = .
	replace kvsatzag = durchschn_zusatzbeitrag/2/100 + kvsatzag_pre ///
		if jahr >= 2019 & jahr != .
	replace kvsatzag = kvsatzag_pre if jahr <= 2018 & jahr != .

	* Pflegeversicherung
	la var pvsatzan "Beitragssatz Pflegeversicherung Arbeitnehmer"
	la var pvsatzan_sachsen ///
		"Beitragssatz Pflegeversicherung Arbeitnehmer Sachsen"
	la var pvsatzag "Beitragssatz Pflegeversicherung Arbeitgeber"
	la var pvsatzag_sachsen ///
	 	"Beitragssatz Pflegeversicherung Arbeitgeber Sachsen"
	// For units without children: Zuschlag zur sozialen Pflegeversicherung
	la var pvz_red_more_2_child ///
		"Faktor Pflegeversicherung Reduktion if more than 2 children"

	replace pvsatzan = pvsatzan_sachsen if pvs == 1
	replace pvsatzag = pvsatzag_sachsen if pvs == 1

    * pva introduced in 2024 and typically is one less than the number of 
    * children
    capture confirm variable pva
    if !_rc {
        di in red "pva exists"
       }
   	else {
		gen pva = 0
		replace pva = 1 if zkf == 2
		replace pva = 2 if zkf == 3
		replace pva = 3 if zkf == 4
		replace pva = 4 if zkf > 4
		assert zkf != .
   	}
	la var pva "Number of Pflegeversicherung Reduktion Faktors"

	replace pvsatzan = pvsatzan + pvz_wo_child if pvz == 1 & jahr > 2009
	replace pvsatzan = pvsatzan - pva * pvz_red_more_2_child ///
		if pvz == 0 & jahr >= 2024

	* Lohnsteuer		
	la var w1stkl5 "1.Stufe Berechnung Lohnsteuer 5"
	la var w2stkl5 "2.Stufe Berechnung Lohnsteuer 5"
	la var w3stkl5 "3.Stufe Berechnung Lohnsteuer 5"
	la var solzfrei "Freigrenze Soli"

	drop pva
end



cap program drop MZTABFB

program define MZTABFB			///

	/*

	Input: 
	stkl: Steuerklasse
	
	Output:
	kztab: Kennzahl Einkommensteuertarif
	anp: Arbeitnehmer Pauschbetrag
	sap: Sonderausgabenpauschale
	kfb: Kinderfreibeträge
	ztabfb: Tabellenfreibetrag (ohne Kinderfreibetrag)

	Zuweisung für Pauschalen außer Vorsorgepauschale
	*/

	gen kztab = .
	replace kztab 		= 1 if inlist(stkl,1, 2, 4, 5,6) 	
	replace kztab		= 2 if stkl == 3  
	la var 	kztab 		"Kennzahl Einkommensteuertarif"
	cap label define kztab 1 "Einzelveranlagung" 2 "Zusammenveranlagung"
	label values kztab kztab

	gen anp_intern = anp
	replace anp_intern = 0 if stkl == 6
	la var anp_intern			"Arbeitnehmer Pauschbetrag"

	gen sap_intern = sap 
	replace sap_intern = sap * kztab if jahr <= 2009
	replace sap_intern = 0 if stkl == 5 & jahr <= 2009
	replace sap_intern = 0 if stkl == 6
	la var 	sap_intern 	"Sonderausgabenpauschale"
	
	gen kfb 		= 0
	replace kfb		= zkf * kfb_stkl_1_3		if stkl == 1
	replace kfb		= zkf * kfb_stkl_1_3		if stkl == 2		
	replace kfb		= zkf * kfb_stkl_1_3		if stkl == 3
	replace kfb		= zkf * kfb_stkl_4			if stkl == 4		
	replace kfb		= 0 						if inlist(stkl,5,6) 
	la var 	kfb 						"Kinderfreibeträge"

	gen efa_intern = 0
	replace efa_intern = efa if stkl == 2
	la var efa "Entlastungsbetrag Alleinerziehende"

	gen ztabfb 		= anp_intern + sap_intern + efa_intern
	la var ztabfb "Tabellenfreibetrag (ohne Kinderfreibetrag)"

	drop efa_intern anp_intern
end




capture program drop MVSP_bef_2009
program define MVSP_bef_2009
	
	/*
	Input:
	zre4VP: Jährlicher Bruttolohn

	Output:
	vspo: Versorgungspauschale für 2004 geltende Fassung wenn nicht über 
		Höchstbetrag

	Festlegung der Inputvariablen für UMVSP
	*/

	gen vspo = zre4VP * vsp_satz_2004_regelung if jahr <= 2009
	gen vspvor_intern = vspvor
	replace vspvor_intern = vspvor_intern * kztab if jahr <= 2009
	gen vspmax1_intern = vspmax1
	replace vspmax1_intern = vspmax1_intern * kztab if jahr <= 2009
	gen vspmax2_intern = vspmax2
	replace vspmax2_intern = vspmax2_intern * kztab if jahr <= 2009
	gen vspkurz_intern = vspkurz
	replace vspkurz_intern = vspkurz_intern * kztab if jahr <= 2009
	
	#delimit; 
	cap la var vspo "Vorsorgepausch. für 2004 geltende Fassung";
	cap la var vspvor_intern "Höchstbetrag Vorsorgepausch. für 2004 geltende 
		Fassung nach § 10c Abs. 2 Nr. 1 EStG";
	cap la var vspmax1_intern "Höchstbetrag Vorsorgepausch. für 2004 geltende 
		Fassung nach §10c Abs. 2 Nr. 2 EStG";
	cap la var vspmax2_intern "Höchstbetrag Vorsorgepausch. für 2004 geltende 
		Fassung nach §10c Abs. 2 Nr. 3 EStG";
	cap la var vspkurz_intern "Höchstbetrag Vorsorgepausch. für 2004 geltende 
		Fassung nach §10c Abs. 3 EStG";
	#delimit cr
	

	UMVSP_bef_2009

	replace vsp = floor(vspo) 		///
		if (vspo <= vspkurz) 		///
		& priv_ins_health == 1 		///
		& jahr <= 2009 

	replace vsp = vspkurz 		///
		if (vspo > vspkurz) 	///
		& priv_ins_health == 1 	///
		& jahr <= 2009 

end

capture program drop UMVSP_bef_2009
program define UMVSP_bef_2009

	/*
	Input:
	zre4VP: Jährlicher Bruttolohn
	vspo: Versorgungspauschale für 2004 geltende Fassung wenn nicht über 
		Höchstbetrag
	vspvor_intern: Höchstbetrag Vorsorgepausch. 2004

	Output:
	vsp: Versorgungspauschale für 2004 geltende Fassung

	Berechnung der Versorgungspauschale nach der 2004 geltenden Fassung 
	*/

	replace vspvor_intern = vspvor_intern - zre4VP * vsp_satz_günstigerprüfung  ///
		if jahr <= 2009
	replace vspvor_intern = 0 if vspvor_intern < 0  & jahr <= 2009
	
	replace vsp = floor(vspo) 			if vspo < vspvor_intern & jahr <= 2009

	
	replace vsp = vspvor_intern 		if vspo > vspvor_intern & jahr <= 2009
	gen vsprest = vspo - vspvor_intern 	if vspo > vspvor_intern & jahr <= 2009

	// Rounding Rules changes over time
	replace vsp = floor(vsp + vsprest) ///
		if (vspo > vspvor_intern) & (vsprest < vspmax1_intern) & jahr <= 2009

	replace vsp = vsp + vspmax1_intern ///
		if (vspo > vspvor_intern) & vsprest > vspmax1_intern & jahr <= 2009
	gen vsprest_2 = ceil((vsprest - vspmax1_intern)/2 * 100) / 100 ///
		if (vspo > vspvor_intern) & (vsprest > vspmax1_intern) & jahr <= 2009

	replace vsp = floor(vsp + vsprest_2) 	///
		if (vspo > vspvor_intern) 			///
			& (vsprest > vspmax1_intern) 	///
			& (vsprest_2 < vspmax2_intern) 	///
		 	& jahr <= 2009
	
	replace vsp = floor(vsp + vspmax2_intern) 	///
		if (vspo > vspvor_intern) 				///
			& (vsprest > vspmax1_intern)		///
			& (vsprest_2 > vspmax2_intern)		///
		 	& jahr <= 2009


	
	// drop vspvor_intern vspmax1_intern vspmax2_intern 
	cap drop vsprest

end

capture program drop MVSP_after_2009
program define MVSP_after_2009

	/*
	Input:
	zre4VP: Jährlicher Bruttolohn
	priv_ins_health: Indicator if privately insured
	ind_priv_ins_health_emp_supp:
        Indicator for employer support for private insurance
	pkpv: Size of employer support for private insurance

	Output:
	vsp: Versorgungspauschale Rente + KV + Pflege reguläre Vorsorgepauschale

	Berechnung reguläre Vorsorgepauschale
	*/

	assert priv_ins_health == 1 if ind_priv_ins_health_emp_supp == 1
	replace zre4VP = bbgkvpv if zre4VP > bbgkvpv & jahr > 2009
	gen vsp3 = zre4VP * (kvsatzan + pvsatzan) ///
		if priv_ins_health == 0 & jahr > 2009
	replace vsp3 = pkpv * 12 / 100 if priv_ins_health == 1 & jahr > 2009
	replace vsp3 = vsp3 - zre4VP * (kvsatzag + pvsatzag) ///
		if ind_priv_ins_health_emp_supp == 1 & jahr > 2009
	replace vsp3 = 0 if priv_ins_health == 1 & stkl == 6 & jahr > 2009
	cap la var vsp3 "Versorungspauschale KV + PV Variante 2" 
	replace vsp = ceil(vsp1 + vsp3) if jahr > 2009

end

cap program drop UPEVP

program define UPEVP			

	/*
	Input:
	zre4j: gross income on yearly level
	stkl: Lohnsteuerklasse
	priv_ins_pen: No public pension 


	Output:
	vsp: Versorgungspauschale Rente + KV + Pflege

	Berechnung Vorsorgepauschale (inkludiert MVSP)
	*/

	* Versorgungspauschale Rente
	replace zre4VP = bbgrv if bbgrv < zre4VP
	gen vsp1 = .
	replace vsp1 = zre4VP * rvsatzan if inrange(jahr,2002,2004)
	replace vsp1 = zre4VP * tbsorv * rvsatzan if inrange(jahr,2005,2022)
	replace vsp1 = zre4VP * rvsatzan if jahr >= 2023
	assert vsp1 != .
	replace vsp1 = 0 if priv_ins_pen == 1
	la var vsp1 "Versorungspauschale Rente"

	* Versorungspauschale Krankenversicherung + Pflege
	la var min_vrsrge_pausch "Mindestvorsorgepauschale" 
	gen vsp2 = .
	replace vsp2 = min_vrsrge_pausch * zre4VP if jahr >= 2005	
	gen vhb = . 
	replace vhb = vhb_stkl_ungl_3 if jahr > 2009
	replace vhb = vhb_stkl_3 if stkl == 3 & jahr > 2009
	replace vhb = vhb_bef2010 * kztab if inrange(jahr,2005,2009)
	cap la var vhb "Höchstbeitrag Minimum Kranken- und Pflegeversicherung"
	replace vsp2 = vhb if vsp2 > vhb & jahr >= 2005
	cap la var vsp2 "Versorungspauschale KV + PV Variante 1"
	gen vspn = .
	replace vspn = ceil(vsp1 + vsp2) if jahr >= 2005

	gen vsp = .	
	la var vsp "Versorgungspauschale Rente + KV + Pflege"


	MVSP_bef_2009 
	MVSP_after_2009


	// Implementation Günstigerprüfung Mindestvorsorgepauschale
	replace vsp = vspn if vspn > vsp & jahr >= 2005

	drop vspvor_intern vspmax1_intern vspmax2_intern vspkurz_intern
end


cap program drop UPVKVLZZ
program define UPVKVLZZ			

	/*
	Input:


	Output:
	vkvlzz: Berücksichtige private Kranken- und 
	Pflegeversicherungsaufwendungen im Lohnzahlungszeitraum in Euro

	Berechnung der berücksichtigten privaten Kranken- und 
	Pflegeversicherungsaufwendungen im Lohnzahlungszeitraum
	*/

	UPVKV

	gen jw = vkv

	UPANTEIL,tax(jw)

	gen vkvlzz = anteil1
	la var vkvlzz "Berücksichtige private KV und PV im Lohnzahlungszeitraum"

	drop jw vkv anteil1 /*vsp2*/

end



cap program drop UPVKV
program define UPVKV			

	/*
	Input:
	vsp2: Variante für Berücksichtigung der Kranken- und 
		Pflegeversicherungsaufwendungen 
	vsp3: Variante für Berücksichtigung der Kranken- und 
		Pflegeversicherungsaufwendungen


	Output:
	vkv: Berücksichtige jährliche private Kranken- und 
		Pflegeversicherungsaufwendungen 

	Berechnung der berücksichtigten jährlichen privaten 
		Kranken- und Pflegeversicherungsaufwendungen
	*/

	gen vkv = 0
	la var vkv ///
		"Berücksichtige jährliche private KV und PV"
	replace vkv = vsp3 * 100 if priv_ins_health == 1 & vsp2 <= vsp3
	replace vkv = vsp2 * 100 if priv_ins_health == 1 & vsp2 > vsp3


end



*** Einkommensteuer

cap program drop UPTAB
prog define UPTAB
	syntax, ///
		taxable_income(string) 	///
		income_tax(string) 		

	/* 
	taxable_income: Input variable
	income_tax: Output variable
	kztab: Einkommensteuertarifart (1 = Grundtarif, 2 = Splitting)

	Calculates income tax (following §32a Absatz 1) 
	*/

	g `taxable_income'_floor = floor(`taxable_income')
	g y = (`taxable_income' - gfb) / y_abzug_2
	g z = (`taxable_income' - z_abzug_1) / z_abzug_2
	g `income_tax' = .
	replace `income_tax' = 0 if `taxable_income' < gfb + 1
	replace `income_tax' = (zahl_1_1 * y + zahl_1_2) * y 				///
		if `taxable_income' >= gfb + 1 	 
	replace `income_tax' = (zahl_2_1 * z + zahl_2_2) * z + zahl_2_3		///
	 	if `taxable_income' >= threshold_2 	 
	replace `income_tax' = rate_3 * `taxable_income' - zahl_3_1			///
	 	if `taxable_income' >= threshold_3 	 
	replace `income_tax' = rate_4 * `taxable_income' - zahl_4_1			///
	 	if `taxable_income' >= threshold_4 	 

	replace `income_tax' = floor(`income_tax')
	replace `income_tax' = `income_tax' * kztab

	drop y z `taxable_income'_floor
end 



*** Soli 

cap program drop MSOLZ
program define MSOLZ

	/* 
	Input:
	zve: zu versteuerndes Einkommen
	kfb: Kinderfreibetrag
	jbmg: Jahressteuer, aus der Solidaritätszuschlag und Kirchenlohnstuer
		ermittelt werden
	r: 0 if no religion

	Output:
	solzlzz: Solidaritätszuschlag
	bk: Bemessungsgrundlage Kirchenlohnsteuer

	Calculation of Solidaritätszuschlag	and Bemessungsgrundlage Kirchensteuer
	*/

	* Double Soli-Freibetrag for Zusammenveranlagung 
	gen solzfrei_intern = solzfrei
	replace solzfrei_intern = solzfrei_intern * kztab

	gen solzlzz = 0
	la var soli_satz "Soli Steuersatz"
	gen solzj = floor((jbmg * soli_satz/100)*100)/100
	la var mindest_soli "Mindestbetrag Soli"
	gen solzmin = (jbmg - solzfrei_intern) * mindest_soli / 100
	replace solzj = solzmin if solzmin < solzj
	gen jw = solzj * 100
	UPANTEIL,tax(jw)
	replace solzlzz = anteil1 if jbmg > solzfrei_intern
	la var solzlzz "Solidaritätszuschlag"
	
	drop solzmin solzfrei_intern jw anteil1

	* Religion
	gen bk = 0 
	gen jw = jbmg * 100
	UPANTEIL,tax(jw)
	replace bk = anteil1 if r > 0
	la var bk "Bemessungsgrundlage Kirchenlohnsteuer"

	drop jw anteil1 
end


*** Steuerklasse V


cap program drop UP_5_6
program define UP_5_6
	syntax, ///
	taxable_income(string) ///
	st(string)

	/* 
	taxable_income: Input variable
	st: Output variable


	Calculate UP5-6 (page 30)/ §39 b Absatz 2 Satz 7 (part 1):  
	Jahreslohnsteuer die sich aus dem 
	Zweifachen des Unterschiedsbetrags zwischen dem Steuerbetrag für das 
	Eineinviertelfache und dem Steuerbetrag für das Dreiviertelfache des zu 
	versteuernden Jahresbetrags nach § 32a Absatz 1 ergibt; die Jahreslohnsteuer
	beträgt jedoch mindestens 14 Prozent des zu versteuernden Jahresbetrags.
	*/

	gen `taxable_income'_125 = `taxable_income' * 1.25
	UPTAB, ///
		taxable_income(`taxable_income'_125) income_tax(St1)

	gen `taxable_income'_075 = `taxable_income' * 0.75
	UPTAB, ///
		taxable_income(`taxable_income'_075) income_tax(St2)

	gen diff = (St1 - St2) * 2
	gen mist = `taxable_income' * mindest_lst_w1stkl5
	replace mist = floor(mist)

	* st is the tarifliche Einkommensteuer (preliminary)
	gen `st' = diff
	replace `st' = mist if diff < mist 

	drop `taxable_income'_125 St1 `taxable_income'_075 St2 diff mist
end


cap program drop MST5_6
program define MST5_6
	syntax, ///
	taxable_income(string) ///
	income_tax(string)
	/* 
	Input:
	taxable_income: Taxable income (adjustet whether Grundtarif or Splitting
	
	Output:
	income_tax: Income Tax for Steuerklasse V

	Calculate UP5-6 (page 30)/ §39 b Absatz 2 Satz 7 (part 2):  
	für den 11 237 Euro übersteigenden Teil des zu versteuernden Jahresbetrags 
	höchstens 42 Prozent, für den 28 959 Euro übersteigenden Teil des zu 
	versteuernden Jahresbetrags 42 Prozent und für den 219 690 Euro 
	übersteigenden Teil des zu versteuernden Jahresbetrags 45 Prozent	
	*/

	gen `income_tax' = 0

	* Taxable Income is below w1stkl5
	UP_5_6, taxable_income(`taxable_income') st(prelim_payroll_tax_sm_w2stkl5)
	replace `income_tax' = prelim_payroll_tax_sm_w2stkl5 if ///
		`taxable_income' < w2stkl5 & `taxable_income' <= w1stkl5

	* Taxable Income is below w2stkl5 but above w1stkl5
	gen vergl = prelim_payroll_tax_sm_w2stkl5
	UP_5_6, taxable_income(w1stkl5) st(payroll_tax_w1stkl5)
	la var lst_w1stkl5_rate "Rate zwischen w1stkl5 und w2stkl5"
	gen hoch = floor(payroll_tax_w1stkl5 ///
		+ lst_w1stkl5_rate * (`taxable_income' - w1stkl5) ///
	)
	gen prelim_payroll_tax_sm_w1stkl5 = .
	replace prelim_payroll_tax_sm_w1stkl5 = vergl if hoch >= vergl
	replace prelim_payroll_tax_sm_w1stkl5 = hoch if hoch < vergl

	replace `income_tax' = prelim_payroll_tax_sm_w1stkl5 if ///
		`taxable_income' < w2stkl5 & `taxable_income' > w1stkl5

	* Taxable Income is above w2stkl5 but below w3stkl5
	UP_5_6, taxable_income(w2stkl5) st(payroll_tax_w2stkl5)
	la var lst_w2stkl5_rate "Rate für zwischen w2stkl5 und w3stkl5"

	replace `income_tax' = floor( 										///
		payroll_tax_w2stkl5 + lst_w2stkl5_rate * (`taxable_income' - w2stkl5)) 		/// 
		if 																///
		`taxable_income' >= w2stkl5 & `taxable_income' < w3stkl5		

	* Taxable Income is above w2stkl5 and above w3stkl5
	replace `income_tax' = floor( 										///
		payroll_tax_w2stkl5 											///
		+ lst_w2stkl5_rate * (w3stkl5 - w2stkl5))				///
		if 																///
		`taxable_income' > w2stkl5 & `taxable_income' > w3stkl5 

	la var lst_w3stkl5_rate "Rate für über w3stkl5"

	replace `income_tax' = floor(										///
		`income_tax'													///
		+ lst_w3stkl5_rate * (`taxable_income' - w3stkl5)) 				///
		if 																///
		`taxable_income' > w2stkl5 & `taxable_income' > w3stkl5 

	drop 								///
		prelim_payroll_tax_sm_w2stkl5 	///
		payroll_tax_w1stkl5 			///
		vergl hoch 						///
		prelim_payroll_tax_sm_w1stkl5 	///
		payroll_tax_w2stkl5 			
end

*** Calculation for Steuerklasse I to VI

cap program drop UPMLST
program define UPMLST
	syntax, ///
	zve(string) ///
	st(string)
	/* 
	Input:
	zve: Taxable Income
	kztab: Einkommensteuertarifart (1 = Grundtarif, 2 = Splitting)
	stkl: Lohnsteuerklasse

	Output
	st: Payroll Tax

	Calculate for Steuerklasse III to VI Steuerklasse Lohnsteuer
	*/
	replace `zve' = 0 if `zve' < 1
	gen x = floor(`zve' / kztab)
	
	* Payroll Tax V
	MST5_6, taxable_income(x) income_tax(payroll_tax_V_VI)

	* Payroll Tax I, II, III & IV
	UPTAB, taxable_income(x) income_tax(payroll_tax_I_IV)

	gen `st' = .
	replace `st' = payroll_tax_V_VI 	if inrange(stkl,5,6)
	replace `st' = payroll_tax_I_IV		if inrange(stkl,1,4)

	drop x payroll_tax_V_VI payroll_tax_I_IV 
end

*** Calculation of income and tax for each Lohnzahlungszeitraum

cap program drop MRE4JL

program define MRE4JL
	/*

	Input: 
	lzz: Lohnzahlungszeitraum, 1: Jahr; 2: Monat; 3: Woche; 4: Tag
	re4: gross income in lzz in cent
	af: Indicator 1 if IV with Faktor
	f: Faktor for IV with Faktor

	Output:
	zre4j: gross income on yearly level in euro

	Calculating gross income on yearly level

	*/


	gen zre4j = .	
    replace zre4j = re4 / 100 if lzz == 1 // is in cents
    replace zre4j = re4 * 12 / 100 if lzz == 2 
    replace zre4j = re4 * 360 / 7 / 100 if lzz == 3 
    replace zre4j = re4 * 360 / 100 if lzz == 4 
    la var zre4j "Gross income on yearly level in Euro"

	gen jlfreib = .	
    replace jlfreib = lzzfreib / 100 if lzz == 1 // is in cents
    replace jlfreib = lzzfreib * 12 / 100 if lzz == 2 
    replace jlfreib = lzzfreib * 360 / 7 / 100 if lzz == 3 
    replace jlfreib = lzzfreib * 360 / 100 if lzz == 4 
    la var jlfreib "Freibetrag Lohnsteuer on yearly level in Euro"

	gen jlhinzu = .	
    replace jlhinzu = lzzhinzu / 100 if lzz == 1 // is in cents
    replace jlhinzu = lzzhinzu * 12 / 100 if lzz == 2 
    replace jlhinzu = lzzhinzu * 360 / 7 / 100 if lzz == 3 
    replace jlhinzu = lzzhinzu * 360 / 100 if lzz == 4 
    la var jlhinzu "Hinzurechungsbetrag Lohnsteuer on yearly level in Euro"


    replace f = 1 if af == 0

end


cap program drop UPANTEIL

program define UPANTEIL
	/*

	Input:
	tax: tax that is split up by lzz
	lzz: Lohnzahlungszeitraum, 1: Jahr; 2: Monat; 3: Woche; 4: Tag

	Output:
	anteil1: value of yearly values within Lohnzahlungszeitraum (lzz)

	* Splitting up off yearly values in values fitting to
	 Lohnzahlungszeitraum (lzz)
	*/
	syntax, ///
		tax(string) 	///

	gen anteil1 = .
    replace anteil1 = `tax' 					if lzz == 1 
    replace anteil1 = floor(`tax' / 12)  		if lzz == 2 
    replace anteil1 = floor(`tax' / 360 * 7)	if lzz == 3 
    replace anteil1 = floor(`tax' / 360)  		if lzz == 4
end


cap program drop UPLSTLZZ

program define UPLSTLZZ

	/*
	
	Input: 
	lstjahr: taxes to pay on yearly level (in Euro)

	Output:
	lstlzz: taxes to pay in Lohnzahlungszeitraum (lzz) in Cent

	* Calculation of income tax for the Lohnzahlungszeitraum (lzz)

	*/

	gen jw = lstjahr * 100
	UPANTEIL, tax(jw)
	gen lstlzz = anteil1
	la var lstlzz "Lohnsteuer in Lohnzahlungszeitraum (lzz)"
	drop jw

	drop anteil1
end

*** Vorsorgepauschale + Zu versteuerndes Einkommen + Lohnsteuer

cap program drop MLSTJAHR

program define MLSTJAHR		
	syntax, ///
	tabelle_freib(string) ///
	st(string)	
	/*
	Input:
	tabelle_freib: Tabellenfreibetrag
	vsp: Vorsorgepauschale
	zre4j: gross income on yearly level

	Output:
	st: Payroll Taxes


	Berechnung zu versteuerndes Einkommen
	*/

	* Calculate Vorsorgepauschale (vsp) moved to MBERECH 
	* (differing from Programmablauf) because otherwise it is called 
	* twice (again for Soli)

	gen zve = zre4 - `tabelle_freib' - vsp
	la var zve "Zu versteuerndes Einkommen"
	*Calculate Payroll Tax
	UPMLST, zve(zve) st(`st')

	drop zve

end


cap program drop MBERECH

program define MBERECH			
	/*
	Input:
	zre4j: gross income on yearly level
	stkl: Lohnsteuerklasse
	f: Faktor for IV with Faktor 
	zkf: Number of eligible children
	ost: Living in eastern Germany

	Output:
	st: Payroll Taxes


	Berechnung Lohnsteuer, Soli und Bemessunggsgrundlage Kirchensteuer
	*/

	*Defintions from MRE4ABZ
	gen zre4 = zre4j - jlfreib + jlhinzu
	replace zre4j = 0 if zre4j < 0
	la var zre4 ///
		"Yearly Income minus Lohnsteuerabzugsmerkmale/Hinzurechungsbetrag"
	gen zre4VP = zre4j 

	* Ermittlung fester Tabellenfreibeträge (ohne Vorsorgepauschale)
	MZTABFB

	* Ermittlungs Versicherungskostenpauschale
	* before 2005: only MVSP + UMVSP
	* betweeen 2005 and 2010: Günstigerprüfung between before 2005 rule and rule
	* 	similar to after 2010 rule
	* after 2010: only MVSP  
	UPEVP 			
	// Before 2010 no Vorsorgepauschale for Steuerklasse 5
	replace vsp = 0 if jahr <= 2009 & inlist(stkl,5,6)

	* Lohnsteuerberechnung 
	MLSTJAHR, tabelle_freib(ztabfb) st(st)
	gen lstjahr = st * f
	drop st
	la var lstjahr "Jahreslohnsteuer"

	* Lohnsteur
	UPLSTLZZ

	* Private Vorsorgeaufwendungen 
	UPVKVLZZ

	* Add Kinderfreibeträge to ztabfb
	gen ztabfb_kbf = ztabfb + kfb
	la var ztabfb_kbf "Tabellenfreibetrag mit Kinderfreibetrag"

	* Lohnsteuerberechnung für Soli und Kirchensteuergrundlage
	MLSTJAHR, tabelle_freib(ztabfb_kbf) st(bemessungsgrdl_soli)

	* Application of Faktor
	gen jbmg = bemessungsgrdl_soli * f
	la var jbmg "Bemessungsgrundlage(Steuer) Soli und Kirchenlohnsteuer"

	*Soli und Bemessungsgrundlage Kirchensteuer
	MSOLZ

	drop sap_intern vspn bemessungsgrdl_soli  ///
		solzj bbgrv kvsatzan kvsatzag 	 ///
	 kztab kfb zre4VP vsp1 vhb vspo vsprest_2 jbmg lstjahr ztabfb_kbf ///
	 vsp2 vsp3 ///
	 zre4j jlfreib jlhinzu zre4 vkvlzz 

	
	// drop anp sap  efa  min_vrsrge_pausch  ///
	// 	vspn vsp3 vsp mindest_lst_w1stkl5 bemessungsgrdl_soli soli_satz ///
	// 	solzj mindest_soli pvz bbgrv rvsatzan bbgkvpv tbsorv kvsatzan 	 ///
	// 	pvsatzan pvsatzag w1stkl5 w2stkl5 w3stkl5 solzfrei_intern lst_w1stkl5_rate  ///
	// 	lst_w2stkl5_rate lst_w3stkl5_rate y_abzug_1 y_abzug_2 z_abzug_1 ///
	// 	z_abzug_2 zahl_1_1 zahl_1_2 threshold_1 zahl_2_1 zahl_2_2 zahl_2_3 ///
	// 	threshold_2 rate_3 zahl_3_1 threshold_3 rate_4 zahl_4_1 threshold_4 ///
	// 	kvz kztab kfb ztabfb zre4VP vsp1 vhb vspo vsprest_2 jbmg

end


*** Function calculating taxes 

cap program drop LST

program define LST	
	/*
	Input:
	lzz: Lohnzahlungszeitraum, 1: Jahr; 2: Monat; 3: Woche; 4: Tag
	re4: gross income in lzz in cents
	stkl: Lohnsteuerklasse
	zkf: Number of eligible children
	ost: Living in eastern Germany
	r: Church
	pvz: Zuschlag zur sozialen Pflegeversicherung
	kvz: Kassenindividuelle Zusatzbeitrag
	af: Indicator 1 if IV with Faktor
	f: Faktor for IV with Faktor
	jahr: year


	Output:
	lstlzz: Payroll Taxes
	solzlzz: Solidaritätszuschlag
	bk: Bemessungsgrundlage Kirchensteuer

	Berechnung Lohnsteuer, Soli und Bemessunggsgrundlage Kirchensteuer
	*/

	* Input Parameters
	MPARA

	* Using lzz and re4 to calculate yearly wage
	MRE4JL

	* Calculate Taxes
	MBERECH

end



*** Einkommensteuer and also returning faktor
capture program drop eink_steur
program define eink_steur

	/*
	Input:
	inc_partner_a: yearly income partner a in Euro
	inc_partner_b: yearly income partner b in Euro
	zkf: Number of eligible children
	ost: Living in eastern Germany
	r: Church
	pvz: Zuschlag zur sozialen Pflegeversicherung
	kvz: Kassenindividuelle Zusatzbeitrag
	jahr: year

	Output:
	lstlzz_couple: Einkommensteuer auf Lohneinkommmen in Euro
	f : Faktor for IV with Faktor
	lstlzz_a: Withholding Taxes partner A
	solzlzz_a: Solidaritätszuschlag partner A
	lstlzz_b: Withholding Taxes partner B
    solzlzz_b: Solidaritätszuschlag partner B
    lstlzz_faktor_a: Withholding Taxes partner A with IV with faktor
    lstlzz_faktor_b: Withholding Taxes partner B with IV with faktor    
	*/

	g sum_income = (inc_partner_a + inc_partner_b)
	la var sum_income "Sum of income both partners"

	* Lohnzahlungszeitraum yearly
	g lzz = 1

	* Couple taxed as if Stkl 4
	g stkl = 4

	* No Faktorverfahren
	g af = 0
	g f = 1

	g re4 =.

	/* Lohnsteuer with Stkl IV for both partners (i.e. getrennte Veranlagung) */

	* Berechnung Vorsorgepauschale und Tabellenfreibetrag Partner A
	replace re4 = inc_partner_a * 100
	la var re4 "Half of taxed income of couple in Cents"
	
	LST

	local output_vars lstlzz solzlzz bk vsp ztabfb
	foreach var of local output_vars{
		rename `var' `var'_a
	}

	* Berechnung Vorsorgepauschale und Tabellenfreibetrag Partner B
	replace re4 = inc_partner_b * 100
	la var re4 "Half of taxed income of couple in Cents"
	
	LST

	local output_vars lstlzz solzlzz bk vsp ztabfb
	foreach var of local output_vars{
		rename `var' `var'_b
	}

	* Drop input variables of LST (except lzz)
	drop stkl af f re4

	/* Einkommensteuer auf halbiertes Einkommen reduziert um Tabellenfreibeträge
	   (beider Partner) und Vorsorgepauschalen (beider Partner)
	*/
	* Bemessungsgrundlage Einkommensteuer
	gen bmg_ehe = sum_income 	///
				- ztabfb_a		///
				- ztabfb_b		///
				- vsp_a 		///
				- vsp_b
	replace bmg_ehe = bmg_ehe / 2

	* Splittingtarif
	g kztab = 2

	UPTAB, taxable_income(bmg_ehe) income_tax(lstlzz_couple) 		
	la var lstlzz_couple ///
		 "Einkommensteuer (ohne Soli) auf Lohneinkommmen in Euro des Couples"

	*Soli und Bemessungsgrundlage Kirchensteuer
	gen jbmg = lstlzz_couple
	la var jbmg "Bemessungsgrundlage Soli und Kirchenlohnsteuer"

	MSOLZ
	rename solzlzz solzlzz_couple
	la var solzlzz_couple "Soli for couple"
	rename bk bk_couple 
	la var bk_couple "Bemessungsgrundlage Kirchensteuer for couple in cent"

	g f = floor(lstlzz_couple / (lstlzz_a / 100 + lstlzz_b / 100)*1000)/1000
	replace f = 1 if f > 1 // §39f Absatz 1 Satz 1
	la var f "Faktor for IV with Faktor"

	replace lstlzz_a = lstlzz_a/100
	replace lstlzz_b = lstlzz_b/100

	/* Lohnsteuer with IV with faktor */

	gen lstlzz_faktor_a = lstlzz_a * f
	la var lstlzz_faktor_a "Lohnsteuer Partner A with IV with factor in Euro"
	gen lstlzz_faktor_b = lstlzz_b * f
	la var lstlzz_faktor_b "Lohnsteuer Partner B with IV with factor in Euro"

	drop lzz bk_a bk_b bk_couple vsp_a vsp_b ///
		ztabfb_a ztabfb_b bmg_ehe kztab jbmg solzj
end





*** Calculating for a couple all tax relevant outcomes
capture program drop all_taxes
program define all_taxes

	/*
	Input:
	inc_partner_a: yearly income partner a in Euro
	inc_partner_b: yearly income partner b in Euro
	zkf: Number of eligible children
	ost: Living in eastern Germany
	r: Church
	pvz: Zuschlag zur sozialen Pflegeversicherung
	kvz: Kassenindividuelle Zusatzbeitrag
	jahr: year
	Add new vars 

	Output:
	einkst_couple: Einkommensteuer auf Lohneinkommmen in Euro joint taxation
	f : Faktor for IV with Faktor
	lstlzz_a_stkl`stkl': Withholding Taxes partner A Steuerklasse `stkl' 
	solzlzz_a_stkl`stkl': Solidaritätszuschlag partner A Steuerklasse `stkl'
	lstlzz_b_stkl`stkl': Withholding Taxes partner B Steuerklasse `stkl'
    solzlzz_b_stkl`stkl': Solidaritätszuschlag partner B Steuerklasse `stkl'
    lstlzz_faktor_a: Withholding Taxes partner A with IV with faktor
    lstlzz_faktor_b: Withholding Taxes partner B with IV with faktor    
	
	*/

	g sum_income = (inc_partner_a + inc_partner_b)
	la var sum_income "Sum of income both partners"

	* Lohnzahlungszeitraum yearly
	g lzz = 1

	* No Faktorverfahren
	g af = 0
	g f = 1

	g re4 =.

	/* Lohnsteuer with Stkl IV for both partners (i.e. separate taxation) */

	local steuerklassen 3 4 5
	gen stkl = .
	foreach stkl of local steuerklassen{

		replace stkl = `stkl'

		* Berechnung Vorsorgepauschale und Tabellenfreibetrag Partner A
		replace re4 = inc_partner_a * 100
		la var re4 "Half of taxed income of couple in Cents"


		LST
		* Convert from Cents to Euros
		replace lstlzz = lstlzz/100

		local output_vars lstlzz solzlzz bk vsp ztabfb
		foreach var of local output_vars{
			rename `var' `var'_stkl`stkl'_a
		}	

		* Berechnung Vorsorgepauschale und Tabellenfreibetrag Partner B
		replace re4 = inc_partner_b * 100
		la var re4 "Half of taxed income of couple in Cents"

		LST
		* Convert from Cents to Euros		
		replace lstlzz = lstlzz/100

		local output_vars lstlzz solzlzz bk vsp ztabfb
		foreach var of local output_vars{
			rename `var' `var'_stkl`stkl'_b
		}	
	}

	* Drop input variables of LST (except lzz)
	drop stkl af f re4

	/* Einkommensteuer auf halbiertes Einkommen reduziert um Tabellenfreibeträge
	   (beider Partner) und Vorsorgepauschalen (beider Partner)
	*/
	* Bemessungsgrundlage Einkommensteuer
	gen bmg_ehe = sum_income 			///
				- ztabfb_stkl4_a		///
				- ztabfb_stkl4_b		///
				- vsp_stkl4_a	 		///
				- vsp_stkl4_b
	replace bmg_ehe = bmg_ehe / 2

	* Splittingtarif
	g kztab = 2

	UPTAB, taxable_income(bmg_ehe) income_tax(lstlzz_couple) 		
	la var lstlzz_couple ///
		 "Einkommensteuer (ohne Soli) auf Lohneinkommmen in Euro des Couples"

	*Soli und Bemessungsgrundlage Kirchensteuer
	gen jbmg = lstlzz_couple
	la var jbmg "Bemessungsgrundlage Soli und Kirchenlohnsteuer"

	MSOLZ
	rename solzlzz solzlzz_couple
	la var solzlzz_couple "Soli for couple"
	rename bk bk_couple 
	la var bk_couple "Bemessungsgrundlage Kirchensteuer for couple"

	g f = floor( ///
		lstlzz_couple / (lstlzz_stkl4_a + lstlzz_stkl4_b)*1000 ///
		)/1000
	replace f = 1 if f > 1 // §39f Absatz 1 Satz 1
	la var f "Faktor for IV with Faktor"

	/* Lohnsteuer with IV with faktor */

	gen lstlzz_faktor_a = floor(lstlzz_stkl4_a * f)
	la var lstlzz_faktor_a "Lohnsteuer Partner A with IV with factor in Euro"
	gen lstlzz_faktor_b = floor(lstlzz_stkl4_b * f)
	la var lstlzz_faktor_b "Lohnsteuer Partner B with IV with factor in Euro"

	gen solzlzz_faktor_a = floor(solzlzz_stkl4_a * f)
	la var solzlzz_faktor_a "Soli Partner A with IV with factor in Euro"
	gen solzlzz_faktor_b = floor(solzlzz_stkl4_b * f)
	la var solzlzz_faktor_b "Soli Partner B with IV with factor in Euro"


	drop lzz bk_stkl?_a bk_stkl?_b bk_couple vsp_stkl?_a vsp_stkl?_b ///
		ztabfb_stkl?_a ztabfb_stkl?_b bmg_ehe kztab jbmg solzj sum_income

end




*** Calculation of Sozialversicherungsbeiträge

capture program drop sozialversicherung
program define sozialversicherung
	/*
	Input:
		  	durchschn_zusatzbeitrag: Average Zusatzbeitrag for health insurance
		  		after 2015 in %
		  	kvsatzan_allg: Allgmeiner not ermäßigter KV Beitragssatz as absolute
		  		value
		  	pvsatzan: as absolute value
		  	avsatzan: as absolute value
		  	bbgr_west: in Euro
		  	bbgrv_ost: in Euro
		  	bbgkpv: in Euro
		  	ost
		  	re4: in Cents
	
	Output: 
			abzug_sozialversicherung: 
				Sum of all Sozialversicherungsbeiträge of Arbeitnehmer
				in EURO
	Berechnung der Sozialversicherungsbeiträge des Arbeitnehmers.
	*/

	* Generate zusatzbeitrag
	gen zusatzbeitrag_intern = durchschn_zusatzbeitrag / 100
	replace zusatzbeitrag_intern = 0 if zusatzbeitrag_intern == .
	replace zusatzbeitrag_intern = zusatzbeitrag_intern / 2 /// 
		if jahr >= 2019 & jahr != .

	gen perc_kranken_pflegeversicherung =   ///
	    kvsatzan_allg                       ///
	    + zusatzbeitrag_intern     			///
	    + pvsatzan                          ///

	la var perc_kranken_pflegeversicherung ///
	    "Beitragssatz Kranken- und Pflegeversicherung"

	gen bbgrv = bbgrv_west
	replace bbgrv = bbgrv_ost if ost == 1

	gen bemessungsgrdl_rv = min(re4,bbgrv * 100)

	gen bemessungsgrdl_kvpv = min(re4,bbgkvpv * 100)

	gen abzug_sozialversicherung = 									///
		((perc_kranken_pflegeversicherung * bemessungsgrdl_kvpv) 	///
		+ (rvsatzan * bemessungsgrdl_rv) 							///
		+ (avsatzan * bemessungsgrdl_rv)) / 100

	drop bbgrv perc_kranken_pflegeversicherung ///
	bemessungsgrdl_rv bemessungsgrdl_kvpv zusatzbeitrag_intern
end



*** Calculation of Net Income depending on Steuerklasse
capture program drop net_income_calc
program define net_income_calc
	syntax, steuerklasse(string)
	/*
	Input:
	steuerklasse: Lohnsteuerklasse
	kirchensteuersatz: Kirchensteuersatz
	re4: gross income in cents
	lzz: Lohnzahlungszeitraum
	kvz
	ost
	pvz
	af: Indicator 1 if IV with Faktor
	f: Faktor for IV with Faktor
	pkpv: For privately insured the yearly amount spend on private insurance


	Output:
	net_income_work_stkl_`steuerklasse' : Nettoeinkommen


	Calculation Net Income (ignoring social security contributions)
	*/

	* Assign Steuerklasse
	if "`steuerklasse'" != "actual" {
		gen stkl    = `steuerklasse'
		la var stkl "Steuerklasse"
	}

	gen r = 1
	la var r "Kirchenzugehörigkeit"

	* Calculate taxes
	LST

	* Calculate Sozialversicherungsbeiträge
*	sozialversicherung

	* Calculate net income for normal employees
	gen net_income_work_stkl_`steuerklasse' = 		///
		re4 / 100 - lstlzz / 100   					///
		- solzlzz / 100 	///
		- bk / 100 * kirchensteuersatz 
		
	la var net_income_work_stkl_`steuerklasse' ///
	"Expected Income Steuerklasse `steuerklasse' "

	drop r stkl vsp ztabfb bk

end


capture program drop net_income_calc_sozb
program define net_income_calc_sozb
	syntax, steuerklasse(string)
	/*
	Input:
	steuerklasse: Lohnsteuerklasse
	kirchensteuersatz: Kirchensteuersatz
	re4: gross income in cents
	lzz: Lohnzahlungszeitraum
	kvz
	ost
	pvz
	af: Indicator 1 if IV with Faktor
	f: Faktor for IV with Faktor
	pkpv: For privately insured the yearly amount spend on private insurance


	Output:
	net_income_work_stkl_`steuerklasse' : Nettoeinkommen


	Calculation Net Income (ignoring social security contributions)
	*/

	* Assign Steuerklasse
	if "`steuerklasse'" != "actual" {
		gen stkl    = `steuerklasse'
		la var stkl "Steuerklasse"
	}

	gen r = 1
	la var r "Kirchenzugehörigkeit"

	* Calculate taxes
	LST

	* Calculate Sozialversicherungsbeiträge
	sozialversicherung

	* Calculate net income for normal employees
	gen net_income_work_stkl_`steuerklasse' = 		///
		re4 / 100 - lstlzz / 100   					///
		- solzlzz / 100 	///
		- bk / 100 * kirchensteuersatz ///
		- abzug_sozialversicherung
	la var net_income_work_stkl_`steuerklasse' ///
	"Expected Income Steuerklasse `steuerklasse' "

	drop r stkl vsp ztabfb bk abzug_sozialversicherung

end



*** Calculation of unemployment benefit
cap program drop arbeitslosengeld
program define arbeitslosengeld
	syntax, 				///
	stkl(string) 	///
	has_child(string)
	/* Calculate Arbeitslosengeld depending on Steuerklasse and whether recipent
	has a child eligible for Kindergeld. So far, it ignores the 
	Beitragsbemessungsgrenze for unemployment benefits

	Inputs:
		steuerklasse: Steuerklasse
		has_child: Indicator "no" or "yes" for at least one child eligible
			for child benefit
		bruttoentgelt: daily average gross income in last 365 days in Euro
		lzz: Lohnzahlungszeitraum, 1: Jahr; 2: Monat; 3: Woche; 4: Tag, should 
			be 4

	Outputs:
		exp_arbeitslg_stkl_`stkl'_k_`has_child': Expected daily unemployment
		benefit in Euro
	*/

	cap noi assert "`has_child'" == "yes" | "`has_child'" == "no"
	if _rc != 0{
	    di as error "has_child has value different from yes or no"
        error 197
	}

	gen re4 = bruttoentgelt
	replace re4 = re4 * 100 //re4 is in cents

	*church does not matter for calculation of unemployment benefits
	gen r = 0

	*Zuschlag für Kinderlose zur Pflegeversicherung not considered
	gen pvz = 0

	* Law: Use durchschnittlicher Beitrag KV
	gen kvz = 0
	replace kvz = durchschn_zusatzbeitrag if inrange(jahr,2015,2024)

	* Number of children not considered for Soli, so 0 for everyone
	gen zkf = 0

	gen ost = 0

    gen af = 1
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

	gen stkl = `stkl'

	* For calculation of Lohnsteuer Beitragsbemessungsgrenze West is used for everyone
	replace bbgrv_ost = bbgrv_west

	* Apply Beitragsbemessungsgrenze 
	* (not sure if needed for real data, but helpful for simulations)	
	* /!\ No adaption needed for lzz = 4!?
	
	gen btragsgrenze_tag_c = bbgrv_west/365 * 100
	la var btragsgrenze_tag_c "Beitragsbemessungsgrenze täglich in Cents"
	replace re4 = btragsgrenze_tag_c if btragsgrenze_tag_c < re4 & re4 != .

	* Calculate taxes
	LST
	
	* Pauschale for social security contributions
	gen sozpausch = 0.21
	replace sozpausch = 0.2 if jahr >= 2019 & jahr != .

	* Following § 153 SGB III Leistungsentgelt 
	gen leistungsentgelt = 			///
		re4 						///
		- lstlzz					///
		- solzlzz  					///	
		- sozpausch * re4	
	replace leistungsentgelt = leistungsentgelt / 100 // In Euro			
	la var leistungsentgelt "Leistungsentgelt in Euro"

	if "`has_child'" == "no" {
		gen exp_arbeitslg_stkl_`stkl'_k_`has_child' = 0.6 * leistungsentgelt
		* Rounding to the next full cent
		replace exp_arbeitslg_stkl_`stkl'_k_`has_child' ///
			= round(exp_arbeitslg_stkl_`stkl'_k_`has_child' * 100) / 100
	}
	if "`has_child'" == "yes" {
		gen exp_arbeitslg_stkl_`stkl'_k_`has_child' = 0.67 * leistungsentgelt	
		* Rounding to the next full cent
		replace exp_arbeitslg_stkl_`stkl'_k_`has_child' ///
			= round(exp_arbeitslg_stkl_`stkl'_k_`has_child' * 100) / 100
	}
	la var exp_arbeitslg_stkl_`stkl'_k_`has_child' ///
		"Expected Arbeitslosengeld Steuerklasse `steuerklasse', `has_child' children"

	* Drop variables created only for calculation of unemployment benefit
	drop r pvz kvz zkf ost sozpausch af f priv_ins_pen priv_ins_health ///
		ind_priv_ins_health_emp_supp pkpv pvs lzzfreib lzzhinzu stkl

	* Drop subresults from function
	drop re4 leistungsentgelt lstlzz solzlzz bk vsp ztabfb btragsgrenze_tag_c
	* Drop variables from year_dependendent_vars_for_tax_calculator.do
	// drop bbgrv_ost bbgrv_west kvsatzan_pre kvsatzag_pre vhb_stkl_ungl_3 	///
	// vhb_stkl_3 vhb_bef2010								  					///
	// vsp_satz_günstigerprüfung vsp_satz_2004_regelung kfb_stkl_4 			///
	// kfb_stkl_1_3 durchschn_zusatzbeitrag

end




*** Calculation of parental benefit

cap program drop parental_benefit
program define parental_benefit
	syntax, 				///
	stkl(string) 			///
	zkf(string)				///
	is_in_church(string)	
	
	/* Calculate Elterngeld depending on Steuerklasse 

	Inputs:
		stkl: Steuerklasse 
		zkf: Number of children
		is_in_church: Indicator "no" or "yes" for being in a church
		bruttoentgelt: gross income in Euro		

	Output: 
		parental_ben`stkl': Parental Benefit with Steuerklasse `stkl' in Euro

	MISSING: For social security contributions, in Midijob (§ 20 Absatz 2) the
	real social security contributions are taken into account

	*/

	cap noi assert "`is_in_church'" == "yes" | "`is_in_church'" == "no"
	if _rc != 0{
	    di as error "is_in_church has value different from yes or no"
        error 197
	}

	/* Church tax reduces estimated net income by a rate of 8% (independent of
	   truely paid church tax) */
	gen church_tax_rate = .
	gen r = .
	disp "`is_in_church'"
	if "`is_in_church'" == "yes"{
		replace church_tax_rate = 0.08
		replace r = 1
	}
	if "`is_in_church'" == "no"{
		replace church_tax_rate = 0
		replace r = 1
	}

	la var church_tax_rate "Parental benefit: Applied Church Tax Rate"
	la var r "Kirchenzugehörigkeit"

	gen stkl 	= `stkl'
	gen zkf		= `zkf'

	*Zuschlag für Kinderlose zur Pflegeversicherung (§ 55 Absatz 3) not considered
	gen pvz = 0

	* Law: Use durchschnittlicher Beitrag KV
	gen kvz = 0
	replace kvz = durchschn_zusatzbeitrag if inrange(jahr,2015,2024)

	gen ost = 0
	
    gen af = 0
    la var af "Indicator for IV with Faktor"

    gen f = 0
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

	gen re4 = bruttoentgelt
	replace re4 = re4 * 100 //re4 is in cents
	replace re4 = bbgrv_west/12 * 100 if bbgrv_west/12 * 100 < re4

	* Calculate taxes
	LST

	* Social security contributions (vor 2012 tatsächlich gezahlte Beiträge)
	gen kvsatz_parent_ben = 0.09
	la var kvsatz_parent_ben "Parental benefit: Rate for health insurance"
	gen rvsatz_parent_ben = 0.1
	la var rvsatz_parent_ben "Parental benefit: Rate for pension insurance"
	gen avsatz_parent_ben = 0.02
	la var avsatz_parent_ben "Parental benefit: Rate for pension insurance"

	* Pauschale for social security contributions
	gen sum_social_sec ///
		= kvsatz_parent_ben + rvsatz_parent_ben + avsatz_parent_ben
	la var sum_social_sec ///
		"Parental benefit: Sum of contributions to social security"

	gen nettoentgelt = 				///
		re4 						///
		- lstlzz					///
		- solzlzz  					///
		- sum_social_sec * re4			
	replace nettoentgelt = nettoentgelt - bk * church_tax_rate if r == 1
	la var nettoentgelt "Parental benefit: Nettoentgelt"

	* Convert Nettoentgelt to Euro
	replace nettoentgelt = nettoentgelt / 100

	* Reduce Nettoentgelt by monthly anp (Arbeitnehmerpauschbetrag)
	replace nettoentgelt = nettoentgelt - anp / 12


	/* Replacement Rate: In den Fällen, in denen das Einkommen aus
	   Erwerbstätigkeit vor der Geburt geringer als 1 000 Euro war, erhöht sich
	   der Prozentsatz von 67 Prozent um 0,1 Prozentpunkte für je 2 Euro, um
	   die dieses Einkommen den Betrag von 1 000 Euro unterschreitet, auf bis
	   zu 100 Prozent.In den Fällen, in denen das Einkommen aus
	   Erwerbstätigkeit vor der Geburt höher als 1 200 Euro war, sinkt der
	   Prozentsatz von 67 Prozent um 0,1 Prozentpunkte für je 2 Euro, um die
	   dieses Einkommen den Betrag von 1 200 Euro überschreitet, auf bis zu 65
	   Prozent */

	gen repl_rate = 0.67
	la var repl_rate ///
		"Replacement rate of Nettoentgelt (function of Nettoentgelt)"
	
	gen dist_to_1000 = 1000 - nettoentgelt
	replace dist_to_1000 = 2 * floor(dist_to_1000/2)
	la var dist_to_1000 "Distance to 1000€ in 2€ steps"
	replace repl_rate = 0.67 + dist_to_1000 / 2 * 0.001 if dist_to_1000 > 0
	replace repl_rate = 1 if repl_rate > 1 & repl_rate < .

	gen dist_to_1200 = 1200 - nettoentgelt
	replace dist_to_1200 = 2 * floor(dist_to_1200/2)
	la var dist_to_1200 "Distance to 1200€ in 2€ steps"
	replace repl_rate = 0.67 + dist_to_1200 / 2 * 0.001 ///
		if dist_to_1200 < 0 & jahr >= 2011
	replace repl_rate = 0.65 if repl_rate < 0.65 & jahr >= 2011

	* Calculation of benefit 
	gen parental_ben`stkl' = repl_rate * nettoentgelt

	replace parental_ben`stkl' = 300 if parental_ben`stkl' < 300
	replace parental_ben`stkl' = 1800 ///
		if parental_ben`stkl' > 1800 & parental_ben`stkl' < .
	la var parental_ben`stkl' "Parental benefit"

	* Not implemented: For incomes above a very high threshold, the benefit drops to 0€

	* Drop variables created only for calculation of parental benefit
	drop church_tax_rate r pvz kvz zkf ost af f stkl re4 kvsatz_parent_ben 	///
		lstlzz rvsatz_parent_ben avsatz_parent_ben sum_social_sec 			///
		solzlzz bk vsp ztabfb repl_rate dist_to_1000 dist_to_1200 			///
		pkpv pvs priv_ins_pen priv_ins_health ind_priv_ins_health_emp_supp	///
		lzzfreib lzzhinzu

end



*** Calculation of Kurzarbeitgeld
cap program drop kurzarbeitgeld
program define kurzarbeitgeld
	syntax, 				///
	stkl(string) 	///
	/* Calculate Kurzarbeitergeld depending on Steuerklasse 
	Assumption: Ist-Entgelt is 0

	Inputs:
		stkl: Steuerklasse
			for child benefit
		lzz: Lohnzahlungszeitraum, 1: Jahr; 2: Monat; 3: Woche; 4: Tag
		bruttoentgelt: average gross income in lzz period in Euro
		jahr: year of kurzarbeit payment

	Output: 

	/!\ Missing: Cap at Beitragsbemessungsgrenze
	* Child: Higher level of short-time replacement (Leistungssatz 1 and 2)

	*/

	*church does not matter for calculation of short time work
	gen r = 0

	*Zuschlag für Kinderlose zur Pflegeversicherung not considered
	gen pvz = 0

	* Law: Use durchschnittlicher Beitrag KV
	gen kvz = 0
	replace kvz = durchschn_zusatzbeitrag if inrange(jahr,2015,2021)

	* Number of children not considered for Soli, so 0 for everyone
	gen zkf = 0

	gen ost = 0
	
    gen af = 1
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

	gen stkl 	= `stkl'

	gen re4 = bruttoentgelt
	replace re4 = re4 * 100 //re4 is in cents
	replace re4 = bbgrv_west/12 * 100 if bbgrv_west/12 * 100 < re4

	* Calculate taxes
	LST

	* Pauschale for social security contributions
	gen sozpausch = 0.21
	replace sozpausch = 0.2 if jahr >= 2019 & jahr != .

	gen nettoentgelt_stkl`stkl' = 	///
		re4 						///
		- lstlzz					///
		- solzlzz  					///	
		- sozpausch * re4				

	replace nettoentgelt_stkl`stkl' = nettoentgelt_stkl`stkl' / 100

	replace nettoentgelt_stkl`stkl' = round(nettoentgelt_stkl`stkl',.01)
	la var nettoentgelt_stkl`stkl' ///
		"Nettoentgelt Steuerklasse `stkl'"
	
	* Drop variables created only for calculation of kurzarbeitergeld
	drop r pvz kvz zkf ost af f stkl sozpausch re4 lstlzz solzlzz bk ///
		vsp ztabfb priv_ins_pen priv_ins_health ind_priv_ins_health_emp_supp ///
		pkpv pvs lzzfreib lzzhinzu

	// * Drop variables from year_dependendent_vars_for_tax_calculator.do
	// drop bbgrv_ost bbgrv_west kvsatzan_pre kvsatzag_pre vhb_stkl_ungl_3 	///
	// vhb_stkl_3 vhb_bef2010 vspvor vspmax1_intern vspmax2_intern vspkurz_intern 	///
	// vsp_satz_günstigerprüfung vsp_satz_2004_regelung kfb_stkl_4 			///
	// kfb_stkl_1_3 durchschn_zusatzbeitrag

end


