with awardtots as (
select unique_award_id, sum(totalobligated) TOB, count(*)
from ml_dataset_4
where naics_code is not null
group by unique_award_id)

--593395.565524058044

select --216958
distinct -- 74032
a.unique_award_id
,case when b.tob > 593395.57 then 1 else 0 end AboveAvgDO
,case when b.tob < 593395.57 then 1 else 0 end BelowAvgDO
,level_2_cat_itprof
,level_2_cat_products
,level_2_cat_caas
,level_3_cat_delivery
,level_3_cat_securitycompliance
,level_3_cat_storage
,level_3_cat_enduser
,level_3_cat_platform
,level_3_cat_application
,level_3_cat_compute
,level_3_cat_itmanagement
,level_3_cat_network
,level_3_cat_datacenter
,co_bus_size_notsba
,co_bus_size_sba
,naics_code
,biz_rule_tiert1
,biz_rule_tiert2
,biz_rule_tierbic
,biz_rule_tier0
,funding_agency_name
,coalesce(replace(replace(REPLACE(vendor_name, '.', '' ),',',''),'!',''),'NotProvided') Vendor
,contractsched70
,contractnetweis
,contractstars8a
,contractwirelessmobilitysolutions
,contractalliant
,contractmas
,contractcnxs
,contractsatcom
,contractveterans
,contractsalesforce
,contracteis
,contractmillennia
,contractmillennialite
into ml_dataset_5
from ml_dataset_4 A
join awardtots B on a.unique_award_id = B.unique_award_id
where naics_code is not null

select 19067.0/216958

select vendor_name, count(*)
from ml_dataset_4
group by vendor_name
order by 1

select distinct
       --vendor_name
       trim(replace(replace(REPLACE(vendor_name, '.', '' ),',',''),'!',''))
from ml_dataset_4
group by vendor_name

select
sum(aboveavgdo) Above
,sum(belowavgdo) Below
from ml_dataset_5
where
contractmillennialite = 1

 --8a, veterans has about the same above as below
 --contract alliant has many above
 --contracteis all below

 select
contractsched70
,contractnetweis
,contractstars8a
,contractwirelessmobilitysolutions
,contractalliant
,contractmas
,contractcnxs
,contractsatcom
,contractveterans
,contractsalesforce
,contracteis
,contractmillennia
,contractmillennialite
,naics_code
,totalobligated
from ml_dataset_4

select naics_code, contract_name_rollup, count(distinct unique_award_id), sum(totalobligated)
from ml_dataset_3
    where naics_code is not null
group by naics_code, contract_name_rollup
order by 1

select contract_name_rollup, count(*)
    from ml_dataset_3
        group by contract_name_rollup

select btrim(naics_code), count(*)
    from ml_dataset_3
        group by btrim(naics_code)


contractsatcom,
contractveterans,
contractsalesforce,
contracteis,
contractmillennia,
contractmillennialite

select
aboveavgdo
,belowavgdo
,level_2_cat_itprof,
level_2_cat_products,
level_2_cat_caas,
level_3_cat_delivery,
level_3_cat_securitycompliance,
level_3_cat_storage,
level_3_cat_enduser,
level_3_cat_platform,
level_3_cat_application,
level_3_cat_compute,
level_3_cat_itmanagement,
level_3_cat_network,
level_3_cat_datacenter,
co_bus_size_notsba,
co_bus_size_sba,
naics_code,
biz_rule_tiert1,
biz_rule_tiert2,
biz_rule_tierbic,
biz_rule_tier0,
contractsched70,
contractnetweis,
contractstars8a,
contractwirelessmobilitysolutions,
contractalliant,
contractmas,
contractcnxs,
contractsatcom,
contractveterans,
contractsalesforce,
contracteis,
contractmillennia,
contractmillennialite
from ml_dataset_5

select * from itc_obs_0421_savecheck3

select
tid
,unique_award_id
,description_of_requirement
,naics_code
,replace(psc_desc,'~',' ') psc_desc
,dollars_obligated
,date_signed
,contract_name
,level_3_category
,level_2_category
,department_name
,funding_agency_name
,funding_cfo_act_agency
,funding_dod_or_civilian
,vendor_name
,eight_a_flag
,co_bus_size_determination
,business_rule_tier
,replace(award_type,'~',' ') award_type
,award_or_idv
from itc_obs_0421_savecheck3
order by 2,5


--REPLACE(source, old_text, new_text );
select level_1_category, count(*)
from itc_obs_0421_savecheck3
group by level_1_category

select --
tid
,unique_award_id
,dollars_obligated
,naics_code
,cast(date_signed as date) date_signed
,case when strpos(upper(contract_name),'SATCOM') > 0 then 'SATCOM'
when strpos(upper(contract_name),'SALESF') >0 then 'SALESFORCE'
when strpos(upper(contract_name),'STAR') >0 then 'STARS8A'
when strpos(contract_name,'70')>0 then 'SCHED70'
when strpos(upper(contract_name),'ALL') >0 then 'ALLIANT'
when strpos(upper(contract_name),'CONN')>0 then 'CONNECTIONS'
when strpos(upper(contract_name),'VET')>0 then 'VETTECHSERV'
when strpos(upper(contract_name),'MILLEN')>0 then 'MILLENIAL'
when strpos(upper(contract_name),'EIS')>0 then 'EIS'
else contract_name end Contract_Name_RU
,case level_3_category when 'Delivery' then 1 else 0 end Level_3_cat_Delivery
,case level_3_category when 'Security & Compliance' then 1 else 0 end Level_3_cat_SecurityCompliance
,case level_3_category when 'Storage' then 1 else 0 end Level_3_cat_Storage
,case level_3_category when 'End User' then 1 else 0 end Level_3_cat_EndUser
,case level_3_category when 'Platform' then 1 else 0 end Level_3_cat_Platform
,case level_3_category when 'Application' then 1 else 0 end Level_3_cat_Application
,case level_3_category when 'Compute' then 1 else 0 end Level_3_cat_Compute
,case level_3_category when 'IT Management' then 1 else 0 end Level_3_cat_ITManagement
,case level_3_category when 'Network' then 1 else 0 end Level_3_cat_Network
,case level_3_category when 'Data Center' then 1 else 0 end Level_3_cat_DataCenter
,case level_2_category when 'IT Professional Services' then 1 else 0 end Level_2_cat_ITPROF
,case level_2_category when 'Products' then 1 else 0 end Level_2_cat_Products
,case level_2_category when 'Capability As a Service' then 1 else 0 end Level_2_cat_CAAS
,case eight_a_flag when 'YES' then 1 else 0 end EightA_YES
,case eight_a_flag when 'NO' then 1 else 0 end EightA_NO
,case co_bus_size_determination when 'OTHER THAN SMALL BUSINESS' then 1 else 0 end co_bus_size_NotSBA
,case co_bus_size_determination when 'SMALL BUSINESS' then 1 else 0 end co_bus_size_SBA
,case business_rule_tier when 'TIER 1' then 1 else 0 end biz_rule_tierT1
,case business_rule_tier when 'TIER 2' then 1 else 0 end biz_rule_tierT2
,case business_rule_tier when 'BIC' then 1 else 0 end biz_rule_tierBIC
,case business_rule_tier when 'TIER 0 - DEFINITIVE CONTRACT' then 1 else 0 end biz_rule_tier0
,replace(award_type,'~',' ') award_type
,case award_or_idv when 'AWARD' then 1 else 0 end AWARD
,case award_or_idv when 'IDV' then 1 else 0 end IDV
,department_name
,funding_agency_name
,funding_cfo_act_agency
,funding_dod_or_civilian
,vendor_name
,description_of_requirement
,replace(psc_desc,'~',' ') psc_desc
into ml_featureset_1
from itc_obs_0421_savecheck3
order by 2,5

select award_or_idv, count(*)
from itc_obs_0421_savecheck3
group by award_or_idv


select description_of_requirement
from itc_obs_0421_savecheck3
where tid in (257042
,190627
,501965
,292083
,306709
,382878
,253007
,254339
,66297
,29316
,29327
,29319
,42757
,42190
,392990
,392992
)




