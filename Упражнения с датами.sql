select * from public.people;

select current_date; -- текущая дата
select current_time; -- текущее время с часовой зоной
select localtime; -- просто текущее время

select current_timestamp; --текущая дата со временем и часовой зоной
select now(); --текущая дата со временем и часовой зоной
select localtimestamp; --просто текущая дата со временем

select extract(day from now()),extract(month from now()),extract(year from now());

update people p set birth_date=date '1980-01-01';

update people p set birth_date=date '1980-01-01'; -- стандарт ANSI
update people p set birth_date=to_date('01.04.2019','dd.mm.yyyy'); -- как в Oracle

update people p set birth_date=p.birth_date+integer '7';-- прибавить семь дней
update people p set birth_date=p.birth_date+interval '1 day'; --или days
update people p set birth_date=p.birth_date+interval '7 days';
update people p set birth_date=p.birth_date+interval '21 day';
update people p set birth_date=p.birth_date+30*interval '1 day'; --интервал можно умножать


update people p set birth_date=p.birth_date+time '3 hours'; -- так нельзя
update people set birth_date=birth_date+ceil(random()*2)*interval '1 day';