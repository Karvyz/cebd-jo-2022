-- TODO 3.3 Créer un trigger pertinent
CREATE trigger if not exists EX-AEQUO 
AFTER UPDATE OF medaille 
ON Participe WHEN EXISTS
    (SELECT P1.numPA;
    FROM Participe P1 JOIN Participe P2 ON 
    (P1.numpPA=P2.numPA AND P1.medaille=P2.medaille and P1.numEP=P2.numEP and P1.medaille<>NULL)
BEGIN
SELECT RAISE (ABORT, "Il ne peux pas y avoir d'exa-equo");
END;