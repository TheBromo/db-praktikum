-- ----------------------------------------------------------------------
-- Manuel Strenge, Micha Mettler, Pascal Küng
-- ----------------------------------------------------------------------
--DROP DATABASE IF EXISTS postgres; 
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;


--USE DATABASE DB_PRAKTIKUM 
-- Sportler Table
CREATE TABLE Sportler (
    SID INT PRIMARY KEY,
    Vorname VARCHAR(50),
    Nachname VARCHAR(50),
    Geburtsdatum DATE
);
-- Spieler Table TODO: ISA CONNECTION To Sportler
CREATE TABLE Spieler (
    Sportart VARCHAR(50),
    Position VARCHAR(50),
    Gehalt INT
) INHERITS(Sportler);
-- Trainer Table TODO: ISA Connection to Sportler
CREATE TABLE Trainer (
    Lizenz VARCHAR(50),
    Lizenzjahr INT CHECK (Lizenzjahr >= 1000 AND Lizenzjahr <= 9999)
)      INHERITS(Sportler);
-- Spiel Table
CREATE TABLE Spiel (
    SPID INT PRIMARY KEY,
    Ort VARCHAR(50),
    Dauer INT  CHECK (Dauer >= 0 AND Dauer <= 999),
    Datum DATE
);
-- Mannschaft Table
CREATE TABLE Mannschaft (
    MID INT PRIMARY KEY,
    Name VARCHAR(50),
    Gruendungsjahr INT CHECK (Gruendungsjahr >= 1000 AND Gruendungsjahr <= 9999)
);
-- Transfers Table
CREATE TABLE Transfers (
    TID INT PRIMARY KEY,
    SID INT,
    Von INT,
    Zu INT,
    Transferdatum DATE,
    Abloese INT,
    FOREIGN KEY (SID) REFERENCES Sportler(SID)
);
-- Trainiert Table
CREATE TABLE Trainiert (
    SID INT,
    MID INT,
    Gehalt INT,
    PRIMARY KEY (SID, MID),
    FOREIGN KEY (SID) REFERENCES Sportler(SID),
    FOREIGN KEY (MID) REFERENCES Mannschaft(MID)
);
-- Gehoertzu Table
CREATE TABLE Gehoertzu (
    SID INT,
    MID INT,
    Verletzt BOOLEAN,
    PRIMARY KEY (SID, MID),
    FOREIGN KEY (SID) REFERENCES Sportler(SID),
    FOREIGN KEY (MID) REFERENCES Mannschaft(MID)
);
-- Spielt Table
CREATE TABLE Spielt (
    SID INT,
    SPID INT,
    PRIMARY KEY (SID, SPID),
    FOREIGN KEY (SID) REFERENCES Sportler(SID),
    FOREIGN KEY (SPID) REFERENCES Spiel(SPID)
);