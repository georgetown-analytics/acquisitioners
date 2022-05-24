select
unique_award_id
--,modification_number
,min(date_signed) FirstSignDate
,max(final_ultimate_completion_date) LastFUD
into tmp_ContractDuration
from itc_customer_data_2015_2021
where tid not in (select tid from excluderows)
and dollars_obligated <> 0
group by unique_award_id

select *
from tmp_ContractDuration
order by 1

select *
from
itc_customer_data_2015_2021
where unique_award_id = 'GS00F122CADU100R16T00003'


select unique_award_id
,FirstSignDate
,LastFUD
,(DATE_PART('year', lastfud::date) - DATE_PART('year',firstsigndate::date)) * 12 +
              (DATE_PART('month', lastfud::date) - DATE_PART('month', firstsigndate::date)) ContractDurationMonths
from tmp_ContractDuration
order by 4 desc

--687160
select unique_award_id
,FirstSignDate
,LastFUD
,(DATE_PART('year', lastfud::date) - DATE_PART('year',firstsigndate::date)) * 12 +
              (DATE_PART('month', lastfud::date) - DATE_PART('month', firstsigndate::date)) ContractDurationMonths
from tmp_ContractDuration
where (DATE_PART('year', lastfud::date) - DATE_PART('year',firstsigndate::date)) * 12 +
              (DATE_PART('month', lastfud::date) - DATE_PART('month', firstsigndate::date)) <0

select
reference_piid refnum
,unique_award_id uaid
,modification_number modnum
,contract_name contra
,level_1_category l1cat
,level_2_category l2cat
,level_3_category l3cat
,funding_agency_name fundag
,funding_department_name fundept
,date_signed signdate
,final_ultimate_completion_date fudate
,dollars_obligated
from itc_customer_data_2015_2021
where tid not in (select tid from excluderows)
order by 1,date_signed,2;

select
unique_award_id
,vendor_name
,count(distinct vendor_name)
from itc_customer_data_2015_2021
group by unique_award_id
,vendor_name
order by 3 desc
--having count(distinct funding_agency_name)>1

select funding_department_name--
from itc_customer_data_2015_2021
where funding_department_name is not null
group by funding_department_name
order by 2 desc

Michelle - DOJ
Paul - Commerce
Desire - Homeland
Richard - Treasury

--JUSTICE, DEPARTMENT OF
select *
into tmp_DOJ
from itc_customer_data_2015_2021
where tid not in (select tid from excluderows)
and upper(funding_department_name) like '%JUSTICE%';

select unique_award_id
, sum(case when dollars_obligated > 0 then dollars_obligated else 0 end) POS
, sum(case when dollars_obligated < 0 then dollars_obligated else 0 end) NEG
, sum(dollars_obligated) AllocatedTD
, count(*) NumTransactions
from tmp_doj
group by unique_award_id
having sum(dollars_obligated)<0
order by 4 desc

--Range of allocations TD 256,868,820.48 to -7,034,006.11 over 42,176 total UAI
--Number of UAI greater than 0: 36,956
--Number of UAI equal 0: 2,282
--Number of UAI less than 0: 2,938

select 36956 + 2282 + 2938


select unique_award_id
from tmp_doj a
where not exists(
    select 1 from tmp_doj b
    where a.unique_award_id = b.unique_award_id
    and b.dollars_obligated <0
    )
group by unique_award_id;

select *
into tmp_dojdept
from itc_customer_data_2015_2021 a
where department_name = 'JUSTICE, DEPARTMENT OF'
and not exists(
    select 1
    from tmp_doj b
    where a.unique_award_id = b.unique_award_id
    and a.tid = b.tid
        )
order by 3;

--insert into tmp_doj
select b.*
from tmp_doj
join tmp_dojdept b on tmp_doj.unique_award_id = b.unique_award_id
where not exists(
    select 1 from tmp_doj c
    where b.tid = c.tid
    )
order by 3



--9887 unique award id have deallocations
--32289 UAID do not have deallocations
--42176 total
--23.4% have deallocations

select 42176-9887

select unique_award_id
from tmp_doj a
where dollars_obligated < 0
group by unique_award_id

select 9883 + 32293

select unique_award_id, sum(dollars_obligated), count(*)
from tmp_doj
group by unique_award_id, dollars_obligated
order by 2

--15A00018A0000024915A00018F00000341

select unique_award_id
--into tmp_doj_zero_only_obligated
from tmp_doj a
where dollars_obligated = 0
and not exists(
    select 1 from tmp_doj b
    where a.unique_award_id = b.unique_award_id
    and b.dollars_obligated <> 0
    )
group by unique_award_id
order by 1
--1587

--the unique award ids have only 0 dollars obligated in this data set
select * from tmp_doj_zero_only_obligated


--this one has 11 GS31Q14BUA0007GSQ3117BU0156

--these have only 0 transactions or adjustments/deallocations
select unique_award_id, max(dollars_obligated), count(*)
from tmp_doj
group by unique_award_id
having max(dollars_obligated) = 0

select *
from
itc_customer_data_2015_2021
where unique_award_id in ('15M20019AA32NP01B15M20021FA32NB14','GS27F0021XGSP0417CX0024','GS35F0119PHC101314FB854')


select *
from tmp_doj
where unique_award_id = '15M20019AA32NP01B15M20021FA32NB14'

select *
from itc_customer_data_2015_2021
where unique_award_id = 'GS27F0021XGSP0417CX0024'
and tid not in (select tid from excluderows)

--vendors
select vendor_name
,vendor_duns_number
, sum(dollars_obligated), count(*) NumActions, min(date_signed) FirstSigned, max(date_signed) LastSigned
from tmp_doj
--where vendor_name is not null
group by vendor_name, vendor_duns_number
order by 3 desc

--what is Boeing doing for the DOJ?
select *
from tmp_doj
where vendor_duns_number =962814153

--what about cdw
select *
from tmp_doj
where vendor_duns_number =26157235


--1839 vendors are null
--2932 vendors for DOJ with total obligations ranging from 238,123,785.88 to -3,611,086.8

select level_1_category, level_2_category, level_3_category, vendor_name, sum(dollars_obligated)
from tmp_doj
group by level_1_category,level_2_category, level_3_category, vendor_name
order by 5 desc
limit 20


WITH CTE_vend AS (select unique_award_id
from tmp_doj
where vendor_name is null
group by unique_award_id)
select b.unique_award_id, b.vendor_name
from CTE_vend a
join itc_customer_data_2015_2021 b
on a.unique_award_id = b.unique_award_id
where b.vendor_name is not null
order by 1

select unique_award_id, department_name, funding_department_name, vendor_name
from itc_customer_data_2015_2021
    where unique_award_id = '15DDHQ19A0000000115DD0S20F00001636'

select --unique_award_id, department_name, funding_department_name, vendor_name
*
from tmp_doj
    where unique_award_id = '15DDHQ19A0000000115DD0S20F00001636'

select distinct unique_award_id, department_name, funding_department_name, vendor_name
into tmp_doj_vendor_backfill
from tmp_doj a
where vendor_name is not null
and exists(
    select 1
    from tmp_doj b
    where a.unique_award_id = b.unique_award_id
    and b.vendor_name is null
    );

--update tmp_doj
set vendor_name = a.vendor_name
--select b.unique_award_id, b.vendor_name, a.vendor_name
from tmp_doj_vendor_backfill a
where a.unique_award_id = tmp_doj.unique_award_id
and tmp_doj.vendor_name is null;

select level_1_category, sum(dollars_obligated), count(distinct unique_award_id), min(date_signed), max(date_signed)
from tmp_doj
group by level_1_category
order by 2 desc

--114,229,887.78

--date_part('decade',TIMESTAMP '2017-09-30')

select level_1_category, level_2_category
     ,case when level_3_category is null then 'none' else level_3_category end L3
     , date_part('year',cast(date_signed as date)),sum(dollars_obligated)
,count(distinct vendor_name) NumVendor
from tmp_doj
group by level_1_category, level_2_category, level_3_category,date_part('year',cast(date_signed as date))
order by 5 desc,6

select contract_name, sum(dollars_obligated)
from itc_customer_data_2015_2021
group by contract_name

select naics_description, description_of_requirement,count(*)
from tmp_doj
group by naics_description,description_of_requirement
order by 3 desc

with scheck as(
select
       tid,
       length(reference_piid) lr
        , length(piid) lp
     ,unique_award_id
     ,length(unique_award_id) lu
     ,co_bus_size_determination
    ,case co_bus_size_determination when 'OTHER THAN SMALL BUSINESS' then 0
     when 'SMALL BUSINESS' then 1 else null end SBA
from tmp_doj)

select *
from scheck
where lr + lp = lu
and sba is null
--group by co_bus_size_determination

with scheck as(
select
       tid
       ,reference_piid
    ,piid
     ,unique_award_id
    ,case co_bus_size_determination when 'OTHER THAN SMALL BUSINESS' then 0
     when 'SMALL BUSINESS' then 1 else null end SBA
     ,award_type_description
,description_of_requirement
,naics_description
,business_rule_tier
,contract_name
,level_1_category
,level_2_category
,level_3_category
,department_name
,funding_department_name
,funding_agency_name
,funding_office_name
,date_part('year',date_signed::date) SignYear
,dollars_obligated
from tmp_doj)

select unique_award_id, sba,sum(dollars_obligated) SumObl, min(SignYear) FirstSignYear
     , max(SignYear) LastSignYear
     , count(*)NumTransactions
,max(SignYear) -  min(SignYear) + 1 NumYears
from scheck
group by sba, unique_award_id
order by 3 desc



select business_rule_tier, count(*)
from tmp_doj
group by business_rule_tier

select * from scheck
where (naics_description like '%FURNITURE%'
  OR level_2_category like '%Furniture')
and (funding_agency_name like '%PRIS%'
or funding_office_name like '%PRIS%')

select *
from itc_customer_data_2015_2021
limit 100

--unique award ID with no positive dollars obligated
select unique_award_id
into tmp_UAI_negOnly
from itc_customer_data_2015_2021 a
where dollars_obligated <0
and not exists(
    select 1 from itc_customer_data_2015_2021 b
    where a.unique_award_id = b.unique_award_id
    and b.dollars_obligated >0
    )
group by unique_award_id
order by 1

--unique award ID with ONLY 0 obligated
select unique_award_id
into tmp_UAI_zeroOnly
from itc_customer_data_2015_2021 a
where dollars_obligated =0
and not exists(
    select 1 from itc_customer_data_2015_2021 b
    where a.unique_award_id = b.unique_award_id
    and b.dollars_obligated <>0
    )
group by unique_award_id
order by 1


--03F066315JA1718F00000018
select a.unique_award_id, a.dollars_obligated
from itc_customer_data_2015_2021 a
join tmp_UAI_negOnly b on a.unique_award_id = b.unique_award_id
order by 2 desc

select count(*)
from tmp_UAI_negOnly

select count(*)
from tmp_UAI_zeroOnly

select count(distinct unique_award_id)
from itc_customer_data_2015_2021

--lets maybe leave the unique award id out of the analysis if they ONLY have negative or 0 dollars obligated associated
select 31209.0/724986 --4% has only negative or 0 dollars obligatged
select 37826.0/724986 --5%% has only 0 dollars obligated

select *
into tmp_culled_1
from itc_customer_data_2015_2021 a
where not exists(
    select 1 from tmp_UAI_negOnly b where a.unique_award_id = b.unique_award_id
    )
and not exists (
    select 1 from tmp_UAI_zeroOnly c where a.unique_award_id = c.unique_award_id
    )

select count(*) from tmp_culled_1 --1031939
select count(*) from itc_customer_data_2015_2021 --1117024

select 1117024 - 1031939

select column_name || ',' from information_schema.columns where table_name = 'tmp_culled_1'

select
reference_piid,
piid,
unique_award_id,
modification_number,
dollars_obligated,
award_type,
award_or_idv,
award_type_description,
description_of_requirement,
national_interest_code,
naics_description,
business_rule_tier,
fiscalyear,
fiscal_quarter,
date_signed,
current_completion_date,
final_ultimate_completion_date,
expiring_date_custom,
contract_name,
multiyear_contract,
level_1_category,
level_2_category,
level_3_category,
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
vendor_duns_number,
vendor_name,
pop_zip_code,
pop_county_name,
epa_designated_products,
co_bus_size_determination,
minority_owned_business_flag,
other_minority_owned,
aiob_flag,
baob_flag,
eight_a_flag,
haob_flag,
hubzone_flag,
naob_flag,
saaob_flag,
sdb,
sdb_flag,
veteran_owned_flag,
women_owned_flag,
wosb_flag,
emerging_small_business_flag,
small_business_flag,
fair_opportunity_description,
min(tid), max(tid), count(*)
from
tmp_culled_1
group by
reference_piid,
piid,
unique_award_id,
modification_number,
dollars_obligated,
award_type,
award_or_idv,
award_type_description,
description_of_requirement,
national_interest_code,
naics_description,
business_rule_tier,
fiscalyear,
fiscal_quarter,
date_signed,
current_completion_date,
final_ultimate_completion_date,
expiring_date_custom,
contract_name,
multiyear_contract,
level_1_category,
level_2_category,
level_3_category,
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
vendor_duns_number,
vendor_name,
pop_zip_code,
pop_county_name,
epa_designated_products,
co_bus_size_determination,
minority_owned_business_flag,
other_minority_owned,
aiob_flag,
baob_flag,
eight_a_flag,
haob_flag,
hubzone_flag,
naob_flag,
saaob_flag,
sdb,
sdb_flag,
veteran_owned_flag,
women_owned_flag,
wosb_flag,
emerging_small_business_flag,
small_business_flag,
fair_opportunity_description
having count(*) =3

--remove the duplicates from the second cull table
select *
into tmp_culled_2
from tmp_culled_1

--delete from tmp_culled_2 where tid in (392431,126959,943754,612815,346549,638250,353186,575307,144238,144291,287257
--,400117,400119,741229,68803,194232,747295,42580,42586,57156,341400,89145,498936,498944)

--delete from tmp_culled_2 where tid in (138351,89147,89141,42587,42581,42574,42572,138353,89149,89143,42589,42583,42576,492001)

select
tid,
reference_piid,
piid,
unique_award_id,
modification_number,
dollars_obligated,
award_type,
award_or_idv,
award_type_description,
description_of_requirement,
national_interest_code,
naics_description,
business_rule_tier,
fiscalyear,
fiscal_quarter,
date_signed,
current_completion_date,
final_ultimate_completion_date,
expiring_date_custom,
contract_name,
level_1_category,
level_2_category,
level_3_category,
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
vendor_duns_number,
vendor_name,
pop_zip_code,
pop_county_name,
epa_designated_products,
fair_opportunity_description,
case co_bus_size_determination when 'OTHER THAN SMALL BUSINESS' then 0 when 'SMALL BUSINESS' then 1 else 0 end SBA_FLAG,
case minority_owned_business_flag when 'NO' then 0 when 'YES' then 1 else null end minority_owned_biz_flag_new,
case other_minority_owned when 'NO' then 0 when 'YES' then 1 else null end other_minority_owned_new,
case aiob_flag when 'NO' then 0 when 'YES' then 1 else null end aiob_flag_new,
case baob_flag when 'NO' then 0 when 'YES' then 1 else null end baob_flag_new,
case eight_a_flag when 'NO' then 0 when 'YES' then 1 else null end eight_a_flag_new,
case haob_flag when 'NO' then 0 when 'YES' then 1 else null end haob_flag_new,
case hubzone_flag when 'NO' then 0 when 'YES' then 1 else null end hubzone_flag_new,
case naob_flag when 'NO' then 0 when 'YES' then 1 else null end naob_flag_new,
case saaob_flag when 'NO' then 0 when 'YES' then 1 else null end saaob_flag_new,
case sdb when 'NO' then 0 when 'YES' then 1 else null end sdb_new,
case sdb_flag when 'NO' then 0 when 'YES' then 1 else null end sdb_flag_new,
case veteran_owned_flag when 'YES' then 1 when 'NO' then 0 else null end vet_own_flag_new,
case women_owned_flag when 'NO' then 0 when 'YES' then 1 else null end women_owned_flag_new,
case wosb_flag when 'NO' then 0 when 'YES' then 1 else null end wosb_flag_new,
case emerging_small_business_flag when 'true' then 1
    when 'false' then 0 else null end Emerging_small_biz_flag
from tmp_culled_2

select
national_interest_code, count(*)
from tmp_culled_2
group by national_interest_code
order by 2

select naics_description, count(*)
from tmp_culled_2
group by naics_description
order by 1

select *
from tmp_culled_2
limit 10
















