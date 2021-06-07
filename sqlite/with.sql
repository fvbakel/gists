select "plain with recursive" as "";
with recursive
    a(b) as (
        select 1
        union all 
        select b+1 from a where b<3
    ),
    c(d) as (
        select max(b) from a
    )
select d from c;


select "Nested with recursive" as "";
with recursive
    a(b) as (
        select 1
        union all 
        select b+1 from a where b<3
    ),
    c(d) as (
        select max(b) from a
    ),
    e(f) as (
            with recursive
                g(h) as (
                    select max(b) from a
                    union all
                        select h +10 from g where h<50
                )
            select h from g
    )
select f from e;

-- not possible Error: near line 36: circular reference: e
select "Recursive with recursive" as "";
with recursive
    a(b) as (
        select 1
        union all
        select max(f) from e 
        union all
        select b+1 from a where b<300
    ),
    e(f) as (
            with recursive
                g(h) as (
                    select max(b) from a
                    union all
                        select h +10 from g where h<50
                )
            select h from g
    )
select f from e;

-- Error: near line 57: multiple recursive references: a
select "Recursive with recursive select" as "";
with recursive
    a(b) as (
        select 1
        union all
        select b+(select max(b) from a) from a where b<300
    )
select b from a;

select "Recursive with recursive" as "";
with recursive
    a(b) as (
        select 1
        union all
        select b+(select d from c) from a where b<300
    ),
    c(d) as (
        select max(b) from a
    )
select b from a;
