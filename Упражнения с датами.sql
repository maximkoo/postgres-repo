select * from public.people;

select current_date; -- ������� ����
select current_time; -- ������� ����� � ������� �����
select localtime; -- ������ ������� �����

select current_timestamp; --������� ���� �� �������� � ������� �����
select now(); --������� ���� �� �������� � ������� �����
select localtimestamp; --������ ������� ���� �� ��������

select extract(day from now()),extract(month from now()),extract(year from now());

update people p set birth_date=date '1980-01-01';

update people p set birth_date=date '1980-01-01'; -- �������� ANSI
update people p set birth_date=to_date('01.04.2019','dd.mm.yyyy'); -- ��� � Oracle

update people p set birth_date=p.birth_date+integer '7';-- ��������� ���� ����
update people p set birth_date=p.birth_date+interval '1 day'; --��� days
update people p set birth_date=p.birth_date+interval '7 days';
update people p set birth_date=p.birth_date+interval '21 day';
update people p set birth_date=p.birth_date+30*interval '1 day'; --�������� ����� ��������


update people p set birth_date=p.birth_date+time '3 hours'; -- ��� ������
update people set birth_date=birth_date+ceil(random()*2)*interval '1 day';