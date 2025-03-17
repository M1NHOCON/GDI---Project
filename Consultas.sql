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



--confusaosinha em faz_reserva, id_res pode se repetir desde que seja com outro id_quarto ou cnpj.
--porem id_res em reserva não pode se repetir, então vai estar se referindo sempre aos mesmos valores de atributos
