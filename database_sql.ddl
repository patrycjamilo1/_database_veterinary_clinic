CREATE TABLE adres (
    id_adres     NUMBER(10) NOT NULL,
    kod_pocztowy VARCHAR2(11),
    miasto       VARCHAR2(20)
);

ALTER TABLE adres ADD CONSTRAINT adres_pk PRIMARY KEY (id_adres);

CREATE TABLE choroba (
    id_choroba    NUMBER(10) NOT NULL,
    nazwa_choroby VARCHAR2(30)
);

ALTER TABLE choroba ADD CONSTRAINT choroba_pk PRIMARY KEY (id_choroba);

CREATE TABLE diagnoza (
    wizyta_id_wizyta   NUMBER(10) NOT NULL,
    choroba_id_choroba NUMBER(10) NOT NULL
);

ALTER TABLE diagnoza ADD CONSTRAINT diagnoza_pk PRIMARY KEY (wizyta_id_wizyta, choroba_id_choroba);

CREATE TABLE gabinet (
    id_gabinet     NUMBER(10) NOT NULL,
    numer_gabinetu NUMBER
);

ALTER TABLE gabinet ADD CONSTRAINT gabinet_pk PRIMARY KEY (id_gabinet);

CREATE TABLE gatunek (
    id_gatunek    NUMBER(10) NOT NULL,
    nazwa_gatunku VARCHAR2(20)
);

ALTER TABLE gatunek ADD CONSTRAINT gatunek_pk PRIMARY KEY (id_gatunek);

CREATE TABLE karta_szczepienia (
    id_karta_szczepienia        NUMBER(10) NOT NULL,
    nazwa_szczepienia           VARCHAR2(35),
    data_ostatniego_szczepienia DATE,
    zwierzę_id_zwierzę          NUMBER(10)
);

ALTER TABLE karta_szczepienia ADD CONSTRAINT karta_szczepienia_pk PRIMARY KEY (id_karta_szczepienia);

CREATE TABLE lek (
    id_lek             NUMBER(10) NOT NULL,
    nazwa_leku         VARCHAR2(20),
    choroba_id_choroba NUMBER(10)
);

ALTER TABLE lek ADD CONSTRAINT lek_pk PRIMARY KEY (id_lek);

CREATE TABLE lekarz (
    id_lekarz                      NUMBER(10) NOT NULL,
    imię                           VARCHAR2(20),
    nazwisko                       VARCHAR2(20),
    data_zatrudnienia              DATE,
    godzina_rozpoczęcia_pracy      DATE,
    godzina_zakończenia_pracy      DATE,
    specjalizacja_id_specjalizacja NUMBER(10) NOT NULL
);

ALTER TABLE lekarz ADD CONSTRAINT lekarz_pk PRIMARY KEY (id_lekarz);

CREATE TABLE rodzaj (
    id_rodzaj          NUMBER(10) NOT NULL,
    nazwa_rodzaju      VARCHAR2(20),
    gatunek_id_gatunek NUMBER(10) NOT NULL
);

ALTER TABLE rodzaj ADD CONSTRAINT rodzaj_pk PRIMARY KEY (id_rodzaj);

CREATE TABLE specjalizacja (
    id_specjalizacja    NUMBER(10) NOT NULL,
    nazwa_specjalizacji VARCHAR2(40)
);

ALTER TABLE specjalizacja ADD CONSTRAINT specjalizacja_pk PRIMARY KEY (id_specjalizacja);

CREATE TABLE wizyta (
    id_wizyta          NUMBER(10) NOT NULL,
    data_               DATE,
    godzina            DATE,
    zwierzę_id_zwierzę NUMBER(10),
    lekarz_id_lekarz   NUMBER(10) NOT NULL,
    gabinet_id_gabinet NUMBER(10)
);

ALTER TABLE wizyta ADD CONSTRAINT wizyta_pk PRIMARY KEY (id_wizyta);

CREATE TABLE właściciel (
    id_właściciel    NUMBER(10) NOT NULL,
    imię             VARCHAR2(20),
    naziwsko         VARCHAR2(20),
    ulica            VARCHAR2(20),
    numer_domu       NUMBER,
    numer_mieszkania NUMBER,
    adres_id_adres   NUMBER(10) NOT NULL
);

ALTER TABLE właściciel ADD CONSTRAINT właściciel_pk PRIMARY KEY (id_właściciel);

CREATE TABLE zabieg (
    id_zabieg        NUMBER(10) NOT NULL,
    nazwa_zabiegu    VARCHAR2(40),
    wizyta_id_wizyta NUMBER(10)
);

ALTER TABLE zabieg ADD CONSTRAINT zabieg_pk PRIMARY KEY (id_zabieg);

CREATE TABLE zwierzę (
    id_zwierzę               NUMBER(10) NOT NULL,
    imię                     VARCHAR2(20),
    data_urodzenia           DATE,
    płeć                     VARCHAR2(6),
    umaszczenie              VARCHAR2(20),
    gatunek_id_gatunek       NUMBER(10) NOT NULL,
    właściciel_id_właściciel NUMBER(10) NOT NULL
);

ALTER TABLE zwierzę ADD CONSTRAINT zwierzę_pk PRIMARY KEY (id_zwierzę);

ALTER TABLE diagnoza
    ADD CONSTRAINT diagnoza_choroba_fk FOREIGN KEY (choroba_id_choroba)
    REFERENCES choroba (id_choroba);

ALTER TABLE diagnoza
    ADD CONSTRAINT diagnoza_wizyta_fk FOREIGN KEY (wizyta_id_wizyta)
    REFERENCES wizyta (id_wizyta);

ALTER TABLE karta_szczepienia
    ADD CONSTRAINT karta_szczepienia_zwierzę_fk FOREIGN KEY (zwierzę_id_zwierzę)
    REFERENCES zwierzę (id_zwierzę);

ALTER TABLE lek
    ADD CONSTRAINT lek_choroba_fk FOREIGN KEY (choroba_id_choroba)
    REFERENCES choroba (id_choroba);

ALTER TABLE lekarz
    ADD CONSTRAINT lekarz_specjalizacja_fk FOREIGN KEY (specjalizacja_id_specjalizacja)
    REFERENCES specjalizacja (id_specjalizacja);

ALTER TABLE rodzaj
    ADD CONSTRAINT rodzaj_gatunek_fk FOREIGN KEY (gatunek_id_gatunek)
    REFERENCES gatunek (id_gatunek);

ALTER TABLE wizyta
    ADD CONSTRAINT wizyta_gabinet_fk FOREIGN KEY (gabinet_id_gabinet)
    REFERENCES gabinet (id_gabinet);

ALTER TABLE wizyta
    ADD CONSTRAINT wizyta_lekarz_fk FOREIGN KEY (lekarz_id_lekarz)
    REFERENCES lekarz (id_lekarz);

ALTER TABLE wizyta
    ADD CONSTRAINT wizyta_zwierzę_fk FOREIGN KEY (zwierzę_id_zwierzę)
    REFERENCES zwierzę (id_zwierzę);

ALTER TABLE właściciel
    ADD CONSTRAINT właściciel_adres_fk FOREIGN KEY (adres_id_adres)
    REFERENCES adres (id_adres);

ALTER TABLE zabieg
    ADD CONSTRAINT zabieg_wizyta_fk FOREIGN KEY (wizyta_id_wizyta)
    REFERENCES wizyta (id_wizyta);

ALTER TABLE zwierzę
    ADD CONSTRAINT zwierzę_gatunek_fk FOREIGN KEY (gatunek_id_gatunek)
    REFERENCES gatunek (id_gatunek);

ALTER TABLE zwierzę
    ADD CONSTRAINT zwierzę_właściciel_fk FOREIGN KEY (właściciel_id_właściciel)
    REFERENCES właściciel (id_właściciel);
    
INSERT INTO adres (id_adres, kod_pocztowy, miasto)
VALUES
    (1, '00-001', 'Warszawa'),
    (2, '50-123', 'Wrocław'),
    (3, '80-456', 'Gdańsk'),
    (4, '02-789', 'Kraków'),
    (5, '90-234', 'Poznań'),
    (6, '70-567', 'Szczecin'),
    (7, '20-890', 'Łódź'),
    (8, '30-345', 'Katowice'),
    (9, '40-678', 'Gdynia'),
    (10, '60-901', NULL);    
    
INSERT INTO gatunek (id_gatunek, nazwa_gatunku)
VALUES
    (1, 'Kot domowy'),
    (2, 'Pies buldog'),
    (3, 'Chomik syryjski'),
    (4, 'Ptak egzotyczny'),
    (5, 'Królik hodowlany'),
    (6, 'Żółw lądowy'),
    (7, 'Ryba akwariowa'),
    (8, 'Jeż europejski'),
    (9, 'Wiewiórka szara'),
    (10, 'Legwan zielony');
    
INSERT INTO specjalizacja (id_specjalizacja, nazwa_specjalizacji)
VALUES
    (1, 'Choroby psów i kotów'),
    (2, 'Chirurgia weterynaryjna'),
    (3, 'Choroby zwierząt futerkowych'),
    (4, 'Choroby drobiu oraz ptaków ozdobnych'),
    (5, 'Rozród zwierząt'),
    (6, 'Choroby przeżuwaczy'),
    (7, 'Choroby ryb'),
    (8, 'Chirurgia weterynaryjna'),
    (9, 'Radiologia weterynaryjna'),
    (10, 'Choroby zwierząt nieudomowionych');

INSERT INTO choroba (id_choroba, nazwa_choroby)
VALUES
    (1, 'Zespół FLUTD'),
    (2, 'Zapalenie gardła'),
    (3, 'Choroba mokrego ogona'),
    (4, 'Ornitoza'),
    (5, 'Anaplazmoza'),
    (6, 'Reumatyzm'),
    (7, 'Choroba serca'),
    (8, 'Choroba tarczycy'),
    (9, 'Nowotwór'),
    (10, 'Grzybica');
    
INSERT INTO lek (id_lek, nazwa_leku, choroba_id_choroba)
VALUES
    (1, 'Paracetamol', 1),
    (2, 'Ibuprofen', 2),
    (3, 'Antyhistaminik', 3),
    (4, 'Diseptol', 4),
    (5, 'Ventolin', 5),
    (6, 'Metotreksat', 6),
    (7, 'Bentoks', 7),
    (8, 'Eutiroks', 8),
    (9, 'Chemioterapia', 9),
    (10, 'Lentyrox', 10);

INSERT INTO rodzaj (id_rodzaj, nazwa_rodzaju, gatunek_id_gatunek)
VALUES
    (1, 'Kot', 1),
    (2, 'Pies', 2),
    (3, 'Chomik', 3),
    (4, 'Ptak', 4),
    (5, 'Królik', 5),
    (6, 'Żółw', 6),
    (7, 'Ryba', 7),
    (8, 'Jeż', 8),
    (9, 'Wiewiórka', 9),
    (10, 'Legwan', 10);
    

INSERT INTO gabinet (id_gabinet, numer_gabinetu)
VALUES
    (1, 101),
    (2, 202),
    (3, 303),
    (4, 404),
    (5, 505),
    (6, 606),
    (7, 707),
    (8, 808),
    (9, 909),
    (10, 1010);
    
INSERT INTO właściciel (id_właściciel, imię, naziwsko, ulica, numer_domu, numer_mieszkania, adres_id_adres)
VALUES
    (1, 'Adam', 'Nowak', 'Kwiatowa', 5, 3, 1),
    (2, 'Ewa', 'Kowalska', 'Słoneczna', 12, 8, 2),
    (3, 'Michał', 'Wiśniewski', NULL, 7, 2, 3),
    (4, 'Anna', 'Dąbrowska', 'Polna', 20, 15, 4),
    (5, 'Piotr', 'Lis', 'Klonowa', 15, 7, 5),
    (6, 'Karolina', 'Jankowska', 'Różana', 10, 5, 6),
    (7, 'Mateusz', 'Wójcik', 'Żeromskiego', 3, 1, 7),
    (8, 'Aleksandra', 'Pawlak', 'Piękna', 18, 10, 8),
    (9, 'Grzegorz', 'Flis', 'Kwiatowa', 25, 12, 9),
    (10, 'Monika', 'Kaczmarek', 'Słowackiego', 8, 4, 10);
    
INSERT INTO zwierzę (id_zwierzę, imię, data_urodzenia, płeć, umaszczenie, gatunek_id_gatunek, właściciel_id_właściciel)
VALUES
    (1, 'Burek', TO_DATE('2018-05-15', 'YYYY-MM-DD'), 'Samiec', 'Brązowe', 1, 1),
    (2, 'Luna', TO_DATE('2019-02-28', 'YYYY-MM-DD'), 'Samica', 'Czarne', 2, 2),
    (3, 'Max', TO_DATE('2017-09-10', 'YYYY-MM-DD'), 'Samiec', 'Białe', 3, 3),
    (4, 'Mia', TO_DATE('2020-07-03', 'YYYY-MM-DD'), 'Samica', NULL, 1, 4),
    (5, 'Rocky', TO_DATE('2016-12-20', 'YYYY-MM-DD'), 'Samiec', 'Czekoladowe', 2, 5),
    (6, 'Daisy', TO_DATE('2019-11-05', 'YYYY-MM-DD'), 'Samica', 'Białe z cętkami', 3, 6),
    (7, 'Charlie', TO_DATE('2018-04-12', 'YYYY-MM-DD'), 'Samiec', 'Czarno-Białe', 1, 7),
    (8, 'Zoe', TO_DATE('2017-08-08', 'YYYY-MM-DD'), 'Samica', 'Szare', 2, 8),
    (9, 'Oscar', TO_DATE('2020-01-25', 'YYYY-MM-DD'), 'Samiec', 'Czarno-Bure', 3, 9),
    (10, 'Molly', TO_DATE('2016-06-30', 'YYYY-MM-DD'), 'Samica', 'Brązowe', 1, 10);
    
INSERT INTO lekarz (id_lekarz, imię, nazwisko, data_zatrudnienia, godzina_rozpoczęcia_pracy, godzina_zakończenia_pracy, specjalizacja_id_specjalizacja)
VALUES
    (1, 'Jan', 'Kowalski', NULL, TO_DATE('08:00:00', 'HH24:MI:SS'), TO_DATE('16:00:00', 'HH24:MI:SS'), 1),
    (2, 'Anna', 'Nowak', TO_DATE('2019-06-15', 'YYYY-MM-DD'), TO_DATE('09:30:00', 'HH24:MI:SS'), TO_DATE('17:30:00', 'HH24:MI:SS'), 2),
    (3, 'Piotr', 'Wiśniewski', TO_DATE('2021-01-10', 'YYYY-MM-DD'), TO_DATE('08:30:00', 'HH24:MI:SS'), TO_DATE('16:30:00', 'HH24:MI:SS'), 3),
    (4, 'Magdalena', 'Dąbrowska', TO_DATE('2022-02-20', 'YYYY-MM-DD'), TO_DATE('10:00:00', 'HH24:MI:SS'), TO_DATE('18:00:00', 'HH24:MI:SS'), 4),
    (5, 'Marcin', 'Lis', TO_DATE('2018-08-05', 'YYYY-MM-DD'), TO_DATE('07:30:00', 'HH24:MI:SS'), TO_DATE('15:30:00', 'HH24:MI:SS'), 5),
    (6, 'Karolina', 'Jankowska', TO_DATE('2020-11-12', 'YYYY-MM-DD'), TO_DATE('11:00:00', 'HH24:MI:SS'), TO_DATE('19:00:00', 'HH24:MI:SS'), 6),
    (7, 'Mateusz', 'Wójcik', TO_DATE('2019-04-02', 'YYYY-MM-DD'), TO_DATE('08:00:00', 'HH24:MI:SS'), TO_DATE('16:00:00', 'HH24:MI:SS'), 7),
    (8, 'Aleksandra', 'Pawlak', TO_DATE('2021-07-25', 'YYYY-MM-DD'), TO_DATE('09:30:00', 'HH24:MI:SS'), TO_DATE('17:30:00', 'HH24:MI:SS'), 8),
    (9, 'Grzegorz', 'Nowicki', TO_DATE('2017-12-15', 'YYYY-MM-DD'), TO_DATE('08:30:00', 'HH24:MI:SS'), TO_DATE('16:30:00', 'HH24:MI:SS'), 9),
    (10, 'Monika', 'Kaczmarek', TO_DATE('2022-04-18', 'YYYY-MM-DD'), TO_DATE('10:00:00', 'HH24:MI:SS'), TO_DATE('18:00:00', 'HH24:MI:SS'), 10);

INSERT INTO wizyta (id_wizyta, data_, godzina, zwierzę_id_zwierzę, lekarz_id_lekarz, gabinet_id_gabinet)
VALUES
    (1, TO_DATE('2023-01-15', 'YYYY-MM-DD'), TO_DATE('10:00:00', 'HH24:MI:SS'), 1, 1, 1),
    (2, TO_DATE('2022-11-10', 'YYYY-MM-DD'), TO_DATE('11:30:00', 'HH24:MI:SS'), 2, 2, 2),
    (3, TO_DATE('2023-03-20', 'YYYY-MM-DD'), TO_DATE('13:15:00', 'HH24:MI:SS'), 3, 3, 3),
    (4, TO_DATE('2022-09-25', 'YYYY-MM-DD'), TO_DATE('14:45:00', 'HH24:MI:SS'), 4, 4, 4),
    (5, TO_DATE('2023-05-15', 'YYYY-MM-DD'), TO_DATE('16:30:00', 'HH24:MI:SS'), 5, 5, 5),
    (6, TO_DATE('2022-08-12', 'YYYY-MM-DD'), TO_DATE('09:00:00', 'HH24:MI:SS'), 6, 6, 6),
    (7, TO_DATE('2023-02-28', 'YYYY-MM-DD'), TO_DATE('10:45:00', 'HH24:MI:SS'), 7, 7, 7),
    (8, TO_DATE('2022-12-15', 'YYYY-MM-DD'), TO_DATE('12:30:00', 'HH24:MI:SS'), 8, 8, 8),
    (9, TO_DATE('2023-04-25', 'YYYY-MM-DD'), TO_DATE('14:15:00', 'HH24:MI:SS'), 9, 9, 9),
    (10, TO_DATE('2022-10-30', 'YYYY-MM-DD'), TO_DATE('15:45:00', 'HH24:MI:SS'), 10, 10, 10);

INSERT INTO diagnoza (wizyta_id_wizyta, choroba_id_choroba)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);
    

INSERT INTO karta_szczepienia (id_karta_szczepienia, nazwa_szczepienia, data_ostatniego_szczepienia, zwierzę_id_zwierzę)
VALUES
    (1, 'Szczepienie przeciwko wściekliźnie', TO_DATE('2023-01-10', 'YYYY-MM-DD'), 1),
    (2, 'Szczepienie przeciwko chorobie zakaźnej', TO_DATE('2022-11-05', 'YYYY-MM-DD'), 2),
    (3, 'Szczepienie przeciwko parwowirozie', TO_DATE('2023-03-15', 'YYYY-MM-DD'), 3),
    (4, 'Szczepienie przeciwko ptasiej grypie', TO_DATE('2022-09-20', 'YYYY-MM-DD'), 4),
    (5, 'Szczepienie przeciwko królikołapie', TO_DATE('2023-05-12', 'YYYY-MM-DD'), 5),
    (6, 'Szczepienie przeciwko grzybicy skóry', TO_DATE('2022-08-08', 'YYYY-MM-DD'), 6),
    (7, 'Szczepienie przeciwko wirusowi rybiej ospie', TO_DATE('2023-02-28', 'YYYY-MM-DD'), 7),
    (8, 'Szczepienie przeciwko jeżowym kleszczom', TO_DATE('2022-12-10', 'YYYY-MM-DD'), 8),
    (9, 'Szczepienie przeciwko wiewiórczej ospie', TO_DATE('2023-04-18', 'YYYY-MM-DD'), 9),
    (10, 'Szczepienie przeciwko bakterii legwany', TO_DATE('2022-10-25', 'YYYY-MM-DD'), 10);

    
INSERT INTO zabieg (id_zabieg, nazwa_zabiegu, wizyta_id_wizyta)
VALUES
    (1, 'Badanie krwi', 1),
    (2, 'Założenie gipsu', 2),
    (3, 'Zabieg chirurgiczny', 3),
    (4, 'Nakładanie szyny', 4),
    (5, 'Poród', 5),
    (6, 'Rehabilitacja po urazie', 6),
    (7, 'Badanie skrzeli ', 7),
    (8, 'Zabieg onkologiczny', 8),
    (9, 'Badanie radiologiczne', 9),
    (10, 'Szczepienie przeciwko chorobie zakaźnej', 10);
    
    
SELECT z.imię AS "Imię Zwierzęcia", z.data_urodzenia, z.płeć, z.umaszczenie,
       g.nazwa_gatunku AS "Gatunek", w.imię || ' ' || w.naziwsko AS "Właściciel"
FROM zwierzę z
JOIN gatunek g ON z.gatunek_id_gatunek = g.id_gatunek
JOIN właściciel w ON z.właściciel_id_właściciel = w.id_właściciel;

SELECT * FROM zwierzę
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM data_urodzenia) < 5;

SELECT g.nazwa_gatunku AS "Gatunek", COUNT(*) AS "Liczba zwierząt"
FROM zwierzę z
JOIN gatunek g ON z.gatunek_id_gatunek = g.id_gatunek
GROUP BY g.nazwa_gatunku;

SELECT * FROM zwierzę
WHERE id_zwierzę IN (
    SELECT DISTINCT w.zwierzę_id_zwierzę
    FROM wizyta w
    WHERE w.data_ > SYSDATE - INTERVAL '10' MONTH
);

SELECT EXTRACT(YEAR FROM w.data_) AS "Rok", l.imię || ' ' || l.nazwisko AS "Lekarz",
       COUNT(*) AS "Liczba wizyt"
FROM wizyta w
JOIN lekarz l ON w.lekarz_id_lekarz = l.id_lekarz
GROUP BY EXTRACT(YEAR FROM w.data_), l.imię, l.nazwisko
ORDER BY "Rok" ASC, "Lekarz";

SELECT * FROM (
    SELECT zwierzę.id_zwierzę, zwierzę.imię, wizyta.data_,
           ROW_NUMBER() OVER (PARTITION BY zwierzę.id_zwierzę ORDER BY wizyta.data_ DESC) AS "Numer Wizyty"
    FROM zwierzę
    JOIN wizyta ON zwierzę.id_zwierzę = wizyta.zwierzę_id_zwierzę
    WHERE zwierzę.płeć = 'Samica'
) T
WHERE "Numer Wizyty" = 1;

SELECT id_wizyta, data_, godzina,
       CASE
           WHEN TO_CHAR(data_, 'DY') = 'SAT' THEN 'Weekend'
           WHEN TO_CHAR(data_, 'DY') = 'SUN' THEN 'Weekend'
           ELSE 'Dzień roboczy'
       END AS "Typ Dnia"
FROM wizyta
WHERE TO_CHAR(data_, 'YYYY-MM') IN (
    SELECT TO_CHAR(data_, 'YYYY-MM')
    FROM wizyta
    GROUP BY TO_CHAR(data_, 'YYYY-MM')
    HAVING COUNT(DISTINCT lekarz_id_lekarz) = 1
) AND EXTRACT(MONTH FROM data_) BETWEEN 4 AND 6;

SELECT id_zwierzę, imię, data_urodzenia,
       CASE
           WHEN MONTHS_BETWEEN(SYSDATE, data_urodzenia) < 12 THEN 'Młode'
           WHEN MONTHS_BETWEEN(SYSDATE, data_urodzenia) >= 12 AND MONTHS_BETWEEN(SYSDATE, data_urodzenia) < 60 THEN 'Dorosłe'
           ELSE 'Starsze'
       END AS "Kategoria Wiekowa"
FROM zwierzę
WHERE data_urodzenia IS NOT NULL
ORDER BY "Kategoria Wiekowa" DESC, data_urodzenia ASC;


SELECT
    id_wizyta,
    data_,
    godzina,
    (SELECT COUNT(*) FROM diagnoza WHERE diagnoza.wizyta_id_wizyta = wizyta.id_wizyta) AS "Liczba Diagnoz",
    (SELECT AVG(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM zwierzę.data_urodzenia)) FROM zwierzę WHERE zwierzę.id_zwierzę = wizyta.zwierzę_id_zwierzę) AS "Średni Wiek Zwierzęcia",
    (SELECT MAX(data_ostatniego_szczepienia) FROM karta_szczepienia WHERE karta_szczepienia.zwierzę_id_zwierzę = wizyta.zwierzę_id_zwierzę) AS "Najnowsze Szczepienie"
FROM
    wizyta;


SELECT
    z.id_zwierzę,
    z.imię AS "Zwierzę",
    COUNT(ks.id_karta_szczepienia) AS "Liczba Szczepień",
    MAX(ks.data_szczepienia) AS "Najnowsze Szczepienie",
    CASE
        WHEN COUNT(ks.id_karta_szczepienia) = 0 THEN 'Niezaszczepione'
        WHEN COUNT(ks.id_karta_szczepienia) > 0 AND COUNT(ks.id_karta_szczepienia) < 3 THEN 'Niski Poziom Ochrony'
        WHEN COUNT(ks.id_karta_szczepienia) >= 3 AND COUNT(ks.id_karta_szczepienia) < 6 THEN 'Średni Poziom Ochrony'
        ELSE 'Wysoki Poziom Ochrony'
    END AS "Stan Ochrony"
FROM
    zwierzę z
LEFT JOIN
    karta_szczepienia ks ON z.id_zwierzę = ks.zwierzę_id_zwierzę
GROUP BY
    z.id_zwierzę, z.imię;

SELECT lekarz.id_lekarz, lekarz.imię, lekarz.nazwisko, specjalizacja.nazwa_specjalizacji, COUNT(wizyta.id_wizyta) AS liczba_wizyt
FROM lekarz
JOIN specjalizacja ON lekarz.specjalizacja_id_specjalizacja = specjalizacja.id_specjalizacja
JOIN wizyta ON lekarz.id_lekarz = wizyta.lekarz_id_lekarz
WHERE EXTRACT(MONTH FROM wizyta.data_) = EXTRACT(MONTH FROM SYSDATE)
GROUP BY lekarz.id_lekarz, lekarz.imię, lekarz.nazwisko, specjalizacja.nazwa_specjalizacji
ORDER BY COUNT(wizyta.id_wizyta) DESC;

SELECT lek.id_lek, lek.nazwa_leku, lek.choroba_id_choroba, wizyta.data_
FROM lek
JOIN diagnoza ON lek.choroba_id_choroba = diagnoza.choroba_id_choroba
JOIN wizyta ON diagnoza.wizyta_id_wizyta = wizyta.id_wizyta
WHERE wizyta.data_ >= ADD_MONTHS(SYSDATE, -12);









    
