--3 creation de la vue
CREATE VIEW Tim_table AS 
SELECT DISTINCT C.codeCours, T.jourCoursDate  FROM Cours C
JOIN Typehoraire T
ON C.codeCours= T.crsCodeCours
JOIN Jourcours J
ON J.dateJourCours=T.jourCoursDate
JOIN Coursdeclasse cls
ON  T.crsCodeCours=cls.crsCodeCours
JOIN Classe Cl
ON cl.specialiteNomSpec=cls.classSpecialiteNomspec
WHERE T.jourCoursDate 
IN ('lundi','mardi','mercredi','jeudi','vendredi','samedi');
--4 script interactif pour enregistré le mot de passe d'un  etudiant

ALTER TABLE ETUDIANT
ADD Password VARCHAR(255);
UPDATE  ETUDIANT
SET Password = '001'||' '||INSTR('&&', '0', 2, 1)
WHERE  MATRICULE = &Maticule;
----le matricule genere est '001 0'

--5 emploi de temp d'un etudiant
SET MARKUP HTML ON SPOOL ON PREFORMAT OFF ENTMAP ON -
HEAD "<TITLE>Emploi DE TEMPS</TITLE> -
<STYLE type='text/css'> -
<!-- BODY {background: #ffffff} --> -
</STYLE>" –
 BODY "TEXT='#000000'" –
 TABLE "WIDTH='90%' BORDER='5'"
SPOOL TimeTable.html
SELECT DISTINCT C.codeCours Matieres, T.jourCoursDate Jours,C.VOLUMEH FROM Cours C
JOIN Typehoraire T
ON C.codeCours= T.crsCodeCours
JOIN Jourcours J
ON J.dateJourCours=T.jourCoursDate
JOIN Coursdeclasse cls
ON T.crsCodeCours=cls.crsCodeCours
JOIN Classe Cl
ON cl.specialiteNomSpec=cls.classSpecialiteNomspec
JOIN Etudiantdeclasse et 
on cls.crsCodeCours=et.COURCODECOURS
JOIN ETUDIANT pp 
ON pp.MATRICULE=et.ETUDIANTMATRICULE
WHERE  et.ETUDIANTMATRICULE=&Matricule AND PASSWORD=&Password;