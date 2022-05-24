--get the counts to make sure the target has the correct number
select count(*) from itc_customer_data_2015_2016;
select count(*) from itc_customer_data_2017_2021;
select count(*) from itc_customer_data_2015_2021;

--select * into itc_customer_data_2015_2021
--from itc_customer_data_2017_2021

--insert into itc_customer_data_2015_2021
select * from itc_customer_data_2015_2021 limit 10;

select (346275 +770749);

--create a view of the dupes to use to populate the exclusion table
create view All_Dupes AS
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
    fair_opportunity_description
        ,count(*) RowCount
        ,min(tid) MinTID
        ,max(tid) MaxTID
from
    itc_customer_data_2015_2021
group by reference_piid,
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
having count(*)>1;
--1117024

--check some of the resulsts
select *
from itc_customer_data_2015_2021
where tid between 89147 and 89149;

select *
from all_dupes
where RowCount=3;
--when the count is 2, there are 2 duplicate rows, so exclude one row to have all unique rows

select
maxtid as TID, 'Duplicate' as ExcludeReason, 1 as ExcludeID
into ExcludeRows
from all_dupes
where RowCount=3;
--when the count is three exclude 2 of the rows and leave one unique row

--check the results
select * from ExcludeRows

--insert into ExcludeRows
select a.mintid, 'Duplicate of ' || a.MaxTID, 1
from all_dupes a
where RowCount=2
and not exists(select 1 from ExcludeRows b where a.mintid = b.tid);
--when the count is two, we can see both rows using this table