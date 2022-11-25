-- TODO 1.3a : Créer les tables manquantes et modifier celles ci-dessous

CREATE TABLE LesDisciplines
(
  numDi NUMBER(4),
  nomDi VARCHAR2(25),
  CONSTRAINT DI_PK PRIMARY KEY (numDi)
);

CREATE TABLE LesParticipants
(
  numPA NUMBER(4),
  CONSTRAINT PA_PK PRIMARY KEY (numPA)
);

CREATE TABLE LesEquipes
(
  numPA NUMBER(4),
  CONSTRAINT EQ_PK PRIMARY KEY (numPA),
  CONSTRAINT EQ_FK_PA FOREIGN KEY (numPA) REFERENCES LesParticipants(numPA)
);

CREATE TABLE LesSportifsEQ
(
  numPA NUMBER(4),
  nomSp VARCHAR2(20),
  prenomSp VARCHAR2(20),
  pays VARCHAR2(20),
  categorieSp VARCHAR2(10),
  dateNaisSp DATE,
  numEq NUMBER(4),
  CONSTRAINT SP_PK PRIMARY KEY (numPA),
  CONSTRAINT SP_FK_EQ FOREIGN KEY (numEq) REFERENCES LesEquipes(numPA),
  CONSTRAINT SP_FK_PA FOREIGN KEY (numPA) REFERENCES LesParticipants(numPA),
  CONSTRAINT SP_CK1 CHECK(numPA > 0),
  CONSTRAINT SP_CK2 CHECK(categorieSp IN ('feminin','masculin')),
  CONSTRAINT SP_CK3 CHECK(numEq > 0)
);


CREATE TABLE LesEpreuves
(
  numEp NUMBER(4),
  nomEp VARCHAR2(20),
  formeEp VARCHAR2(13),
  numDi NUMBER(4),
  categorieEp VARCHAR2(10),
  nbSportifsEp NUMBER(4),
  dateEp DATE,
  CONSTRAINT EP_PK PRIMARY KEY (numEp),
  CONSTRAINT EP_FK_DI FOREIGN KEY (numDI) REFERENCES LesDisciplines(numDI),
  CONSTRAINT EP_CK1 CHECK (formeEp IN ('individuelle','par equipe','par couple')),
  CONSTRAINT EP_CK2 CHECK (categorieEp IN ('feminin','masculin','mixte')),
  CONSTRAINT EP_CK3 CHECK (numEp > 0),
  CONSTRAINT EP_CK4 CHECK (nbSportifsEp > 0)
);

CREATE TABLE Participe
(
  numPA NUMBER(4),
  numEp NUMBER(4),
  medaille VARCHAR2(25),
  CONSTRAINT DI_PK PRIMARY KEY (numPA, numEp),
  CONSTRAINT PAR_FK_PA FOREIGN KEY (numPA) REFERENCES LesParticipants(numPA),
  CONSTRAINT PAR_FK_EP FOREIGN KEY (numEp) REFERENCES LesEpreuves(numEp),
  CONSTRAINT PAR_CK2 CHECK(medaille IN ('or','argent','bronze'))

);


-- TODO 1.4a : ajouter la définition de la vue LesAgesSportifs
-- TODO 1.5a : ajouter la définition de la vue LesNbsEquipiers
-- TODO 3.3 : ajouter les éléments nécessaires pour créer le trigger (attention, syntaxe SQLite différent qu'Oracle)

