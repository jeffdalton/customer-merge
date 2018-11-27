create schema import;

drop table if exists import.filtered_merge_list;

create table import.filtered_merge_list
(
    survivor text,
    mergee text
);

copy import.filtered_merge_list 
from '[IMPORT_FILE]' delimiter ',' CSV HEADER;

