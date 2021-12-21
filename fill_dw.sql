-- DAssure:
BEGIN
FOR i IN
(SELECT NumAss, NomAss, TypeAss, v.CODEVILLE, NomVille, w.CODEWILAYA, NomWilaya
 FROM Assure a, VILLE v, WILAYA w
  WHERE a.CodeVille = v.CodeVille and v.CodeWilaya = w.CodeWilaya) LOOP
	INSERT INTO DAssure VALUES (i.NumAss, i.NomAss, i.TypeAss, i.CodeVille, i.NomVille, i.CodeWilaya, i.NomWilaya) ;
END LOOP ;
COMMIT ;
END ;
/

-- create a sequence: 
CREATE SEQUENCE seq
MINVALUE 1
MAXVALUE 800000
START WITH 1
INCREMENT BY 1 ;

CREATE SEQUENCE seq2
MINVALUE 1
MAXVALUE 800000
START WITH 1
INCREMENT BY 1 ;

CREATE SEQUENCE seq3
MINVALUE 1
MAXVALUE 2000000
START WITH 1
INCREMENT BY 1 ;

-- DModele: 
BEGIN
FOR i IN
(SELECT codemodele, LIBELLEMODEL, mar.codemarque, LIBELIEMARQUE, nationalite
 FROM modele mod, marque mar
  WHERE mod.codemarque = mar.codemarque) LOOP
	INSERT INTO DModele VALUES (i.codemodele, i.LIBELLEMODEL, i.codemarque, i.LIBELIEMARQUE, i.nationalite) ;
END LOOP ;
COMMIT ;
END ;
/


-- DType:
BEGIN
FOR i IN
(SELECT codetype, LIBELLETYPE
 FROM type) LOOP
	INSERT INTO DType VALUES (i.codetype, i.LIBELLETYPE) ;
END LOOP ;
COMMIT ;
END ;
/


-- Dcompagnie:
BEGIN
FOR i IN
(SELECT CODECOMP, NOMCOMP, TYPECOMP
 FROM compagnie) LOOP
	INSERT INTO Dcompagnie VALUES (i.CODECOMP, i.NOMCOMP, i.TYPECOMP) ;
END LOOP ;
COMMIT ;
END ;
/


-- fill Dtemps and Fsouscription
declare
Var number;
BEGIN
FOR i IN
(SELECT count(CONTRAT.NUMPOLICE) AS NB,sum(CONTRAT.MONTANT) as ca,ASSURE.NUMASS,MODELE.CODEMODELE,TYPE.CODETYPE,COMPAGNIE.CODECOMP,CONTRAT.DATESOUSCRIPTION
FROM	ASSURE, CONTRAT , COMPAGNIE ,VEHICULE ,TYPE , MODELE
	WHERE    ASSURE.NUMASS = CONTRAT.NUMASS
		AND    COMPAGNIE.CODECOMP = CONTRAT.CODECOMP
		AND    VEHICULE.MATRICULE = CONTRAT.MATRICULE 
		AND     TYPE.CODETYPE = VEHICULE.CODETYPE
		AND     MODELE.CODEMODELE = VEHICULE.CODEMODELE
GROUP BY ASSURE.NUMASS,MODELE.CODEMODELE,TYPE.CODETYPE,COMPAGNIE.CODECOMP,CONTRAT.DATESOUSCRIPTION) LOOP
	Var := seq3.nextval;
	INSERT INTO DTemps VALUES (var, to_char(to_date(i.datesouscription, 'MM-DD-YYYY'), 'MM'),
									 to_char(to_date(i.datesouscription, 'MM-DD-YYYY'), 'MONTH'),
									 to_char(to_date(i.datesouscription, 'MM-DD-YYYY'), 'Q'),
									 to_char(to_date(i.datesouscription, 'MM-DD-YYYY'), 'YYYY')) ;
	INSERT INTO FSOUSCRIPTION VALUES (i.NUMASS,i.CODEMODELE,i.CODETYPE,i.CODECOMP,Var,i.NB,i.ca);
END LOOP ;
COMMIT ;
END ;
