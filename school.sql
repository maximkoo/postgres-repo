CREATE TABLE persons (
	person_id int4 primary key,
	person_name varchar(256) NULL,
	person_gender bool NULL,
	birth_date date NULL
);

-- тут надо импортировать данные из файла

create table subjects 
(subject_id int4 primary key,
 subject_name varchar(256),
 subject_type numeric(2));

INSERT INTO subjects (subject_id, subject_name, subject_type) VALUES(1, 'Алгебра', 0);
INSERT INTO subjects (subject_id, subject_name, subject_type) VALUES(2, 'Геометрия', 0);
INSERT INTO subjects (subject_id, subject_name, subject_type) VALUES(3, 'Физика', 0);
INSERT INTO subjects (subject_id, subject_name, subject_type) VALUES(4, 'Химия', 0);
INSERT INTO subjects (subject_id, subject_name, subject_type) VALUES(5, 'Литература', 1);
INSERT INTO subjects (subject_id, subject_name, subject_type) VALUES(6, 'Биология', 0);
INSERT INTO subjects (subject_id, subject_name, subject_type) VALUES(7, 'Физкультура', 1);
INSERT INTO subjects (subject_id, subject_name, subject_type) VALUES(8, 'ОБЖ', 1);

select * from dates;

create table dates (date_value date primary key);
with recursive q as
(select 1 as i, date_trunc('year',now()) as d
 union all
 select i+1 as i,date_trunc('year',now())+q.i*interval '1 day' as d from q where i<365)
insert into dates(date_value)
 select q.d::date from q; 
 
create table school (person_id int4 references persons(person_id),
    				 subject_id int4 references subjects(subject_id),
    				 date_value date references dates(date_value),
    				 rate numeric(1),
    				primary key(person_id,subject_id,date_value) );
    			
insert into school
select p.person_id,
       s.subject_id,
       d.date_value,
       ceil(random()*7) as rate
  from persons p 
 inner join subjects s
   on 1=1
 inner join dates d
   on 1=1;
   
  update school h set rate=null where h.rate not in (2,3,4,5);
  
select count(s.rate),
 	   s.person_id, 
 	   s.subject_id
  from school s
 group by ROLLUP(s.person_id, s.subject_id);
 
select s.person_id,
	   s.subject_id,
	   s.date_value,
	   s.rate,
	   (select count(s2.rate) from school s2 where s2.person_id=s.person_id) as person_rate_count
  from school s;
 
select s.person_id,
	   s.subject_id,
	   s.date_value,
	   s.rate,
	   ss.person_rate_count
  from school s
  inner join (select s2.person_id,count(s2.rate) as person_rate_count from school s2 group by s2.person_id) ss
     on s.person_id=ss.person_id
 
   select s.*,
   	count(s.rate) over (partition by s.person_id)
   from school s;

  select p.*,
  		lead (p.person_name,1) over (order by person_name)
  from persons p
  order by person_id