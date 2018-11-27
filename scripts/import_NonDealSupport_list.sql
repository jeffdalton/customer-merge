
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
from '[IMPORT_FILE]' delimiter ',' CSV HEADER;

