--------------------1- R1
select sum(CA) as chiffre_affaire, count(NBCONTRAT) as nombre_des_contrats 
from FSOUSCRIPTION fs
where  fs.NUMASS In (select NUMASS from DAssure where nomville = 'Alger')
and fs.codemodele In (select codemodele from DModele where libellemodel = 'duster' )


--------------------2- create a meterialized view to accelerate the afromentioned query 
CREATE MATERIALIZED VIEW VMCA
   BUILD IMMEDIATE
   REFRESH COMPLETE
   AS SELECT da.codeville as codeville, da.nomville as nomville, dm.codemodele as codemodele, dm.libellemodel as libellemodel, fs.CA as ca, fs.NBCONTRAT as NBCONTRAT
      FROM FSOUSCRIPTION fs, DModele dm, DAssure da
      WHERE fs.codemodele = dm.codemodele and fs.codeville = da.codeville
      GROUP BY da.codeville , da.nomville, dm.codemodele , dm.libellemodel 

--------------------3- R1 query on the view
SELECT CA, NBCONTRAT FROM VMCA 
WHERE libellemodel = 'LHJNMWLI  ' and nomville = 'Alger'


--------------------4- create a view of the turnover (ca: chiifre d'affaire in frnech) over each three months
CREATE MATERIALIZED VIEW VMCATrimestriel
   BUILD IMMEDIATE
   REFRESH COMPLETE
   AS SELECT dt.TRIMESTER, fs.CA
      FROM FSOUSCRIPTION fs, Dtemps dt
      where fs.codetemps = dt.codetemps

--------------------5- R2: a second quey 
SELECT dt.annee, sum(CA) as ca from FSOUSCRIPTION fs, DTemps dt
where fs.codetemps = dt.codetemps
group by dt.annee
------ la vue est non exploitée dans R2, car elle ne possède pas l'infromation sur l'annee

--------------------6- the dimensions hierarchie:
CREATE DIMENSION DimAssur 
   LEVEL assure   IS (DAssure.NUMASS)
   LEVEL ville       IS (DAssure.codeville) 
   LEVEL wilaya      IS (DAssure.codewilaya) 
   HIERARCHY geog_rollup (
      assure      CHILD OF
      ville          CHILD OF 
      wilaya  

-- dtemps dimension hierarchy

CREATE DIMENSION dtemps
LEVEL niv1 IS (DTemps.mois)
LEVEL niv2 IS (DTemps.trimestre)
LEVEL niv3 IS (DTemps.annee)
HIERARCHY temps ( niv1 CHILD OF niv2 CHILD OF niv3 )
ATTRIBUTE niv1 DETERMINES (DTemps.libmois);


-- dmodele dimension hierarchy

CREATE DIMENSION dmodele
LEVEL niv1 IS (dmodele.CODEMODELE)
LEVEL niv2 IS (dmodele.CODEMARQUE)
LEVEL niv3 IS (dmodele.NATIONALITE)
HIERARCHY temps ( niv1 CHILD OF niv2 CHILD OF niv3 )
ATTRIBUTE niv1 DETERMINES (dmodele.LIBELLEMOD)
ATTRIBUTE niv2 DETERMINES (dmodele.LIBELLEMARQUE) ;


--------------------9- create a view of the turnover (ca: chiifre d'affaire in frnech) of each cars brand (marque)
CREATE MATERIALIZED VIEW VMCAMarque
 BUILD IMMEDIATE
 REFRESH COMPLETE
 ON COMMIT
 AS
 select m.LIBELLEMARQUE,m.CODEMARQUE, sum(ca)
 from fsouscription f , dmodele m
 where f.codemodele = m.codemodele
 group by (m.LIBELLEMARQUE,m.CODEMARQUE) ;   

---------------------- the third query R3: 
select m.NATIONALITE, sum(ca)
 from fsouscription f , dmodele m
 where f.codemodele = m.codemodele
 group by (m.NATIONALITE) ;