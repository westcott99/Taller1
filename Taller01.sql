create database Restaurante;
use Restaurante;

create table Platos(
codigo varchar(5) not null primary key,
nombre varchar(30) not null
);

create table Menu(
CODPlato varchar(5) not null,
IDCategoria varchar(5) not null,
Precio float(4)
);

create table Categoria(
ID varchar(5) not null  primary key,
Nombre varchar(30) not null
);

insert into Platos() values("P0001","Pupusas");
insert into Platos() values("P0002","Pasteles");
insert into Platos() values("P0003","Yuca frita");
insert into Platos() values("P0004","Tamales");
insert into Platos() values("P0005","Empanadas");
insert into Platos() values("P0006","Canoas de platano");
insert into Platos() values("P0007","Riguas");
insert into Platos() values("P0008","Enchiladas");
insert into Platos() values("P0009","Panes con pollo");
insert into Platos() values("P0010","Elotes locos");
insert into Platos() values("P0011","Frozen de frutas");
insert into Platos() values("P0012","Chocolate");
insert into Platos() values("P0013","Nachos con queso");
insert into Platos() values("P0014","Helados de crema");
insert into Platos() values("P0015","Peras al chocolate");
insert into Platos() values("P0016","Frutilla con crema");
insert into Platos() values("P0017","Budin de platano");
select * from Platos;

insert into Categoria() values("C0001","Bebida");
insert into Categoria() values("C0002","Tipicos");
insert into Categoria() values("C0003","Entrada");
insert into Categoria() values("C0004","Postre");
select * from Categoria; 

insert into Menu() values("P0001","C0002",\N);
insert into Menu() values("P0002","C0002",0.35);
insert into Menu() values("P0003","C0002",1.50);
insert into Menu() values("P0004","C0002",0.75);
insert into Menu() values("P0005","C0002",0.50);
insert into Menu() values("P0006","C0002",1.00);
insert into Menu() values("P0007","C0002",1.25);
insert into Menu() values("P0008","C0002",0.40);
insert into Menu() values("P0009","C0002",3.50);
insert into Menu() values("P0010","C0002",1.00);
insert into Menu() values("P0011","C0001",2.00);
insert into Menu() values("P0013","C0003",3.00);
insert into Menu() values("P0015","C0004",1.25);
insert into Menu() values("P0017","C0004",1.50);
select * from Menu;

alter table platos add constraint fk_platosmenu foreign key (codigo) references menu(codplato);
alter table categoria add constraint fk_categoriamenu foreign key (id) references menu(idcategoria);
/* Ejercicios */
/* Obtener los nombres de todos los platos */
select nombre from platos;
/* Obtener todos los datos de las categorías de plato */
select * from platos;
/* Obtener el precio promedio de los platillos en el menu (dos decimales) */
select round(avg(precio),2) from menu;
/* Obtener el nombre de categoría del plato de comida “Nachos con queso” */
select categoria.nombre as 'Categoria', menu.codplato from categoria inner join menu on categoria.id = menu.idcategoria where menu.codplato="P0013";
/* Obtener los nombre de los platos pertenecientes a la categoría Típicos */
select platos.nombre, menu.idcategoria as 'tipicos' from platos inner join menu on platos.codigo = menu.codplato where menu.idcategoria="C0002";
/* Obtener el nombre del plato más caro de todo del menu */
select platos.nombre, menu.precio from platos inner join menu on platos.codigo = menu.codplato where menu.precio = (select max(precio) from menu);
/* Obtener el nombre de los 5 platos más caro del menú, mostrando el nombre de plato y el
nombre de la categoría a la que pertenece */
select platos.nombre, menu.precio, categoria.nombre as 'categoria' from menu inner join platos on menu.codplato = platos.codigo inner join categoria on menu.idcategoria = categoria.id
where menu.precio order by precio desc limit 5;
/* Nombre de las categorías y su cantidad de platos respectivos en el menú */
select categoria.nombre, menu.codplato from categoria left join menu on categoria.id = menu.idcategoria;
/* Nombre de platos que estén en el rango de precio de 1.00 a 3.00 */
select platos.nombre, menu.precio from platos inner join menu on platos.codigo = menu.codplato where menu.precio = (select * from menu where precio between 1 and 3);
/* Aumentar los precios en 0.10 de cada plato */
select precio+0.10 from menu;
/* Sustituir los datos del plato Pupusas por el nombre “Pupusa Loca” */
update platos set platos.nombre="Pupusa Loca" where platos.codigo="P0001";
/* Sustituir los datos del plato Tamales por el nombre “Tamal de Chipilin” */
update platos set platos.nombre="Tamal de Chipilin" where platos.codigo="P0004";
/* Hacer constar en la base de datos que la categoría Postre ya no tendrá ningún plato en
nuestro menú. (Aunque la categoría en si va a seguir en nuestra base de datos) */
