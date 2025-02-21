***********************************************
* Title: 000_imort_and_explore
* Proyect: SPIA - Colombia country study
* Purpose: 
/*
	Do file used to explore ENA datasets
*/
* Last update date: 2025-02-17
* Author: Juan Sebastián Lemos
***********************************************


clear all
set more off
cap log close


************************************************
*                0. Key Macros                 *
************************************************

	di "current user: `c(username)'"
	
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
*                1. Import data                *
************************************************

	****** Import Fisrt semester
	
	* Cosechas
	import delimited "${raw}/CSV/EAA_19_ANONIMIZADA/EAAP_19_COSECHAS.csv", clear
	duplicates report keyppal_co // Unique id
	save "${cooked}/EAAP_19_COSECHAS.dta", replace
	
	/* 
	- Cosechas information:
	
	Maybe the most important variables are:
		- cosecha_cant: cantidad cosechada
		- cosecha_um: unidad de medida
		- espec_prod: especificación del producto
		- rend_def: rendimiento
		- porc_autocon porc_autocon_ali_anim porc_autocon_ali_huma porc_autocon_semilla porc_venta
		 - precio_x_kilo
	*/
	
	
	* Cultivos
	import delimited "${raw}/CSV/EAA_19_ANONIMIZADA/EAAP_19_CULTIVOS.csv", clear
	duplicates report keyppal_cu // Uniqe id
	save "${cooked}/EAAP_19_CULTIVOS.dta", replace
	
	/* 
	- Cultivos information:
	
	Maybe the most important variables are:
		- cul_tipo : tipo de cultivo
		- cul_nom : nombre
		- cul_var : variedad
		- siembra_anio: año de siembra 
		- lote_um: unidad de medida
		- ar_semoplan: área sembrada
		- riego_sis: sistema de riego
		- area_riego: área regada
		- frec_rieg: frecuencia del riego
		- insumos_cul_opa insumos_cul_opb insumos_cul_opc
		- prod_quim: ferecuencia uso de productos químicos
		- sin_prod_quim: ferecuencia de al aplicicación de control
		- afec_pme_cul: cuál fue la incidencia de afectación de plagas
		- planfert_cul: plan de fertilización del cultivo
		- fertilizante_opa fertilizante_opb: tipos de fertilizantes
		- for_apli_insum: forma de aplicicación de fertilizante
		- cant_fert_con_quim: número de fertilizaciones con productos químicos
		- cant_fert_sin_quim: número de fertilizaciones sin productos
		- cul_etamaq_opa cul_etamaq_opb cul_etamaq_opc cul_etamaq_opd cul_etamaq_ope
		  cul_etamaq_opf cul_etamaq_opg cul_etamaq_oph : tipo de maquinaria
		- plafor_bcarb: plantación con bonos de carbono
		- pradera_man: uso de forrajes
		- sempla_proc: de dónde proviene la semmilla
	*/
	
	
	* Dispersos
	import delimited "${raw}/CSV/EAA_19_ANONIMIZADA/EAAP_19_DISPERSOS.csv", clear
	duplicates report keyppal_d // uniqe id
	duplicates report keyppal // llave externa
	save "${cooked}/EAAP_19_DISPERSOS.dta", replace	
	
	/* 
	- Cultivos dispersos information:	
	
	Maybe the most important variables are:
		- dis_nom : nombre del disperso
	*/
	
	
	* Energía
	import delimited "${raw}/CSV/EAA_19_ANONIMIZADA/EAAP_19_ENERGIA.csv", clear
	duplicates report keyppal // Uniqe id	
	save "${cooked}/EAAP_19_ENERGIA.dta", replace	
	
	/* 
	- Uso de energía en UPA's:	
	
	Maybe the most important variables are:
		- maq_agr_sn: maquinaria para uso agrícola
		- util_maq_agricola_opa util_estier_opb util_estier_opc: tipo de maquinaria
		- maq_pec_sn: maquinaria para uso pecuario
		- ppal_uso_maq_pec: uso de la maquinaria
		- tip_maq_opa tip_maq_opb tip_maq_opc: qué maquinaria se utiliza
		- manejo_estierc: uso de estiércol 
		- tip_estiercol_opa tip_estiercol_opb: cantidad de estiércol por tipo (dummy)
		- cant_estier_seco cant_estier_liq: cantidad
		- um_estier_opa um_estier_opb: unidades de medida
		- util_estier_opa util_estier_opb: tipos de uso
		- porc_fertil: porcentaje de abono
		- porc_alim_pecu: porentaje de alimento a pecuarios
		- porc_biogas: insumo de biogas
		- resid_aprovec: tipo de aprovechamiento de residuos agricolas
		- util_resid_opa util_estier_opb util_estier_opc: cómo se usan y en qué porcentaje
		- porc_alim_anim: estiercol para alimento animal
		- porc_compost: porcentaje composta
		- porc_biocomb: porcetaje para biocombustible
	*/	
	
	
	* Identificación (this will be the master dataset)
	import delimited "${raw}/CSV/EAA_19_ANONIMIZADA/EAAP_19_IDENTIFICACION.csv", clear
	duplicates report keyppal // Uniqe id
	save "${cooked}/EAAP_19_IDENTIFICACION.dta", replace	
	
	/* 
	- UPA's:	
	
	Maybe the most important variables are:
		- cod_reg
		- cod_dpto
		- upa_area
		- tecinf_upa_opa tecinf_upa_opb tecinf_upa_opc tecinf_upa_opd tecinf_upa_ope tecinf_upa_opf : tipos de tecnología de información
		- util_produpa_opa util_produpa_opb util_produpa_opc util_produpa_opd util_produpa_ope util_produpa_opf 
		  util_produpa_opg util_produpa_oph : tipos de usos de las tecnologías
		- actv_upa_op* todas son actividades de las upa's
		- sisprod_upa_op*: sistemas de producción
	
	*/
	

	* Lotes
	import delimited "${raw}/CSV/EAA_19_ANONIMIZADA/EAAP_19_LOTES.csv", clear
	duplicates report keyppal_l // NO uniqe id
	duplicates drop keyppal_l, force
	save "${cooked}/EAAP_19_LOTES.dta", replace	
	
		* - Información de lotes: riego_sn
	
	
	* Maquinaria agrícola
	import delimited "${raw}/CSV/EAA_19_ANONIMIZADA/EAAP_19_MAQ_AGR.csv", clear
	duplicates report keyppal_mqa // No unique id
	
	save "${cooked}/EAAP_19_MAQ_AGR.dta", replace	
	
		* - maq_agricola: tipo de maquinaria
		
	
	* Maquinaria pecuaria
	import delimited "${raw}/CSV/EAA_19_ANONIMIZADA/EAAP_19_MAQ_PEC.csv", clear
	duplicates report keyppal_mqp // No unique id
	save "${cooked}/EAAP_19_MAQ_PEC.dta", replace	
	
		* - maq_pecuaria: tipo de maquinaria
	
	*  ¿Muestras?
	import delimited "${raw}/CSV/EAA_19_ANONIMIZADA/EAAP_19_NU_MUES.csv", clear
	duplicates report keyppal_nm // Uniqe id
	save "${cooked}/EAAP_19_NU_MUES.dta", replace	
	
	/* 
	- Tipos de muestra	
	
	Maybe the most important variables are:
		- acul_tipo: tipo cultivo
		- acul_nom: nombre cultivo
	*/	
	
	
	* Otras especies
	import delimited "${raw}/CSV/EAA_19_ANONIMIZADA/EAAP_19_OTESPEC.csv", clear
	duplicates report keyppal_oe // Unique id
	save "${cooked}/EAAP_19_OTESPEC.dta", replace
	
	/*
	- Otras especies pecuarias y otros productos
	   
	Maybe the most important variables are:
		- num_otespec: numero de otras especies
		- otespec: cuáles son las otras especies
		- otep_tot: total especie pecuaria
		- otep_prod_totalpdcc_op* : producción de otros productos agrícolas
	*/
	
	* Pecuaria
	import delimited "${raw}/CSV/EAA_19_ANONIMIZADA/EAAP_19_PECUARIA.csv", clear
	duplicates report keyppal // Unique id	
	save "${cooked}/EAAP_19_PECUARIA.dta", replace
	
	/*
	- Especies pecuarias
	   
	Maybe the most important variables are:
		- espec_exiup_op* : tipo de especies que están.
		- bovtotal_pon: cantidad de ganado bovino
	*/	
	
	
	* Productor 
	import delimited "${raw}/CSV/EAA_19_ANONIMIZADA/EAAP_19_PRODUCTOR.csv", clear
	duplicates report keyppal_pr
	save "${cooked}/EAAP_19_PRODUCTOR.dta", replace
	
	
	/*
	- Productor
	   
	Maybe the most important variables are:
		- cond_cam_prod_sn: considerarse campesino
		- sit_desplaz_op* : situación de desplazamiento
		- cod_dpto_resprod: departamento
		- edad_prod: edad		
	*/
	
	
	* Uso suelo
	
	import delimited "${raw}/CSV/EAA_19_ANONIMIZADA/EAAP_19_USUELO.csv", clear
	duplicates report keyppal // unique id
	save "${cooked}/EAAP_19_USUELO.dta", replace
	
	/*
	- Uso suelo
	 
	Maybe the most important variables are:
		- ar_perm ar_tran: area de cultivos
		- ar_pasf: área pastos
		- ar_malras_sn: area malezas
		- ar_malras: área de malezas
		
	*/

	
	****** Now second semester
	
	* I think the only differnt one is EABP_19_MODULO
	import delimited "${raw}/CSV/EAB_19_ANONIMIZADA/EABP_19_MODULO.csv", clear
	duplicates report keyppal
	
	/*
	- Modulo temporal
	 
	Maybe the most important variables are:
		- insum_agrop_op* : insumos de plantas
		- acti_agricola_dif_op* : cuáles actividades agrícolas mejoraron
		- acti_pecuaria_dif_op* : cuáles actividades pecuarias mejoraron
		- fuentes_info_op* : cuál fuente de información uso
		- recursos_financi_op* fuentes de financiación
		- asistencia_tecnica_op* : de quién recibió asistencia técnica
	*/
	
	
	* The rest of the modules keep the same
	local datasets EABP_19_COSECHAS EABP_19_CULTIVOS EABP_19_DISPERSOS EABP_19_IDENTIFICACION ///
	EABP_19_LOTES EABP_19_MODULO EABP_19_OTESPEC EABP_19_PECUARIA EABP_19_PRODUCTOR ///
	EABP_19_USUELO
	
	foreach x of local datasets {
		import delimited "${raw}/CSV/EAB_19_ANONIMIZADA/`x'.csv", clear
	    save "${cooked}/`x'.dta", replace 
	}
	
	* Clean observation before merging
	use "${cooked}/EABP_19_CULTIVOS.dta", clear
	duplicates report keyppal_cu
	duplicates drop keyppal_cu, force
	save "${cooked}/EABP_19_CULTIVOS.dta", replace	
	
************************************************
*                2. End                        *
************************************************
	
	