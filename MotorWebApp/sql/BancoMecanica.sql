create table cliente
(
        id bigint not null primary key generated always as identity (start with 1, increment by 1),
	cpf varchar(11) not null,
	nome varchar(100) not null,
	tel varchar(11) not null

);

create table carro
(
        id bigint not null primary key generated always as identity (start with 1, increment by 1),
	placa varchar(7) not null,
	modelo varchar(30) not null,
	marca varchar(30) not null,
	ano int not null,
	cliente int not null
);

create table mecanico
(
        id bigint not null primary key generated always as identity (start with 1, increment by 1),
	cpf varchar(11) not null,
	nome varchar(100) not null
);

create table conserto
(
        id bigint not null primary key generated always as identity (start with 1, increment by 1),
	carro int not null,
	mecanico int not null,
	peca varchar(20) not null,
	preco decimal(5,2)
);

create table users
(
    id bigint not null primary key generated always as identity (start with 1, increment by 1),
    role varchar(200) not null,
    name varchar(200) not null,
    login varchar(200) not null,
    passwordHash bigint not null
);

insert into users values (default, 'ADMIN', 'Administrator', 'admin', 1509442);
