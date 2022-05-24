select *
from all_dupes;

--see the excluded rows
select * from excluderows;

select count(*) from itc_customer_data_2015_2021;
--1117024

--look at the first rows
select * from itc_customer_data_2015_2021
limit 10

--GS00F175CASAQMMA17F0792
--view one unique reward
select *
from itc_customer_data_2015_2021
where tid not in (select TID from excluderows)
and unique_award_id = 'GS00F175CASAQMMA17F0792'


select multiyear_contract, count(*)
from itc_customer_data_2015_2021
where tid not in (select TID from excluderows)
group by multiyear_contract
order by 2 desc
--9 fair_opportunity_description 58K null
--small_business_flag - yes/no mostly null - change to 0/1
--emerging_small_business_flag - true/false null - change to 0/1
--wosb_flag - yes/no no null - change to 0/1
--women_owned_flag - yes/no no null - change to 0/1
--veteran_owned_flag - yes/no no null - change to 0/1
--sdb_flag - yes/no no null - change to 0/1
--sdb  - yes/no no null - change to 0/1
--saaob_flag - yes/no no null - change to 0/1
--naob_flag  - yes/no no null - change to 0/1
--hubzone_flag - yes/no no null - change to 0/1
--haob_flag - yes/no no null - change to 0/1
--eight_a_flag - yes/no no null - change to 0/1
--baob_flag - yes/no no null - change to 0/1
--aiob_flag - yes/no no null - change to 0/1
--2 other_minority_owned - no null - change to 0/1
--2 minority_owned_business_flag no null - change to 0/1
--3 co_bus_size_determination - small biz, other than small biz, null - change to 0/1 change title
--8 epa_designated_products 5K null
--1404 pop_county_name 16K null
--53415 pop_zip_code 14K null
--13428 vendor_name 27K null
--13681 vendor_duns_number 27K null
--9897 contracting_office_info no null - sole purpose is to write contracts
--4417 contracting_office_name - some null
--176 contracting_agency_name
--10 managing_agency
--2 funding_dod_or_civilian
--2 funding_cfo_act_agency CFO, Non CFO
--35583 funding_office_info - addresses
--17995 funding_office_name
--366 funding_agency_name
--funding_department_name 97 overall agency with the contract top level agency
--68 department name
--126 level_3_category; ~half null
--88 level_2_category
--21 level_1_category
--26782 unique reference_piid
--6932754 unique piid
--734,986 unique unique_award_id
--4407 modification_number
--500 dollars_obligated range -90,103,381 to 326,054,061.33
--5 award_type
--2 award_or_idv
--5 award_type_description 5
--description_of_requirement 521227
--national_interest_code 23
--naics_description 433
--business_rule_tier 5
--fiscalyear 7
--fiscal_quarter 4
--date_signed 2556 - range 2014-10-01 00:00:00.000000,2021-09-30 00:00:00.000000
--15440 current_completion_date
--12705 final_ultimate_completion_date
--21959 expiring_date_custom - has time value
--71 unique contract_name
--3 multiyear_contract; 677063 null, 44 K null and Y 171 - drop this from final

select
unique_award_id
,sum(case when dollars_obligated > 0 then dollars_obligated else 0 end) POS
, sum(case when dollars_obligated < 0 then dollars_obligated else 0 end) NEG
, sum(case when dollars_obligated > 0 then dollars_obligated else 0 end)+sum(case when dollars_obligated < 0 then dollars_obligated else 0 end) TOT
from itc_customer_data_2015_2021
where tid not in (select TID from excluderows)
group by unique_award_id
order by 1

--
select sum(case when dollars_obligated > 0 then 1 else 0 end) POS
,sum(case when dollars_obligated < 0 then 1 else 0 end) NEG
from itc_customer_data_2015_2021
where tid not in (select TID from excluderows)
order by 1

select count(*)
from itc_customer_data_2015_2021
where tid not in (select TID from excluderows)
and dollars_obligated = 0
--161,759 - do we need the records that don't contain any dollar values?

--contract duration
select unique_award_id, contract_name, date_signed, current_completion_date, final_ultimate_completion_date
     ,expiring_date_custom
,(DATE_PART('year', final_ultimate_completion_date::date) - DATE_PART('year',date_signed::date)) * 12 +
              (DATE_PART('month', final_ultimate_completion_date::date) - DATE_PART('month', date_signed::date)) ContractDuration
from itc_customer_data_2015_2021
where tid not in (select TID from excluderows)
and final_ultimate_completion_date is not null
and final_ultimate_completion_date > date_signed
--997503

select tid, unique_award_id, contract_name, date_signed, current_completion_date, final_ultimate_completion_date
     ,expiring_date_custom
,(DATE_PART('year', final_ultimate_completion_date::date) - DATE_PART('year',date_signed::date)) * 12 +
              (DATE_PART('month', final_ultimate_completion_date::date) - DATE_PART('month', date_signed::date)) ContractDuration1
,(DATE_PART('year', expiring_date_custom::date) - DATE_PART('year',date_signed::date)) * 12 +
              (DATE_PART('month', expiring_date_custom::date) - DATE_PART('month', date_signed::date)) ContractDuration2
from itc_customer_data_2015_2021
where tid not in (select TID from excluderows)
and ((DATE_PART('year', final_ultimate_completion_date::date) - DATE_PART('year',date_signed::date)) * 12 +
              (DATE_PART('month', final_ultimate_completion_date::date) - DATE_PART('month', date_signed::date))>0
    OR (DATE_PART('year', expiring_date_custom::date) - DATE_PART('year',date_signed::date)) * 12 +
              (DATE_PART('month', expiring_date_custom::date) - DATE_PART('month', date_signed::date))>0)

--115681
--1116980
select 115681.0/1116980

--number of rows where completion_date or expiring date duration is <= 0
294177

--number of rows where completion date or expiring date contract duration is > 0

select count(*)
from itc_customer_data_2015_2021
where tid not in (select TID from excluderows)


--91326

select column_name
from information_schema.columns
where table_name = 'itc_customer_data_2015_2021'
and column_name ~ 'flag';

select minority_owned_business_flag, count(*)
from itc_customer_data_2015_2021
where tid not in (select TID from excluderows)
group by minority_owned_business_flag
order by 2 desc

select
aiob_flag
,baob_flag
,eight_a_flag
,emerging_small_business_flag
,haob_flag
,hubzone_flag
,minority_owned_business_flag
,naob_flag
,saaob_flag
,sdb_flag
,small_business_flag
,veteran_owned_flag
,women_owned_flag
,wosb_flag
from itc_customer_data_2015_2021
where tid not in (select TID from excluderows)














