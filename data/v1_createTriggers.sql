-- TODO 3.3 Créer un trigger pertinent
CREATE trigger if not exists EXAEQUO 
AFTER UPDATE OF medaille 
ON Inscriptions WHEN EXISTS
    (SELECT I1.numPA
    FROM Inscriptions I1 JOIN Inscriptions I2 ON 
     (I1.numPA=I2.numPA AND I1.medaille=I2.medaille and I1.numEp=I2.numEp and I1.medaille<>NULL))
BEGIN
SELECT RAISE (ABORT, "Il ne peux pas y avoir d'exa-equo");
END;