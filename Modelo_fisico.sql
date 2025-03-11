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
