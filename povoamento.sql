-- 1. Tabela: Funcionario (7 funcionários, sendo 1 gerente)
INSERT INTO Funcionario (CPF, Telefone, Nome, Salario, Cargo, CPF_Chefe) VALUES 
  ('1', '11', 'Carlos Silva', 3500.00, 'Gerente', NULL),
  ('2', '22', 'Ana Souza', 2800.00, 'Supervisor', '1'),
  ('3', '33', 'João Pereira', 2200.00, 'Assistente', '2'),
  ('4', '44', 'Maria Oliveira', 3200.00, 'Supervisor', '1'),
  ('5', '55', 'Lucas Santos', 2500.00, 'Atendente', '2'),
  ('6', '66', 'Fernanda Costa', 2900.00, 'Supervisor', '1'),
  ('7', '77', 'Rafael Lima', 2400.00, 'Assistente', '2');

-- 2. Tabela: Hotel (2 hotéis)
INSERT INTO Hotel (CNPJ, Nome, Endereco, CPF_Gerente) VALUES 
  ('1', 'Hotel Luxo', 'Rua A, 123', '1'),
  ('2', 'Hotel Praia', 'Rua B, 456', '2');

-- 3. Tabela: Fones (telefones dos hotéis)
INSERT INTO Fones (CNPJ, Fone) VALUES 
  ('1', '11'),
  ('2', '22');

-- 4. Tabela: Quarto (3 quartos em cada hotel – um de cada tipo)
INSERT INTO Quarto (ID_Quarto, CNPJ, Tipo, Capacidade, Valor) VALUES 
  (1, '1', 'Simples', 1, 100.00),
  (2, '1', 'Duplo', 2, 150.00),
  (3, '1', 'Suite', 4, 200.00),
  (1, '2', 'Simples', 1, 110.00),
  (2, '2', 'Duplo', 2, 160.00),
  (3, '2', 'Suite', 4, 210.00);

-- 5. Tabela: Comodidade 
INSERT INTO Comodidade (ID_Com, Descricao, Custo_Ad) VALUES 
  (1, 'Ar Condicionado', 20.00),
  (2, 'TV', 15.00),
  (3, 'WiFi', 10.00),
  (4, 'Piscina', 30.00),
  (5, 'Academia', 25.00),
  (6, 'Estacionamento', 10.00);

-- 6. Tabela: Reserva (2 reservas)
INSERT INTO Reserva (ID_Res, Check_In, Check_Out, Num_Hospedes, Status, Valor_Total) VALUES 
  (1, TO_DATE('2025-03-10','YYYY-MM-DD'), TO_DATE('2025-03-15','YYYY-MM-DD'), 2, 'Confirmada', 300.00),
  (2, TO_DATE('2025-03-12','YYYY-MM-DD'), TO_DATE('2025-03-14','YYYY-MM-DD'), 1, 'Cancelada', 200.00);

-- 7. Tabela: Cliente (4 clientes)
INSERT INTO Cliente (CPF, Telefone, Nome) VALUES 
  ('8', '88', 'João'),
  ('9', '99', 'Marcos'),
  ('0', '00', 'Maria'),
  ('12', '44', 'Pedro');

-- 8. Tabela: Setor (3 setores)
INSERT INTO Setor (ID_Setor, Nome, CNPJ) VALUES 
  (1, 'Recepção', '1'),
  (2, 'Limpeza', '1'),
  (3, 'Administração', '2');

-- 9. Tabela: Faz_Reserva
INSERT INTO Faz_Reserva (ID_Res, ID_Quarto, CNPJ, CPF_Cli) VALUES 
  (1, 1, '1', '8'),
  (2, 1, '2', '9');

-- 10. Tabela: Pagamento
INSERT INTO Pagamento (ID_Pag, Data, Valor, Forma_Pag, ID_Res, ID_Quarto, CNPJ) VALUES 
  (1, TO_DATE('2025-03-10','YYYY-MM-DD'), 150.00, 'Cartão', 1, 1, '1'),
  (2, TO_DATE('2025-03-11','YYYY-MM-DD'), 150.00, 'Dinheiro', 1, 1, '1'),
  (3, TO_DATE('2025-03-12','YYYY-MM-DD'), 200.00, 'Cartão', 2, 1, '2');

-- 11. Tabela: Quarto_Tem_Comodidade
INSERT INTO Quarto_Tem_Comodidade (ID_Comodidade, ID_Quarto, CNPJ) VALUES 
  (1, 1, '1'),
  (2, 2, '1'),
  (3, 3, '1'),
  (1, 1, '2'),
  (2, 2, '2'),
  (3, 3, '2');

-- 12. Tabela: Hotel_Tem_Comodidade
INSERT INTO Hotel_Tem_Comodidade (ID_Comodidade, CNPJ) VALUES 
  (4, '1'),
  (5, '2'),
  (6, '2');

-- 13. Tabela: Trabalha
INSERT INTO Trabalha (CPF_Func, Data_Admissao, ID_Setor) VALUES 
  ('1', TO_DATE('2020-01-10','YYYY-MM-DD'), 1),
  ('2', TO_DATE('2021-06-15','YYYY-MM-DD'), 2),
  ('3', TO_DATE('2019-04-10','YYYY-MM-DD'), 3),
  ('4', TO_DATE('2022-03-20','YYYY-MM-DD'), 1),
  ('5', TO_DATE('2023-07-30','YYYY-MM-DD'), 2),
  ('6', TO_DATE('2022-05-01','YYYY-MM-DD'), 3),
  ('7', TO_DATE('2023-08-01','YYYY-MM-DD'), 1);
