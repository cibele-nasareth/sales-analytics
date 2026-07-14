Create database cimark
default character set utf8mb4
default collate utf8mb4_general_ci;

create table categorias (
  id_categoria int auto_increment,
  primary key(id_categoria),
  nome_categoria varchar(20) not null 
) default charset = utf8mb4;

create table clientes (
id_cliente int auto_increment primary key,
nome varchar(100) not null,
cpf varchar(11) not null unique,
genero enum ('Feminino', 'Masculino', 'Não Binário', 'Outro'),
data_nascimento date,
telefone varchar(20),
email varchar(30) not null,
endereco varchar(100)
)default charset = utf8mb4;

create table vendedores (
id_vendedor int auto_increment primary key,
nome varchar(100) not null,
cpf varchar(11) not null unique,
telefone varchar(20),
data_nascimento date not null,
email varchar(100) not null unique
) default charset = utf8mb4;

create table produtos (
id_produto int auto_increment primary key,
nome_produto varchar(100) not null,
preco decimal(10,2) not null,
publico enum ('Adulto', 'Infantil'),
cor varchar(20),
tamanho enum ('PP', 'P', 'M', 'G', 'GG'),
estoque int not null,
id_categoria int not null,
foreign key (id_categoria) references categorias (id_categoria)
) default charset = utf8mb4;

create table vendas (
id_venda int not null auto_increment primary key,
id_cliente int not null,
id_vendedor int not null,
foreign key (id_cliente) references clientes (id_cliente),
foreign key (id_vendedor) references vendedores (id_vendedor),
data_venda date,
forma_pagamento enum ('Débito', 'Crédito', 'Pix'),
valor_total decimal(10,2) not null
) default charset = utf8mb4;

create table itens_venda (
id_item int not null auto_increment primary key,
id_venda int not null,
id_produto int not null,
foreign key (id_venda) references vendas (id_venda),
foreign key (id_produto) references produtos (id_produto),
quantidade int not null,
preco_unitario decimal(10,2) not null
) default charset = utf8mb4;