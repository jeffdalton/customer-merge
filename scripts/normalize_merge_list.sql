drop table if exists Merge_list;

create table Merge_List (
    Survivor varchar(10),
    Mergee varchar(10),

    PRIMARY KEY (Survivor, Mergee)
);

insert into Merge_List (Survivor, Mergee)
    select Survivor, Mergee
    from Import.filtered_merge_list;


