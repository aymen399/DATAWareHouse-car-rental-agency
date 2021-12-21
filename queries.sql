 

----------------------------------Requête-1-
select t.annee,c.codecomp,m.codemodele,sum(ca)
from fsouscription f , dmodele m, dcompagnie c, dtemps t
where f.codecomp=c.codecomp
and f.codemodele=m.codemodele
and f.codetemps=t.codetemps
group by t.annee,c.codecomp,m.codemodele;



----------------------------------Requête-2-
select t.annee,c.codecomp,m.codemodele,sum(ca) as chiffre_affaire
from fsouscription f , dmodele m, dcompagnie c, dtemps t
where f.codecomp=c.codecomp
and f.codemodele=m.codemodele
and f.codetemps=t.codetemps
group by ROLLUP(t.annee,c.codecomp,m.codemodele);




----------------------------------Requête-3-
select t.annee,c.codecomp,m.codemodele,sum(ca) as chiffre_affaire
from fsouscription f , dmodele m, dcompagnie c, dtemps t
where f.codecomp=c.codecomp
and f.codemodele=m.codemodele
and f.codetemps=t.codetemps
group by CUBE(t.annee,c.codecomp,m.codemodele);


----------------------------------Requête-4-
select t.annee, c.codecomp,m.codemodele,sum(ca) as chiffre_affaire,
grouping(t.annee) as ann ,
grouping(c.codecomp) as comp
,grouping(m.codemodele) as modele
from fsouscription f , dmodele m, dcompagnie c,dtemps t
where f.codecomp=c.codecomp
and f.codemodele=m.codemodele
and f.codetemps=t.codetemps
group by ROLLUP(t.annee,c.codecomp,m.codemodele);




----------------------------------//5-Requête5

select t.annee, c.codecomp, m.codemodele, sum(ca) as chiffre_affaire,
grouping_id(t.annee,c.codecomp,m.codemodele) as sous_totale_id
from fsouscription f , dmodele m, dcompagnie c,dtemps t
where f.codecomp=c.codecomp
and f.codemodele=m.codemodele
and f.codetemps=t.codetemps
group by ROLLUP(t.annee,c.codecomp,m.codemodele);


---------------------------------------- pour afficher les lignes de du résultat dont gid > 1  ---------
select * from (select t.annee, c.codecomp, m.codemodele, sum(ca) as chiffre_affaire,
grouping_id(t.annee,c.codecomp,m.codemodele) as sous_totale_id
from fsouscription f , dmodele m, dcompagnie c,dtemps t
where f.codecomp=c.codecomp
and f.codemodele=m.codemodele
and f.codetemps=t.codetemps
group by ROLLUP(t.annee,c.codecomp,m.codemodele)) where sous_totale_id>1;

----------------------------------Requête-6-

select decode(grouping(t.annee),1,'sous_total_annee',t.annee) as ann,
decode(grouping(c.codecomp),1,'sous_total_comp',c.codecomp) as comp,
decode(grouping(m.codemodele),1,'sous_total_marque',m.codemodele) as marq 
, sum(ca) as chiffre_affaire
from fsouscription f , dmodele m, dcompagnie c,dtemps t
where f.codecomp=c.codecomp
and f.codemodele=m.codemodele
and f.codetemps=t.codetemps
group by ROLLUP(t.annee,c.codecomp,m.codemodele);



----------------------------------Requête-7.a- rank

select c.CODECOMP ,sum(CA) as chiffre_affaire,
rank() over (order by sum(CA)  desc) as classement_dense
from fsouscription f,dcompagnie c
where f.CODECOMP=c.CODECOMP
group by c.CODECOMP;



--------------------*----Requête-7.b-  Dense_rank
select c.CODECOMP ,sum(CA) as chiffre_affaire,
Dense_rank() over (order by sum(CA)  desc) as classement_non_dense
from fsouscription f,dcompagnie c
where f.CODECOMP=c.CODECOMP
group by c.CODECOMP;


------------------------------*----Requête-8-


select t.mois ,sum(CA) as chiffre_affaire,
avg(sum(CA)) over(order by t.mois rows 3 preceding)
from fsouscription f, dtemps t,dcompagnie c
where f.CODECOMP=c.CODECOMP
and f.CODETEMPS=t.CODETEMPS
and c.CODECOMP='6'
group by t.mois 
order by t.mois ;


--------------------Requête-9-
select c.CODECOMP,m.CODEMODELE, sum(CA)as somme ,
cume_dist() over(partition by f.CODECOMP order by sum(CA))as Cum_dist_ca
from fsouscription f , DMODELE m,DCOMPAGNIE c
where f.CODECOMP=c.CODECOMP
and f.CODEMODELE=m.CODEMODELE
group by c.CODECOMP,m.CODEMODELE
order by c.CODECOMP,m.CODEMODELE;	

 --------------------Requête-10-
select t.MOIS,sum(CA) as chiffre_affaire,
ntile(3) over(order by sum(CA)) as trimestre
from fsouscription f, dtemps t
where f.CODETEMPS=t.CODETEMPS
group by t.mois 
order by t.mois;
	 