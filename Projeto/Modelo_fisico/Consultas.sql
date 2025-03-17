/*Seu projeto deve ter todos os tipos de consultas abaixo
1-Group by/Having
2-Junção interna
3-Junção externa
4-Semi junção
5-Anti-junção
6-Subconsulta do tipo escalar
7-Subconsulta do tipo linha
8-Subconsulta do tipo tabela
9-Operação de conjunto

Atenção: Cada aluno deve fazer ao menos 01 dessas consultas mais 01 procedimento com SQL embutida e parâmetro, função com SQL embutida e parâmetro ou gatilho. 
*/
--ATENÇÃO - É IMPORTANTE QUE OS GATILHOS RESOLVAM PROBLEMAS REAIS DO NOSSO ESQUEMA(vejam meu exemplo(Paulo))
--SUGESTÃO - Trocar datas de check-in-out para quarto, pois em reserva, reservamos quartos mesmos nos dias que não estaremos neles caso sejam de hoteis diferentes



-- Consulta 1 -- Mostra todos os setores que tem uma quantidade > x
select s.NOME, S.CNPJ, count(*) as QTD
from SETOR S, TRABALHA T
where S.ID_SETOR = T.ID_SETOR
group by S.NOME, S.CNPJ
having QTD>1

-- Consulta 2 -- Retorna todo os trabalhadores que trabalham em um setor no hotel
select F.NOME as FNOME, T.ID_SETOR, S.NOME as NOME_Setor, S.CNPJ
from Funcionario F INNER JOIN TRABALHA T on F.CPF = T.CPF_FUNC
                    INNER JOIN SETOR S on T.ID_SETOR = S.ID_SETOR

-- Consulta 3 -- Rtorna funcionarios com salario acima da media
-- Achei meio sem sentido, pq calcula a média dos funcionários de todos os hotéis...
--acho que isso não seja junção externa
SELECT F.nome, F.salario, (select round(AVG(D.SALARIO),2) from FUNCIONARIO d)
from FUNCIONARIO F
where F.salario >(
    select avg(salario)
    from FUNCIONARIO
)

--Consulta 1 - Paulo -- mostra o os nomes e quantidade de reservas dos clientes que fizeram mais de uma reserva
SELECT C.Nome AS Nome_Cliente,COUNT(r.ID_Res) AS Total_Reservas
FROM Cliente C
JOIN Faz_Reserva fr ON c.CPF = fr.CPF_Cli
JOIN Reserva r ON fr.ID_Res = r.ID_Res
GROUP BY C.Nome
HAVING COUNT(r.ID_Res) > 1

--Consulta 2 - Paulo - mostra os hoteis e seus respectivos gerentes
SELECT 
    H.Nome AS Nome_Hotel,
    (F.Nome) AS Nome_Gerente,
    (F.Cargo)
FROM Hotel H
INNER JOIN Funcionario F ON H.CPF_Gerente = F.CPF;

--Consulta 3 - Paulo -- mostra todos os quartos e suas comodidades(quando existem)
SELECT Distinct Q.ID_Quarto,Q.CNPJ, Q.Tipo, Q.VALOR, QC.ID_QUARTO AS Comodidade
FROM Quarto Q
LEFT JOIN Quarto_Tem_Comodidade QC 
ON Q.ID_Quarto = QC.ID_Quarto
ORDER BY Q.ID_Quarto;

--Consulta 4 - Paulo -- Mostra apenas os ids de reserva que tem algum pagamento
Select R.ID_RES
from RESERVA R
Where exists(
    select *
    from pagamento P
    where P.ID_PAG = R.ID_RES
    AND Q.CNPJ = FZ.CNPJ

)

--Consulta 5 - Paulo -- Mostra as reservas que nao tem nenhum pagamento
Select R.ID_RES
from RESERVA R
Where not exists(
    select *
    from pagamento P
   where P.ID_RES = R.ID_RES
)

--Consulta 6 Paulo -- (consulta que retorna apenas um valor) - Funcionário com o maior salário
SELECT Nome
FROM Funcionario
WHERE Salario = (SELECT MAX(Salario) FROM Funcionario);

--Consulta 7 - Paulo -- (retorna 1 linha com várias colunas)- reserva com o maior valor
SELECT * 
FROM Reserva
WHERE ID_Res = (
    SELECT ID_Res 
    FROM Reserva 
    WHERE Valor_Total = (SELECT MAX(Valor_Total) 
                         FROM Reserva)
);

--Consulta 8 - Paulo - (retorna varias colunas e linhas) retorna os setores com mais funcionários
SELECT S.ID_Setor, S.Nome, COUNT(T.CPF_Func) AS Num_Funcionarios
FROM Setor S
JOIN Trabalha T ON S.ID_Setor = T.ID_Setor
GROUP BY S.ID_Setor, S.Nome
HAVING COUNT(T.CPF_Func) = (
    SELECT MAX(Num_Func)
    FROM (
        SELECT COUNT(CPF_Func) AS Num_Func
        FROM Trabalha
        GROUP BY ID_Setor
    )
);

--Consulta 9 - Paulo - Retorna os cpf's e nomes de todas as pessoas, clientes + func
SELECT CPF, Nome, 'Funcionário' AS Tipo
FROM Funcionario
UNION
SELECT CPF, Nome, 'Cliente' AS Tipo
FROM Cliente;

--Procedimento - Paulo - Insere um novo Funcionário
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

--Função - Paulo - retorna o salário de um funcionário
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

--Gatilho - Paulo - Impede que o funcionário tenha um chefe que trabalha em outro hotel
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


  
-- Procedimento - Muda o chefe de um funcionário
CREATE OR REPLACE PROCEDURE AlterarChefeFuncionario(
    p_CPF IN VARCHAR2,       -- CPF do funcionário cujo chefe será alterado
    p_CPF_Chefe IN VARCHAR2  -- Novo chefe
) AS
    v_Existe NUMBER;
BEGIN
    -- Verifica se o funcionário existe
    SELECT COUNT(*) INTO v_Existe
    FROM Funcionario
    WHERE CPF = p_CPF;

    -- Se existe, atualiza o chefe
    IF v_Existe > 0 THEN
        UPDATE Funcionario
        SET CPF_Chefe = p_CPF_Chefe
        WHERE CPF = p_CPF;
        
        COMMIT;
    END IF;
END;
/
-----------------exemplo de como usa-----------------
  BEGIN
    AlterarChefeFuncionario('12345678901', '56789012345');
END;
----------------------------------

-- Consulta 1 -- Vinicius -- Total de reservas por cliente com valor total superior a 1000
SELECT CPF_Cli, SUM(r.Valor_Total) AS Total_Gasto
FROM Faz_Reserva fr
JOIN Reserva r ON fr.ID_Res = r.ID_Res
GROUP BY CPF_Cli
HAVING SUM(r.Valor_Total) > 1000;

-- Consulta 2 -- Vinicius -- Pagamentos com detalhes de reserva
SELECT p.ID_Pag, p.Valor, r.Status
FROM Pagamento p INNER JOIN 
      Reserva r ON p.ID_Res = r.ID_Res;

-- Consulta 3 -- vinicius -- Setores e funcionários alocados (incluindo setores sem funcionários)
SELECT s.Nome, f.Nome
FROM Setor s LEFT JOIN
      Trabalha t ON s.ID_Setor = t.ID_Setor LEFT JOIN
      Funcionario f ON t.CPF_Func = f.CPF;

-- Consulta 4 -- vinicius -- Clientes que já fizeram reservas
SELECT DISTINCT c.*
FROM Cliente c
WHERE EXISTS (
    SELECT fr.ID_RES
    FROM Faz_Reserva fr 
    WHERE fr.CPF_Cli = c.CPF
);

-- Consulta 5 -- vinicius -- Clientes que nunca fizeram reservas
SELECT *
FROM Cliente c
WHERE NOT EXISTS (
    SELECT fr.ID_RES 
    FROM Faz_Reserva fr 
    WHERE fr.CPF_Cli = c.CPF
);
-- Consulta 6 -- vinicius -- Retorna o Faturamento total de Reservas
SELECT (SELECT SUM(Valor_Total) FROM Reserva) AS Total_Reservas 
FROM DUAL;

-- Consulta 7 -- vinicius --Detalhes do funcionário com maior salário
SELECT *
FROM Funcionario f
WHERE f.SALARIO = (
  SELECT MAX(f2.SALARIO)
  FROM Funcionario f2
);

-- Consulta 8 -- vinicius --Listar funcionários que trabalham em setores específicos, nesse caso, 1, 2 e 3
SELECT *
FROM Funcionario
WHERE CPF IN (
  SELECT CPF_Func 
  FROM Trabalha 
  WHERE ID_Setor IN (1, 2, 3)
);

-- Consulta 9 -- vinicius -- MINUS: Quartos que nunca foram reservados
SELECT ID_Quarto FROM Quarto
MINUS
SELECT ID_Quarto FROM Faz_Reserva;


--confusaosinha em faz_reserva, id_res pode se repetir desde que seja com outro id_quarto ou cnpj.
--porem id_res em reserva não pode se repetir, então vai estar se referindo sempre aos mesmos valores de atributos
