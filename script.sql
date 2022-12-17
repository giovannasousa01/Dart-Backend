select * from usuarios;

insert into usuarios(nome, email, password) values ('Giovanna Sousa', 'giovanna@gmail.com', 'sorvete004');
insert into usuarios(nome, email, password) values ('Daniel Jimenez', 'daniel@gmail.com', 'lua0812');
insert into usuarios(nome, email, password) values ('Maria Vidigal', 'maria@gmail.com', 'gaucha01');
insert into usuarios(nome, email, password) values ('Nicolas Abreu', 'nicolas@gmail.com', 'pokemon');


insert into noticias(titulo, descricao, id_usuario) values ('Inacreditável', 'Namorado de 18 anos se recusa a comprar chocolate para sua namorada na tpm', 1);

select 
	n.titulo as 'Titulo',
    n.descricao as 'Descrição',
    u.nome as 'Autor'
from noticias n 
inner join usuarios u on u.id = n.id_usuario;


    