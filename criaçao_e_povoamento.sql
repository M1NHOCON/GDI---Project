-- 1. Tabela: Funcionario (7 funcionários, sendo 1 gerente)
INSERT INTO Funcionario (CPF, Telefone, Nome, Salario, Cargo, CPF_Chefe) VALUES 
  ('111', '11', 'Carlos Silva', 3500.00, 'Gerente', NULL),
  ('222', '22', 'Ana Souza', 2800.00, 'Supervisor', '111'),
  ('333', '33', 'João Pereira', 2200.00, 'Assistente', '222'),
  ('444', '44', 'Maria Oliveira', 3200.00, 'Supervisor', '111'),
  ('555', '55', 'Lucas Santos', 2500.00, 'Atendente', '222'),
  ('666', '66', 'Fernanda Costa', 2900.00, 'Supervisor', '111'),
  ('777', '77', 'Rafael Lima', 2400.00, 'Assistente', '222');

-- 2. Tabela: Hotel (2 hotéis)
INSERT INTO Hotel (CNPJ, Nome, Endereco, CPF_Gerente) VALUES 
  ('1111', 'Hotel Luxo', 'Rua A, 123', '111'),
  ('2222', 'Hotel Praia', 'Rua B, 456', '222');

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
INSERT INTO Reserva (ID_Res, Check_In, Check_Out, Num_Hospedes, Status, Valor_Total) VALUES 
  (1, TO_DATE('2025-03-10','YYYY-MM-DD'), TO_DATE('2025-03-15','YYYY-MM-DD'), 2, 'Confirmada', 300.00),
  (2, TO_DATE('2025-03-12','YYYY-MM-DD'), TO_DATE('2025-03-14','YYYY-MM-DD'), 1, 'Cancelada', 200.00);

-- 7. Tabela: Cliente (4 clientes)
INSERT INTO Cliente (CPF, Telefone, Nome) VALUES 
  ('888', '88', 'Cliente A'),
  ('999', '99', 'Cliente B'),
  ('000', '00', 'Cliente C'),
  ('121', '44', 'Cliente D');

-- 8. Tabela: Setor (3 setores)
INSERT INTO Setor (ID_Setor, Nome, CNPJ) VALUES 
  (1, 'Recepção', '1111'),
  (2, 'Limpeza', '1111'),
  (3, 'Administração', '2222');

-- 9. Tabela: Faz_Reserva (relaciona Reserva, Quarto e Cliente)
-- Atribuindo a reserva 1 ao quarto 1 do Hotel 1 e a reserva 2 ao quarto 1 do Hotel 2
INSERT INTO Faz_Reserva (ID_Res, ID_Quarto, CNPJ, CPF_Cli) VALUES 
  (1, 1, '1111', '888'),
  (2, 1, '2222', '999');

-- 10. Tabela: Pagamento 
-- Reserva 1: dois pagamentos (150,00 + 150,00 = 300,00); Reserva 2: um pagamento de 200,00
INSERT INTO Pagamento (ID_Pag, Data, Valor, Forma_Pag, ID_Res, ID_Quarto, CNPJ) VALUES 
  (1, TO_DATE('2025-03-10','YYYY-MM-DD'), 150.00, 'Cartão', 1, 1, '1111'),
  (2, TO_DATE('2025-03-11','YYYY-MM-DD'), 150.00, 'Dinheiro', 1, 1, '1111'),
  (3, TO_DATE('2025-03-12','YYYY-MM-DD'), 200.00, 'Cartão', 2, 1, '2222');

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
