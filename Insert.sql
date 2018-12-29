USE `mydb`;
DELETE FROM Rezerva;
DELETE FROM Specijalan_teret;
DELETE FROM Teret;
DELETE FROM Upravlja;
DELETE FROM Voznja;
DELETE FROM Linija;
DELETE FROM Kapetan;
DELETE FROM Brod;
DELETE FROM Pristaniste;

INSERT INTO Pristaniste VALUES
(1,3,2),
(2,2,1),
(3,3,3);

INSERT INTO Brod VALUES
(1,'Argonaute',5000,150,1),
(2,'Atropos',6500,200,1),
(3,'Clam',4000,140,1),
(4,'Clorinda',8000,300,2),
(5,'Flame',3000,100,2),
(6,'Friday',8000,310,3),
(7,'Porta Coeli',6000,200,3),
(8,'Pucelle',7000,300,3);

INSERT INTO Kapetan VALUES
(1,'Bernard Cornwell',45),
(2,'Patrick Brian',56),
(3,'Frederick Marryat',NULL),
(4,'Herman Melville',42);

INSERT INTO Linija VALUES
(1,'Rotterdam', 12000),
(2,'Barcelona',8000),
(3,'Antwerp',NULL),
(4,'Thessaloniki',4000),
(5,'Liverpool',NULL);

INSERT INTO Voznja VALUES
(5,4,'2019-01-03','2019-01-10'),
(6,1,'2019-02-10','2019-02-15');


INSERT INTO Rezerva VALUES
(1,4),
(2,3),
(5,7),
(6,8);

INSERT INTO Upravlja VALUES
(2,3,'2018-12-29','2019-01-05'),
(1,3,'2019-01-08','2019-01-15');

INSERT INTO Teret VALUES
(1,80,4,'Rotterdam',NULL,NULL),
(2,160,6,'Antwerp',NULL,NULL),
(3,50,2,'Antwerp',NULL,NULL),
(4,250,10,'Liverpool',NULL,NULL),
(5,100,8,'Liverpool',NULL,NULL),
(6,80,4,'Rotterdam',NULL,NULL),
(7,160,6,'Thessaloniki',NULL,NULL),
(8,50,2,'Antwerp',NULL,NULL),
(9,250,10,'Barcelona',NULL,NULL),
(10,10000,8,'Barcelona',NULL,NULL);

INSERT INTO Specijalan_teret VALUES
(2,'Osetljiv','Unutrasnja izolacija',NULL),
(5,'Osetljiv','Duplo pakovanje',NULL),
(7,'Skupocen',NULL,'Carrier osiguranje');
