-- Group by/Having -- mostra o os nomes e quantidade de reservas dos clientes que fizeram mais de uma reserva
SELECT C.Nome AS Nome_Cliente,COUNT(r.ID_Res) AS Total_Reservas
FROM Cliente C JOIN
     Faz_Reserva fr ON c.CPF = fr.CPF_Cli JOIN 
     Reserva r ON fr.ID_Res = r.ID_Res
GROUP BY C.Nome
HAVING COUNT(r.ID_Res) > 1

-- Junção interna - mostra os hoteis e seus respectivos gerentes
SELECT 
    H.Nome AS Nome_Hotel,
    (F.Nome) AS Nome_Gerente,
    (F.Cargo)
FROM Hotel H
INNER JOIN Funcionario F ON H.CPF_Gerente = F.CPF;

-- Junção externa -- mostra todos os quartos e suas comodidades(quando existem)
SELECT Distinct Q.ID_Quarto,Q.CNPJ, Q.Tipo, Q.VALOR, (QC.ID_COMODIDADE)
FROM Quarto Q
LEFT JOIN Quarto_Tem_Comodidade QC 
ON Q.ID_Quarto = QC.ID_Quarto
ORDER BY Q.ID_Quarto;

-- Semi junção -- Clientes que já fizeram reservas
SELECT DISTINCT c.*
FROM Cliente c
WHERE EXISTS (
    SELECT fr.ID_RES
    FROM Faz_Reserva fr 
    WHERE fr.CPF_Cli = c.CPF
);

-- Anti-junção -- Mostra as reservas que nao tem nenhum pagamento
Select R.ID_RES
from RESERVA R
Where not exists(
    select *
    from pagamento P
   where P.ID_RES = R.ID_RES
)

-- Subconsulta do tipo escalar -- (consulta que retorna apenas um valor) - Funcionário com o maior salário
SELECT Nome
FROM Funcionario
WHERE Salario = (SELECT MAX(Salario) FROM Funcionario);

-- Subconsulta do tipo linha -- (retorna 1 linha com várias colunas)- reserva com o maior valor
SELECT * 
FROM Reserva
WHERE ID_Res = (
    SELECT ID_Res 
    FROM Reserva 
    WHERE Valor_Total = (SELECT MAX(Valor_Total) 
                         FROM Reserva)
);

-- Subconsulta do tipo tabela --Listar funcionários que trabalham em setores específicos, nesse caso, 111 e 222
SELECT *
FROM Funcionario
WHERE CPF IN (
  SELECT CPF_Func 
  FROM Trabalha 
  WHERE ID_Setor IN (111,222)
);

-- Operação de conjunto - Retorna os cpf's e nomes de todas as pessoas, clientes + func
SELECT CPF, Nome, 'Funcionário' AS Tipo
FROM Funcionario
UNION
SELECT CPF, Nome, 'Cliente' AS Tipo
FROM Cliente;

--Procedimento - Insere um novo Funcionário
CREATE OR REPLACE PROCEDURE InserirFuncionario(
    p_CPF IN VARCHAR2,
    p_Telefone IN VARCHAR2,
    p_Nome IN VARCHAR2,
    p_Salario IN NUMBER,
    p_Cargo IN VARCHAR2,
    p_CPF_Chefe IN VARCHAR2 DEFAULT NULL
) AS
BEGIN
    INSERT INTO Funcionario (CPF, Telefone, Nome, Salario, Cargo, CPF_Chefe)
    VALUES (p_CPF, p_Telefone, p_Nome, p_Salario, p_Cargo, p_CPF_Chefe);
    COMMIT;
END;
----------------exemplo de como usa-----------------
BEGIN
    InserirFuncionario('12345678901', '11999999999', 'Carlos Silva', 3000, 'Recepcionista', NULL);
END;
---------------------------------

--Função - retorna o salário de um funcionário
CREATE OR REPLACE FUNCTION ObterSalario(
    p_CPF IN VARCHAR2
) RETURN NUMBER AS
    v_Salario NUMBER;
BEGIN
    SELECT Salario INTO v_Salario
    FROM Funcionario
    WHERE CPF = p_CPF;

    RETURN v_Salario;
END;
---------------exemplo de uso---------------
SELECT ObterSalario('1') FROM DUAL;
--------------------------------------------

--Gatilho - Impede que o funcionário tenha um chefe que trabalha em outro hotel
CREATE OR REPLACE TRIGGER ChefeMesmoHotel
BEFORE INSERT OR UPDATE OF CPF_Chefe ON Funcionario
FOR EACH ROW
WHEN (NEW.CPF_Chefe IS NOT NULL)  -- Só verifica se houver um chefe informado
DECLARE
    v_Chefe_Hotel NUMBER;
    v_Func_Hotel NUMBER;
BEGIN
    -- Obtém o hotel do chefe
    SELECT ID_Setor INTO v_Chefe_Hotel
    FROM Trabalha
    WHERE CPF_Func = :NEW.CPF_Chefe
    AND ROWNUM = 1; -- Garante apenas um resultado

    -- Obtém o hotel do funcionário
    SELECT ID_Setor INTO v_Func_Hotel
    FROM Trabalha
    WHERE CPF_Func = :NEW.CPF
    AND ROWNUM = 1;

    -- Se forem diferentes, impede a operação
    IF v_Chefe_Hotel != v_Func_Hotel THEN
        RAISE_APPLICATION_ERROR(-20001, 'O chefe deve trabalhar no mesmo hotel que o funcionário.');
    END IF;
END;
