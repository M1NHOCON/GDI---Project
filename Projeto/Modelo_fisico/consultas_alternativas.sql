---1----
select c.nome, (select count(*) from Faz_Reserva fr where fr.CPF_Cli = c.cpf)
from Cliente c
where (select count(*) from Faz_Reserva fr where fr.CPF_Cli = c.cpf)>1

