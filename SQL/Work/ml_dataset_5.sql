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

