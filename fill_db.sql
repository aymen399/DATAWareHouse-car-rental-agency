-- trunc: used to formate the data on a specific format : ex formating dates on jj/mm/yy
-- floor: return the integer part of a number

--modele:

DECLARE
	m char (30); l number; i number;
BEGIN
for i in 1..200 LOOP	
	SELECT dbms_random.string('U', 30) into m from dual;
    SELECT floor(dbms_random.value(1, 20)) into l from dual;
    INSERT into modele VALUES(i, l, m);
end loop;
 COMMIT;
END;
/                 


--contrat:

declare 
d date; mat number; c number; m number; a number;

begin
for i in 1..800000 loop
	select to_date(trunc(dbms_random.value(to_char(date '2015-01-01', 'j'),
	to_char(date '2017-12-31', 'j'))), 'j') into d from dual;
	select trunc (dbms_random.value (5000, 100000), 2) into m from dual;
	select floor (dbms_random.value (1, 40000)) into mat from dual;
	select floor (dbms_random.value(1, 200000)) into a from dual;
	select floor (dbms_random.value(1, 20)) into c from dual;
	insert into contrat values (i, a, c, mat, d, m);
		
end loop;
COMMIT;
end;
/


--type:

DECLARE
lib char(20);

begin
for i in 1..2 loop
	select dbms_random.string('U', 20) into lib from dual;
	INSERT into type VALUES (i, lib);
end loop;
COMMIT;
END;
/


-- marque:

declare
lib char(20); nationnalite char(20); 

BEGIN
for i in 1..20 loop
	select dbms_random.string('U', 20) into lib from dual;
	select dbms_random.string('U', 20) into nationnalite from dual;
	INSERT into marque VALUES (i, lib, nationnalite);
END loop;
COMMIT;
end;
/


-- vehicule:

DECLARE
codeT number; codeM number; couleur char(10);

BEGIN
for i in 1..40000 loop 
	select dbms_random.value(1, 2) into codeT from dual;
	select dbms_random.value(1, 200) into codeM from dual;
	select dbms_random.string('U', 10) into couleur from dual;
	INSERT into vehicule VALUES(i, codeT, codeM, couleur);
END loop;
COMMIT;
END;
/

-- assuré: 

DECLARE 
codeV number; nom char(20); typeAss char(20);

BEGIN
for i in 1..200000 loop
	select floor(dbms_random.value(1, 400)) into codeV from dual;
	select dbms_random.string('U', 20) into nom from dual;
	select dbms_random.string('U', 20) into typeAss from dual;
	INSERT into assure VALUES(i, codeV, nom, typeAss);
END loop;
COMMIT;
END;
/

-- wilaya:++

DECLARE
nom char(30);

BEGIN
for i in 1..48 loop
	select dbms_random.string('U', 30) into nom from dual;
	INSERT into wilaya VALUES(i, nom);
END loop;
COMMIT;
END;
/


-- ville:++

DECLARE
nom char(30); codeW number;

BEGIN
for i in 1..400 loop
	select dbms_random.string('U', 30) into nom from dual;
	select dbms_random.value(1, 48) into codeW from dual;
	INSERT into ville VALUES(i, codeW, nom);
END loop;
COMMIT;
END;
/

-- compagnie:

DECLARE
nom char(30); typeC char(15);

BEGIN
for i in 1..20 loop 
	select dbms_random.string('U', 30) into nom from dual;
	select dbms_random.string('U', 15) into typeC from dual;
	INSERT into compagnie VALUES(i, nom, typeC);
END loop;
COMMIT;
END;
/