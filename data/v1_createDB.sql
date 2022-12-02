-- TODO 1.3a : Créer les tables manquantes et modifier celles ci-dessous

CREATE TABLE Participants
(
  numPA NUMBER(4) NOT NULL,
  CONSTRAINT PA_PK PRIMARY KEY (numPA)
);

CREATE TABLE Equipes_base
(
  numPA NUMBER(4) NOT NULL,
  CONSTRAINT EQ_PK PRIMARY KEY (numPA),
  CONSTRAINT EQ_FK_PA FOREIGN KEY (numPA) REFERENCES Participants(numPA)
);

CREATE TABLE Sportifs_base
(
  numPA NUMBER(4) NOT NULL,
  nomSp VARCHAR2(20),
  prenomSp VARCHAR2(20),
  pays VARCHAR2(20),
  categorieSp VARCHAR2(10),
  dateNaisSp DATE,
  numEq NUMBER(4),
  CONSTRAINT SP_PK PRIMARY KEY (numPA),
  CONSTRAINT SP_FK_EQ FOREIGN KEY (numEq) REFERENCES Equipes_base(numPA),
  CONSTRAINT SP_FK_PA FOREIGN KEY (numPA) REFERENCES Participants(numPA),
  CONSTRAINT SP_CK1 CHECK(numPA > 0),
  CONSTRAINT SP_CK2 CHECK(categorieSp IN ('feminin','masculin')),
  CONSTRAINT SP_CK3 CHECK(numEq > 0)
);


CREATE TABLE Epreuves
(
  numEp NUMBER(4) NOT NULL,
  nomEp VARCHAR2(20),
  formeEp VARCHAR2(13),
  nomDi VARCHAR(25),
  categorieEp VARCHAR2(10),
  nbSportifsEp NUMBER(4),
  dateEp DATE,
  CONSTRAINT EP_PK PRIMARY KEY (numEp),
  CONSTRAINT EP_CK1 CHECK (formeEp IN ('individuelle','par equipe','par couple')),
  CONSTRAINT EP_CK2 CHECK (categorieEp IN ('feminin','masculin','mixte')),
  CONSTRAINT EP_CK3 CHECK (numEp > 0),
  CONSTRAINT EP_CK4 CHECK (nbSportifsEp > 0)
);

CREATE TABLE Inscriptions
(
  numPA NUMBER(4) NOT NULL,
  numEp NUMBER(4) NOT NULL,
  medaille VARCHAR2(25),
  CONSTRAINT DI_PK PRIMARY KEY (numPA, numEp),
  CONSTRAINT PAR_FK_PA FOREIGN KEY (numPA) REFERENCES Participants(numPA),
  CONSTRAINT PAR_FK_EP FOREIGN KEY (numEp) REFERENCES Epreuves(numEp),
  CONSTRAINT PAR_CK2 CHECK(medaille IN ('or','argent','bronze', 'null'))

);

-- TODO 1.4a : ajouter la définition de la vue LesAgesSportifs

CREATE VIEW Sportifs AS
SELECT numPa, nomSp, prenomSp, pays, categorieSp, dateNaisSp, numEq, cast(strftime('%Y.%m%d', 'now') - strftime('%Y.%m%d', dateNaisSp) as int) as age
FROM Sportifs_base;

-- TODO 1.5a : ajouter la définition de la vue LesNbsEquipiers

CREATE VIEW Equipes AS
SELECT numEq, count(*) as nbEquipiers
FROM Sportifs_base 
GROUP BY numEq;

-- TODO 3.3 : ajouter les éléments nécessaires pour créer le trigger (attention, syntaxe SQLite différent qu'Oracle)

