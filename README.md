# ENA cleanig repository
Repository used to store code to clean ENA. We expect the final output of this repository 
to be: (1) a set of reproducible codes that imports, process, clean and store 
ENA (Encuesta Nacional Agropecuaria) data and (2) a directory of the variables 
we considered the most important ones to characterize the colombian 
agricultural sector. 

All data could be downloaded from the following [link](https://microdatos.dane.gov.co/index.php/catalog/749/get-microdata).

All data we are using to produce this files was downloaded 2024/05/10.

Currently, data is stored at Uniandes One-drive.


### Tidy tables

Here are presented all datsets produces after the cleaning process:

| Name of the dataset and path | Level of aggregation | Unique_ID | Foreign key | Year(s) | Description                                                        |
|-------------------------------------|----------------------|--------------|------|------| -------------------------------------------------------------------|
| [ENA-2019-general-table_cosechas-cultivos](https://uniandes-my.sharepoint.com/:u:/r/personal/js_lemos_uniandes_edu_co/Documents/SPIA-Colombia-country-study_data/001.ENA-cleanig_repository/Build/Tasty/ENA-2019-general-table_cosechas-cultivos.dta?csf=1&web=1&e=8l4nCh)| Cosecha-Cultivo-Lote-UPA | unique_id | keyppal_co - keyppal_cu - keyppal_l - keyppal | 2019 | Information of every havrvest, crop produced in a Agricultural Production Unit (UPA)   |

### Variables dictionaries and modules

Here are presented all variables selectes after the cleaning process:

| Variable       | Description        | Where to find it at DANE                |
|-----------------------|--------------------------------------------------|-----------------|
| cosecha_cant          | Cantidad cosechada o a cosechar            |  EAAP_19_COSECHAS & EABP_19_COSECHAS  |
| cosecha_um            | Unidad de medida                           |  EAAP_19_COSECHAS & EABP_19_COSECHAS  |
| espec_prod            | Especificación del producto                |  EAAP_19_COSECHAS & EABP_19_COSECHAS  |
| rend_def              | Rendimiento                                |  EAAP_19_COSECHAS & EABP_19_COSECHAS  |
| precio_x_kilo         | Precio por kilo                            |  EAAP_19_COSECHAS & EABP_19_COSECHAS  |




### Updated for last time
Last update: 2025/02/21
