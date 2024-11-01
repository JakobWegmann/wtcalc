/* Variable values for the tax calculator 
generated in import_year_dependent_vars.do */

quietly gen bbgrv_ost = . 
quietly tostring bbgrv_ost, replace

quietly gen bbgrv_west = . 
quietly tostring bbgrv_west, replace

quietly gen avsatzan = . 
quietly tostring avsatzan, replace

quietly gen rvsatzan = . 
quietly tostring rvsatzan, replace

quietly gen tbsorv = . 
quietly tostring tbsorv, replace

quietly gen bbgkvpv = . 
quietly tostring bbgkvpv, replace

quietly gen kvsatzan_allg = . 
quietly tostring kvsatzan_allg, replace

quietly gen kvsatzan_pre = . 
quietly tostring kvsatzan_pre, replace

quietly gen kvsatzag_pre = . 
quietly tostring kvsatzag_pre, replace

quietly gen pvsatzan = . 
quietly tostring pvsatzan, replace

quietly gen pvsatzan_sachsen = . 
quietly tostring pvsatzan_sachsen, replace

quietly gen pvsatzag = . 
quietly tostring pvsatzag, replace

quietly gen pvsatzag_sachsen = . 
quietly tostring pvsatzag_sachsen, replace

quietly gen pvz_wo_child = . 
quietly tostring pvz_wo_child, replace

quietly gen pvz_red_more_2_child = . 
quietly tostring pvz_red_more_2_child, replace

quietly gen w1stkl5 = . 
quietly tostring w1stkl5, replace

quietly gen w2stkl5 = . 
quietly tostring w2stkl5, replace

quietly gen w3stkl5 = . 
quietly tostring w3stkl5, replace

quietly gen mindest_lst_w1stkl5 = . 
quietly tostring mindest_lst_w1stkl5, replace

quietly gen lst_w1stkl5_rate = . 
quietly tostring lst_w1stkl5_rate, replace

quietly gen lst_w2stkl5_rate = . 
quietly tostring lst_w2stkl5_rate, replace

quietly gen lst_w3stkl5_rate = . 
quietly tostring lst_w3stkl5_rate, replace

quietly gen anp = . 
quietly tostring anp, replace

quietly gen sap = . 
quietly tostring sap, replace

quietly gen vhb_stkl_ungl_3 = . 
quietly tostring vhb_stkl_ungl_3, replace

quietly gen vhb_stkl_3 = . 
quietly tostring vhb_stkl_3, replace

quietly gen min_vrsrge_pausch = . 
quietly tostring min_vrsrge_pausch, replace

quietly gen vhb_bef2010 = . 
quietly tostring vhb_bef2010, replace

quietly gen vspvor = . 
quietly tostring vspvor, replace

quietly gen vspmax1 = . 
quietly tostring vspmax1, replace

quietly gen vspmax2 = . 
quietly tostring vspmax2, replace

quietly gen vspkurz = . 
quietly tostring vspkurz, replace

quietly gen vsp_satz_günstigerprüfung = . 
quietly tostring vsp_satz_günstigerprüfung, replace

quietly gen vsp_satz_2004_regelung = . 
quietly tostring vsp_satz_2004_regelung, replace

quietly gen gfb = . 
quietly tostring gfb, replace

quietly gen y_abzug_2 = . 
quietly tostring y_abzug_2, replace

quietly gen z_abzug_1 = . 
quietly tostring z_abzug_1, replace

quietly gen z_abzug_2 = . 
quietly tostring z_abzug_2, replace

quietly gen zahl_1_1 = . 
quietly tostring zahl_1_1, replace

quietly gen zahl_1_2 = . 
quietly tostring zahl_1_2, replace

quietly gen threshold_1 = . 
quietly tostring threshold_1, replace

quietly gen zahl_2_1 = . 
quietly tostring zahl_2_1, replace

quietly gen zahl_2_2 = . 
quietly tostring zahl_2_2, replace

quietly gen zahl_2_3 = . 
quietly tostring zahl_2_3, replace

quietly gen threshold_2 = . 
quietly tostring threshold_2, replace

quietly gen rate_3 = . 
quietly tostring rate_3, replace

quietly gen zahl_3_1 = . 
quietly tostring zahl_3_1, replace

quietly gen threshold_3 = . 
quietly tostring threshold_3, replace

quietly gen rate_4 = . 
quietly tostring rate_4, replace

quietly gen zahl_4_1 = . 
quietly tostring zahl_4_1, replace

quietly gen threshold_4 = . 
quietly tostring threshold_4, replace

quietly gen soli_satz = . 
quietly tostring soli_satz, replace

quietly gen mindest_soli = . 
quietly tostring mindest_soli, replace

quietly gen solzfrei = . 
quietly tostring solzfrei, replace

quietly gen kfb_stkl_4 = . 
quietly tostring kfb_stkl_4, replace

quietly gen kfb_stkl_1_3 = . 
quietly tostring kfb_stkl_1_3, replace

quietly gen durchschn_zusatzbeitrag = . 
quietly tostring durchschn_zusatzbeitrag, replace

quietly gen efa = . 
quietly tostring efa, replace



* Year 2005
quietly replace bbgrv_ost = "." if jahr == 2005
quietly replace bbgrv_west = "62400" if jahr == 2005
quietly replace avsatzan = ".0325" if jahr == 2005
quietly replace rvsatzan = ".0975" if jahr == 2005
quietly replace tbsorv = ".2" if jahr == 2005
quietly replace bbgkvpv = "42300" if jahr == 2005
quietly replace kvsatzan_allg = ".07325" if jahr == 2005
quietly replace kvsatzan_pre = "." if jahr == 2005
quietly replace kvsatzag_pre = "." if jahr == 2005
quietly replace pvsatzan = ".0085" if jahr == 2005
quietly replace pvsatzan_sachsen = "" if jahr == 2005
quietly replace pvsatzag = ".0085" if jahr == 2005
quietly replace pvsatzag_sachsen = "" if jahr == 2005
quietly replace pvz_wo_child = "." if jahr == 2005
quietly replace pvz_red_more_2_child = "." if jahr == 2005
quietly replace w1stkl5 = "9144" if jahr == 2005
quietly replace w2stkl5 = "25812" if jahr == 2005
quietly replace w3stkl5 = "10000000" if jahr == 2005
quietly replace mindest_lst_w1stkl5 = ".15" if jahr == 2005
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2005
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2005
quietly replace lst_w3stkl5_rate = "10000000" if jahr == 2005
quietly replace anp = "920" if jahr == 2005
quietly replace sap = "36" if jahr == 2005
quietly replace vhb_stkl_ungl_3 = "." if jahr == 2005
quietly replace vhb_stkl_3 = "." if jahr == 2005
quietly replace min_vrsrge_pausch = ".11" if jahr == 2005
quietly replace vhb_bef2010 = "1500" if jahr == 2005
quietly replace vspvor = "3068" if jahr == 2005
quietly replace vspmax1 = "1334" if jahr == 2005
quietly replace vspmax2 = "667" if jahr == 2005
quietly replace vspkurz = "1134" if jahr == 2005
quietly replace vsp_satz_günstigerprüfung = ".16" if jahr == 2005
quietly replace vsp_satz_2004_regelung = ".2" if jahr == 2005
quietly replace gfb = "7664" if jahr == 2005
quietly replace y_abzug_2 = "10000" if jahr == 2005
quietly replace z_abzug_1 = "12739" if jahr == 2005
quietly replace z_abzug_2 = "10000" if jahr == 2005
quietly replace zahl_1_1 = "883.74" if jahr == 2005
quietly replace zahl_1_2 = "1500" if jahr == 2005
quietly replace threshold_1 = "7665" if jahr == 2005
quietly replace zahl_2_1 = "228.74" if jahr == 2005
quietly replace zahl_2_2 = "2397" if jahr == 2005
quietly replace zahl_2_3 = "989" if jahr == 2005
quietly replace threshold_2 = "12740" if jahr == 2005
quietly replace rate_3 = ".42" if jahr == 2005
quietly replace zahl_3_1 = "7914" if jahr == 2005
quietly replace threshold_3 = "52152" if jahr == 2005
quietly replace rate_4 = "10000000" if jahr == 2005
quietly replace zahl_4_1 = "10000000" if jahr == 2005
quietly replace threshold_4 = "10000000" if jahr == 2005
quietly replace soli_satz = "5.5" if jahr == 2005
quietly replace mindest_soli = "20" if jahr == 2005
quietly replace solzfrei = "972" if jahr == 2005
quietly replace kfb_stkl_4 = "2904" if jahr == 2005
quietly replace kfb_stkl_1_3 = "5808" if jahr == 2005
quietly replace durchschn_zusatzbeitrag = "." if jahr == 2005
quietly replace efa = "1308" if jahr == 2005

* Year 2006
quietly replace bbgrv_ost = "." if jahr == 2006
quietly replace bbgrv_west = "63000" if jahr == 2006
quietly replace avsatzan = ".0325" if jahr == 2006
quietly replace rvsatzan = ".0975" if jahr == 2006
quietly replace tbsorv = ".24" if jahr == 2006
quietly replace bbgkvpv = "42750" if jahr == 2006
quietly replace kvsatzan_allg = ".0755" if jahr == 2006
quietly replace kvsatzan_pre = "." if jahr == 2006
quietly replace kvsatzag_pre = "." if jahr == 2006
quietly replace pvsatzan = ".0085" if jahr == 2006
quietly replace pvsatzan_sachsen = "" if jahr == 2006
quietly replace pvsatzag = ".0085" if jahr == 2006
quietly replace pvsatzag_sachsen = "" if jahr == 2006
quietly replace pvz_wo_child = "." if jahr == 2006
quietly replace pvz_red_more_2_child = "." if jahr == 2006
quietly replace w1stkl5 = "9144" if jahr == 2006
quietly replace w2stkl5 = "25812" if jahr == 2006
quietly replace w3stkl5 = "10000000" if jahr == 2006
quietly replace mindest_lst_w1stkl5 = ".15" if jahr == 2006
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2006
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2006
quietly replace lst_w3stkl5_rate = "10000000" if jahr == 2006
quietly replace anp = "920" if jahr == 2006
quietly replace sap = "36" if jahr == 2006
quietly replace vhb_stkl_ungl_3 = "." if jahr == 2006
quietly replace vhb_stkl_3 = "." if jahr == 2006
quietly replace min_vrsrge_pausch = ".11" if jahr == 2006
quietly replace vhb_bef2010 = "1500" if jahr == 2006
quietly replace vspvor = "3068" if jahr == 2006
quietly replace vspmax1 = "1334" if jahr == 2006
quietly replace vspmax2 = "667" if jahr == 2006
quietly replace vspkurz = "1134" if jahr == 2006
quietly replace vsp_satz_günstigerprüfung = ".16" if jahr == 2006
quietly replace vsp_satz_2004_regelung = ".2" if jahr == 2006
quietly replace gfb = "7664" if jahr == 2006
quietly replace y_abzug_2 = "10000" if jahr == 2006
quietly replace z_abzug_1 = "12739" if jahr == 2006
quietly replace z_abzug_2 = "10000" if jahr == 2006
quietly replace zahl_1_1 = "883.74" if jahr == 2006
quietly replace zahl_1_2 = "1500" if jahr == 2006
quietly replace threshold_1 = "7665" if jahr == 2006
quietly replace zahl_2_1 = "228.74" if jahr == 2006
quietly replace zahl_2_2 = "2397" if jahr == 2006
quietly replace zahl_2_3 = "989" if jahr == 2006
quietly replace threshold_2 = "12740" if jahr == 2006
quietly replace rate_3 = ".42" if jahr == 2006
quietly replace zahl_3_1 = "7914" if jahr == 2006
quietly replace threshold_3 = "52152" if jahr == 2006
quietly replace rate_4 = "10000000" if jahr == 2006
quietly replace zahl_4_1 = "10000000" if jahr == 2006
quietly replace threshold_4 = "10000000" if jahr == 2006
quietly replace soli_satz = "5.5" if jahr == 2006
quietly replace mindest_soli = "20" if jahr == 2006
quietly replace solzfrei = "972" if jahr == 2006
quietly replace kfb_stkl_4 = "2904" if jahr == 2006
quietly replace kfb_stkl_1_3 = "5808" if jahr == 2006
quietly replace durchschn_zusatzbeitrag = "." if jahr == 2006
quietly replace efa = "1308" if jahr == 2006

* Year 2007
quietly replace bbgrv_ost = "." if jahr == 2007
quietly replace bbgrv_west = "63000" if jahr == 2007
quietly replace avsatzan = ".021" if jahr == 2007
quietly replace rvsatzan = ".0995" if jahr == 2007
quietly replace tbsorv = ".28" if jahr == 2007
quietly replace bbgkvpv = "42750" if jahr == 2007
quietly replace kvsatzan_allg = ".0785" if jahr == 2007
quietly replace kvsatzan_pre = "." if jahr == 2007
quietly replace kvsatzag_pre = "." if jahr == 2007
quietly replace pvsatzan = ".0085" if jahr == 2007
quietly replace pvsatzan_sachsen = "" if jahr == 2007
quietly replace pvsatzag = ".0085" if jahr == 2007
quietly replace pvsatzag_sachsen = "" if jahr == 2007
quietly replace pvz_wo_child = "." if jahr == 2007
quietly replace pvz_red_more_2_child = "." if jahr == 2007
quietly replace w1stkl5 = "9144" if jahr == 2007
quietly replace w2stkl5 = "25812" if jahr == 2007
quietly replace w3stkl5 = "200000" if jahr == 2007
quietly replace mindest_lst_w1stkl5 = ".15" if jahr == 2007
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2007
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2007
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2007
quietly replace anp = "920" if jahr == 2007
quietly replace sap = "36" if jahr == 2007
quietly replace vhb_stkl_ungl_3 = "." if jahr == 2007
quietly replace vhb_stkl_3 = "." if jahr == 2007
quietly replace min_vrsrge_pausch = ".11" if jahr == 2007
quietly replace vhb_bef2010 = "1500" if jahr == 2007
quietly replace vspvor = "3068" if jahr == 2007
quietly replace vspmax1 = "1334" if jahr == 2007
quietly replace vspmax2 = "667" if jahr == 2007
quietly replace vspkurz = "1134" if jahr == 2007
quietly replace vsp_satz_günstigerprüfung = ".16" if jahr == 2007
quietly replace vsp_satz_2004_regelung = ".2" if jahr == 2007
quietly replace gfb = "7664" if jahr == 2007
quietly replace y_abzug_2 = "10000" if jahr == 2007
quietly replace z_abzug_1 = "12739" if jahr == 2007
quietly replace z_abzug_2 = "10000" if jahr == 2007
quietly replace zahl_1_1 = "883.74" if jahr == 2007
quietly replace zahl_1_2 = "1500" if jahr == 2007
quietly replace threshold_1 = "7665" if jahr == 2007
quietly replace zahl_2_1 = "228.74" if jahr == 2007
quietly replace zahl_2_2 = "2397" if jahr == 2007
quietly replace zahl_2_3 = "989" if jahr == 2007
quietly replace threshold_2 = "12740" if jahr == 2007
quietly replace rate_3 = ".42" if jahr == 2007
quietly replace zahl_3_1 = "7914" if jahr == 2007
quietly replace threshold_3 = "52152" if jahr == 2007
quietly replace rate_4 = ".45" if jahr == 2007
quietly replace zahl_4_1 = "15414" if jahr == 2007
quietly replace threshold_4 = "250001" if jahr == 2007
quietly replace soli_satz = "5.5" if jahr == 2007
quietly replace mindest_soli = "20" if jahr == 2007
quietly replace solzfrei = "972" if jahr == 2007
quietly replace kfb_stkl_4 = "2904" if jahr == 2007
quietly replace kfb_stkl_1_3 = "5808" if jahr == 2007
quietly replace durchschn_zusatzbeitrag = "." if jahr == 2007
quietly replace efa = "1308" if jahr == 2007

* Year 2008
quietly replace bbgrv_ost = "." if jahr == 2008
quietly replace bbgrv_west = "63600" if jahr == 2008
quietly replace avsatzan = ".0165" if jahr == 2008
quietly replace rvsatzan = ".0995" if jahr == 2008
quietly replace tbsorv = ".32" if jahr == 2008
quietly replace bbgkvpv = "43200" if jahr == 2008
quietly replace kvsatzan_allg = ".079" if jahr == 2008
quietly replace kvsatzan_pre = "." if jahr == 2008
quietly replace kvsatzag_pre = "." if jahr == 2008
quietly replace pvsatzan = ".00975" if jahr == 2008
quietly replace pvsatzan_sachsen = "" if jahr == 2008
quietly replace pvsatzag = ".00975" if jahr == 2008
quietly replace pvsatzag_sachsen = "" if jahr == 2008
quietly replace pvz_wo_child = "." if jahr == 2008
quietly replace pvz_red_more_2_child = "." if jahr == 2008
quietly replace w1stkl5 = "9144" if jahr == 2008
quietly replace w2stkl5 = "25812" if jahr == 2008
quietly replace w3stkl5 = "200000" if jahr == 2008
quietly replace mindest_lst_w1stkl5 = ".15" if jahr == 2008
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2008
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2008
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2008
quietly replace anp = "920" if jahr == 2008
quietly replace sap = "36" if jahr == 2008
quietly replace vhb_stkl_ungl_3 = "." if jahr == 2008
quietly replace vhb_stkl_3 = "." if jahr == 2008
quietly replace min_vrsrge_pausch = ".11" if jahr == 2008
quietly replace vhb_bef2010 = "1500" if jahr == 2008
quietly replace vspvor = "3068" if jahr == 2008
quietly replace vspmax1 = "1334" if jahr == 2008
quietly replace vspmax2 = "667" if jahr == 2008
quietly replace vspkurz = "1134" if jahr == 2008
quietly replace vsp_satz_günstigerprüfung = ".16" if jahr == 2008
quietly replace vsp_satz_2004_regelung = ".2" if jahr == 2008
quietly replace gfb = "7664" if jahr == 2008
quietly replace y_abzug_2 = "10000" if jahr == 2008
quietly replace z_abzug_1 = "12739" if jahr == 2008
quietly replace z_abzug_2 = "10000" if jahr == 2008
quietly replace zahl_1_1 = "883.74" if jahr == 2008
quietly replace zahl_1_2 = "1500" if jahr == 2008
quietly replace threshold_1 = "7665" if jahr == 2008
quietly replace zahl_2_1 = "228.74" if jahr == 2008
quietly replace zahl_2_2 = "2397" if jahr == 2008
quietly replace zahl_2_3 = "989" if jahr == 2008
quietly replace threshold_2 = "12740" if jahr == 2008
quietly replace rate_3 = ".42" if jahr == 2008
quietly replace zahl_3_1 = "7914" if jahr == 2008
quietly replace threshold_3 = "52152" if jahr == 2008
quietly replace rate_4 = ".45" if jahr == 2008
quietly replace zahl_4_1 = "15414" if jahr == 2008
quietly replace threshold_4 = "250001" if jahr == 2008
quietly replace soli_satz = "5.5" if jahr == 2008
quietly replace mindest_soli = "20" if jahr == 2008
quietly replace solzfrei = "972" if jahr == 2008
quietly replace kfb_stkl_4 = "2904" if jahr == 2008
quietly replace kfb_stkl_1_3 = "5808" if jahr == 2008
quietly replace durchschn_zusatzbeitrag = "." if jahr == 2008
quietly replace efa = "1308" if jahr == 2008

* Year 2009
quietly replace bbgrv_ost = "." if jahr == 2009
quietly replace bbgrv_west = "64800" if jahr == 2009
quietly replace avsatzan = ".014" if jahr == 2009
quietly replace rvsatzan = ".0995" if jahr == 2009
quietly replace tbsorv = ".36" if jahr == 2009
quietly replace bbgkvpv = "44100" if jahr == 2009
quietly replace kvsatzan_allg = ".0805" if jahr == 2009
quietly replace kvsatzan_pre = "." if jahr == 2009
quietly replace kvsatzag_pre = "." if jahr == 2009
quietly replace pvsatzan = ".00975" if jahr == 2009
quietly replace pvsatzan_sachsen = "" if jahr == 2009
quietly replace pvsatzag = ".00975" if jahr == 2009
quietly replace pvsatzag_sachsen = "" if jahr == 2009
quietly replace pvz_wo_child = ".0025" if jahr == 2009
quietly replace pvz_red_more_2_child = "." if jahr == 2009
quietly replace w1stkl5 = "9225" if jahr == 2009
quietly replace w2stkl5 = "26276" if jahr == 2009
quietly replace w3stkl5 = "200320" if jahr == 2009
quietly replace mindest_lst_w1stkl5 = ".14" if jahr == 2009
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2009
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2009
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2009
quietly replace anp = "920" if jahr == 2009
quietly replace sap = "36" if jahr == 2009
quietly replace vhb_stkl_ungl_3 = "." if jahr == 2009
quietly replace vhb_stkl_3 = "." if jahr == 2009
quietly replace min_vrsrge_pausch = ".11" if jahr == 2009
quietly replace vhb_bef2010 = "1500" if jahr == 2009
quietly replace vspvor = "3068" if jahr == 2009
quietly replace vspmax1 = "1334" if jahr == 2009
quietly replace vspmax2 = "667" if jahr == 2009
quietly replace vspkurz = "1134" if jahr == 2009
quietly replace vsp_satz_günstigerprüfung = ".16" if jahr == 2009
quietly replace vsp_satz_2004_regelung = ".2" if jahr == 2009
quietly replace gfb = "7834" if jahr == 2009
quietly replace y_abzug_2 = "10000" if jahr == 2009
quietly replace z_abzug_1 = "13139" if jahr == 2009
quietly replace z_abzug_2 = "10000" if jahr == 2009
quietly replace zahl_1_1 = "939.68" if jahr == 2009
quietly replace zahl_1_2 = "1400" if jahr == 2009
quietly replace threshold_1 = "7835" if jahr == 2009
quietly replace zahl_2_1 = "228.74" if jahr == 2009
quietly replace zahl_2_2 = "2397" if jahr == 2009
quietly replace zahl_2_3 = "1007" if jahr == 2009
quietly replace threshold_2 = "13140" if jahr == 2009
quietly replace rate_3 = ".42" if jahr == 2009
quietly replace zahl_3_1 = "8064" if jahr == 2009
quietly replace threshold_3 = "52552" if jahr == 2009
quietly replace rate_4 = ".45" if jahr == 2009
quietly replace zahl_4_1 = "15576" if jahr == 2009
quietly replace threshold_4 = "250401" if jahr == 2009
quietly replace soli_satz = "5.5" if jahr == 2009
quietly replace mindest_soli = "20" if jahr == 2009
quietly replace solzfrei = "972" if jahr == 2009
quietly replace kfb_stkl_4 = "3012" if jahr == 2009
quietly replace kfb_stkl_1_3 = "6024" if jahr == 2009
quietly replace durchschn_zusatzbeitrag = "." if jahr == 2009
quietly replace efa = "1308" if jahr == 2009

* Year 2010
quietly replace bbgrv_ost = "55800" if jahr == 2010
quietly replace bbgrv_west = "66000" if jahr == 2010
quietly replace avsatzan = ".014" if jahr == 2010
quietly replace rvsatzan = ".0995" if jahr == 2010
quietly replace tbsorv = ".4" if jahr == 2010
quietly replace bbgkvpv = "45000" if jahr == 2010
quietly replace kvsatzan_allg = ".079" if jahr == 2010
quietly replace kvsatzan_pre = ".076" if jahr == 2010
quietly replace kvsatzag_pre = ".067" if jahr == 2010
quietly replace pvsatzan = ".00975" if jahr == 2010
quietly replace pvsatzan_sachsen = ".01475" if jahr == 2010
quietly replace pvsatzag = ".00975" if jahr == 2010
quietly replace pvsatzag_sachsen = ".00475" if jahr == 2010
quietly replace pvz_wo_child = ".0025" if jahr == 2010
quietly replace pvz_red_more_2_child = "." if jahr == 2010
quietly replace w1stkl5 = "9429" if jahr == 2010
quietly replace w2stkl5 = "26441" if jahr == 2010
quietly replace w3stkl5 = "200584" if jahr == 2010
quietly replace mindest_lst_w1stkl5 = ".14" if jahr == 2010
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2010
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2010
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2010
quietly replace anp = "920" if jahr == 2010
quietly replace sap = "36" if jahr == 2010
quietly replace vhb_stkl_ungl_3 = "1900" if jahr == 2010
quietly replace vhb_stkl_3 = "3000" if jahr == 2010
quietly replace min_vrsrge_pausch = ".12" if jahr == 2010
quietly replace vhb_bef2010 = "." if jahr == 2010
quietly replace vspvor = "." if jahr == 2010
quietly replace vspmax1 = "." if jahr == 2010
quietly replace vspmax2 = "." if jahr == 2010
quietly replace vspkurz = "." if jahr == 2010
quietly replace vsp_satz_günstigerprüfung = "." if jahr == 2010
quietly replace vsp_satz_2004_regelung = "." if jahr == 2010
quietly replace gfb = "8004" if jahr == 2010
quietly replace y_abzug_2 = "10000" if jahr == 2010
quietly replace z_abzug_1 = "13469" if jahr == 2010
quietly replace z_abzug_2 = "10000" if jahr == 2010
quietly replace zahl_1_1 = "912.17" if jahr == 2010
quietly replace zahl_1_2 = "1400" if jahr == 2010
quietly replace threshold_1 = "8005" if jahr == 2010
quietly replace zahl_2_1 = "228.74" if jahr == 2010
quietly replace zahl_2_2 = "2397" if jahr == 2010
quietly replace zahl_2_3 = "1038" if jahr == 2010
quietly replace threshold_2 = "13470" if jahr == 2010
quietly replace rate_3 = ".42" if jahr == 2010
quietly replace zahl_3_1 = "8172" if jahr == 2010
quietly replace threshold_3 = "52882" if jahr == 2010
quietly replace rate_4 = ".45" if jahr == 2010
quietly replace zahl_4_1 = "15694" if jahr == 2010
quietly replace threshold_4 = "250731" if jahr == 2010
quietly replace soli_satz = "5.5" if jahr == 2010
quietly replace mindest_soli = "20" if jahr == 2010
quietly replace solzfrei = "972" if jahr == 2010
quietly replace kfb_stkl_4 = "3504" if jahr == 2010
quietly replace kfb_stkl_1_3 = "7008" if jahr == 2010
quietly replace durchschn_zusatzbeitrag = "." if jahr == 2010
quietly replace efa = "1308" if jahr == 2010

* Year 2011
quietly replace bbgrv_ost = "57600" if jahr == 2011
quietly replace bbgrv_west = "66000" if jahr == 2011
quietly replace avsatzan = ".015" if jahr == 2011
quietly replace rvsatzan = ".0995" if jahr == 2011
quietly replace tbsorv = ".44" if jahr == 2011
quietly replace bbgkvpv = "44550" if jahr == 2011
quietly replace kvsatzan_allg = ".082" if jahr == 2011
quietly replace kvsatzan_pre = ".079" if jahr == 2011
quietly replace kvsatzag_pre = ".07" if jahr == 2011
quietly replace pvsatzan = ".00975" if jahr == 2011
quietly replace pvsatzan_sachsen = ".01475" if jahr == 2011
quietly replace pvsatzag = ".00975" if jahr == 2011
quietly replace pvsatzag_sachsen = ".00475" if jahr == 2011
quietly replace pvz_wo_child = ".0025" if jahr == 2011
quietly replace pvz_red_more_2_child = "." if jahr == 2011
quietly replace w1stkl5 = "9429" if jahr == 2011
quietly replace w2stkl5 = "26441" if jahr == 2011
quietly replace w3stkl5 = "200584" if jahr == 2011
quietly replace mindest_lst_w1stkl5 = ".14" if jahr == 2011
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2011
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2011
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2011
quietly replace anp = "920" if jahr == 2011
quietly replace sap = "36" if jahr == 2011
quietly replace vhb_stkl_ungl_3 = "1900" if jahr == 2011
quietly replace vhb_stkl_3 = "3000" if jahr == 2011
quietly replace min_vrsrge_pausch = ".12" if jahr == 2011
quietly replace vhb_bef2010 = "." if jahr == 2011
quietly replace vspvor = "." if jahr == 2011
quietly replace vspmax1 = "." if jahr == 2011
quietly replace vspmax2 = "." if jahr == 2011
quietly replace vspkurz = "." if jahr == 2011
quietly replace vsp_satz_günstigerprüfung = "." if jahr == 2011
quietly replace vsp_satz_2004_regelung = "." if jahr == 2011
quietly replace gfb = "8004" if jahr == 2011
quietly replace y_abzug_2 = "10000" if jahr == 2011
quietly replace z_abzug_1 = "13469" if jahr == 2011
quietly replace z_abzug_2 = "10000" if jahr == 2011
quietly replace zahl_1_1 = "912.17" if jahr == 2011
quietly replace zahl_1_2 = "1400" if jahr == 2011
quietly replace threshold_1 = "8005" if jahr == 2011
quietly replace zahl_2_1 = "228.74" if jahr == 2011
quietly replace zahl_2_2 = "2397" if jahr == 2011
quietly replace zahl_2_3 = "1038" if jahr == 2011
quietly replace threshold_2 = "13470" if jahr == 2011
quietly replace rate_3 = ".42" if jahr == 2011
quietly replace zahl_3_1 = "8172" if jahr == 2011
quietly replace threshold_3 = "52882" if jahr == 2011
quietly replace rate_4 = ".45" if jahr == 2011
quietly replace zahl_4_1 = "15694" if jahr == 2011
quietly replace threshold_4 = "250731" if jahr == 2011
quietly replace soli_satz = "5.5" if jahr == 2011
quietly replace mindest_soli = "20" if jahr == 2011
quietly replace solzfrei = "972" if jahr == 2011
quietly replace kfb_stkl_4 = "3504" if jahr == 2011
quietly replace kfb_stkl_1_3 = "7008" if jahr == 2011
quietly replace durchschn_zusatzbeitrag = "." if jahr == 2011
quietly replace efa = "1308" if jahr == 2011

* Year 2012
quietly replace bbgrv_ost = "57600" if jahr == 2012
quietly replace bbgrv_west = "67200" if jahr == 2012
quietly replace avsatzan = ".015" if jahr == 2012
quietly replace rvsatzan = ".098" if jahr == 2012
quietly replace tbsorv = ".48" if jahr == 2012
quietly replace bbgkvpv = "45900" if jahr == 2012
quietly replace kvsatzan_allg = ".082" if jahr == 2012
quietly replace kvsatzan_pre = ".079" if jahr == 2012
quietly replace kvsatzag_pre = ".07" if jahr == 2012
quietly replace pvsatzan = ".00975" if jahr == 2012
quietly replace pvsatzan_sachsen = ".01475" if jahr == 2012
quietly replace pvsatzag = ".00975" if jahr == 2012
quietly replace pvsatzag_sachsen = ".00475" if jahr == 2012
quietly replace pvz_wo_child = ".0025" if jahr == 2012
quietly replace pvz_red_more_2_child = "." if jahr == 2012
quietly replace w1stkl5 = "9429" if jahr == 2012
quietly replace w2stkl5 = "26441" if jahr == 2012
quietly replace w3stkl5 = "200584" if jahr == 2012
quietly replace mindest_lst_w1stkl5 = ".14" if jahr == 2012
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2012
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2012
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2012
quietly replace anp = "1000" if jahr == 2012
quietly replace sap = "36" if jahr == 2012
quietly replace vhb_stkl_ungl_3 = "1900" if jahr == 2012
quietly replace vhb_stkl_3 = "3000" if jahr == 2012
quietly replace min_vrsrge_pausch = ".12" if jahr == 2012
quietly replace vhb_bef2010 = "." if jahr == 2012
quietly replace vspvor = "." if jahr == 2012
quietly replace vspmax1 = "." if jahr == 2012
quietly replace vspmax2 = "." if jahr == 2012
quietly replace vspkurz = "." if jahr == 2012
quietly replace vsp_satz_günstigerprüfung = "." if jahr == 2012
quietly replace vsp_satz_2004_regelung = "." if jahr == 2012
quietly replace gfb = "8004" if jahr == 2012
quietly replace y_abzug_2 = "10000" if jahr == 2012
quietly replace z_abzug_1 = "13469" if jahr == 2012
quietly replace z_abzug_2 = "10000" if jahr == 2012
quietly replace zahl_1_1 = "912.17" if jahr == 2012
quietly replace zahl_1_2 = "1400" if jahr == 2012
quietly replace threshold_1 = "8005" if jahr == 2012
quietly replace zahl_2_1 = "228.74" if jahr == 2012
quietly replace zahl_2_2 = "2397" if jahr == 2012
quietly replace zahl_2_3 = "1038" if jahr == 2012
quietly replace threshold_2 = "13470" if jahr == 2012
quietly replace rate_3 = ".42" if jahr == 2012
quietly replace zahl_3_1 = "8172" if jahr == 2012
quietly replace threshold_3 = "52882" if jahr == 2012
quietly replace rate_4 = ".45" if jahr == 2012
quietly replace zahl_4_1 = "15694" if jahr == 2012
quietly replace threshold_4 = "250731" if jahr == 2012
quietly replace soli_satz = "5.5" if jahr == 2012
quietly replace mindest_soli = "20" if jahr == 2012
quietly replace solzfrei = "972" if jahr == 2012
quietly replace kfb_stkl_4 = "3504" if jahr == 2012
quietly replace kfb_stkl_1_3 = "7008" if jahr == 2012
quietly replace durchschn_zusatzbeitrag = "." if jahr == 2012
quietly replace efa = "1308" if jahr == 2012

* Year 2013
quietly replace bbgrv_ost = "58800" if jahr == 2013
quietly replace bbgrv_west = "69600" if jahr == 2013
quietly replace avsatzan = ".015" if jahr == 2013
quietly replace rvsatzan = ".0945" if jahr == 2013
quietly replace tbsorv = ".52" if jahr == 2013
quietly replace bbgkvpv = "47250" if jahr == 2013
quietly replace kvsatzan_allg = ".082" if jahr == 2013
quietly replace kvsatzan_pre = ".079" if jahr == 2013
quietly replace kvsatzag_pre = ".07" if jahr == 2013
quietly replace pvsatzan = ".01025" if jahr == 2013
quietly replace pvsatzan_sachsen = ".01525" if jahr == 2013
quietly replace pvsatzag = ".01025" if jahr == 2013
quietly replace pvsatzag_sachsen = ".00525" if jahr == 2013
quietly replace pvz_wo_child = ".0025" if jahr == 2013
quietly replace pvz_red_more_2_child = "." if jahr == 2013
quietly replace w1stkl5 = "9550" if jahr == 2013
quietly replace w2stkl5 = "26441" if jahr == 2013
quietly replace w3stkl5 = "200584" if jahr == 2013
quietly replace mindest_lst_w1stkl5 = ".14" if jahr == 2013
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2013
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2013
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2013
quietly replace anp = "1000" if jahr == 2013
quietly replace sap = "36" if jahr == 2013
quietly replace vhb_stkl_ungl_3 = "1900" if jahr == 2013
quietly replace vhb_stkl_3 = "3000" if jahr == 2013
quietly replace min_vrsrge_pausch = ".12" if jahr == 2013
quietly replace vhb_bef2010 = "." if jahr == 2013
quietly replace vspvor = "." if jahr == 2013
quietly replace vspmax1 = "." if jahr == 2013
quietly replace vspmax2 = "." if jahr == 2013
quietly replace vspkurz = "." if jahr == 2013
quietly replace vsp_satz_günstigerprüfung = "." if jahr == 2013
quietly replace vsp_satz_2004_regelung = "." if jahr == 2013
quietly replace gfb = "8130" if jahr == 2013
quietly replace y_abzug_2 = "10000" if jahr == 2013
quietly replace z_abzug_1 = "13469" if jahr == 2013
quietly replace z_abzug_2 = "10000" if jahr == 2013
quietly replace zahl_1_1 = "933.7" if jahr == 2013
quietly replace zahl_1_2 = "1400" if jahr == 2013
quietly replace threshold_1 = "8131" if jahr == 2013
quietly replace zahl_2_1 = "228.74" if jahr == 2013
quietly replace zahl_2_2 = "2397" if jahr == 2013
quietly replace zahl_2_3 = "1014" if jahr == 2013
quietly replace threshold_2 = "13470" if jahr == 2013
quietly replace rate_3 = ".42" if jahr == 2013
quietly replace zahl_3_1 = "8196" if jahr == 2013
quietly replace threshold_3 = "52882" if jahr == 2013
quietly replace rate_4 = ".45" if jahr == 2013
quietly replace zahl_4_1 = "15718" if jahr == 2013
quietly replace threshold_4 = "250731" if jahr == 2013
quietly replace soli_satz = "5.5" if jahr == 2013
quietly replace mindest_soli = "20" if jahr == 2013
quietly replace solzfrei = "972" if jahr == 2013
quietly replace kfb_stkl_4 = "3504" if jahr == 2013
quietly replace kfb_stkl_1_3 = "7008" if jahr == 2013
quietly replace durchschn_zusatzbeitrag = "." if jahr == 2013
quietly replace efa = "1308" if jahr == 2013

* Year 2014
quietly replace bbgrv_ost = "60000" if jahr == 2014
quietly replace bbgrv_west = "71400" if jahr == 2014
quietly replace avsatzan = ".015" if jahr == 2014
quietly replace rvsatzan = ".0945" if jahr == 2014
quietly replace tbsorv = ".5600000000000001" if jahr == 2014
quietly replace bbgkvpv = "48600" if jahr == 2014
quietly replace kvsatzan_allg = ".082" if jahr == 2014
quietly replace kvsatzan_pre = ".079" if jahr == 2014
quietly replace kvsatzag_pre = ".07" if jahr == 2014
quietly replace pvsatzan = ".01025" if jahr == 2014
quietly replace pvsatzan_sachsen = ".01525" if jahr == 2014
quietly replace pvsatzag = ".01025" if jahr == 2014
quietly replace pvsatzag_sachsen = ".00525" if jahr == 2014
quietly replace pvz_wo_child = ".0025" if jahr == 2014
quietly replace pvz_red_more_2_child = "." if jahr == 2014
quietly replace w1stkl5 = "9763" if jahr == 2014
quietly replace w2stkl5 = "26441" if jahr == 2014
quietly replace w3stkl5 = "200584" if jahr == 2014
quietly replace mindest_lst_w1stkl5 = ".14" if jahr == 2014
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2014
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2014
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2014
quietly replace anp = "1000" if jahr == 2014
quietly replace sap = "36" if jahr == 2014
quietly replace vhb_stkl_ungl_3 = "1900" if jahr == 2014
quietly replace vhb_stkl_3 = "3000" if jahr == 2014
quietly replace min_vrsrge_pausch = ".12" if jahr == 2014
quietly replace vhb_bef2010 = "." if jahr == 2014
quietly replace vspvor = "." if jahr == 2014
quietly replace vspmax1 = "." if jahr == 2014
quietly replace vspmax2 = "." if jahr == 2014
quietly replace vspkurz = "." if jahr == 2014
quietly replace vsp_satz_günstigerprüfung = "." if jahr == 2014
quietly replace vsp_satz_2004_regelung = "." if jahr == 2014
quietly replace gfb = "8354" if jahr == 2014
quietly replace y_abzug_2 = "10000" if jahr == 2014
quietly replace z_abzug_1 = "13469" if jahr == 2014
quietly replace z_abzug_2 = "10000" if jahr == 2014
quietly replace zahl_1_1 = "974.58" if jahr == 2014
quietly replace zahl_1_2 = "1400" if jahr == 2014
quietly replace threshold_1 = "8355" if jahr == 2014
quietly replace zahl_2_1 = "228.74" if jahr == 2014
quietly replace zahl_2_2 = "2397" if jahr == 2014
quietly replace zahl_2_3 = "971" if jahr == 2014
quietly replace threshold_2 = "13470" if jahr == 2014
quietly replace rate_3 = ".42" if jahr == 2014
quietly replace zahl_3_1 = "8239" if jahr == 2014
quietly replace threshold_3 = "52882" if jahr == 2014
quietly replace rate_4 = ".45" if jahr == 2014
quietly replace zahl_4_1 = "15761" if jahr == 2014
quietly replace threshold_4 = "250731" if jahr == 2014
quietly replace soli_satz = "5.5" if jahr == 2014
quietly replace mindest_soli = "20" if jahr == 2014
quietly replace solzfrei = "972" if jahr == 2014
quietly replace kfb_stkl_4 = "3504" if jahr == 2014
quietly replace kfb_stkl_1_3 = "7008" if jahr == 2014
quietly replace durchschn_zusatzbeitrag = "" if jahr == 2014
quietly replace efa = "1308" if jahr == 2014

* Year 2015
quietly replace bbgrv_ost = "62400" if jahr == 2015
quietly replace bbgrv_west = "72600" if jahr == 2015
quietly replace avsatzan = ".015" if jahr == 2015
quietly replace rvsatzan = ".0935" if jahr == 2015
quietly replace tbsorv = ".6" if jahr == 2015
quietly replace bbgkvpv = "49500" if jahr == 2015
quietly replace kvsatzan_allg = ".073" if jahr == 2015
quietly replace kvsatzan_pre = ".07" if jahr == 2015
quietly replace kvsatzag_pre = ".07" if jahr == 2015
quietly replace pvsatzan = ".01175" if jahr == 2015
quietly replace pvsatzan_sachsen = ".01675" if jahr == 2015
quietly replace pvsatzag = ".01175" if jahr == 2015
quietly replace pvsatzag_sachsen = ".00675" if jahr == 2015
quietly replace pvz_wo_child = ".0025" if jahr == 2015
quietly replace pvz_red_more_2_child = "." if jahr == 2015
quietly replace w1stkl5 = "9763" if jahr == 2015
quietly replace w2stkl5 = "26441" if jahr == 2015
quietly replace w3stkl5 = "200584" if jahr == 2015
quietly replace mindest_lst_w1stkl5 = ".14" if jahr == 2015
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2015
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2015
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2015
quietly replace anp = "1000" if jahr == 2015
quietly replace sap = "36" if jahr == 2015
quietly replace vhb_stkl_ungl_3 = "1900" if jahr == 2015
quietly replace vhb_stkl_3 = "3000" if jahr == 2015
quietly replace min_vrsrge_pausch = ".12" if jahr == 2015
quietly replace vhb_bef2010 = "." if jahr == 2015
quietly replace vspvor = "." if jahr == 2015
quietly replace vspmax1 = "." if jahr == 2015
quietly replace vspmax2 = "." if jahr == 2015
quietly replace vspkurz = "." if jahr == 2015
quietly replace vsp_satz_günstigerprüfung = "." if jahr == 2015
quietly replace vsp_satz_2004_regelung = "." if jahr == 2015
quietly replace gfb = "8354" if jahr == 2015
quietly replace y_abzug_2 = "10000" if jahr == 2015
quietly replace z_abzug_1 = "13469" if jahr == 2015
quietly replace z_abzug_2 = "10000" if jahr == 2015
quietly replace zahl_1_1 = "974.58" if jahr == 2015
quietly replace zahl_1_2 = "1400" if jahr == 2015
quietly replace threshold_1 = "8355" if jahr == 2015
quietly replace zahl_2_1 = "228.74" if jahr == 2015
quietly replace zahl_2_2 = "2397" if jahr == 2015
quietly replace zahl_2_3 = "971" if jahr == 2015
quietly replace threshold_2 = "13470" if jahr == 2015
quietly replace rate_3 = ".42" if jahr == 2015
quietly replace zahl_3_1 = "8239" if jahr == 2015
quietly replace threshold_3 = "52882" if jahr == 2015
quietly replace rate_4 = ".45" if jahr == 2015
quietly replace zahl_4_1 = "15761" if jahr == 2015
quietly replace threshold_4 = "250731" if jahr == 2015
quietly replace soli_satz = "5.5" if jahr == 2015
quietly replace mindest_soli = "20" if jahr == 2015
quietly replace solzfrei = "972" if jahr == 2015
quietly replace kfb_stkl_4 = "3504" if jahr == 2015
quietly replace kfb_stkl_1_3 = "7008" if jahr == 2015
quietly replace durchschn_zusatzbeitrag = ".9" if jahr == 2015
quietly replace efa = "1308" if jahr == 2015

* Year 2016
quietly replace bbgrv_ost = "64800" if jahr == 2016
quietly replace bbgrv_west = "74400" if jahr == 2016
quietly replace avsatzan = ".015" if jahr == 2016
quietly replace rvsatzan = ".0935" if jahr == 2016
quietly replace tbsorv = ".64" if jahr == 2016
quietly replace bbgkvpv = "50850" if jahr == 2016
quietly replace kvsatzan_allg = ".073" if jahr == 2016
quietly replace kvsatzan_pre = ".07" if jahr == 2016
quietly replace kvsatzag_pre = ".07" if jahr == 2016
quietly replace pvsatzan = ".01175" if jahr == 2016
quietly replace pvsatzan_sachsen = ".01675" if jahr == 2016
quietly replace pvsatzag = ".01175" if jahr == 2016
quietly replace pvsatzag_sachsen = ".00675" if jahr == 2016
quietly replace pvz_wo_child = ".0025" if jahr == 2016
quietly replace pvz_red_more_2_child = "." if jahr == 2016
quietly replace w1stkl5 = "10070" if jahr == 2016
quietly replace w2stkl5 = "26832" if jahr == 2016
quietly replace w3stkl5 = "203557" if jahr == 2016
quietly replace mindest_lst_w1stkl5 = ".14" if jahr == 2016
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2016
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2016
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2016
quietly replace anp = "1000" if jahr == 2016
quietly replace sap = "36" if jahr == 2016
quietly replace vhb_stkl_ungl_3 = "1900" if jahr == 2016
quietly replace vhb_stkl_3 = "3000" if jahr == 2016
quietly replace min_vrsrge_pausch = ".12" if jahr == 2016
quietly replace vhb_bef2010 = "." if jahr == 2016
quietly replace vspvor = "." if jahr == 2016
quietly replace vspmax1 = "." if jahr == 2016
quietly replace vspmax2 = "." if jahr == 2016
quietly replace vspkurz = "." if jahr == 2016
quietly replace vsp_satz_günstigerprüfung = "." if jahr == 2016
quietly replace vsp_satz_2004_regelung = "." if jahr == 2016
quietly replace gfb = "8652" if jahr == 2016
quietly replace y_abzug_2 = "10000" if jahr == 2016
quietly replace z_abzug_1 = "13669" if jahr == 2016
quietly replace z_abzug_2 = "10000" if jahr == 2016
quietly replace zahl_1_1 = "993.62" if jahr == 2016
quietly replace zahl_1_2 = "1400" if jahr == 2016
quietly replace threshold_1 = "8653" if jahr == 2016
quietly replace zahl_2_1 = "225.4" if jahr == 2016
quietly replace zahl_2_2 = "2397" if jahr == 2016
quietly replace zahl_2_3 = "952.48" if jahr == 2016
quietly replace threshold_2 = "13670" if jahr == 2016
quietly replace rate_3 = ".42" if jahr == 2016
quietly replace zahl_3_1 = "8394" if jahr == 2016
quietly replace threshold_3 = "53666" if jahr == 2016
quietly replace rate_4 = ".45" if jahr == 2016
quietly replace zahl_4_1 = "16027" if jahr == 2016
quietly replace threshold_4 = "254447" if jahr == 2016
quietly replace soli_satz = "5.5" if jahr == 2016
quietly replace mindest_soli = "20" if jahr == 2016
quietly replace solzfrei = "972" if jahr == 2016
quietly replace kfb_stkl_4 = "3624" if jahr == 2016
quietly replace kfb_stkl_1_3 = "7248" if jahr == 2016
quietly replace durchschn_zusatzbeitrag = "1.1" if jahr == 2016
quietly replace efa = "1908" if jahr == 2016

* Year 2017
quietly replace bbgrv_ost = "68400" if jahr == 2017
quietly replace bbgrv_west = "76200" if jahr == 2017
quietly replace avsatzan = ".015" if jahr == 2017
quietly replace rvsatzan = ".0935" if jahr == 2017
quietly replace tbsorv = ".68" if jahr == 2017
quietly replace bbgkvpv = "52200" if jahr == 2017
quietly replace kvsatzan_allg = ".073" if jahr == 2017
quietly replace kvsatzan_pre = ".07" if jahr == 2017
quietly replace kvsatzag_pre = ".07" if jahr == 2017
quietly replace pvsatzan = ".01275" if jahr == 2017
quietly replace pvsatzan_sachsen = ".01775" if jahr == 2017
quietly replace pvsatzag = ".01275" if jahr == 2017
quietly replace pvsatzag_sachsen = ".00775" if jahr == 2017
quietly replace pvz_wo_child = ".0025" if jahr == 2017
quietly replace pvz_red_more_2_child = "." if jahr == 2017
quietly replace w1stkl5 = "10240" if jahr == 2017
quietly replace w2stkl5 = "27029" if jahr == 2017
quietly replace w3stkl5 = "205043" if jahr == 2017
quietly replace mindest_lst_w1stkl5 = ".14" if jahr == 2017
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2017
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2017
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2017
quietly replace anp = "1000" if jahr == 2017
quietly replace sap = "36" if jahr == 2017
quietly replace vhb_stkl_ungl_3 = "1900" if jahr == 2017
quietly replace vhb_stkl_3 = "3000" if jahr == 2017
quietly replace min_vrsrge_pausch = ".12" if jahr == 2017
quietly replace vhb_bef2010 = "." if jahr == 2017
quietly replace vspvor = "." if jahr == 2017
quietly replace vspmax1 = "." if jahr == 2017
quietly replace vspmax2 = "." if jahr == 2017
quietly replace vspkurz = "." if jahr == 2017
quietly replace vsp_satz_günstigerprüfung = "." if jahr == 2017
quietly replace vsp_satz_2004_regelung = "." if jahr == 2017
quietly replace gfb = "8820" if jahr == 2017
quietly replace y_abzug_2 = "10000" if jahr == 2017
quietly replace z_abzug_1 = "13769" if jahr == 2017
quietly replace z_abzug_2 = "10000" if jahr == 2017
quietly replace zahl_1_1 = "1007.27" if jahr == 2017
quietly replace zahl_1_2 = "1400" if jahr == 2017
quietly replace threshold_1 = "8821" if jahr == 2017
quietly replace zahl_2_1 = "223.76" if jahr == 2017
quietly replace zahl_2_2 = "2397" if jahr == 2017
quietly replace zahl_2_3 = "939.5700000000001" if jahr == 2017
quietly replace threshold_2 = "13770" if jahr == 2017
quietly replace rate_3 = ".42" if jahr == 2017
quietly replace zahl_3_1 = "8475" if jahr == 2017
quietly replace threshold_3 = "54058" if jahr == 2017
quietly replace rate_4 = ".45" if jahr == 2017
quietly replace zahl_4_1 = "16164" if jahr == 2017
quietly replace threshold_4 = "256304" if jahr == 2017
quietly replace soli_satz = "5.5" if jahr == 2017
quietly replace mindest_soli = "20" if jahr == 2017
quietly replace solzfrei = "972" if jahr == 2017
quietly replace kfb_stkl_4 = "3678" if jahr == 2017
quietly replace kfb_stkl_1_3 = "7356" if jahr == 2017
quietly replace durchschn_zusatzbeitrag = "1.1" if jahr == 2017
quietly replace efa = "1908" if jahr == 2017

* Year 2018
quietly replace bbgrv_ost = "69600" if jahr == 2018
quietly replace bbgrv_west = "78000" if jahr == 2018
quietly replace avsatzan = ".015" if jahr == 2018
quietly replace rvsatzan = ".093" if jahr == 2018
quietly replace tbsorv = ".72" if jahr == 2018
quietly replace bbgkvpv = "53100" if jahr == 2018
quietly replace kvsatzan_allg = ".073" if jahr == 2018
quietly replace kvsatzan_pre = ".07" if jahr == 2018
quietly replace kvsatzag_pre = ".07" if jahr == 2018
quietly replace pvsatzan = ".01275" if jahr == 2018
quietly replace pvsatzan_sachsen = ".01775" if jahr == 2018
quietly replace pvsatzag = ".01275" if jahr == 2018
quietly replace pvsatzag_sachsen = ".00775" if jahr == 2018
quietly replace pvz_wo_child = ".0025" if jahr == 2018
quietly replace pvz_red_more_2_child = "." if jahr == 2018
quietly replace w1stkl5 = "10440" if jahr == 2018
quietly replace w2stkl5 = "27475" if jahr == 2018
quietly replace w3stkl5 = "208426" if jahr == 2018
quietly replace mindest_lst_w1stkl5 = ".14" if jahr == 2018
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2018
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2018
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2018
quietly replace anp = "1000" if jahr == 2018
quietly replace sap = "36" if jahr == 2018
quietly replace vhb_stkl_ungl_3 = "1900" if jahr == 2018
quietly replace vhb_stkl_3 = "3000" if jahr == 2018
quietly replace min_vrsrge_pausch = ".12" if jahr == 2018
quietly replace vhb_bef2010 = "." if jahr == 2018
quietly replace vspvor = "." if jahr == 2018
quietly replace vspmax1 = "." if jahr == 2018
quietly replace vspmax2 = "." if jahr == 2018
quietly replace vspkurz = "." if jahr == 2018
quietly replace vsp_satz_günstigerprüfung = "." if jahr == 2018
quietly replace vsp_satz_2004_regelung = "." if jahr == 2018
quietly replace gfb = "9001" if jahr == 2018
quietly replace y_abzug_2 = "10000" if jahr == 2018
quietly replace z_abzug_1 = "13996" if jahr == 2018
quietly replace z_abzug_2 = "10000" if jahr == 2018
quietly replace zahl_1_1 = "997.8" if jahr == 2018
quietly replace zahl_1_2 = "1400" if jahr == 2018
quietly replace threshold_1 = "9001" if jahr == 2018
quietly replace zahl_2_1 = "220.13" if jahr == 2018
quietly replace zahl_2_2 = "2397" if jahr == 2018
quietly replace zahl_2_3 = "948.49" if jahr == 2018
quietly replace threshold_2 = "13997" if jahr == 2018
quietly replace rate_3 = ".42" if jahr == 2018
quietly replace zahl_3_1 = "8621.75" if jahr == 2018
quietly replace threshold_3 = "54950" if jahr == 2018
quietly replace rate_4 = ".45" if jahr == 2018
quietly replace zahl_4_1 = "16437.7" if jahr == 2018
quietly replace threshold_4 = "260533" if jahr == 2018
quietly replace soli_satz = "5.5" if jahr == 2018
quietly replace mindest_soli = "20" if jahr == 2018
quietly replace solzfrei = "972" if jahr == 2018
quietly replace kfb_stkl_4 = "3714" if jahr == 2018
quietly replace kfb_stkl_1_3 = "7428" if jahr == 2018
quietly replace durchschn_zusatzbeitrag = "1" if jahr == 2018
quietly replace efa = "1908" if jahr == 2018

* Year 2019
quietly replace bbgrv_ost = "73800" if jahr == 2019
quietly replace bbgrv_west = "80400" if jahr == 2019
quietly replace avsatzan = ".0125" if jahr == 2019
quietly replace rvsatzan = ".093" if jahr == 2019
quietly replace tbsorv = ".76" if jahr == 2019
quietly replace bbgkvpv = "54450" if jahr == 2019
quietly replace kvsatzan_allg = ".073" if jahr == 2019
quietly replace kvsatzan_pre = ".07" if jahr == 2019
quietly replace kvsatzag_pre = ".07" if jahr == 2019
quietly replace pvsatzan = ".01525" if jahr == 2019
quietly replace pvsatzan_sachsen = ".02025" if jahr == 2019
quietly replace pvsatzag = ".01525" if jahr == 2019
quietly replace pvsatzag_sachsen = ".01025" if jahr == 2019
quietly replace pvz_wo_child = ".0025" if jahr == 2019
quietly replace pvz_red_more_2_child = "." if jahr == 2019
quietly replace w1stkl5 = "10635" if jahr == 2019
quietly replace w2stkl5 = "27980" if jahr == 2019
quietly replace w3stkl5 = "212261" if jahr == 2019
quietly replace mindest_lst_w1stkl5 = ".14" if jahr == 2019
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2019
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2019
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2019
quietly replace anp = "1000" if jahr == 2019
quietly replace sap = "36" if jahr == 2019
quietly replace vhb_stkl_ungl_3 = "1900" if jahr == 2019
quietly replace vhb_stkl_3 = "3000" if jahr == 2019
quietly replace min_vrsrge_pausch = ".12" if jahr == 2019
quietly replace vhb_bef2010 = "." if jahr == 2019
quietly replace vspvor = "." if jahr == 2019
quietly replace vspmax1 = "." if jahr == 2019
quietly replace vspmax2 = "." if jahr == 2019
quietly replace vspkurz = "." if jahr == 2019
quietly replace vsp_satz_günstigerprüfung = "." if jahr == 2019
quietly replace vsp_satz_2004_regelung = "." if jahr == 2019
quietly replace gfb = "9169" if jahr == 2019
quietly replace y_abzug_2 = "10000" if jahr == 2019
quietly replace z_abzug_1 = "14254" if jahr == 2019
quietly replace z_abzug_2 = "10000" if jahr == 2019
quietly replace zahl_1_1 = "980.14" if jahr == 2019
quietly replace zahl_1_2 = "1400" if jahr == 2019
quietly replace threshold_1 = "9169" if jahr == 2019
quietly replace zahl_2_1 = "216.16" if jahr == 2019
quietly replace zahl_2_2 = "2397" if jahr == 2019
quietly replace zahl_2_3 = "965.58" if jahr == 2019
quietly replace threshold_2 = "14225" if jahr == 2019
quietly replace rate_3 = ".42" if jahr == 2019
quietly replace zahl_3_1 = "8780.9" if jahr == 2019
quietly replace threshold_3 = "55961" if jahr == 2019
quietly replace rate_4 = ".45" if jahr == 2019
quietly replace zahl_4_1 = "16740.68" if jahr == 2019
quietly replace threshold_4 = "265327" if jahr == 2019
quietly replace soli_satz = "5.5" if jahr == 2019
quietly replace mindest_soli = "20" if jahr == 2019
quietly replace solzfrei = "972" if jahr == 2019
quietly replace kfb_stkl_4 = "3810" if jahr == 2019
quietly replace kfb_stkl_1_3 = "7620" if jahr == 2019
quietly replace durchschn_zusatzbeitrag = ".9" if jahr == 2019
quietly replace efa = "1908" if jahr == 2019

* Year 2020
quietly replace bbgrv_ost = "77400" if jahr == 2020
quietly replace bbgrv_west = "82800" if jahr == 2020
quietly replace avsatzan = ".012" if jahr == 2020
quietly replace rvsatzan = ".093" if jahr == 2020
quietly replace tbsorv = ".8" if jahr == 2020
quietly replace bbgkvpv = "56250" if jahr == 2020
quietly replace kvsatzan_allg = ".073" if jahr == 2020
quietly replace kvsatzan_pre = ".07" if jahr == 2020
quietly replace kvsatzag_pre = ".07" if jahr == 2020
quietly replace pvsatzan = ".01525" if jahr == 2020
quietly replace pvsatzan_sachsen = ".02025" if jahr == 2020
quietly replace pvsatzag = ".01525" if jahr == 2020
quietly replace pvsatzag_sachsen = ".01025" if jahr == 2020
quietly replace pvz_wo_child = ".0025" if jahr == 2020
quietly replace pvz_red_more_2_child = "." if jahr == 2020
quietly replace w1stkl5 = "10898" if jahr == 2020
quietly replace w2stkl5 = "28526" if jahr == 2020
quietly replace w3stkl5 = "216400" if jahr == 2020
quietly replace mindest_lst_w1stkl5 = ".14" if jahr == 2020
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2020
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2020
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2020
quietly replace anp = "1000" if jahr == 2020
quietly replace sap = "36" if jahr == 2020
quietly replace vhb_stkl_ungl_3 = "1900" if jahr == 2020
quietly replace vhb_stkl_3 = "3000" if jahr == 2020
quietly replace min_vrsrge_pausch = ".12" if jahr == 2020
quietly replace vhb_bef2010 = "." if jahr == 2020
quietly replace vspvor = "." if jahr == 2020
quietly replace vspmax1 = "." if jahr == 2020
quietly replace vspmax2 = "." if jahr == 2020
quietly replace vspkurz = "." if jahr == 2020
quietly replace vsp_satz_günstigerprüfung = "." if jahr == 2020
quietly replace vsp_satz_2004_regelung = "." if jahr == 2020
quietly replace gfb = "9408" if jahr == 2020
quietly replace y_abzug_2 = "10000" if jahr == 2020
quietly replace z_abzug_1 = "14532" if jahr == 2020
quietly replace z_abzug_2 = "10000" if jahr == 2020
quietly replace zahl_1_1 = "972.87" if jahr == 2020
quietly replace zahl_1_2 = "1400" if jahr == 2020
quietly replace threshold_1 = "9409" if jahr == 2020
quietly replace zahl_2_1 = "212.02" if jahr == 2020
quietly replace zahl_2_2 = "2397" if jahr == 2020
quietly replace zahl_2_3 = "972.79" if jahr == 2020
quietly replace threshold_2 = "14533" if jahr == 2020
quietly replace rate_3 = ".42" if jahr == 2020
quietly replace zahl_3_1 = "8963.74" if jahr == 2020
quietly replace threshold_3 = "57052" if jahr == 2020
quietly replace rate_4 = ".45" if jahr == 2020
quietly replace zahl_4_1 = "17078.74" if jahr == 2020
quietly replace threshold_4 = "270501" if jahr == 2020
quietly replace soli_satz = "5.5" if jahr == 2020
quietly replace mindest_soli = "20" if jahr == 2020
quietly replace solzfrei = "972" if jahr == 2020
quietly replace kfb_stkl_4 = "3906" if jahr == 2020
quietly replace kfb_stkl_1_3 = "7812" if jahr == 2020
quietly replace durchschn_zusatzbeitrag = "1.1" if jahr == 2020
quietly replace efa = "1908" if jahr == 2020

* Year 2021
quietly replace bbgrv_ost = "80400" if jahr == 2021
quietly replace bbgrv_west = "85200" if jahr == 2021
quietly replace avsatzan = ".012" if jahr == 2021
quietly replace rvsatzan = ".093" if jahr == 2021
quietly replace tbsorv = ".84" if jahr == 2021
quietly replace bbgkvpv = "58050" if jahr == 2021
quietly replace kvsatzan_allg = ".073" if jahr == 2021
quietly replace kvsatzan_pre = ".07" if jahr == 2021
quietly replace kvsatzag_pre = ".07" if jahr == 2021
quietly replace pvsatzan = ".01525" if jahr == 2021
quietly replace pvsatzan_sachsen = ".02025" if jahr == 2021
quietly replace pvsatzag = ".01525" if jahr == 2021
quietly replace pvsatzag_sachsen = ".01025" if jahr == 2021
quietly replace pvz_wo_child = ".0025" if jahr == 2021
quietly replace pvz_red_more_2_child = "." if jahr == 2021
quietly replace w1stkl5 = "11237" if jahr == 2021
quietly replace w2stkl5 = "28959" if jahr == 2021
quietly replace w3stkl5 = "219690" if jahr == 2021
quietly replace mindest_lst_w1stkl5 = ".14" if jahr == 2021
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2021
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2021
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2021
quietly replace anp = "1000" if jahr == 2021
quietly replace sap = "36" if jahr == 2021
quietly replace vhb_stkl_ungl_3 = "1900" if jahr == 2021
quietly replace vhb_stkl_3 = "3000" if jahr == 2021
quietly replace min_vrsrge_pausch = ".12" if jahr == 2021
quietly replace vhb_bef2010 = "." if jahr == 2021
quietly replace vspvor = "." if jahr == 2021
quietly replace vspmax1 = "." if jahr == 2021
quietly replace vspmax2 = "." if jahr == 2021
quietly replace vspkurz = "." if jahr == 2021
quietly replace vsp_satz_günstigerprüfung = "." if jahr == 2021
quietly replace vsp_satz_2004_regelung = "." if jahr == 2021
quietly replace gfb = "9744" if jahr == 2021
quietly replace y_abzug_2 = "10000" if jahr == 2021
quietly replace z_abzug_1 = "14753" if jahr == 2021
quietly replace z_abzug_2 = "10000" if jahr == 2021
quietly replace zahl_1_1 = "995.21" if jahr == 2021
quietly replace zahl_1_2 = "1400" if jahr == 2021
quietly replace threshold_1 = "9745" if jahr == 2021
quietly replace zahl_2_1 = "208.85" if jahr == 2021
quietly replace zahl_2_2 = "2397" if jahr == 2021
quietly replace zahl_2_3 = "950.96" if jahr == 2021
quietly replace threshold_2 = "14754" if jahr == 2021
quietly replace rate_3 = ".42" if jahr == 2021
quietly replace zahl_3_1 = "9136.629999999999" if jahr == 2021
quietly replace threshold_3 = "57919" if jahr == 2021
quietly replace rate_4 = ".45" if jahr == 2021
quietly replace zahl_4_1 = "17374.99" if jahr == 2021
quietly replace threshold_4 = "274613" if jahr == 2021
quietly replace soli_satz = "5.5" if jahr == 2021
quietly replace mindest_soli = "11.9" if jahr == 2021
quietly replace solzfrei = "16956" if jahr == 2021
quietly replace kfb_stkl_4 = "4194" if jahr == 2021
quietly replace kfb_stkl_1_3 = "8388" if jahr == 2021
quietly replace durchschn_zusatzbeitrag = "1.3" if jahr == 2021
quietly replace efa = "1908" if jahr == 2021

* Year 2022
quietly replace bbgrv_ost = "81000" if jahr == 2022
quietly replace bbgrv_west = "84600" if jahr == 2022
quietly replace avsatzan = ".012" if jahr == 2022
quietly replace rvsatzan = ".093" if jahr == 2022
quietly replace tbsorv = ".88" if jahr == 2022
quietly replace bbgkvpv = "58050" if jahr == 2022
quietly replace kvsatzan_allg = ".073" if jahr == 2022
quietly replace kvsatzan_pre = ".07" if jahr == 2022
quietly replace kvsatzag_pre = ".07" if jahr == 2022
quietly replace pvsatzan = ".01525" if jahr == 2022
quietly replace pvsatzan_sachsen = ".02025" if jahr == 2022
quietly replace pvsatzag = ".01525" if jahr == 2022
quietly replace pvsatzag_sachsen = ".01025" if jahr == 2022
quietly replace pvz_wo_child = ".0035" if jahr == 2022
quietly replace pvz_red_more_2_child = "." if jahr == 2022
quietly replace w1stkl5 = "11793" if jahr == 2022
quietly replace w2stkl5 = "29298" if jahr == 2022
quietly replace w3stkl5 = "222260" if jahr == 2022
quietly replace mindest_lst_w1stkl5 = ".14" if jahr == 2022
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2022
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2022
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2022
quietly replace anp = "1200" if jahr == 2022
quietly replace sap = "36" if jahr == 2022
quietly replace vhb_stkl_ungl_3 = "1900" if jahr == 2022
quietly replace vhb_stkl_3 = "3000" if jahr == 2022
quietly replace min_vrsrge_pausch = ".12" if jahr == 2022
quietly replace vhb_bef2010 = "." if jahr == 2022
quietly replace vspvor = "." if jahr == 2022
quietly replace vspmax1 = "." if jahr == 2022
quietly replace vspmax2 = "." if jahr == 2022
quietly replace vspkurz = "." if jahr == 2022
quietly replace vsp_satz_günstigerprüfung = "." if jahr == 2022
quietly replace vsp_satz_2004_regelung = "." if jahr == 2022
quietly replace gfb = "10347" if jahr == 2022
quietly replace y_abzug_2 = "10000" if jahr == 2022
quietly replace z_abzug_1 = "14926" if jahr == 2022
quietly replace z_abzug_2 = "10000" if jahr == 2022
quietly replace zahl_1_1 = "1088.67" if jahr == 2022
quietly replace zahl_1_2 = "1400" if jahr == 2022
quietly replace threshold_1 = "9985" if jahr == 2022
quietly replace zahl_2_1 = "206.43" if jahr == 2022
quietly replace zahl_2_2 = "2397" if jahr == 2022
quietly replace zahl_2_3 = "869.3200000000001" if jahr == 2022
quietly replace threshold_2 = "14927" if jahr == 2022
quietly replace rate_3 = ".42" if jahr == 2022
quietly replace zahl_3_1 = "9336.450000000001" if jahr == 2022
quietly replace threshold_3 = "58597" if jahr == 2022
quietly replace rate_4 = ".45" if jahr == 2022
quietly replace zahl_4_1 = "17621.2" if jahr == 2022
quietly replace threshold_4 = "277826" if jahr == 2022
quietly replace soli_satz = "5.5" if jahr == 2022
quietly replace mindest_soli = "11.9" if jahr == 2022
quietly replace solzfrei = "16956" if jahr == 2022
quietly replace kfb_stkl_4 = "4194" if jahr == 2022
quietly replace kfb_stkl_1_3 = "8388" if jahr == 2022
quietly replace durchschn_zusatzbeitrag = "1.3" if jahr == 2022
quietly replace efa = "4008" if jahr == 2022

* Year 2023
quietly replace bbgrv_ost = "85200" if jahr == 2023
quietly replace bbgrv_west = "87600" if jahr == 2023
quietly replace avsatzan = ".013" if jahr == 2023
quietly replace rvsatzan = ".093" if jahr == 2023
quietly replace tbsorv = "1" if jahr == 2023
quietly replace bbgkvpv = "59850" if jahr == 2023
quietly replace kvsatzan_allg = ".073" if jahr == 2023
quietly replace kvsatzan_pre = ".07" if jahr == 2023
quietly replace kvsatzag_pre = ".07" if jahr == 2023
quietly replace pvsatzan = ".01525" if jahr == 2023
quietly replace pvsatzan_sachsen = ".02025" if jahr == 2023
quietly replace pvsatzag = ".01525" if jahr == 2023
quietly replace pvsatzag_sachsen = ".01025" if jahr == 2023
quietly replace pvz_wo_child = ".0035" if jahr == 2023
quietly replace pvz_red_more_2_child = "." if jahr == 2023
quietly replace w1stkl5 = "12485" if jahr == 2023
quietly replace w2stkl5 = "31404" if jahr == 2023
quietly replace w3stkl5 = "222260" if jahr == 2023
quietly replace mindest_lst_w1stkl5 = ".14" if jahr == 2023
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2023
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2023
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2023
quietly replace anp = "1230" if jahr == 2023
quietly replace sap = "36" if jahr == 2023
quietly replace vhb_stkl_ungl_3 = "1900" if jahr == 2023
quietly replace vhb_stkl_3 = "3000" if jahr == 2023
quietly replace min_vrsrge_pausch = ".12" if jahr == 2023
quietly replace vhb_bef2010 = "." if jahr == 2023
quietly replace vspvor = "." if jahr == 2023
quietly replace vspmax1 = "." if jahr == 2023
quietly replace vspmax2 = "." if jahr == 2023
quietly replace vspkurz = "." if jahr == 2023
quietly replace vsp_satz_günstigerprüfung = "." if jahr == 2023
quietly replace vsp_satz_2004_regelung = "." if jahr == 2023
quietly replace gfb = "10908" if jahr == 2023
quietly replace y_abzug_2 = "10000" if jahr == 2023
quietly replace z_abzug_1 = "15999" if jahr == 2023
quietly replace z_abzug_2 = "10000" if jahr == 2023
quietly replace zahl_1_1 = "979.18" if jahr == 2023
quietly replace zahl_1_2 = "1400" if jahr == 2023
quietly replace threshold_1 = "10908" if jahr == 2023
quietly replace zahl_2_1 = "192.59" if jahr == 2023
quietly replace zahl_2_2 = "2397" if jahr == 2023
quietly replace zahl_2_3 = "966.53" if jahr == 2023
quietly replace threshold_2 = "16000" if jahr == 2023
quietly replace rate_3 = ".42" if jahr == 2023
quietly replace zahl_3_1 = "9972.98" if jahr == 2023
quietly replace threshold_3 = "62810" if jahr == 2023
quietly replace rate_4 = ".45" if jahr == 2023
quietly replace zahl_4_1 = "18307.73" if jahr == 2023
quietly replace threshold_4 = "277826" if jahr == 2023
quietly replace soli_satz = "5.5" if jahr == 2023
quietly replace mindest_soli = "11.9" if jahr == 2023
quietly replace solzfrei = "17543" if jahr == 2023
quietly replace kfb_stkl_4 = "4476" if jahr == 2023
quietly replace kfb_stkl_1_3 = "8952" if jahr == 2023
quietly replace durchschn_zusatzbeitrag = "1.6" if jahr == 2023
quietly replace efa = "4260" if jahr == 2023

* Year 2024
quietly replace bbgrv_ost = "89400" if jahr == 2024
quietly replace bbgrv_west = "90600" if jahr == 2024
quietly replace avsatzan = ".013" if jahr == 2024
quietly replace rvsatzan = ".093" if jahr == 2024
quietly replace tbsorv = "1" if jahr == 2024
quietly replace bbgkvpv = "62100" if jahr == 2024
quietly replace kvsatzan_allg = ".073" if jahr == 2024
quietly replace kvsatzan_pre = ".07" if jahr == 2024
quietly replace kvsatzag_pre = ".07" if jahr == 2024
quietly replace pvsatzan = ".017" if jahr == 2024
quietly replace pvsatzan_sachsen = ".022" if jahr == 2024
quietly replace pvsatzag = ".017" if jahr == 2024
quietly replace pvsatzag_sachsen = ".012" if jahr == 2024
quietly replace pvz_wo_child = ".006" if jahr == 2024
quietly replace pvz_red_more_2_child = ".0025" if jahr == 2024
quietly replace w1stkl5 = "13279" if jahr == 2024
quietly replace w2stkl5 = "33380" if jahr == 2024
quietly replace w3stkl5 = "222260" if jahr == 2024
quietly replace mindest_lst_w1stkl5 = ".14" if jahr == 2024
quietly replace lst_w1stkl5_rate = ".42" if jahr == 2024
quietly replace lst_w2stkl5_rate = ".42" if jahr == 2024
quietly replace lst_w3stkl5_rate = ".45" if jahr == 2024
quietly replace anp = "1230" if jahr == 2024
quietly replace sap = "36" if jahr == 2024
quietly replace vhb_stkl_ungl_3 = "1900" if jahr == 2024
quietly replace vhb_stkl_3 = "3000" if jahr == 2024
quietly replace min_vrsrge_pausch = ".12" if jahr == 2024
quietly replace vhb_bef2010 = "." if jahr == 2024
quietly replace vspvor = "." if jahr == 2024
quietly replace vspmax1 = "." if jahr == 2024
quietly replace vspmax2 = "." if jahr == 2024
quietly replace vspkurz = "." if jahr == 2024
quietly replace vsp_satz_günstigerprüfung = "." if jahr == 2024
quietly replace vsp_satz_2004_regelung = "." if jahr == 2024
quietly replace gfb = "11604" if jahr == 2024
quietly replace y_abzug_2 = "10000" if jahr == 2024
quietly replace z_abzug_1 = "17005" if jahr == 2024
quietly replace z_abzug_2 = "10000" if jahr == 2024
quietly replace zahl_1_1 = "922.98" if jahr == 2024
quietly replace zahl_1_2 = "1400" if jahr == 2024
quietly replace threshold_1 = "11604" if jahr == 2024
quietly replace zahl_2_1 = "181.19" if jahr == 2024
quietly replace zahl_2_2 = "2397" if jahr == 2024
quietly replace zahl_2_3 = "1025.38" if jahr == 2024
quietly replace threshold_2 = "17006" if jahr == 2024
quietly replace rate_3 = ".42" if jahr == 2024
quietly replace zahl_3_1 = "10602.13" if jahr == 2024
quietly replace threshold_3 = "66761" if jahr == 2024
quietly replace rate_4 = ".45" if jahr == 2024
quietly replace zahl_4_1 = "18936.88" if jahr == 2024
quietly replace threshold_4 = "277826" if jahr == 2024
quietly replace soli_satz = "5.5" if jahr == 2024
quietly replace mindest_soli = "11.9" if jahr == 2024
quietly replace solzfrei = "18130" if jahr == 2024
quietly replace kfb_stkl_4 = "4656" if jahr == 2024
quietly replace kfb_stkl_1_3 = "9312" if jahr == 2024
quietly replace durchschn_zusatzbeitrag = "1.7" if jahr == 2024
quietly replace efa = "4260" if jahr == 2024

quietly destring bbgrv_ost, replace
quietly destring bbgrv_west, replace
quietly destring avsatzan, replace
quietly destring rvsatzan, replace
quietly destring tbsorv, replace
quietly destring bbgkvpv, replace
quietly destring kvsatzan_allg, replace
quietly destring kvsatzan_pre, replace
quietly destring kvsatzag_pre, replace
quietly destring pvsatzan, replace
quietly destring pvsatzan_sachsen, replace
quietly destring pvsatzag, replace
quietly destring pvsatzag_sachsen, replace
quietly destring pvz_wo_child, replace
quietly destring pvz_red_more_2_child, replace
quietly destring w1stkl5, replace
quietly destring w2stkl5, replace
quietly destring w3stkl5, replace
quietly destring mindest_lst_w1stkl5, replace
quietly destring lst_w1stkl5_rate, replace
quietly destring lst_w2stkl5_rate, replace
quietly destring lst_w3stkl5_rate, replace
quietly destring anp, replace
quietly destring sap, replace
quietly destring vhb_stkl_ungl_3, replace
quietly destring vhb_stkl_3, replace
quietly destring min_vrsrge_pausch, replace
quietly destring vhb_bef2010, replace
quietly destring vspvor, replace
quietly destring vspmax1, replace
quietly destring vspmax2, replace
quietly destring vspkurz, replace
quietly destring vsp_satz_günstigerprüfung, replace
quietly destring vsp_satz_2004_regelung, replace
quietly destring gfb, replace
quietly destring y_abzug_2, replace
quietly destring z_abzug_1, replace
quietly destring z_abzug_2, replace
quietly destring zahl_1_1, replace
quietly destring zahl_1_2, replace
quietly destring threshold_1, replace
quietly destring zahl_2_1, replace
quietly destring zahl_2_2, replace
quietly destring zahl_2_3, replace
quietly destring threshold_2, replace
quietly destring rate_3, replace
quietly destring zahl_3_1, replace
quietly destring threshold_3, replace
quietly destring rate_4, replace
quietly destring zahl_4_1, replace
quietly destring threshold_4, replace
quietly destring soli_satz, replace
quietly destring mindest_soli, replace
quietly destring solzfrei, replace
quietly destring kfb_stkl_4, replace
quietly destring kfb_stkl_1_3, replace
quietly destring durchschn_zusatzbeitrag, replace
quietly destring efa, replace
