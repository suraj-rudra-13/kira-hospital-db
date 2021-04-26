 create table doctor(
  doctor_id int primary key,
  first_name varchar(20),
  middle_name varchar(20),
  last_name varchar(20)
);

create table doc_qual(
  doctor_id int,
  qualification varchar(20),
  foreign key(doctor_id) references doctor(doctor_id)
);

create table doc_spec(
  doctor_id int,
  specification varchar(20),
  foreign key(doctor_id) references doctor(doctor_id)
);


create table patient(
  patient_id int primary key,
  first_name varchar(20),
  middle_name varchar(20),
  last_name varchar(20),
  dob date,
  locality varchar(10),
  city varchar(20),
  pincode varchar(6),
);

create table medicine(
  code int primary key,
  price real not null,
  quantity int not null,
  bill real not null
);

create table treats(
  patient_id int primary key,
  doctor_id int,
  foreign key(doctor_id) references doctor(doctor_id),
  foreign key(patient_id) references patient(patient_id)
);
  

create table bills(
  patient_id int,
  medicine_code int,
  bill real,
  primary key(patient_id, medicine_code),
  foreign key(medicine_code) references medicine(code),
  foreign key(patient_id) references patient(patient_id)
)


alter table doctor add column (name varchar(60) as (concat_ws(' ', first_name, middle_name, last_name)));
alter table patient add column (name varchar(60) as (concat_ws(' ', first_name, middle_name, last_name)));
alter table patient add column  (age real AS (datediff('year', '2021-01-01')));
alter table patient add column (address varchar(36) AS (concat_ws(' ', locality, city, pincode)));