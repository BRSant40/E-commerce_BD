# Projeto de Banco de Dados para E-commerce

Este README fornece uma visão geral do esquema do banco de dados criado para um cenário de e-commerce. O banco de dados foi desenvolvido utilizando MySQL.

## Estrutura do Banco de Dados

O banco de dados `ecommerce` é composto pelas seguintes tabelas:

### 1. `cliente`

Armazena informações sobre os clientes.

| Coluna        | Tipo         | Atributos                     | Descrição                                  |
|---------------|--------------|-------------------------------|---------------------------------------------|
| `idClient`    | INT          | AUTO_INCREMENT, PRIMARY KEY   | Identificador único do cliente              |
| `Fname`       | VARCHAR(10)  | DEFAULT NULL                  | Primeiro nome do cliente (pessoa física)   |
| `Minit`       | CHAR(3)      | DEFAULT NULL                  | Inicial do nome do meio (pessoa física)     |
| `Lname`       | VARCHAR(20)  | DEFAULT NULL                  | Sobrenome do cliente (pessoa física)      |
| `business_name`| VARCHAR(30)  | DEFAULT NULL                  | Nome fantasia da empresa (pessoa jurídica) |
| `CPF`         | CHAR(11)     | DEFAULT NULL, UNIQUE          | Cadastro de Pessoa Física                 |
| `CNPJ`        | CHAR(14)     | DEFAULT NULL, UNIQUE          | Cadastro Nacional da Pessoa Jurídica       |
| `Address`     | VARCHAR(255) | NOT NULL                      | Endereço do cliente                         |

### 2. `product`

Armazena informações sobre os produtos.

| Coluna             | Tipo                                   | Atributos          | Descrição                                          |
|--------------------|----------------------------------------|--------------------|----------------------------------------------------|
| `idProduct`        | INT                                    | AUTO_INCREMENT, PRIMARY KEY | Identificador único do produto                     |
| `Pname`            | VARCHAR(50)                            | NOT NULL           | Nome do produto                                    |
| `classification_kids`| BOOLEAN                                | DEFAULT FALSE      | Indica se o produto é para crianças               |
| `category`         | ENUM('Eletronico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') | NOT NULL           | Categoria do produto                               |
| `avaliação`        | FLOAT                                  | DEFAULT 0          | Avaliação do produto                               |
| `size`             | VARCHAR(10)                            | DEFAULT NULL       | Tamanho do produto (se aplicável)                |
| `valor`            | FLOAT                                  | DEFAULT NULL       | Valor do produto                                   |

### 3. `card`

Armazena informações sobre os cartões de crédito dos clientes.

| Coluna        | Tipo         | Atributos                     | Descrição                                    |
|---------------|--------------|-------------------------------|-----------------------------------------------|
| `idCard`      | INT          | AUTO_INCREMENT, PRIMARY KEY   | Identificador único do cartão                 |
| `idCclient`   | INT          | DEFAULT NULL, FOREIGN KEY references `cliente` | Identificador do cliente associado ao cartão      |
| `cardname`    | VARCHAR(45)  | NOT NULL                      | Nome no cartão                                |
| `validity`    | DATE         | NOT NULL                      | Data de validade do cartão                    |
| `number_card` | CHAR(16)     | NOT NULL                      | Número do cartão (normalmente criptografado) |

### 4. `orders`

Armazena informações sobre os pedidos.

| Coluna           | Tipo                                          | Atributos                                         | Descrição                                          |
|------------------|-----------------------------------------------|---------------------------------------------------|------------------------------------------------------|
| `idOrder`        | INT                                           | AUTO_INCREMENT, PRIMARY KEY                       | Identificador único do pedido                        |
| `idOrderClient`  | INT                                           | DEFAULT NULL, FOREIGN KEY references `cliente`, ON UPDATE CASCADE | Identificador do cliente que fez o pedido            |
| `orderStatus`    | ENUM('Cancelado', 'Confirmado', 'Em processamento') | DEFAULT 'Em processamento'                       | Status do pedido                                     |
| `orderDescription`| VARCHAR(255)                                  | DEFAULT NULL                                      | Descrição do pedido (opcional)                       |
| `sendValue`      | FLOAT                                         | DEFAULT 10                                        | Valor do frete                                       |
| `paymentPix`     | INT                                           | DEFAULT 0                                         | Indica se o pagamento foi feito por Pix (0: Não, 1: Sim)|

### 5. `productStorage`

Armazena informações sobre o estoque dos produtos.

| Coluna          | Tipo          | Atributos                     | Descrição                                     |
|-----------------|---------------|-------------------------------|-------------------------------------------------|
| `idProdStorage` | INT           | AUTO_INCREMENT, PRIMARY KEY   | Identificador único do local de armazenamento |
| `storageLocation`| VARCHAR(255)  | DEFAULT NULL                  | Localização do estoque                            |
| `quantity`      | INT           | DEFAULT 0                     | Quantidade de produtos no estoque              |

### 6. `supplier`

Armazena informações sobre os fornecedores.

| Coluna        | Tipo          | Atributos                     | Descrição                               |
|---------------|---------------|-------------------------------|-------------------------------------------|
| `idSupplier`  | INT           | AUTO_INCREMENT, PRIMARY KEY   | Identificador único do fornecedor       |
| `SocialName`  | VARCHAR(255)  | NOT NULL                      | Nome social do fornecedor               |
| `CNPJ`        | CHAR(14)      | NOT NULL, UNIQUE              | Cadastro Nacional da Pessoa Jurídica     |
| `contact`     | CHAR(11)      | NOT NULL                      | Número de contato do fornecedor         |

### 7. `seller`

Armazena informações sobre os vendedores.

| Coluna        | Tipo          | Atributos                     | Descrição                             |
|---------------|---------------|-------------------------------|---------------------------------------|
| `idSeller`    | INT           | AUTO_INCREMENT, PRIMARY KEY   | Identificador único do vendedor         |
| `SocialName`  | VARCHAR(255)  | NOT NULL                      | Nome social do vendedor               |
| `AbstName`    | VARCHAR(255)  | DEFAULT NULL                  | Nome fantasia do vendedor (opcional)  |
| `CNPJ`        | CHAR(14)      | DEFAULT NULL, UNIQUE          | Cadastro Nacional da Pessoa Jurídica   |
| `CPF`         | CHAR(11)      | DEFAULT NULL, UNIQUE          | Cadastro de Pessoa Física             |
| `location`    | VARCHAR(255)  | DEFAULT NULL                  | Localização do vendedor               |
| `contact`     | CHAR(11)      | NOT NULL                      | Número de contato do vendedor         |

### 8. `productSupplier`

Tabela de relacionamento muitos-para-muitos entre `product` e `supplier`.

| Coluna        | Tipo | Atributos                                                                 | Descrição                                      |
|---------------|------|---------------------------------------------------------------------------|------------------------------------------------|
| `idPsupplier` | INT  | PRIMARY KEY (parte da chave composta), FOREIGN KEY references `supplier` | Identificador do fornecedor                    |
| `idPproduct`  | INT  | PRIMARY KEY (parte da chave composta), FOREIGN KEY references `product`  | Identificador do produto                       |
| `SprodQuantity`| INT  | DEFAULT 1                                                               | Quantidade do produto fornecida pelo fornecedor |

### 9. `productSeller`

Tabela de relacionamento muitos-para-muitos entre `product` e `seller`.

| Coluna        | Tipo | Atributos                                                               | Descrição                                  |
|---------------|------|-------------------------------------------------------------------------|--------------------------------------------|
| `idPseller`   | INT  | PRIMARY KEY (parte da chave composta), FOREIGN KEY references `seller` | Identificador do vendedor                  |
| `idPproduct`  | INT  | PRIMARY KEY (parte da chave composta), FOREIGN KEY references `product`| Identificador do produto                   |
| `prodQuantity`| INT  | DEFAULT 1                                                             | Quantidade do produto vendida pelo vendedor |

### 10. `productOrder`

Tabela de relacionamento muitos-para-muitos entre `product` e `orders`.

| Coluna      | Tipo                                      | Atributos                                                               | Descrição                                     |
|-------------|-------------------------------------------|-------------------------------------------------------------------------|------------------------------------------------|
| `idPOproduct`| INT                                       | PRIMARY KEY (parte da chave composta), FOREIGN KEY references `product`| Identificador do produto no pedido             |
| `idPOorder` | INT                                       | PRIMARY KEY (parte da chave composta), FOREIGN KEY references `orders` | Identificador do pedido                        |
| `poQuantity`| INT                                       | DEFAULT 1                                                             | Quantidade do produto no pedido                |
| `poStatus`  | ENUM ('Disponível', 'Sem estoque') | DEFAULT 'Disponível'                                                    | Status do produto no pedido                  |

### 11. `storageLocation`

Tabela de relacionamento muitos-para-muitos entre `product` e `productStorage`.

| Coluna      | Tipo | Atributos                                                                    | Descrição                                    |
|-------------|------|------------------------------------------------------------------------------|----------------------------------------------|
| `idLproduct`| INT  | PRIMARY KEY (parte da chave composta), FOREIGN KEY references `product`     | Identificador do produto                     |
| `idLstorage`| INT  | PRIMARY KEY (parte da chave composta), FOREIGN KEY references `productStorage`| Identificador do local de armazenamento    |
| `Location`  | VARCHAR(255) | NOT NULL                                                             | Localização específica do produto no estoque |

### 12. `Send`

Armazena informações sobre as entregas.

| Coluna        | Tipo                                          | Atributos                     | Descrição                                      |
|---------------|-----------------------------------------------|-------------------------------|------------------------------------------------|
| `idSend`      | INT                                           | AUTO_INCREMENT, PRIMARY KEY   | Identificador único da entrega                 |
| `send_cod`    | CHAR(13)                                      | DEFAULT NULL                  | Código de rastreamento da entrega (opcional)   |
| `idSclient`   | INT                                           | DEFAULT NULL, FOREIGN KEY references `cliente` | Identificador do cliente para a entrega         |
| `send_status` | ENUM('Delivered', 'Awaiting Payment','In progress', 'Canceled') | DEFAULT 'Awaiting Payment'  | Status da entrega                                |

## Relacionamentos entre as Tabelas

* Um cliente pode ter múltiplos cartões (`cliente` para `card` - 1:N).
* Um cliente pode fazer múltiplos pedidos (`cliente` para `orders` - 1:N).
* Um produto pode ser fornecido por múltiplos fornecedores (`product` para `supplier` - N:N através de `productSupplier`).
* Um produto pode ser vendido por múltiplos vendedores (`product` para `seller` - N:N através de `productSeller`).
* Um pedido pode conter múltiplos produtos (`orders` para `product` - N:N através de `productOrder`).
* Um produto pode estar armazenado em múltiplas localizações de estoque (`product` para `productStorage` - N:N através de `storageLocation`).
* Uma entrega está associada a um cliente (`Send` para `cliente` - 1:N).

## Instruções de Uso

Para utilizar este banco de dados, você precisará de um sistema de gerenciamento de banco de dados MySQL. Você pode executar o script SQL fornecido para criar as tabelas e inserir os dados de exemplo.

Sinta-se à vontade para contribuir e expandir este esquema de banco de dados conforme as necessidades do seu projeto de e-commerce evoluírem.

Lembrando que este é um projeto com fins didáticos.
```
