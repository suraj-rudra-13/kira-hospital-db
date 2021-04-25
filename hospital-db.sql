 create table doctor(
  doctor_id int primary key,
  first_name varchar(20),
  middle_name varchar(20),
  last_name varchar(20),
  name varchar(60) AS (concat_ws(' ', first_name, middle_name, last_name))
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
  name varchar(60) AS (concat_ws(' ', first_name, middle_name, last_name)),
  dob date,
  age real AS (datediff('year', '2021-01-01')),
  locality varchar(10),
  city varchar(20),
  pincode varchar(6),
  address varchar(36) AS (concat_ws(' ', locality, city, pincode)) 
);

create table medicine(
  code int primary key,
  price real not null,
  quantity int not null,
  bill real not null
);

create table treats(
  patient_id int,
  doctor_id int,
  foreign key(doctor_id) references doctor(doctor_id),
  foreign key(patient_id) references patient(patient_id)
);
  

create table bills(
  patient_id int,
  bill real,
  foreign key(bill) references medicine(bill),
  foreign key(patient_id) references patient(patient_id)
)