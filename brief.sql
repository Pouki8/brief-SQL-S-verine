/*J’ai en premier créer ma base de données :*/
CREATE database brief_sql_Zapata;

/*Création des tables :*/
CREATE table Editeurs(
EditeursID int not null auto_increment,
nom char(50),
adresse char (150),
primary key (EditeursID)
);

CREATE table ISBN(
ISBNID int not null auto_increment,
code char(13) unique,
check (length(code) = 13),
id_editeur int not null,
primary key (ISBNID),
constraint ISBN_Editeurs_FK foreign key (id_editeur) references Editeurs(EditeursID)
);

CREATE table Livres(
LivresID int not null auto_increment,
titre char(250),
id_isbn int not null unique,
primary key (LivresID),
constraint Livres_ISBN_FK foreign key (id_isbn) references ISBN(ISBNID)
);

CREATE table Pays(
PaysID int auto_increment,
libelle char(250),
primary key (PaysID)
);

CREATE table Auteurs(
AuteursID int not null auto_increment,
nom char(50),
prenom char(50),
id_pays int not null,
primary key (AuteursID),
constraint Auteurs_Pays_FK foreign key (id_pays) references Pays(PaysID)
);

/*Ensuite, j’ai saisie toutes les données que je souhaitais mettre dans les tables :*/
INSERT INTO Pays (libelle) values ("France"), ("Portugal"), ("Algérie");

INSERT INTO Auteurs (nom, prenom, id_pays) values ("Millet", "Stéphane", 3),("Bojko", "Jérémy", 1), 
("Ramos", "Marie-Emmanuelle", 2), ("Soumare", "Idrissa", 1), ("Mehdi", "Audrey", 1), ("Oillic", "Xavier", 1), 
("Le Fils", "Martin", 1);

INSERT INTO Editeurs (nom, adresse) values ("Flammarion", "82, rue Saint-Lazare, CS 10124, 75009 Paris"), 
("Gallimard", "5 Rue Gaston Gallimard, 75007 Paris"), ("Hachette", "58 r Jean Bleuzen, 92170 Vanves");

INSERT INTO ISBN (code, id_editeur) values ("1-123-456-789", 1), ("2-123-456-789", 1), ("3-123-456-789", 1), 
("1-987-654-321", 2), ("2-987-654-321", 2), ("1-321-654-987", 3);

INSERT INTO Livres (titre, id_isbn) values ("Java pour les nuls", 4), ("Angular pour les nuls", 5), 
("Ma vie en formation CDA", 1), ("Promo Simplon 2024", 2),("Hacker en 20 min.", 3), ("La Beyonce en moi", 6);

/*Puis j’ai ajouté la table de jointure entre les auteurs et les livres :*/
CREATE table Livre_Auteur (
livreID int not null,
auteurID int not null,
Primary key (livreID, auteurID),
constraint Livre_Auteur_Livres_FK foreign key (livreID) references Livres(LivresID),
constraint Livre_Auteur_Auteurs_FK foreign key (auteurID) references Auteurs(AuteursID));


/*Puis j’ai ajouté les données pour attribuer chaque livre aux auteurs dédiés :*/
INSERT INTO Livre_Auteur (livreID, auteurID) values (7, 1), (8, 2), (9, 3), (10, 4), (10, 6), (11, 7), (12, 5);

SELECT Auteurs.nom, Auteurs.prenom, Livres.titre, Editeurs.nom, ISBN.code from Livre_Auteur 
JOIN Auteurs on Livre_Auteur.auteurID = Auteurs.AuteursID 
JOIN Livres on Livre_Auteur.livreID = Livres.LivresID
JOIN ISBN on Livres.id_isbn = ISBN.ISBNID 
JOIN Editeurs on ISBN.id_editeur = Editeurs.EditeursID
ORDER BY Auteurs.nom;

SELECT Livres.titre, Auteurs.nom from Livre_Auteur 
JOIN Livres  on Livre_Auteur.livreID = Livres.LivresID 
JOIN Auteurs on Auteurs.AuteursID =Livre_Auteur.auteurID 
WHERE Auteurs.id_pays  = 1;

SELECT Livres.titre, Auteurs.nom from Livre_Auteur 
JOIN Livres  on Livre_Auteur.livreID = Livres.LivresID 
JOIN Auteurs on Auteurs.AuteursID =Livre_Auteur.auteurID 
JOIN ISBN on ISBN.ISBNID = Livres.id_isbn
WHERE ISBN.id_editeur = 3;





