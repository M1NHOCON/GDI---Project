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
SELECT F.nome, F.salario, (select AVG(D.SALARIO) from FUNCIONARIO d)
from FUNCIONARIO F
where F.salario >(
    select avg(salario)
    from FUNCIONARIO
)
