-- ===========================================
-- Criação do BD para o cenário de E-commerce
-- ===========================================
-- drop database ecommerce;
create database if not exists ecommerce;
use ecommerce;

-- Criar tabela Cliente
create table cliente(
		idClient int auto_increment primary key,
        Fname varchar(10) default null,
        Minit char(3) default null,
        Lname varchar(20) default null,
        business_name varchar(30) default null,
        CPF char(11) default null,
        CNPJ char(14) default null,
        Address varchar(255) not null,
        constraint unique_cpf_client unique (CPF),
        constraint unique_cnpj_client unique (CNPJ)
);

alter table cliente auto_increment=1;
 
-- alter table product
-- modify column Pname varchar(50);

-- Criar tabela Produto
create table product(
	   idProduct int auto_increment primary key,
	   Pname varchar(50) not null,
       classification_kids bool default false,
       category enum('Eletronico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
       avaliação float default 0,
       size varchar(10),
       valor float
);

alter table product auto_increment=1;

-- Criar tabela cartão
create table card(
	   idCard int auto_increment,
	   idCclient int default null,
       primary key (idCard),
       cardname varchar(45) not null,
       validity date not null,
       number_card char(16) not null,
       constraint fk_CardClient foreign key (idCclient) references cliente (idClient)
);

alter table card auto_increment=1;

-- Criar tabela Pedido
create table orders(
	   idOrder int auto_increment primary key,
       idOrderClient int,
       orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
       orderDescription varchar(255),
       sendValue float default 10,
       paymentPix int default 0,
       constraint fk_orders_client foreign key (idOrderClient) references cliente(idClient)
				on update cascade
);

alter table orders auto_increment=1;

-- Criar tabela Estoque
create table productStorage(
	   idProdStorage int auto_increment primary key,
       storageLocation varchar(255),
       quantity int default 0
);

alter table productStorage auto_increment=1;

-- Criar tabela Fornecedor
create table supplier(	
	   idSupplier int auto_increment primary key,
       SocialName varchar(255) not null,
       CNPJ char(14) not null,
       contact char(11) not null,
       constraint unique_supplier unique (CNPJ)
);

alter table supplier auto_increment=1;

-- Criar tabela Vendedor
create table seller(
	   idSeller int auto_increment primary key,
       SocialName varchar(255) not null,
       AbstName varchar(255),
       CNPJ char(14),
       CPF char(11),
       location varchar(255),
       contact char(11) not null,
       constraint unique_cnpj_seller unique (CNPJ),
       constraint unique_cpf_seller unique (CPF)
);

alter table seller auto_increment=1;

-- Criar tabela Produto/Fornecedor
create table productSupplier(
	   idPsupplier int,
       idPproduct int,
       SprodQuantity int default 1,
       primary key (idPsupplier, idPproduct),
       constraint fk_product_supplier foreign key (idPsupplier) references supplier (idSupplier),
       constraint fk_Sproduct_product foreign key (idPproduct) references product (idProduct)
);


-- Criar tabela Produto/Vendedor
create table productSeller(
	   idPseller int,
       idPproduct int,
       prodQuantity int default 1,
       primary key (idPseller, idPproduct),
       constraint fk_product_seller foreign key (idPseller) references seller (idSeller),
       constraint fk_product_product foreign key (idPproduct) references product (idProduct)
);

-- Criar tabela Produto/Pedido
create table productOrder(
	   idPOproduct int,
       idPOorder int,
       poQuantity int default 1,
       poStatus enum ('Disponível', 'Sem estoque') default 'Disponível',
       primary key (idPOproduct, idPOorder),
       constraint fk_PO_product foreign key (idPOproduct) references product(idProduct),
       constraint fk_PO_order foreign key (idPOorder) references orders(idOrder)
);

-- Criar tabela Estoque/Localização
create table storageLocation(
	   idLproduct int,
       idLstorage int,
       Location varchar(255) not null,
       primary key (idLproduct, idLstorage),
       constraint fk_storage_product foreign key (idLproduct) references product (idProduct),
       constraint fk_storage_storage foreign key (idLstorage) references productStorage (idProdStorage)
);

-- Criar tabela Entrega
create table Send(
	   idSend int auto_increment primary key,
       send_cod char(13),
       idSclient int,
       send_status enum('Delivered', 'Awaiting Payment','In progress', 'Canceled') default 'Awaiting Payment',
       constraint fk_send_client foreign key (idSclient) references cliente(idClient)
);

-- =========================================================
--                        INSERINDO DADOS
-- =========================================================

insert into cliente(Fname, Minit, Lname, business_name, CPF, CNPJ, Address)
	   values (null, null, null, 'Assunsão LTDA', null, '13648215489631', 'Rua Mauricio Gois 36, Centro - Cidade das Flores'),
			  (null, null, null, 'TOP Serviços & Manutenção LTDA', null, '13087642358420', 'Avenida Alameda Vinha 367, Centro - Cidade das Flores'),
              (null, null, null, 'Rocha LTDA', null, '31076498215304', 'Avenida Koller 671, Centro - Cidade das Flores'),
              (null, null, null, 'Sanlim LTDA', null, '82164723950148', 'Rua Augusto Gloop 36, Centro - Cidade das Flores'),
              (null, null, null, 'Monada Serviços LTDA', null, '13046852130468', 'Avenida Mario Souza 620, Centro - Cidade das Flores'),
              (null, null, null, 'Verde Santos LTDA', null, '37160843020054', 'Avenida Alameda Vinha 2485, Centro - Cidade das Flores'),
              ('Bruno', 'V', 'Santana', null, '17523545769', null, 'Avenida Mario Souza 289, Centro - Cidade das Flores'),
              ('Matias', null, 'Oliveira', null, '79425145625', null, 'Avenida Mario Souza 1548, Centro - Cidade das Flores'),
              ('Lucas', 'S', 'Ferreira', null, '43651204841', null, 'Avenida Koller 6451, Centro - Cidade das Flores'),
              ('Erica', null, 'Gonçalves', null, '46201578452', null, 'Avenida Koller 964, Centro - Cidade das Flores'),
              ('Rodolfo', 'G', 'Madeira', null, '94512032154', null, 'Avenida Mario Souza 427, Centro - Cidade das Flores'),
              ('Tiago', 'L', 'Santos', null, '7620154203', null, 'Avenida Mario Souza 5212, Centro - Cidade das Flores'),
              ('Arthur', 'V', 'Prado', null, '1547824301', null, 'Avenida Mario Souza 5, Centro - Cidade das Flores');
              
insert into product (Pname, classification_kids, category, avaliação, size, valor) -- Category ('Eletronico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis')
	   values ('Fone Ouvido', False, 'Eletronico', '4', null, 8.90),
			  ('Saia', False, 'Vestimenta', '5', null, 16.99),
              ('Boneca', True, 'Brinquedos', '3', null, 22.90),
              ('Estante', False, 'Móveis', '4', '180x45x45', 199.90),
              ('Sofá Retrátil', False, 'Móveis', '4', '3x57x80', 459.90),
              ('TV 4K 50 Polegadas', False, 'Eletronico', '5', null, 1199.90),
              ('Cama de Casal', False, 'Móveis', '4', '138x188', 429.90);

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentPix)
	   values (1, 'Confirmado', 'Compra via App', 20, 1),
			  (2, 'Confirmado', 'Compra via App', 50, 0),
              (3, 'Confirmado', 'Compra via web site', 40, 0),
              (4, default, 'Compra via web site', 20, 0),
              (5, 'Cancelado', 'Compra via App', 15, 1),
              (6, 'Confirmado', 'Compra via web site', 25, 1),
              (7, 'Confirmado', 'Compra via web site', 15, 1),
              (8, 'Cancelado', 'Compra via App', 50, 0),
              (9, default, 'Compra via web site', 30, 0),
              (10, default, 'Compra via App', 18, 1);
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentPix)
       values (11, 'Confirmado', 'Compra via web site', 20, 0),
              (12, 'Confirmado', 'Compra via web site', 15, 1),
              (13, 'Cancelado', 'Compra via App', 30, 0);

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus)
       values (1, 1, 1400, 'Disponível'),
              (2, 2, 1200, 'Disponível'),
              (3, 3, 275, 'Disponível'),
              (4, 4, 356, 'Disponível'),
              (5, 5, 290, 'Disponível'),
              (6, 6, 202, 'Disponível'),
              (7, 7, 1, 'Disponível'),
              (1, 8, 2, 'Disponível'),
              (2, 9, 3, 'Disponível'),
              (3, 10, 2, 'Disponível'),
			  (4, 11, 2, 'Disponível'),
              (5, 12, 1, 'Disponível'),
              (6, 13, 1, 'Disponível');

insert into productStorage (storageLocation, quantity)
	   values ('Rio de Janeiro', 5800),
			  ('Pernambuco', 3500),
              ('São Paulo', 12500),
              ('Curitiba', 8400),
              ('Bahia', 1850),
              ('Espirito Santo', 980);

insert into storageLocation (idLproduct, idLstorage, Location)
       values (1, 1, 'RJ'), -- FONE / RJ
			  (2, 2, 'PE'), -- SAIA / PE
              (3, 4, 'PR'), -- BONECA / PR
              (4, 5, 'BA'), -- ESTANTE / BA
              (5, 6, 'ES'), -- SOFÁ RETRÁTIL
              (6, 3, 'SP'), -- TV / SP
              (7, 3, 'SP'); -- CAMA / SP 
              
insert into supplier (SocialName, CNPJ, contact)
       values ('Almeida & Filhos', 39420744865333, 21975304513),
              ('Eletro Valvos', 10795849668872, 11924875310),
              ('Geraldo Gerais Ltda', 89642800175641, 11948531007);

insert into productSupplier (idPsupplier, idPproduct, SprodQuantity)
       values (1, 1, 500), 
              (2, 6, 585),
              (3, 4, 633);
              
insert into seller (SocialName, Abstname, location, contact)
	   values ('Tech Eletronics', null, 'Rio de Janeiro', 21945304875),
              ('Boutique Durghas', null, 'Rio de Janeiro', 21947620001),
              ('Kids World', null, 'São Paulo', 11954231549);

insert into productSeller (idPseller, idPproduct, prodQuantity)
	   values (1, 1, 950),
              (2, 2, 395),
              (3, 3, 790),
              (1, 6, 285);
              
insert into card (idCclient, cardname, validity, number_card)
       values (1, 'Maria M Silva', '2029-03-05', 1975204866315785),
			  (2, 'Matheus O Pimentel', '2032-10-19', 9453001975302548),
              (3, 'Julia S Silva', '2028-05-17', 6154024876201542),
              (4, 'Roberto G Assis', '2030-01-25', 3784562018954230),
              (5, 'Isabela M Cruz', '2029-07-12', 7306548215648562),
              (6, 'Marco L Teixeira', '2031-04-14', 1364587999564280),
              (7, 'Arthur V Armando', '2027-12-06', 4302154789654230),
              (8, 'Douglas A Ferreira', '2033-11-29', 4965210032547787),
              (9, 'Bruno V Santana', '2029-04-28', 6478512035486520),
              (10, 'Renam O Goiano', '2033-12-01', 4962102547895462),
              (11, 'Mirella F Santos', '2029-08-05', 6451203154872365);
       
insert into Send(send_cod, idSclient, send_Status)
	   values (4652103548751, 1, 'Delivered'),
			  (9642103548712, 2, 'In Progress'),
              (1975320457845, 3, 'Delivered'),
              (null, 4, 'Awaiting Payment'),
              (null, 5, 'Canceled'),
              (9453102154521, 6, 'In Progress'),
              (2015420002154, 7, 'In Progress'),
              (null, 8, 'Canceled'),
              (null, 9, 'Awaiting Payment'),
              (null, 10, 'Awaiting Payment'),
              (7954231021548, 11, 'Delivered'),
              (6491038452198, 12, 'In Progress'),
              (null, 13, 'Canceled');

-- ========================================
-- RECUPERAÇÃO SIMPLES COM SELECT STATMENT
-- ========================================

-- Recuperando todos os clientes pessoa física
select concat(Fname, ' ', Lname) as Cliente, CPF from cliente
		where Fname is not null;
        
-- Recuperando todos os clientes pessoa jurídica
select business_name as Razão_Social, CNPJ from cliente
		where business_name is not null;


-- ===========================
-- FILTROS COM WHERE STATMENT
-- ===========================

-- Clientes pessoa física com pedidos confirmado
select concat(Fname, ' ', Lname) as Cliente, orderStatus as Status_Pedido from cliente, orders
		where idOrderClient = idClient and orderStatus = 'Confirmado' and Fname is not null;

-- Clientes pessoa jurídica com pedidos confirmado
select business_name as Razão_Social, orderStatus as Status_Pedido from cliente, orders
		where idOrderClient = idClient and orderStatus = 'Confirmado' and business_name is not null;
        
-- ================================================================================
-- CRIE EXPRESSÕES PARA GERAR ATRIBUTOS DERIVADOS / ORDER BY / PESPECTIVA COMPLEXA
-- ================================================================================

-- RECUPERAR DADOS DOS CLIENTES E TOTAL PAGO NAS SUAS COMPRAS

SELECT
    CONCAT(c.Fname, ' ', c.Lname) AS Cliente_PF,
    c.CPF,
    c.business_name AS Cliente_PJ,
    c.CNPJ,
    c.Address AS Endereço,
    o.orderStatus AS Status_Pedido,
    SUM(po.poQuantity) AS Quantidade_Total_Itens, -- Quantidade total de itens comprados
    round(SUM(po.poQuantity * p.valor), 2) AS Total_Pago -- Valor total pago
FROM
    cliente c
INNER JOIN
    orders o ON c.idClient = o.idOrderClient
INNER JOIN
    productOrder po ON o.idOrder = po.idPOorder
INNER JOIN
    product p ON po.idPOproduct = p.idProduct
GROUP BY
    c.idClient, c.Fname, c.Lname, c.CPF, c.business_name, c.CNPJ, c.Address, o.orderStatus
ORDER BY
    c.idClient;
    
-- ===============
-- HAVING STATMENT
-- ===============

-- Clientes pessoa jurídica com mais de 1000 compras
select c.business_name as Razão_Social, c.CNPJ, c.Address as Endereço, SUM(po.poQuantity) AS Quantidade_Total_Itens, o.orderStatus as Status_Pedido, round(sum(po.poQuantity * p.valor), 2) as Total_Pago
			from cliente c
				inner join orders o on c.idClient = o.idOrderClient
                inner join productOrder po on o.idOrder = po.idPOorder
                inner join product p on po.idPOproduct = p.idProduct
                group by c.business_name, c.CNPJ, c.Address, o.orderStatus
                having Quantidade_Total_Itens > 1000;