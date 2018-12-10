create table T_DOCTOR (
    id
        char(8)
        not null
        primary key,
    name
        varchar(32),
    deptCode
        char(2)
);

create table T_ORDER (
    id
        integer
        not null
        auto_increment
        primary key,
    doctorId
        char(8)
        references T_DOCTOR(id)
);

create table T_PATIENT (
    id
        char(8)
        not null
        primary key,
    name
        varchar(32)
);

create table T_ORDER_DETAIL (
    orderId
        integer
        not null,
    studyInstanceUID
        varchar(16),
    patientId
        char(8),
    primary key (orderId, studyInstanceUID),
    foreign key (patientId)
        references T_PATIENT(id)
);