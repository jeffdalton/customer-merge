create schema import;

drop table if exists import.filtered_merge_list;

create table import.filtered_merge_list
(
    survivor text,
    mergee text
);

copy import.filtered_merge_list 
from 'C:\software\customer-merge\data\B_Final_Filtered_Merge_List.csv' delimiter ',' CSV HEADER;


drop table if exists import.non_deal_support_list;

create table import.non_deal_support_list (
    nds_number text,
    nds_name text,
    nds_category text,
    nds_support_type text,
    nds_type text,
    nds_customer_ids text,
    nds_customer_exclude_flag text,
    nds_customer_names text
);

copy import.non_deal_support_list 
from 'C:\software\customer-merge\data\IM_NDS_Customers.csv' delimiter ',' CSV HEADER;

drop table if exists Merge_list;

create table Merge_List (
    Survivor varchar(10),
    Mergee varchar(10),

    PRIMARY KEY (Survivor, Mergee)
);

insert into Merge_List (Survivor, Mergee)
    select Survivor, Mergee
    from Import.filtered_merge_list;


drop table if exists non_deal_support_customers;

create table non_deal_support_customers (
    partyID varchar(10),
    nds_number varchar(10),
        PRIMARY KEY (partyID, nds_number)
);

insert into non_deal_support_customers (
    partyID,
    nds_number
)
select s.token, nds_number
from import.non_deal_support_list t, unnest(string_to_array(t.nds_customer_ids,';')) s(token);
