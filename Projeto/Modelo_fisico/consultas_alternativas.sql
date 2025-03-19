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
