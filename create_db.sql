/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 11g                            */
/* Date de création :  11/7/2021(november) 10:06:46 AM                    */
/*==============================================================*/


alter table ASSURE
   drop constraint FK_ASSURE_HABITE_VILLE;

alter table CONTRAT
   drop constraint FK_CONTRAT_CONCERNE_ASSURE;

alter table CONTRAT
   drop constraint FK_CONTRAT_COUVRE_VEHICULE;

alter table CONTRAT
   drop constraint FK_CONTRAT_ETABLIE_COMPAGNI;

alter table METTRE_EN_JEU
   drop constraint FK_METTRE_E_METTRE_EN_GARANTIE;

alter table METTRE_EN_JEU
   drop constraint FK_METTRE_E_METTRE_EN_SINISTRE;

alter table MODELE
   drop constraint FK_MODELE_APPARTIEN_MARQUE;

alter table SINISTRE
   drop constraint FK_SINISTRE_ALIEU_VILLE;

alter table SINISTRE
   drop constraint FK_SINISTRE_RATTACHE__CONTRAT;

alter table SINISTRE
   drop constraint FK_SINISTRE_SUIVI_PAR_EXPERT;

alter table SOUSCRIRE
   drop constraint FK_SOUSCRIR_SOUSCRIRE_GARANTIE;

alter table SOUSCRIRE
   drop constraint FK_SOUSCRIR_SOUSCRIRE_CONTRAT;

alter table VEHICULE
   drop constraint FK_VEHICULE_APPARTIEN_MODELE;

alter table VEHICULE
   drop constraint FK_VEHICULE_EST_TYPE;

alter table VILLE
   drop constraint FK_VILLE_SETROUVE_WILAYA;

drop table ASSURE cascade constraints;

drop table COMPAGNIE cascade constraints;

drop table CONTRAT cascade constraints;

drop table EXPERT cascade constraints;

drop table GARANTIES cascade constraints;

drop table MARQUE cascade constraints;

drop table METTRE_EN_JEU cascade constraints;

drop table MODELE cascade constraints;

drop table SINISTRE cascade constraints;

drop table SOUSCRIRE cascade constraints;

drop table TYPE cascade constraints;

drop table VEHICULE cascade constraints;

drop table VILLE cascade constraints;

drop table WILAYA cascade constraints;

/*==============================================================*/
/* Table : ASSURE                                               */
/*==============================================================*/
create table ASSURE 
(
   NUMASS               INTEGER              not null,
   CODEVILLE            INTEGER              not null,
   NOMASS               VARCHAR2(20)         not null,
   TYPEASS              VARCHAR2(20)         not null,
   constraint PK_ASSURE primary key (NUMASS)
);

/*==============================================================*/
/* Table : COMPAGNIE                                            */
/*==============================================================*/
create table COMPAGNIE 
(
   CODECOMP             INTEGER              not null,
   NOMCOMP             VARCHAR2(30)         not null,
   TYPECOMP            VARCHAR2(15)         not null,
   constraint PK_COMPAGNIE primary key (CODECOMP)
);

/*==============================================================*/
/* Table : CONTRAT                                              */
/*==============================================================*/
create table CONTRAT 
(
   NUMPOLICE           INTEGER              not null,
   NUMASS               INTEGER              not null,
   CODECOMP             INTEGER              not null,
   MATRICULE           VARCHAR2(10)         not null,
   DATESOUSCRIPTION    DATE                 not null,
   MONTANT              FLOAT                not null,
   constraint PK_CONTRAT primary key (NUMPOLICE)
);

/*==============================================================*/
/* Table : EXPERT                                               */
/*==============================================================*/
create table EXPERT 
(
   CODEEXP             INTEGER              not null,
   NOMEXP              VARCHAR2(30)         not null,
   ADRESSEEXP          VARCHAR2(30)         not null,
   TELEXP              VARCHAR2(14)         not null,
   constraint PK_EXPERT primary key (CODEEXP)
);

/*==============================================================*/
/* Table : GARANTIES                                            */
/*==============================================================*/
create table GARANTIES 
(
   CODEGAR             INTEGER              not null,
   LIBELLEGAR           VARCHAR2(30)         not null,
   MONTANTPLAFOND       INTEGER              not null,
   constraint PK_GARANTIES primary key (CODEGAR)
);

/*==============================================================*/
/* Table : MARQUE                                               */
/*==============================================================*/
create table MARQUE 
(
   CODEMARQUE           INTEGER              not null,
   LIBELIEMARQUE       VARCHAR2(20)         not null,
   NATIONALITE          VARCHAR2(20)         not null,
   constraint PK_MARQUE primary key (CODEMARQUE)
);

/*==============================================================*/
/* Table : METTRE_EN_JEU                                        */
/*==============================================================*/
create table METTRE_EN_JEU 
(
   CODESINISTRE         INTEGER              not null,
   CODEGAR             INTEGER              not null,
   constraint PK_METTRE_EN_JEU primary key (CODESINISTRE, CODEGAR)
);

/*==============================================================*/
/* Table : MODELE                                               */
/*==============================================================*/
create table MODELE 
(
   CODEMODELE           INTEGER              not null,
   CODEMARQUE           INTEGER              not null,
   LIBELLEMODEL        VARCHAR2(30),
   constraint PK_MODELE primary key (CODEMODELE)
);

/*==============================================================*/
/* Table : SINISTRE                                             */
/*==============================================================*/
create table SINISTRE 
(
   CODESINISTRE         INTEGER              not null,
   CODEEXP             INTEGER              not null,
   CODEVILLE            INTEGER              not null,
   NUMPOLICE           INTEGER              not null,
   DATESINISTRE         DATE                 not null,
   RUE                 VARCHAR2(20)         not null,
   ETATDOSSIER         VARCHAR2(10)         not null,
   constraint PK_SINISTRE primary key (CODESINISTRE)
);

/*==============================================================*/
/* Table : SOUSCRIRE                                            */
/*==============================================================*/
create table SOUSCRIRE 
(
   NUMPOLICE           INTEGER              not null,
   CODEGAR             INTEGER              not null,
   constraint PK_SOUSCRIRE primary key (NUMPOLICE, CODEGAR)
);

/*==============================================================*/
/* Table : TYPE                                                 */
/*==============================================================*/
create table TYPE 
(
   CODETYPE             INTEGER              not null,
   LIBELLETYPE          VARCHAR2(30)         not null,
   constraint PK_TYPE primary key (CODETYPE)
);

/*==============================================================*/
/* Table : VEHICULE                                             */
/*==============================================================*/
create table VEHICULE 
(
   MATRICULE           VARCHAR2(10)         not null,
   CODETYPE             INTEGER              not null,
   CODEMODELE           INTEGER              not null,
   COULEUR             VARCHAR2(10),
   constraint PK_VEHICULE primary key (MATRICULE)
);

/*==============================================================*/
/* Table : VILLE                                                */
/*==============================================================*/
create table VILLE 
(
   CODEVILLE            INTEGER              not null,
   CODEWILAYA           INTEGER              not null,
   NOMVILLE             VARCHAR2(30)         not null,
   constraint PK_VILLE primary key (CODEVILLE)
);

/*==============================================================*/
/* Table : WILAYA                                               */
/*==============================================================*/
create table WILAYA 
(
   CODEWILAYA           INTEGER              not null,
   NOMWILAYA            VARCHAR2(30)         not null,
   constraint PK_WILAYA primary key (CODEWILAYA)
);

alter table ASSURE
   add constraint FK_ASSURE_HABITE_VILLE foreign key (CODEVILLE)
      references VILLE (CODEVILLE);

alter table CONTRAT
   add constraint FK_CONTRAT_CONCERNE_ASSURE foreign key (NUMASS)
      references ASSURE (NUMASS);

alter table CONTRAT
   add constraint FK_CONTRAT_COUVRE_VEHICULE foreign key (MATRICULE)
      references VEHICULE (MATRICULE);

alter table CONTRAT
   add constraint FK_CONTRAT_ETABLIE_COMPAGNI foreign key (CODECOMP)
      references COMPAGNIE (CODECOMP);

alter table METTRE_EN_JEU
   add constraint FK_METTRE_E_METTRE_EN_GARANTIE foreign key (CODEGAR)
      references GARANTIES (CODEGAR);

alter table METTRE_EN_JEU
   add constraint FK_METTRE_E_METTRE_EN_SINISTRE foreign key (CODESINISTRE)
      references SINISTRE (CODESINISTRE);

alter table MODELE
   add constraint FK_MODELE_APPARTIEN_MARQUE foreign key (CODEMARQUE)
      references MARQUE (CODEMARQUE);

alter table SINISTRE
   add constraint FK_SINISTRE_ALIEU_VILLE foreign key (CODEVILLE)
      references VILLE (CODEVILLE);

alter table SINISTRE
   add constraint FK_SINISTRE_RATTACHE__CONTRAT foreign key (NUMPOLICE)
      references CONTRAT (NUMPOLICE);

alter table SINISTRE
   add constraint FK_SINISTRE_SUIVI_PAR_EXPERT foreign key (CODEEXP)
      references EXPERT (CODEEXP);

alter table SOUSCRIRE
   add constraint FK_SOUSCRIR_SOUSCRIRE_GARANTIE foreign key (CODEGAR)
      references GARANTIES (CODEGAR);

alter table SOUSCRIRE
   add constraint FK_SOUSCRIR_SOUSCRIRE_CONTRAT foreign key (NUMPOLICE)
      references CONTRAT (NUMPOLICE);

alter table VEHICULE
   add constraint FK_VEHICULE_APPARTIEN_MODELE foreign key (CODEMODELE)
      references MODELE (CODEMODELE);

alter table VEHICULE
   add constraint FK_VEHICULE_EST_TYPE foreign key (CODETYPE)
      references TYPE (CODETYPE);

alter table VILLE
   add constraint FK_VILLE_SETROUVE_WILAYA foreign key (CODEWILAYA)
      references WILAYA (CODEWILAYA);

