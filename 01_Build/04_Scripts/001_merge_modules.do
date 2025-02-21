***********************************************
* Title: 001_merge_modules
* Proyect: SPIA - Colombia country study
* Purpose: 
/*
	Do file used to merge ENA modules
*/
* Last update date: 2025-02-20
* Author: Juan Sebastián Lemos
***********************************************


clear all
set more off
cap log close


************************************************
*                0. Key Macros                 *
************************************************

	if "`c(os)'" == "MacOSX" {
	    global path "../../Library/CloudStorage/OneDrive-Universidaddelosandes/SPIA-Colombia-country-study_data/001.ENA-cleanig_repository"
		global raw "${path}/Build/Raw"
	 global cooked "${path}/Build/Cooked"
	 global tasty "${path}/Build/Tasty"	
	}
	else if "`c(os)'" == "Windows" {
		global path "..\..\..\..\001.ENA-cleanig_repository"
		global raw "${path}\Build\Raw"
		global cooked "${path}\Build\Cooked"
		global tasty "${path}\Build\Tasty"
	}

************************************************
*                1. Merge fist semester        *
************************************************
	
	
	*** Merge Cosechas-Cultivos-Lotes
	import delimited "${raw}/CSV/EAA_19_ANONIMIZADA/EAAP_19_COSECHAS.csv", clear
	
	* Keep relevant data
	keep keyppal_co keyppal_cu cosecha_cant cosecha_um espec_prod rend_def porc* precio_x_kilo
	
	* Merge with cultivos
	duplicates report keyppal_cu
	
	local covs_cul keyppal_l cul_tipo cul_nom cul_var siembra_anio lote_um ar_semoplan riego_sis ///
	area_riego frec_rieg insumos_cul_opa prod_quim sin_prod_quim afec_pme_cul ///
	planfert_cul fertilizante_op* for_apli_insum cant_fert_con_quim  cant_fert_sin_quim ///
	cul_etamaq_opa cul_etamaq_opf plafor_bcarb pradera_man sempla_proc
	
	merge m:1 keyppal_cu using "${cooked}/EAAP_19_CULTIVOS.dta", ///
	keepusing(`covs_cul') nogen
	
	* Merge with lotes
	duplicates report keyppal_l
	
	local covs_lote keyppal riego_sn
	
	merge m:1 keyppal_l using "${cooked}/EAAP_19_LOTES.dta", ///
	keepusing(`covs_lote') nogen
	
	
	tempfile lote_cosechas_cultivos
	save `lote_cosechas_cultivos'
	
	
	
	*** Merge everything with master dataset
	
	* Master dataset
	import delimited "${raw}/CSV/EAA_19_ANONIMIZADA/EAAP_19_IDENTIFICACION.csv", clear
	keep keyppal cod_reg cod_dpto upa_area tecinf_upa_op* util_produpa_op* ///
	actv_upa_op* sisprod_upa_op*
	
	* Merge with Energía
	local energia maq_agr_sn util_maq_agricola_op* maq_pec_sn ppal_uso_maq_pec ///
	tip_maq_op* manejo_estierc tip_estiercol_op* cant_estier_seco um_estier_op* ///
	util_estier_op* porc_fertil porc_alim_pecu porc_biogas resid_aprovec ///
	util_resid_op* porc_alim_anim porc_compost porc_biocomb
	
	merge 1:1 keyppal using "${cooked}/EAAP_19_ENERGIA.dta", nogen ///
	keepusing(`energia')

	* Merge with Pecuaria
	local pecu espec_exiup_op* bovtotal_pon 
	
	merge 1:1 keyppal using "${cooked}/EAAP_19_PECUARIA.dta", nogen ///
	keepusing(`pecu')	
	
	* Merge with Uso suelo
	local suelo ar_perm ar_tran ar_pasf ar_malras_sn ar_malras
	
	merge 1:1 keyppal using "${cooked}/EAAP_19_USUELO.dta", nogen ///
	keepusing(`suelo')
	
	tempfile upas
	save `upas'
	
	* Observation unit: UPA
	*-----------------------* 
	
	* Merge with cosechas-cultivos-lote
	merge 1:m keyppal using "`lote_cosechas_cultivos'", nogen
	
	tempfile firstsemester
	save `firstsemester'
	
	* Observation unit: cosechas-cultivos-lote-UPA
	*----------------------------------------------* 
	
	* Other potential merges if requiered:
	/*
	
	Note: eac obsrvation unit will change after merging the following databases.
	
	* Merge with Dispersos
	use `upas'
	local dispersos dis_nom
	merge 1:m keyppal using "${cooked}/EAAP_19_DISPERSOS.dta", nogen ///
	keepusing(`dispersos')
	
	* Merge with Maquinaria agrícola
	use `upas'
	local maq_agri maq_agricola
	
	merge 1:m keyppal using "${cooked}/EAAP_19_MAQ_AGR.dta", nogen ///
	keepusing(`maq_agri')
	
	* Merge with Maquinaria pecuaria
	use `upas'
	local maq_pecu maq_pecuaria
	
	merge 1:m keyppal using "${cooked}/EAAP_19_MAQ_PEC.dta", nogen ///
	keepusing(`maq_pecu')
	
	* Merge with muestras
	use `upas'
	local muestras acul_tipo acul_nom
	
	merge 1:m keyppal using "${cooked}/EAAP_19_NU_MUES.dta", nogen ///
	keepusing(`muestras')
	
	* Merge with Otras especies
	use `upas'
	local espe num_otespec otespec otep_tot otep_prod_totalpdcc_op* 
	
	merge 1:m keyppal using "${cooked}/EAAP_19_OTESPEC.dta", nogen ///
	keepusing(`espe')
	
	* Merge with productor
	use `upas'
	local productor cond_cam_prod_sn sit_desplaz_op* cod_dpto_resprod edad_prod
	
	merge 1:m keyppal using "${cooked}/EAAP_19_PRODUCTOR.dta", nogen ///
	keepusing(`productor')
	*/
	
	
************************************************
*                2. Merge second semester      *
************************************************
	
	
	*** Merge Cosechas-Cultivos-Lotes
	import delimited "${raw}/CSV/EAB_19_ANONIMIZADA/EABP_19_COSECHAS.csv", clear
	
	* Keep relevant data
	keep keyppal_co keyppal_cu cosecha_cant cosecha_um espec_prod rend_def porc* precio_x_kilo
	
	* Merge with cultivos
	duplicates report keyppal_cu
	
	local covs_cul keyppal_l cul_tipo cul_nom cul_var siembra_anio lote_um ar_semoplan riego_sis ///
	area_riego frec_rieg insumos_cul_opa prod_quim sin_prod_quim afec_pme_cul ///
	planfert_cul fertilizante_op* for_apli_insum cant_fert_con_quim  cant_fert_sin_quim ///
	cul_etamaq_opa cul_etamaq_opf plafor_bcarb pradera_man sempla_proc
	
	merge m:1 keyppal_cu using "${cooked}/EABP_19_CULTIVOS.dta", ///
	keepusing(`covs_cul') nogen
	
	* Merge with lotes
	duplicates report keyppal_l
	
	local covs_lote keyppal riego_sn
	
	merge m:1 keyppal_l using "${cooked}/EAAP_19_LOTES.dta", ///
	keepusing(`covs_lote') nogen
	
	
	tempfile lote_cosechas_cultivos_eabp
	save `lote_cosechas_cultivos_eabp'
	
	
	*** Merge everything with master dataset
	
	* Master dataset
	import delimited "${raw}/CSV/EAB_19_ANONIMIZADA/EABP_19_IDENTIFICACION.csv", clear
	keep keyppal cod_reg cod_dpto upa_area tecinf_upa_op* util_produpa_op* ///
	actv_upa_op* sisprod_upa_op*
	
	* Merge with modulo temporal
	local modulo insum_agrop_op* acti_agricola_dif_op* acti_pecuaria_dif_op* ///
	fuentes_info_op* recursos_financi_op* asistencia_tecnica_op*
	
	merge 1:1 keyppal using "${cooked}/EABP_19_MODULO.dta", nogen ///
	keepusing(`modulo')

	* Merge with Pecuaria
	local pecu espec_exiup_op* bovtotal_pon 
	
	merge 1:1 keyppal using "${cooked}/EABP_19_PECUARIA.dta", nogen ///
	keepusing(`pecu')	
	
	* Merge with Uso suelo
	local suelo ar_perm ar_tran ar_pasf ar_malras_sn ar_malras
	
	merge 1:1 keyppal using "${cooked}/EABP_19_USUELO.dta", nogen ///
	keepusing(`suelo')
	
	tempfile upas_eabp
	save `upas_eabp'
	
	* Observation unit: UPA
	*-----------------------* 
	
	* Merge with cosechas-cultivos-lote
	merge 1:m keyppal using "`lote_cosechas_cultivos_eabp'", nogen
	
	tempfile secondsemester
	save `secondsemester'
	

	* Observation unit: cosechas-cultivos-lote-UPA
	*----------------------------------------------* 
	

************************************************
*                3. Append data                *
************************************************

	use "`firstsemester'", clear
	append using "`secondsemester'"
	
	save "${tasty}/ENA-2019-general-table_cosechas-cultivos.dta", replace	

	
	