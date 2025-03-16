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

--confusaosinha em faz_reserva, id_res pode se repetir desde que seja com outro id_quarto ou cnpj.
--porem id_res em reserva não pode se repetir, então vai estar se referindo sempre aos mesmos valores de atributos
