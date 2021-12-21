create table DAssure
 (
 	NumASS integer not null,
 	NomAss varchar2(20) not null,
 	TypeAss varchar2(20) not null,
 	CODEVILLE integer not null, 
 	NomVille varchar2(30) not null,
 	CODEWILAYA integer not null,
 	NomWilaya varchar2(30) not null,
 	foreign key (CODEVILLE) references VILLE (CODEVILLE),
 	foreign key (CODEWILAYA) references WILAYA (CODEWILAYA),
 	foreign key (NumASS) references ASSURE (NumASS),
 	primary key (NumASS)
 	
);	

 create table DModele
 (
 	CODEMODELE integer not null, 
 	LIBELLEMODEL varchar2(30) not null, 
 	CODEMARQUE integer not null, 
 	LIBELLEMARQUE VARCHAR2(20) not null, 
	NATIONALITE VARCHAR2(20) not null,
	foreign key (CODEMARQUE) references MARQUE (CODEMARQUE),
 	foreign key (CODEMODELE) references MODELE (CODEMODELE),
 	primary key (CODEMODELE)

 );

 CREATE TABLE DType 
 (
 	CODETYPE INTEGER not null,
	LIBELLETYPE VARCHAR2(30) not null,
	foreign key (CODETYPE) references TYPE (CODETYPE),
 	primary key (CODETYPE)

 );


 CREATE TABLE DCompagnie 
 (
 	CODECOMP INTEGER not null,
	NOMCOMP VARCHAR2(30) not null,
	TYPECOMP VARCHAR2(15) not null, 
	foreign key (CODECOMP) references COMPAGNIE (CODECOMP),
 	primary key (CODECOMP)

 )


  CREATE TABLE DTemps 
 (
 	CODETEMPS INTEGER not null,
	MOIS INTEGER not null,
	LibMois VARCHAR2(15) not null,
	Trimester INTEGER not null,
	Annee INTEGER not null,
 	primary key (CODETEMPS)

 )

create table FSouscription
 (
 	NumASS integer not null,
 	CODEMODELE integer not null,
 	CodeType integer not null,
 	CodeComp integer not null, 
 	CODETEMPS integer not null,
 	Nbcontrat integer not null,
 	CA        float not null,
 	foreign key (CODEMODELE) references DMODELE (CODEMODELE),
 	foreign key (CodeType) references Dtype(CODETYPE),
 	foreign key (NumASS) references DASSURE (NumASS),
 	foreign key (CODECOMP) references DCOMPAGNIE(CODECOMP),
 	foreign key (CodeTemps) references Dtemps (CODETEMPS),
 	primary key (NumASS,CodeModele,CodeType,CodeComp,CodeTemps)

);
