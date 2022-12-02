-- TODO 1.3a : Détruire les tables manquantes et modifier celles ci-dessous
DROP TABLE IF EXISTS Participe;
DROP TABLE IF EXISTS LesEpreuves;
DROP TABLE IF EXISTS LesSportifsEQ;
DROP TABLE IF EXISTS LesEquipes;
DROP TABLE IF EXISTS LesParticipants;
DROP TABLE IF EXISTS LesDisciplines;
-- TODO 3.3 : pensez à détruire vos triggers !
DROP TRIGGER EX-AEQUO ON Participe CASCADE;