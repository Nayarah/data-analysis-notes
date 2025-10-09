/*
Objetivo: Exemplos de DDL (Data Definition Language) e DML (Data Manipulation Language) no BigQuery.
Contexto: Criando e populando um schema 'dm_mobility' para testes de JOINs.
*/

-- 1. DDL: Criação das tabelas de Schema Estrela (clientes/pedidos)
.CREATE TABLE dm_mobility.clientes (
    id_cliente INT,
    nome STRING
);

CREATE TABLE dm_mobility.pedidos (
    id_pedido INT,
    id_cliente INT,
    data_pedido DATE
);

CREATE TABLE dm_mobility.itens_pedido (
    id_item INT,
    id_pedido INT,
    produto STRING,
    preco DECIMAL(10, 2)
);

-- 2. DML: Inserindo dados de exemplo (Mock Data)
INSERT INTO dm_mobility.clientes VALUES
(1, 'Ana Silva'),
(2, 'João Souza'),
(3, 'Maria Oliveira'),
(4, 'Pedro Santos');

INSERT INTO dm_mobility.pedidos VALUES
(101, 1, '2025-09-01'),
(102, 2, '2025-09-02'),
(103, 1, '2025-09-03');

INSERT INTO dm_mobility.itens_pedido VALUES
(1, 101, 'Mouse Gamer', 150.00),
(2, 101, 'Teclado Mecânico',299.5),
(3, 102, 'Monitor Ultrawide', 1200.00),
(4, 103, 'Cadeira Gamer', 750.00);