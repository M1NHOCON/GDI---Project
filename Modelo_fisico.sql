-- Tabela Funcionário
CREATE TABLE Funcionario (
    CPF VARCHAR2(11) PRIMARY KEY,
    Telefone VARCHAR2(20),
    Nome VARCHAR2(100),
    Salario NUMBER(10,2),
    Cargo VARCHAR2(50),
    CPF_Chefe VARCHAR2(11),
    CONSTRAINT FK_Funcionario_Chefe FOREIGN KEY (CPF_Chefe) REFERENCES Funcionario(CPF)
);

-- Tabela Hotel
CREATE TABLE Hotel (
    CNPJ VARCHAR2(14) PRIMARY KEY,
    Nome VARCHAR2(100),
    Endereco VARCHAR2(200),
    CPF_Gerente VARCHAR2(11) NOT NULL UNIQUE,
    CONSTRAINT FK_Hotel_Gerente FOREIGN KEY (CPF_Gerente) REFERENCES Funcionario(CPF)
);

-- Tabela Fones (Hotel pode ter vários telefones)
CREATE TABLE Fones (
    CNPJ VARCHAR2(14),
    Fone VARCHAR2(20),
    PRIMARY KEY (CNPJ, Fone),
    CONSTRAINT FK_Fones_Hotel FOREIGN KEY (CNPJ) REFERENCES Hotel(CNPJ)
);

-- Tabela Quarto
CREATE TABLE Quarto (
    ID_Quarto NUMBER,
    CNPJ VARCHAR2(14),
    Tipo VARCHAR2(30),
    Capacidade NUMBER(1),
    Valor NUMBER(6,2),
    PRIMARY KEY (ID_Quarto, CNPJ),
    CONSTRAINT FK_Quarto_Hotel FOREIGN KEY (CNPJ) REFERENCES Hotel(CNPJ)
);

-- Tabela Comodidade
CREATE TABLE Comodidade (
    ID_Com NUMBER(10) PRIMARY KEY,
    Descricao VARCHAR2(100),
    Custo_Ad NUMBER(6,2)
);



-- Tabela Reserva
CREATE TABLE Reserva (
    ID_Res NUMBER PRIMARY KEY,
    Check_In DATE,
    Check_Out DATE,
    Num_Hospedes NUMBER,
    Status VARCHAR2(20),
    Valor_Total NUMBER(10,2)
);

-- Tabela Cliente
CREATE TABLE Cliente (
    CPF VARCHAR2(11) PRIMARY KEY,
    Telefone VARCHAR2(20),
    Nome VARCHAR2(100)
);

-- Tabela Setor
CREATE TABLE Setor (
    ID_Setor VARCHAR2(5) PRIMARY KEY,
    Nome VARCHAR2(100),
    CNPJ VARCHAR2(14) NOT NULL,
    CONSTRAINT FK_Setor_Hotel FOREIGN KEY (CNPJ) REFERENCES Hotel(CNPJ)
);

-- Tabela Faz_reserva (Relaciona Reserva, Quarto e Cliente)
CREATE TABLE Faz_Reserva (
    ID_Res VARCHAR2(5),
    ID_Quarto VARCHAR2(5),
    CNPJ VARCHAR2(14),
    CPF_Cli VARCHAR2(11) NOT NULL,
    PRIMARY KEY (ID_Res, ID_Quarto, CNPJ),
    CONSTRAINT FK_FazReserva_Reserva FOREIGN KEY (ID_Res) REFERENCES Reserva(ID_Res),
    CONSTRAINT FK_FazReserva_Quarto FOREIGN KEY (ID_Quarto, CNPJ) REFERENCES Quarto(ID_Quarto, CNPJ),
    CONSTRAINT FK_FazReserva_Cliente FOREIGN KEY (CPF_Cli) REFERENCES Cliente(CPF)
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    ID_Pag NUMBER PRIMARY KEY,
    Data DATE,
    Valor NUMBER(10,2),
    Forma_Pag VARCHAR2(50),
    ID_Res NUMBER,
    ID_Quarto NUMBER,
    CNPJ VARCHAR2(14),
    CONSTRAINT FK_Pagamento_FazReserva FOREIGN KEY (ID_Res, ID_Quarto, CNPJ) REFERENCES Faz_Reserva(ID_Res, ID_Quarto, CNPJ)
);

-- Tabela Quarto_Tem_Comodidade
CREATE TABLE Quarto_Tem_Comodidade (
    ID_Comodidade NUMBER,
    ID_Quarto NUMBER,
    CNPJ VARCHAR2(14),
    PRIMARY KEY (ID_Comodidade, ID_Quarto, CNPJ),
    CONSTRAINT FK_QTC_Comodidade FOREIGN KEY (ID_Comodidade) REFERENCES Comodidade(ID_Com),
    CONSTRAINT FK_QTC_Quarto FOREIGN KEY (ID_Quarto, CNPJ) REFERENCES Quarto(ID_Quarto, CNPJ)
);

-- Tabela Hotel_Tem_Comodidade
CREATE TABLE Hotel_Tem_Comodidade (
    ID_Comodidade NUMBER,
    CNPJ VARCHAR2(14),
    PRIMARY KEY (ID_Comodidade, CNPJ),
    CONSTRAINT FK_HTC_Comodidade FOREIGN KEY (ID_Comodidade) REFERENCES Comodidade(ID_Com),
    CONSTRAINT FK_HTC_Hotel FOREIGN KEY (CNPJ) REFERENCES Hotel(CNPJ)
);

-- Tabela Trabalha (Relaciona Funcionário e Setor)
CREATE TABLE Trabalha (
    CPF_Func VARCHAR2(11),
    Data_Admissao DATE,
    ID_Setor NUMBER NOT NULL,
    PRIMARY KEY (CPF_Func, Data_Admissao),
    CONSTRAINT FK_Trabalha_Funcionario FOREIGN KEY (CPF_Func) REFERENCES Funcionario(CPF),
    CONSTRAINT FK_Trabalha_Setor FOREIGN KEY (ID_Setor) REFERENCES Setor(ID_Setor)
);

--------------------------------povoamento--------------------------------------------

--O chefe de um funcionário deve trabalhar no mesmo hotel que ele!!!!!!!!!!!!!!!!!!!!!!
-- 1. Tabela: Funcionario (7 funcionários, sendo 1 gerente)
INSERT INTO Funcionario (CPF, Telefone, Nome, Salario, Cargo, CPF_Chefe) VALUES 
  ('111', '11', 'Carlos Silva', 3500.00, 'Gerente', NULL),
  ('222', '22', 'Ana Souza', 2800.00, 'Supervisor', NULL),
  ('333', '33', 'João Pereira', 2200.00, 'Assistente', '222'),
  ('444', '44', 'Maria Oliveira', 3200.00, 'Supervisor', '111'),
  ('555', '55', 'Lucas Santos', 2500.00, 'Atendente', '222'),
  ('666', '66', 'Fernanda Costa', 2900.00, 'Supervisor', '111'),
  ('777', '77', 'Rafael Lima', 2400.00, 'Assistente', '222');

-- 2. Tabela: Hotel (2 hotéis)
INSERT INTO Hotel (CNPJ, Nome, Endereco, CPF_Gerente) VALUES 
  ('1111', 'Hotel Chic', 'Glória do Goita-PE', '111'),
  ('2222', 'Hotel Beira Mar', 'Boa Viagem, Recife-PE', '222');

-- 3. Tabela: Fones (telefones dos hotéis)
INSERT INTO Fones (CNPJ, Fone) VALUES 
  ('1111', '11'),
  ('2222', '22');

-- 4. Tabela: Quarto (3 quartos em cada hotel – um de cada tipo)
INSERT INTO Quarto (ID_Quarto, CNPJ, Tipo, Capacidade, Valor) VALUES 
  (1, '1111', 'Simples', 1, 100.00),
  (2, '1111', 'Duplo', 2, 150.00),
  (3, '1111', 'Suite', 4, 200.00),
  (1, '2222', 'Simples', 1, 110.00),
  (2, '2222', 'Duplo', 2, 160.00),
  (3, '2222', 'Suite', 4, 210.00);

-- 5. Tabela: Comodidade 
-- (3 comodidades destinadas aos quartos e 3 destinadas aos hotéis)
INSERT INTO Comodidade (ID_Com, Descricao, Custo_Ad) VALUES 
  (1, 'Ar Condicionado', 20.00),   -- Para Quarto
  (2, 'TV', 15.00),                -- Para Quarto
  (3, 'WiFi', 10.00),              -- Para Quarto
  (4, 'Piscina', 30.00),           -- Para Hotel
  (5, 'Academia', 25.00),          -- Para Hotel
  (6, 'Estacionamento', 10.00);    -- Para Hotel

-- 6. Tabela: Reserva (2 reservas; a reserva 1 terá 2 pagamentos)
-- O status deve ser calculado baseado no valor dos pagamentos e na data!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
INSERT INTO Reserva (ID_Res, Check_In, Check_Out, Num_Hospedes, Status, Valor_Total) VALUES 
  (1, TO_DATE('2025-03-10','YYYY-MM-DD'), TO_DATE('2025-03-15','YYYY-MM-DD'), 2, 'Confirmada', 300.00),
  (2, TO_DATE('2025-03-12','YYYY-MM-DD'), TO_DATE('2025-03-14','YYYY-MM-DD'), 1, 'Aguardando Pagamento', 200.00),
  (2, TO_DATE('2025-03-13','YYYY-MM-DD'), TO_DATE('2025-03-14','YYYY-MM-DD'), 1, 'Cancelada', 200.00);


-- 7. Tabela: Cliente (4 clientes)
INSERT INTO Cliente (CPF, Telefone, Nome) VALUES 
  ('100', '88', 'João'),
  ('200', '99', 'Marcos'),
  ('300', '30', 'Maria'),
  ('400', '44', 'Pedro');

-- 8. Tabela: Setor (3 setores)
INSERT INTO Setor (ID_Setor, Nome, CNPJ) VALUES 
  (1, 'Recepção', '1111'),
  (2, 'Limpeza', '1111'),
  (3, 'Administração', '1111'),
  (4, 'Recepção', '2222');

-- 9. Tabela: Faz_Reserva (relaciona Reserva, Quarto e Cliente)
-- Atribuindo a reserva 1 ao quarto 1 do Hotel 1 e a reserva 2 ao quarto 1 do Hotel 2
INSERT INTO Faz_Reserva (ID_Res, ID_Quarto, CNPJ, CPF_Cli) VALUES 
  (1, 1, '1111', '100'),
  (2, 1, '2222', '200');

-- 10. Tabela: Pagamento 
-- Reserva 1: dois pagamentos (150,00 + 150,00 = 300,00); Reserva 2: um pagamento de 200,00
INSERT INTO Pagamento (ID_Pag, Data, Valor, Forma_Pag, ID_Res, ID_Quarto, CNPJ) VALUES 
  (1, TO_DATE('2025-03-09','YYYY-MM-DD'), 150.00, 'Cartão', 1, 1, '1111'),
  (2, TO_DATE('2025-03-10','YYYY-MM-DD'), 150.00, 'Dinheiro', 1, 1, '1111'),
  (3, TO_DATE('2025-03-12','YYYY-MM-DD'), 100.00, 'Cartão', 2, 1, '2222');

-- 11. Tabela: Quarto_Tem_Comodidade 
-- (Associando as 3 comodidades de quarto a cada hotel – considerando os quartos de ID 1, 2 e 3)
INSERT INTO Quarto_Tem_Comodidade (ID_Comodidade, ID_Quarto, CNPJ) VALUES 
  (1, 1, '1111'),
  (2, 2, '1111'),
  (3, 3, '1111'),
  (1, 1, '2222'),
  (2, 2, '2222'),
  (3, 3, '2222');

-- 12. Tabela: Hotel_Tem_Comodidade 
-- (Associando as 3 comodidades de hotel: Hotel 1 com a comodidade 4; Hotel 2 com as comodidades 5 e 6)
INSERT INTO Hotel_Tem_Comodidade (ID_Comodidade, CNPJ) VALUES 
  (4, '1111'),
  (5, '2222'),
  (6, '2222');

-- 13. Tabela: Trabalha (Relaciona os 7 funcionários aos 3 setores)
INSERT INTO Trabalha (CPF_Func, Data_Admissao, ID_Setor) VALUES 
  ('111', TO_DATE('2020-01-10','YYYY-MM-DD'), 1),
  ('222', TO_DATE('2021-06-15','YYYY-MM-DD'), 2),
  ('333', TO_DATE('2019-04-10','YYYY-MM-DD'), 3),
  ('444', TO_DATE('2022-03-20','YYYY-MM-DD'), 1),
  ('555', TO_DATE('2023-07-30','YYYY-MM-DD'), 2),
  ('666', TO_DATE('2022-05-01','YYYY-MM-DD'), 3),
  ('777', TO_DATE('2023-08-01','YYYY-MM-DD'), 1);

