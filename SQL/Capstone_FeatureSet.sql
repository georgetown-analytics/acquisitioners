--Group the contract names together so that there are less unique values that represent the same contract
select contract_name, count(*)
from itc_obs_0421_savecheck3
group by contract_name
order by 2 desc


--tag the contracts, one hot some of the columns
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
,case eight_a_flag when 'YES' then 1 else 0 end EightA_Yes
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

--check
select award_or_idv, count(*)
from itc_obs_0421_savecheck3
group by award_or_idv

--check
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

select distinct
unique_award_id,
dollars_obligated,
naics_code,
date_signed,
contract_name_ru,
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
level_2_cat_itprof,
level_2_cat_products,
level_2_cat_caas,
eighta_yes,
eighta_no,
co_bus_size_notsba,
co_bus_size_sba,
biz_rule_tiert1,
biz_rule_tiert2,
biz_rule_tierbic,
biz_rule_tier0,
award_type,
award,
idv,
department_name,
funding_agency_name,
funding_cfo_act_agency,
funding_dod_or_civilian,
vendor_name,
description_of_requirement,
psc_desc
from ml_featureset_1

--unique award ids that only have 0 dollars obligated
select unique_award_id, count(*)
from ml_featureset_1 a
where dollars_obligated = 0
and not exists(
    select 1
    from ml_featureset_1 b
    where a.unique_award_id = b.unique_award_id
    and b.dollars_obligated <> 0
    )
group by unique_award_id
order by 2 desc

select *
from itc_obs_0421_savecheck3
where unique_award_id = 'GS35F0662RGSP0714HH0023'

with look as (
select unique_award_id, date_signed
from
ml_featureset_1
group by unique_award_id, date_signed)

select unique_award_id, count(*), count(distinct date_signed)
from look
group by unique_award_id
having count(*) <> count(distinct date_signed)
--no unique award id have two records on the same date_signed

--look for duplicates
select
count(*)
,min(tid)
,max(tid)
,unique_award_id,
dollars_obligated,
naics_code,
date_signed,
contract_name_ru,
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
level_2_cat_itprof,
level_2_cat_products,
level_2_cat_caas,
eighta_yes,
eighta_no,
co_bus_size_notsba,
co_bus_size_sba,
biz_rule_tiert1,
biz_rule_tiert2,
biz_rule_tierbic,
biz_rule_tier0,
award_type,
award,
idv,
department_name,
funding_agency_name,
funding_cfo_act_agency,
funding_dod_or_civilian,
vendor_name,
description_of_requirement,
psc_desc
from ml_featureset_1
group by
unique_award_id,
dollars_obligated,
naics_code,
date_signed,
contract_name_ru,
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
level_2_cat_itprof,
level_2_cat_products,
level_2_cat_caas,
eighta_yes,
eighta_no,
co_bus_size_notsba,
co_bus_size_sba,
biz_rule_tiert1,
biz_rule_tiert2,
biz_rule_tierbic,
biz_rule_tier0,
award_type,
award,
idv,
department_name,
funding_agency_name,
funding_cfo_act_agency,
funding_dod_or_civilian,
vendor_name,
description_of_requirement,
psc_desc
having count(*) >1
order by 1 desc

select *
from itc_obs_0421_savecheck3
where unique_award_id = 'GS00Q17NSD3001'


select
count(*)
,min(tid)
,max(tid)
,unique_award_id,
reference_piid,
piid,
modification_number,
description_of_requirement,
naics_code,
psc_desc,
dollars_obligated,
fiscalyear,
fiscal_quarter,
final_ultimate_completion_date,
expiring_date_custom,
current_completion_date,
date_signed,
contract_name,
multiyear_contract,
level_3_category,
level_2_category,
level_1_category,
department_name,
funding_department_name,
funding_agency_name,
funding_office_name,
funding_office_info,
funding_cfo_act_agency,
funding_dod_or_civilian,
managing_agency,
contracting_agency_name,
contracting_office_name,
contracting_office_info,
vendor_name,
pop_zip_code,
pop_county_name,
eight_a_flag,
co_bus_size_determination,
business_rule_tier,
award_type,
award_or_idv
from itc_obs_0421_savecheck3
group by
unique_award_id,
reference_piid,
piid,
modification_number,
description_of_requirement,
naics_code,
psc_desc,
dollars_obligated,
fiscalyear,
fiscal_quarter,
final_ultimate_completion_date,
expiring_date_custom,
current_completion_date,
date_signed,
contract_name,
multiyear_contract,
level_3_category,
level_2_category,
level_1_category,
department_name,
funding_department_name,
funding_agency_name,
funding_office_name,
funding_office_info,
funding_cfo_act_agency,
funding_dod_or_civilian,
managing_agency,
contracting_agency_name,
contracting_office_name,
contracting_office_info,
vendor_name,
pop_zip_code,
pop_county_name,
eight_a_flag,
co_bus_size_determination,
business_rule_tier,
award_type,
award_or_idv
having count(*) >1
order by 1 desc

select * from ml_featureset_1

select
unique_award_id
,coalesce(naics_code,1)
,count(distinct coalesce(naics_code,1)) NumNaics
,count(*)
from ml_featureset_1
group by
unique_award_id
,naics_code
having count(distinct coalesce(naics_code,1)) >1
order by 3 desc

with nai as (
    select distinct
    unique_award_id
    ,coalesce(naics_code,1) naics
    from ml_featureset_1
)

select
unique_award_id, count(*)
from nai
group by unique_award_id
having count(*)>1
order by 1

--check
select * from ml_featureset_1 where unique_award_id = 'GS35F0119YHHSP233201500164G'
select * from ml_featureset_1 where unique_award_id = 'GS35F0153MFERC14F0205'
select * from ml_featureset_1 where unique_award_id = 'GS35F0265X15JPPS19F00000031'
select * from ml_featureset_1 where unique_award_id = 'GS35F0265XAG7604D160224'
select * from ml_featureset_1 where unique_award_id = 'GS35F0265XIND17PD00944'
select * from ml_featureset_1 where unique_award_id = 'GS35F0265XW9124P19F00A4'
select * from ml_featureset_1 where unique_award_id = 'GS35F0271VW52P1J16F0047'
select * from ml_featureset_1 where unique_award_id = 'GS35F0337PINR16PD00721'


select distinct contract_name_ru
from ml_featureset_1

select min(naics_code), max(naics_code)
from ml_featureset_1

select unique_award_id
       ,contract_name_ru
from ml_featureset_1 a
where exists(
    select 1
    from ml_featureset_1 b
    where a.unique_award_id = b.unique_award_id
    and a.contract_name_ru <> b.contract_name_ru
          )

select unique_award_id, contract_name_ru, count(distinct contract_name_ru), count(*)
    from
    ml_featureset_1
group by unique_award_id, contract_name_ru
order by 3 desc

select vendor_name, count(*)
from ml_featureset_1
group by vendor_name
order by 1

--any easy dupes in the vendor name? not really
select distinct
replace(trim(replace(replace(replace(replace(replace(replace(replace(REPLACE(coalesce(vendor_name,'none'), ',', '' ),'.',''),'&',''),')',''),'(',''),'@',''),'  ',' '),'-','')),'  ',' ')
from ml_featureset_1
order by 1

select count(distinct vendor_name) from ml_featureset_1

--vendors with the highest number of unique awards
select coalesce(vendor_name,'none'), count(distinct unique_award_id), sum(dollars_obligated)
from ml_featureset_1
group by coalesce(vendor_name,'none')
order by 2 desc


--Second ML_featureset with some updates and new fields per discussion with Blake on 5/13
select --
tid
,unique_award_id
,dollars_obligated
,naics_code
,fiscalyear
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
,case eight_a_flag when 'YES' then 1 else 0 end EightA --change this to a single column from 2
,case co_bus_size_determination when 'SMALL BUSINESS' then 1 else 0 end co_bus_size_SBA --change this to a single column from 2
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
,case when strpos(upper(vendor_name),'BOOZ') > 0 then 1 else 0 end VDO1_Booz
,case when coalesce(vendor_name,'none')='none' then 1 else 0 end VDO2_None
,case when strpos(upper(vendor_name),'DELL FEDERAL SYSTEMS') > 0 then 1 else 0 end VDO3_DFS
,case when strpos(upper(vendor_name),'SCIENCE APPLICATIONS INTERNATIONAL') > 0 then 1 else 0 end VDO4_SAIC
,case when strpos(upper(vendor_name),'CARAHSOFT') > 0 then 1 else 0 end VDO5_CARA
,case when strpos(upper(vendor_name),'INSIGHT PUBLIC') > 0 then 1 else 0 end VDO6_IPSI
,case when strpos(upper(vendor_name),'AT&T C') > 0 then 1 else 0 end VDO7_ATTC
,case when strpos(upper(vendor_name),'ACCENTURE F') > 0 then 1 else 0 end VDO8_ACCT
,case when strpos(upper(vendor_name),'SYSTEMS RESEARCH AND A') > 0 then 1 else 0 end VDO9_SRAC
,case when strpos(upper(vendor_name),'INTERNATIONAL BUSINESS M') > 0 then 1 else 0 end VD10_IBM
,case when vendor_name in ('INSIGHT PUBLIC SECTOR, INC.','BOOZ ALLEN HAMILTON INC.' ,'DELL FEDERAL SYSTEMS L.P.'
    ,'SCIENCE APPLICATIONS INTERNATIONAL CORPORATION','CARAHSOFT TECHNOLOGY CORPORATION','INSIGHT PUBLIC SECTOR, INC.'
    ,'AT&T CORP.','ACCENTURE FEDERAL SERVICES LLC','SYSTEMS RESEARCH AND APPLICATIONS CORPORATION','INTERNATIONAL BUSINESS MACHINES CORPORATION') then 0
when coalesce(vendor_name,'none')='none' then 0 else 1 end VD11_Other
,case when coalesce(vendor_name,'none')='none' then 1 else 0 end VA01_None
,case when strpos(upper(vendor_name),'SOLVIX') > 0 then 1 else 0 end VA02_SOLV
,case when strpos(upper(vendor_name),'CARAHSOFT') > 0 then 1 else 0 end VA03_CARA
,case when strpos(upper(vendor_name),'AT&T C') > 0 then 1 else 0 end VA04_ATTC
,case when strpos(upper(vendor_name),'CELLCO') > 0 then 1 else 0 end VA05_CELL
,case when strpos(upper(vendor_name),'MCI C') > 0 then 1 else 0 end VA06_MCIC
,case when strpos(upper(vendor_name),'DLT S') > 0 then 1 else 0 end VA07_DLTS
,case when strpos(upper(vendor_name),'AT&T M') > 0 then 1 else 0 end VA08_ATTM
,case when strpos(upper(vendor_name),'QWEST') > 0 then 1 else 0 end VA09_QWES
,case when strpos(upper(vendor_name),'DELL M') > 0 then 1 else 0 end VA10_DELLM
,case when vendor_name in ('SOLVIX SOLUTIONS','CARAHSOFT TECHNOLOGY CORPORATION','AT&T CORP.','CELLCO PARTNERSHIP','MCI COMMUNICATIONS SERVICES INC','DLT SOLUTIONS, LLC','AT&T MOBILITY LLC',
'QWEST GOVERNMENT SERVICES INC','QWEST GOVERNMENT SERVICES, INC') then 0
when coalesce(vendor_name,'none')='none' then 0 else 1 end VA11_Other
,description_of_requirement
,replace(psc_desc,'~',' ') psc_desc
into ml_featureset_2
from itc_obs_0421_savecheck3

select
tid,
unique_award_id,
dollars_obligated,
naics_code,
fiscalyear,
contract_name_ru,
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
level_2_cat_itprof,
level_2_cat_products,
level_2_cat_caas,
eighta,
co_bus_size_sba,
biz_rule_tiert1,
biz_rule_tiert2,
biz_rule_tierbic,
biz_rule_tier0,
award_type,
award,
idv,
department_name,
funding_agency_name,
funding_cfo_act_agency,
funding_dod_or_civilian,
vdo1_booz,
vdo2_none,
vdo3_dfs,
vdo4_saic,
vdo5_cara,
vdo6_ipsi,
vdo7_attc,
vdo8_acct,
vdo9_srac,
vd10_ibm,
vd11_other,
va01_none,
va02_solv,
va03_cara,
va04_attc,
va05_cell,
va06_mcic,
va07_dlts,
va08_attm,
va09_qwes,
va10_dellm,
va11_other,
description_of_requirement,
psc_desc
from ml_featureset_2
order by 2,5

select department_name, funding_agency_name, count(*)
from ml_featureset_2
group by department_name, funding_agency_name
order by 3 desc

--one hots - award type,funding_dod_or_civilian - do this in pandas


select vendor_name
from itc_obs_0421_savecheck3
where vendor_name like 'CELLCO%'
group by vendor_name

select vendor_name
from itc_obs_0421_savecheck3
where strpos(upper(vendor_name),'MCI') > 0
group by vendor_name

/*
 Top Vendors by Num of Awards
 none,13441,7385173799.44
SOLVIX SOLUTIONS,11104,20768540.04
CARAHSOFT TECHNOLOGY CORPORATION,9199,3262467758.73
AT&T CORP.,8222,2501263822.09
CELLCO PARTNERSHIP,7766,434794262.63
MCI COMMUNICATIONS SERVICES INC,7460,1259050459.03
"DLT SOLUTIONS, LLC",6698,1484477182.04
AT&T MOBILITY LLC,5672,539914605.49
QWEST GOVERNMENT SERVICES INC
"QWEST GOVERNMENT SERVICES, INC"

DELL MARKETING L.P.,5013,1240017524.57


 Top vendors by dollars obligated
none,30561,7385173799.44
BOOZ ALLEN HAMILTON INC.,2863,4598307365.31
DELL FEDERAL SYSTEMS L.P.,2951,4290170409.65
SCIENCE APPLICATIONS INTERNATIONAL CORPORATION,1835,4036062711.48
CARAHSOFT TECHNOLOGY CORPORATION,14493,3262467758.73
"INSIGHT PUBLIC SECTOR, INC.",4270,2514517511.06
AT&T CORP.,26124,2501263822.09
ACCENTURE FEDERAL SERVICES LLC,2326,2382489740.59
SYSTEMS RESEARCH AND APPLICATIONS CORPORATION,1447,2310333689.11
INTERNATIONAL BUSINESS MACHINES CORPORATION,2722,2210694188.53

 Top Vendors by Number of Transactions
MCI COMMUNICATIONS SERVICES INC
none
AT&T CORP.
QWEST GOVERNMENT SERVICES INC
AT&T MOBILITY LLC
CELLCO PARTNERSHIP
CARAHSOFT TECHNOLOGY CORPORATION
SOLVIX SOLUTIONS
"DLT SOLUTIONS, LLC"
DELL MARKETING L.P.
*/

select vendor_name
,case when vendor_name in ('INSIGHT PUBLIC SECTOR, INC.','BOOZ ALLEN HAMILTON INC.' ,'DELL FEDERAL SYSTEMS L.P.'
    ,'SCIENCE APPLICATIONS INTERNATIONAL CORPORATION','CARAHSOFT TECHNOLOGY CORPORATION','INSIGHT PUBLIC SECTOR, INC.'
    ,'AT&T CORP.','ACCENTURE FEDERAL SERVICES LLC','SYSTEMS RESEARCH AND APPLICATIONS CORPORATION','INTERNATIONAL BUSINESS MACHINES CORPORATION') then 0
when coalesce(vendor_name,'none')='none' then 0 else 1 end VD11_Other
from itc_obs_0421_savecheck3
--where vendor_name in ('INSIGHT PUBLIC SECTOR, INC.','BOOZ ALLEN HAMILTON INC.' ,'DELL FEDERAL SYSTEMS L.P.'
 --   ,'SCIENCE APPLICATIONS INTERNATIONAL CORPORATION','CARAHSOFT TECHNOLOGY CORPORATION','INSIGHT PUBLIC SECTOR, INC.'
 --   ,'AT&T CORP.','ACCENTURE FEDERAL SERVICES LLC','SYSTEMS RESEARCH AND APPLICATIONS CORPORATION','INTERNATIONAL BUSINESS MACHINES CORPORATION')
limit 500

select vendor_name
,case when vendor_name in ('SOLVIX SOLUTIONS','CARAHSOFT TECHNOLOGY CORPORATION','AT&T CORP.','CELLCO PARTNERSHIP','MCI COMMUNICATIONS SERVICES INC','DLT SOLUTIONS, LLC','AT&T MOBILITY LLC',
'QWEST GOVERNMENT SERVICES INC','QWEST GOVERNMENT SERVICES, INC') then 0
when coalesce(vendor_name,'none')='none' then 0 else 1 end VA11_Other
from itc_obs_0421_savecheck3
--where vendor_name in ('INSIGHT PUBLIC SECTOR, INC.','BOOZ ALLEN HAMILTON INC.' ,'DELL FEDERAL SYSTEMS L.P.'
 --   ,'SCIENCE APPLICATIONS INTERNATIONAL CORPORATION','CARAHSOFT TECHNOLOGY CORPORATION','INSIGHT PUBLIC SECTOR, INC.'
 --   ,'AT&T CORP.','ACCENTURE FEDERAL SERVICES LLC','SYSTEMS RESEARCH AND APPLICATIONS CORPORATION','INTERNATIONAL BUSINESS MACHINES CORPORATION')
limit 500

'SOLVIX SOLUTIONS','CARAHSOFT TECHNOLOGY CORPORATION','AT&T CORP.','CELLCO PARTNERSHIP','MCI COMMUNICATIONS SERVICES INC','DLT SOLUTIONS, LLC','AT&T MOBILITY LLC',
'QWEST GOVERNMENT SERVICES INC','QWEST GOVERNMENT SERVICES, INC'

--check work
select *
from itc_obs_0421_savecheck3
where unique_award_id = 'GS00T07NSD0008'
and dollars_obligated <> 0

select unique_award_id, count(*)
from itc_obs_0421_savecheck3
group by unique_award_id
order by 2 desc

--find that fiscal is different from the sign year, so add sign year to the dataset
select
a.tid, a.fiscalyear, b.date_signed, DATE_PART('year', b.date_signed::date) TrxYear
from
ml_featureset_2 a
join itc_obs_0421_savecheck3 b on a.tid  = b.tid

--update ml_featureset_2
set trxyear = DATE_PART('year', itc_obs_0421_savecheck3.date_signed::date)
from
     itc_obs_0421_savecheck3
where ml_featureset_2.tid  = itc_obs_0421_savecheck3.tid

select trxyear, count(*)
from ml_featureset_2
where trxyear <> fiscalyear
group by trxyear

/*
 UPDATE t1
SET t1.c1 = new_value
FROM t2
WHERE t1.c2 = t2.c2;
 */




