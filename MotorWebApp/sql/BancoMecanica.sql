create table cliente
(
	cpf int not null primary key,
	nome varchar(100) not null,
	tel varchar(11) not null

)

create table carro
(
	placa varchar(7) not null primary key,
	modelo varchar(30) not null,
	marca varchar(30) not null,
	ano year not null,
	cliente int not null
)

create table mecanico
(
	cpf int not null primary key,
	nome varchar(100) not null
)

create table conserto
(
	carro varchar(7) not null,
	mecanico int not null,
	peca varchar(20) not null,
	preco decimal(5,2)
)