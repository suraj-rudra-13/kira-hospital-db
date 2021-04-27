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
  pincode varchar(6)
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
);


insert into doctor values(101,"","","");
insert into doctor values(101,"","","");
insert into doctor values(101,"","","");
insert into doctor values(101,"","","");
insert into doctor values(101,"","","");
insert into doctor values(101,"","","");


insert into patient values(201,"","","","","","",);
insert into patient values(201,"","","","","","",);
insert into patient values(201,"","","","","","",);
insert into patient values(201,"","","","","","",);
insert into patient values(201,"","","","","","",);
insert into patient values(201,"","","","","","",);
insert into patient values(201,"","","","","","",);
insert into patient values(201,"","","","","","",);
insert into patient values(201,"","","","","","",);
insert into patient values(201,"","","","","","",);
insert into patient values(201,"","","","","","",);
insert into patient values(201,"","","","","","",);
insert into patient values(201,"","","","","","",);
insert into patient values(201,"","","","","","",);
insert into patient values(201,"","","","","","",);
insert into patient values(201,"","","","","","",);


insert into medicine values(10001,"",);
insert into medicine values(10001,"",);
insert into medicine values(10001,"",);
insert into medicine values(10001,"",);
insert into medicine values(10001,"",);
insert into medicine values(10001,"",);
insert into medicine values(10001,"",);

insert into treats values(201,103);
insert into treats values(201,103);
insert into treats values(201,103);
insert into treats values(201,103);
insert into treats values(201,103);
insert into treats values(201,103);
insert into treats values(201,103);
insert into treats values(201,103);
insert into treats values(201,103);
insert into treats values(201,103);
insert into treats values(201,103);
insert into treats values(201,103);
insert into treats values(201,103);
insert into treats values(201,103);
insert into treats values(201,103);



create view creator as select doctor.first_name as dname, patient.first_name as pname from  ((treats inner join patient on treats.patient_id=patient.patient_id) inner join doctor on treats.doctor_id=doctor.doctor_id);
create view heamler as select doctor.doctor_id,doctor.name as Dname,doc_qual.qualification from doctor inner join doc_qual on doc_qual.doctor_id=doctor.doctor_id;