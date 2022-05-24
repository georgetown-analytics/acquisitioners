select count(*)
from itc_obs_test

select 528527 + 113

select count(*)
from itc_obs_test a
    join "ITC_OBS_DescriptionofReqOnly" b on a.TID = b."RowID"

--update itc_obs_test
set description_of_requirement = "ITC_OBS_DescriptionofReqOnly".description_of_requirement
from "ITC_OBS_DescriptionofReqOnly"
where itc_obs_test."RowID" = "ITC_OBS_DescriptionofReqOnly"."RowID"

select TID
    from itc_obs_test
where description_of_requirement is not null

--update itc_obs_test
set "Vendor_duns_number" = "itc_obs_dunsNum".vendor_duns_number
from "itc_obs_dunsNum"
where itc_obs_test.TID = "itc_obs_dunsNum"."RowID"


select tid
    from itc_obs_test
where description_of_requirement is null
order by 1

select description_of_requirement
    from itc_obs_test
        where tid = 134249

update itc_obs_test set description_of_requirement = 'IGF::CL::IGFIT AND TELECOM- INFORMATION AND DATA BROADCASTING OR DATA DISTRIBUTION' where TID = 318

--doesnt work
--copy (SELECT tid from itc_obs_test where description_of_requirement is null) to 'D:\GT\CAPSTONE\GovtSegment\itc_missing.csv' with csv

--this also doesnt work but there is a button on the output tab to export to csv so not necessary
-- copy (SELECT tid from itc_obs_test where description_of_requirement is null) to stdout;


--insert into itc_obs_test
("RowID",
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
"RowID",
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
from itc_obs_popzip_error

select column_name || ','
from information_schema.columns
where table_name = 'itc_obs_test'