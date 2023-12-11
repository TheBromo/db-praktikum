-- ----------------------------------------------------------------------
-- Manuel Strenge, Micha Mettler, Pascal Küng
-- ----------------------------------------------------------------------

DROP SCHEMA IF EXISTS  StrengeMettlerKueng CASCADE;
CREATE SCHEMA IF NOT EXISTS StrengeMettlerKueng;
SET search_path TO StrengeMettlerKueng;


-- ----------------------------------------------------------------------
-- Table creation
-- ----------------------------------------------------------------------

-- Sportler Table
CREATE TABLE Sportler (
    SID INT PRIMARY KEY,
    Vorname VARCHAR(50) NOT NULL,
    Nachname VARCHAR(50)NOT NULL,
    Geburtsdatum DATE NOT NULL
);

-- Spieler Table
CREATE TABLE Spieler (
    Sportart VARCHAR(50) NOT NULL,
    Position VARCHAR(50) NOT NULL,
    Gehalt INT NOT NULL
) INHERITS(Sportler);

-- Trainer Table 
CREATE TABLE Trainer (
    Lizenz VARCHAR(50) NOT NULL,
    Lizenzjahr INT NOT NULL CHECK (Lizenzjahr >= 1000 AND Lizenzjahr <= 9999)
)      INHERITS(Sportler);

-- Spiel Table
CREATE TABLE Spiel (
    SPID INT PRIMARY KEY,
    Ort VARCHAR(50) NOT NULL,
    Dauer INT NOT NULL CHECK (Dauer >= 0 AND Dauer <= 999),
    Datum DATE NOT NULL
);

-- Mannschaft Table
CREATE TABLE Mannschaft (
    MID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Gruendungsjahr INT NOT NULL CHECK (Gruendungsjahr >= 1000 AND Gruendungsjahr <= 9999)
);

-- Transfers Table 
CREATE TABLE Transfers (
    TID INT PRIMARY KEY,
    SID INT NOT NULL,
    Von INT NOT NULL, --TODO muss vorkommen in Manschaftstabelle
    Zu INT NOT NULL, --TODO muss vorkommen in Manschaftstabelle
    Transferdatum DATE NOT NULL,
    Abloese INT NOT NULL,
    FOREIGN KEY (Von) REFERENCES Mannschaft(MID),-- ist das korrekt so keine Ahnung :(
    FOREIGN KEY (Zu) REFERENCES Mannschaft(MID),
    FOREIGN KEY (SID) REFERENCES Sportler(SID)
);

-- Trainiert Table
CREATE TABLE Trainiert (
    SID INT NOT NULL,
    MID INT NOT NULL,
    Gehalt INT NOT NULL,
    PRIMARY KEY (SID, MID),
    FOREIGN KEY (SID) REFERENCES Sportler(SID),
    FOREIGN KEY (MID) REFERENCES Mannschaft(MID)
);

-- Gehoertzu Table
CREATE TABLE Gehoertzu (
    SID INT NOT NULL,
    MID INT NOT NULL ,
    Verletzt BOOLEAN NOT NULL,
    PRIMARY KEY (SID, MID),
    FOREIGN KEY (SID) REFERENCES Sportler(SID),
    FOREIGN KEY (MID) REFERENCES Mannschaft(MID)
);

-- Spielt Table
CREATE TABLE Spielt (
    SID INT NOT NULL,
    SPID INT NOT NULL,
    PRIMARY KEY (SID, SPID),
    FOREIGN KEY (SID) REFERENCES Sportler(SID),
    FOREIGN KEY (SPID) REFERENCES Spiel(SPID)
);

-- ----------------------------------------------------------------------
-- Testdaten 
-- ----------------------------------------------------------------------
-- ----------------------------------------------------------------------
-- Manuel Strenge, Micha Mettler, Pascal Küng
-- ----------------------------------------------------------------------

-- Sportler Table
INSERT INTO Sportler (SID, Vorname, Nachname, Geburtsdatum)
VALUES (1, 'John', 'Doe', '1990-01-01'),
       (2, 'Jane', 'Smith', '1995-05-10'),
       (3, 'Michael', 'Johnson', '1988-09-15'),
       (4, 'Emily', 'Brown', '1992-03-20'),
       (5, 'David', 'Wilson', '1997-07-25');

-- Spieler Table
INSERT INTO Spieler (SID, Vorname, Nachname, Geburtsdatum, Sportart, Position, Gehalt)
VALUES (1,'Amber', 'Smith', '1966-04-26', 'Football', 'Quarterback', 1000000),
       (2,'Denise', 'Brennan', '1950-02-06', 'Basketball', 'Point Guard', 500000),
       (3,'John', 'Parker', '1992-12-06', 'Soccer', 'Forward', 800000),
       (4,'Larry', 'Ramos', '1966-08-31', 'Baseball', 'Pitcher', 700000),
       (5,'Teresa', 'Williams', '1968-05-06', 'Tennis', 'Singles', 300000);

-- Trainer Table
INSERT INTO Trainer (SID, Vorname, Nachname, Geburtsdatum,Lizenz, Lizenzjahr)
VALUES (6,'Tamara', 'Wood', '1996-05-30', 'Football Coach', 2010),
       (7,'Erin', 'Jones', '1958-07-30', 'Basketball Coach', 2015),
       (8,'Tammy', 'Phillips', '1968-08-08', 'Soccer Coach', 2005),
       (9,'Robin', 'Jackson', '1996-06-07', 'Baseball Coach', 2008),
       (10,'Craig', 'Thomas', '1973-07-05', 'Tennis Coach', 2012);

-- Spiel Table
INSERT INTO Spiel (SPID, Ort, Dauer, Datum)
VALUES (1, 'Stadium A', 120, '2022-01-15'),
       (2, 'Stadium B', 90, '2022-02-20'),
       (3, 'Stadium C', 150, '2022-03-10'),
       (4, 'Stadium D', 105, '2022-04-05'),
       (5, 'Stadium E', 135, '2022-05-12');

-- Mannschaft Table
INSERT INTO Mannschaft (MID, Name, Gruendungsjahr)
VALUES (1, 'Team A', 2000),
       (2, 'Team B', 1995),
       (3, 'Team C', 2010),
       (4, 'Team D', 2005),
       (5, 'Team E', 2015);

-- Transfers Table
INSERT INTO Transfers (TID, SID, Von, Zu, Transferdatum, Abloese)
VALUES (1, 1, 1, 2, '2022-01-01', 500000),
       (2, 2, 3, 1, '2022-02-05', 800000),
       (3, 3, 4, 3, '2022-03-15', 700000),
       (4, 4, 5, 4, '2022-04-10', 300000),
       (5, 5, 2, 5, '2022-05-20', 400000);

-- Trainiert Table
INSERT INTO Trainiert (SID, MID, Gehalt)
VALUES (2, 1, 100000),
       (1, 2, 90000),
       (3, 3, 80000),
       (5, 4, 70000),
       (4, 5, 60000);

-- Gehoertzu Table
INSERT INTO Gehoertzu (SID, MID, Verletzt)
VALUES (1, 1, false),
       (2, 2, true),
       (3, 3, false),
       (4, 4, true),
       (5, 5, false);

-- Spielt Table
INSERT INTO Spielt (SID, SPID)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5);

-- ----------------------------------------------------------------------
-- Queries
-- ----------------------------------------------------------------------

SELECT * FROM Sportler;
SELECT * FROM Spieler;
SELECT * FROM Trainer;
SELECT * FROM Spiel;   
SELECT * FROM Mannschaft;
SELECT * FROM Transfers;
SELECT * FROM Trainiert;
SELECT * FROM Gehoertzu;
SELECT * FROM Spielt;