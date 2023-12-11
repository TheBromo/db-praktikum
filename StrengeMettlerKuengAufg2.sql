SET search_path TO StrengeMettlerKueng;

-- Aufgabe 2.1
SELECT SID, Vorname, Nachname
FROM Spieler S
WHERE NOT EXISTS (
    SELECT 1
    FROM StrengeMettlerKueng.Spielt ST
    WHERE ST.SID = S.SID
);

-- Aufgabe 2.2
SELECT SID, Vorname, Nachname AS Typ
FROM Spieler
UNION ALL
SELECT SID, Vorname, Nachname AS Typ
FROM Trainer;

-- Aufgabe 2.3
SELECT 
    S.SID, 
    S.Vorname, 
    S.Nachname,
    CASE 
        WHEN SUM(T.Abloese) >= 100000 THEN 'teuer'
        WHEN SUM(T.Abloese) < 100000 AND SUM(T.Abloese) >= 50000 THEN 'normal'
        ELSE 'billig'
    END AS Kategorie
FROM 
    Transfers T
JOIN 
    Spieler S ON T.SID = S.SID
WHERE 
    T.Transferdatum BETWEEN '2010-01-01' AND '2018-12-31'
GROUP BY 
    S.SID, S.Vorname, S.Nachname
HAVING 
    COUNT(T.TID) >= 2;
	
-- Aufgabe 2.4
CREATE OR REPLACE VIEW AverageSalary AS
SELECT 
    Position, 
    Sportart,
    AVG(Gehalt) AS Durchschnittsgehalt
FROM 
    Spieler
WHERE 
    Nachname LIKE 'S%' 
GROUP BY 
    Position, Sportart
HAVING 
    AVG(Gehalt) > 10000;
SELECT * FROM AverageSalary;

-- Aufgabe 2.5
WITH SpielerMannschaft AS (
    SELECT 
        S.SID,
        S.Vorname,
        S.Nachname,
        M.Name AS Mannschaftsname,
        M.MID
    FROM 
        Spieler S
    JOIN 
        Gehoertzu G ON S.SID = G.SID
    JOIN 
        Mannschaft M ON G.MID = M.MID
),
TrainerMannschaft AS (
    SELECT 
        T.SID,
        T.Vorname,
        T.Nachname,
        M.MID
    FROM 
        Trainer T
    JOIN 
        Trainiert Tr ON T.SID = Tr.SID
    JOIN 
        Mannschaft M ON Tr.MID = M.MID
)
SELECT 
    SM.Vorname AS SpielerVorname,
    SM.Nachname AS SpielerNachname,
    SM.Mannschaftsname,
    TM.Vorname AS TrainerVorname,
    TM.Nachname AS TrainerNachname
FROM 
    SpielerMannschaft SM
LEFT JOIN 
    TrainerMannschaft TM ON SM.MID = TM.MID;