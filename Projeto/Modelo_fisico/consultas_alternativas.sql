---1----
select c.nome, (select count(*) from Faz_Reserva fr where fr.CPF_Cli = c.cpf)
from Cliente c
where (select count(*) from Faz_Reserva fr where fr.CPF_Cli = c.cpf)>1

-----2-----
Select h.Nome as hotel , (select f.NOME from funcionario f where f.CPF = h.CPF_GERENTE)  as gerente
from hotel h
where h.CPF_GERENTE IN (
    select f.cpf
    from FUNCIONARIO f
    where f.cpf = h.CPF_GERENTE
)

--------3--------
SELECT DISTINCT 
    Q.ID_Quarto, 
    Q.CNPJ, 
    Q.Tipo, 
    Q.VALOR, 
    (SELECT QC.ID_COMODIDADE 
     FROM Quarto_Tem_Comodidade QC 
     WHERE QC.ID_Quarto = Q.ID_Quarto 
     LIMIT 1) AS ID_COMODIDADE
FROM Quarto Q
ORDER BY Q.ID_Quarto;

----4----
select distinct c.*
from cliente c
Inner join FAZ_RESERVA Fr
on fr.CPF_CLI = c.cpf 


