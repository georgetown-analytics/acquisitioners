select *
from itc_obs_test
limit 100;

select min(final_ultimate_completion_date), max(final_ultimate_completion_date), count(*)
from itc_obs_test
group by final_ultimate_completion_date



select count(*)
from itc_obs_test
where itc_obs_test.modification_number is null
--528640

select a.tid, a.unique_award_id
,a.description_of_requirement, b.description_of_requirement
--count(*)
from itc_obs_test a  --528640
join itc_customer_data_2015_2021 b
on a.unique_award_id = b.unique_award_id
and a.modification_number = b.modification_number  --314865
and a.dollars_obligated = b.dollars_obligated  --314330
where a.funding_agency_name = b.funding_agency_name --314306
and coalesce(a.vendor_name,'a') = coalesce(b.vendor_name,'a') --296220
and a.description_of_requirement <> b.description_of_requirement

select *
from itc_obs_test
where description_of_requirement like '%#NAME?%'

select date_signed, current_completion_date,final_ultimate_completion_date
from itc_obs_0421_savecheck3
limit 50

select description_of_requirement
from itc_obs_0421_savecheck3
where description_of_requirement like '%#Name%'

--insert into itc_obs_0421_savecheck3
(TID,
unique_award_id,
reference_piid,
piid,
modification_number,
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
pop_county_name,
eight_a_flag,
co_bus_size_determination,
business_rule_tier,
award_type,
award_or_idv)
select
TID,
unique_award_id,
reference_piid,
piid,
modification_number,
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
pop_county_name,
eight_a_flag,
co_bus_size_determination,
business_rule_tier,
award_type,
award_or_idv
from "PopZipAdd"

select count(*) from itc_obs_0421_savecheck3

select column_name
from information_schema.columns
where table_name = 'itc_obs_0421_savecheck3'