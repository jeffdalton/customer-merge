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