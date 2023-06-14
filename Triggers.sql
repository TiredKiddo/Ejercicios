CREATE TABLE tb_a (
    id         NUMBER(12),
    nombre_p   VARCHAR(50),
    tipo       VARCHAR(35),
    costo      NUMBER(10)
);

drop TABLE tb_a;

CREATE TABLE tb_b (
    descripcion VARCHAR(100),
    Fecha DATE
);

drop table tb_b;

INSERT INTO tb_a VALUES (
    001,
    'donitas',
    'pan',
    20
);

INSERT INTO tb_a VALUES (
    002,
    'rebanada',
    'pan',
    10
);

INSERT INTO tb_a VALUES (
    003,
    'mantecadas',
    'pan',
    25
);

INSERT INTO tb_a VALUES (
    004,
    'nito',
    'pan',
    15
);

INSERT INTO tb_a VALUES (
    005,
    'buñuelos',
    'pan',
    20
);

INSERT INTO tb_a VALUES (
    021,
    'doritos',
    'botana',
    15
);

INSERT INTO tb_a VALUES (
    022,
    'paketaxo',
    'botana',
    56
);

INSERT INTO tb_a VALUES (
    023,
    'Sabritas adobadas',
    'botana',
    35
);

INSERT INTO tb_a VALUES (
    024,
    'crujitos',
    'botana',
    15
);

INSERT INTO tb_a VALUES (
    025,
    'sabritones',
    'botana',
    50
);

INSERT INTO tb_a VALUES (
    051,
    'pulparindo',
    'dulce',
    8
);

INSERT INTO tb_a VALUES (
    052,
    'picafresa',
    'dulce',
    2
);

INSERT INTO tb_a VALUES (
    053,
    'mazapan',
    'dulce',
    8
);

INSERT INTO tb_a VALUES (
    054,
    'panditas',
    'dulce',
    18
);

INSERT INTO tb_a VALUES (
    055,
    'dragoncito',
    'dulce',
    3
);


SELECT * FROM tb_b;

--update tb_a set costo = 19 where nombre_p = 'Sabritas adobadas';

-------------------- Actualiza
/*create or replace trigger tr_actualizar_tiendita
after update
on tb_a
begin
 insert into tb_b values ('Se actualizado el dato');
end tr_actualizar_tiendita;


-----------------------Elimina
create or replace trigger tr_Elimina_tiendita 
after delete
on tb_a
begin 
 insert into tb_b values ('El registro ha sido borrado'); 
end tr_Elimina_tiendita;

DELETE FROM tb_a WHERE id = 053;
------------------ Inserta

create or replace trigger tr_Inserta_tiendita 
after insert
on tb_a
begin 
 insert into tb_b values ('El registro ha sido Insertado'); 
end tr_Inserta_tiendita;

INSERT INTO tb_a VALUES (053, 'Lechera','Dulce',35);


*/

-------------------------- ejercicio 1

create or replace trigger tr_acciones_tb_a
after insert or update or delete
on tb_a
for each row
declare
    descripcion varchar2(50);
begin
    if inserting then
        descripcion := 'Data insertada';
    elsif updating then
        descripcion := 'Data Actualizada';
    elsif deleting then
        descripcion := 'Data Eliminada';
    end if;
    
    insert into tb_b (descripcion, Fecha) values (descripcion, 'null');
end tr_acciones_tb_a;

drop trigger tr_acciones_tb_a;
-------------------------- ejercicio 2

Create or replace Trigger tr_insertar_fecha_tiendita
 after insert 
 on tb_a
 for each row
 declare 
 v_fecha_hora timestamp;
 begin
 IF SUBSTR(:new.nombre_p,1,1) = 'd' then  
    select systimestamp into v_fecha_hora from dual; 
    insert into tb_b 
    values ('se agregó un producto y que su nombre empieza con d’', v_fecha_hora );
    END IF;
 end tr_insertar_fecha_tiendita;
 
 drop trigger tr_insertar_fecha_tiendita;

 --------------------------- 3er ejercicio
 
 Create or replace Trigger tr_eliminar_producto_humilde
 after delete 
 on tb_a
 for each row
 declare 
 v_fecha_hora timestamp;
 begin
 IF (:OLD.costo <= 12) THEN
    select systimestamp into v_fecha_hora from dual; 
    INSERT INTO tb_b VALUES 
    ('se eliminó un producto humilde que quería comprar con lo que tenia de mi pasaje :,c',v_fecha_hora);
  END IF;
END tr_eliminar_producto_humilde;


drop trigger tr_eliminar_producto_humilde;

