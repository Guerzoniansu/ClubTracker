-- Création de la base de données
DROP DATABASE IF EXISTS clubs_management;
CREATE DATABASE clubs_management CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE clubs_management;

-- Table des clubs
CREATE TABLE IF NOT EXISTS clubs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(191) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Insertion des clubs
INSERT INTO clubs (name, password) VALUES
('Club Informatique', '$2y$10$pocJbsYmvPtpF29FE3T3pe6sJCvwdI11pcehqD5WRpkJrsfctnQ.G'),
('Club Presse', '$2y$10$eVxxsx3xJhQiwfQd1HXM7.i8i/P/LxEdNC3c2p2wvPPCZp1aA84v6'),
('Club Leadership', '$2y$10$nmTz..eTTKGs15aW/5SpDe091tK7qUV9qNA99.tiy61Aqav5vTk5u'),
('Club Anglais', '$2y$10$TeID/YzAaxouamJa.urZsO4ziOnI/EcWw4StBPLUk/1JPqxBCs52y');

-- Table des types d'événements
CREATE TABLE IF NOT EXISTS event_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    club_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    FOREIGN KEY (club_id) REFERENCES clubs(id) ON DELETE CASCADE
);


-- Insertion des types d'événements pour chaque club
-- Club Informatique (id=1)
INSERT INTO event_types (club_id, name) VALUES
(1, 'Programmation'),
(1, 'Environnement Informatique'),
(1, 'Machine Learning');

-- Club Presse (id=2)
INSERT INTO event_types (club_id, name) VALUES
(2, 'Publication'),
(2, 'Interview'),
(2, 'Reportage');

-- Club Leadership (id=3)
INSERT INTO event_types (club_id, name) VALUES
(3, 'Culture Générale'),
(3, 'Art oratoire'),
(3, 'Elegance Day');

-- Club Anglais (id=4)
INSERT INTO event_types (club_id, name) VALUES
(4, 'Treasure Hunt'),
(4, 'English Learning'),
(4, 'Quiz Competition');

-- Table des étudiants
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    class VARCHAR(50) NOT NULL
);

-- Insertion des étudiants
INSERT INTO students (name, class) VALUES
('Siga Ibrahima georges','AS1'),
('AMOULE Léonce Yannick Mahounan','AS1'),
('TEGUERA Mohamed Abdoul Djalil','AS1'),
('Nguimkeng Linda lamerveille','AS1'),
('DIOP Ndeye Marieme','AS1'),
('DIAGO Moustapha','AS1'),
('DIALLO Seynabou','AS1'),
('YEMELI SAAH EUGÈNE CRESPO','AS1'),
('Diouf Safiatou','AS1'),
('NDIAYE Bator','AS1'),
('Mamadou Abdoul-Karim Ahamed','AS1'),
('Wade Fatou Soumaya','AS2'),
('TCHAPDA KOUADJO Wilfred Rod','AS2'),
('Ba Abdou','AS2'),
('MARE Marc','AS2'),
('BOGNON Enagnon Justin','AS2'),
('TOURE Ndeye Salla','AS2'),
('Gueye Awa','AS2'),
('CISSE Ndeye Aissatou','AS2'),
('Ndao Saer','AS2'),
('Diop Papa Magatte','AS2'),
('Kassi Mamadou Maxwell','AS2'),
('DOSSEKOU Kouami Emmanuel','AS2'),
('OUMSAORE Gilbert','AS2'),
('SAKHO Cheikh Oumar','AS2'),
('SALL Ndeye Khary','AS2'),
('DAIFERLE Marianne','AS2'),
('Badji Pape Mamadou','AS2'),
('SARR Mouhamadou Moustapha','AS2'),
('Bah Fatoumata','AS2'),
('ATTISSO Kossivi Moïse','AS2'),
('JEAZE Josée Clemence','AS2'),
('GUEYE Aissatou','AS2'),
('TOURE Naba Amadou Seydou','AS2'),
('NOBA Poko Ibrahim','AS2'),
('Dia Mouhammadou','AS2'),
('DJEKONBE NDOASNAN ARMAND','AS2'),
('NZONDE David Christ','AS2'),
('MEZANVOU KAMDOUN ALEX TRESOR','AS3'),
('LO Ibrahima Fa','AS3'),
('BA Baba','AS3'),
('ABDOULAYE HALIDOU Salimou','AS3'),
('Kamara Birahime','AS3'),
('Mbaye Ababacar','AS3'),
('FALL Kossa','AS3'),
('DEME Safietou','AS3'),
('Camara Sanor','AS3'),
('Kane Boubacar','AS3'),
('OUEDRAOGO Faïçal Cheick Hamed','AS3'),
('TETOMTI SIGUIM Bill','AS3'),
('DRAME Sèkou','AS3'),
('NGAMENI NZANGA TEKI Aude Sandra','AS3'),
('OUMAROU SOULEYE Ahmed Firhoun','AS3'),
('SENE Djiby','AS3'),
('NGOYI Parfait Jemmy Prodige','AS3'),
('DASSI NGUEGANG Ange','AS3'),
('TALL Fatimata','AS3'),
('Jackson Kebjam','AS3'),
('Diallo Mamadou Saïdou','AS3'),
('Diop Papa Boubacar','AS3'),
('TRAORÉ Cheikh Omar','AS3'),
('Fall Ndeye Ramatoulaye Ndoye','ISE1 Eco'),
('SOW Samba','ISE1 Eco'),
('BATABATI Eyawè Jean-Luc','ISE1 Eco'),
('BERETE Mamady I','ISE1 Eco'),
('ZINABA ALBERT','ISE1 Eco'),
('RASAMOELINA Nihaviana Albert Paulinah','ISE1 Eco'),
('Mistalengar Djerakei','ISE1 Eco'),
('KAFANDO Gandwende Judicaël Oscar','ISE1 Eco'),
('Foumsou Lawa Foumsou','ISE1 Eco'),
('BALAFAI Paul','ISE1 Eco'),
('Diallo Aïssatou Sega','ISE1 Eco'),
('HABA Fromo Francis','ISE1 Eco'),
('DIALLO Cheikh Oumar','ISE1 Eco'),
('MBENGUE Dior','ISE1 Maths'),
('SEUNKAM Kerencia Dyvana','ISE1 Maths'),
('SOMA Ben Idriss Diloma','ISE1 Maths'),
('ILLY Jacques','ISE1 Maths'),
('DIOP Yague','ISE2'),
('ADAM ALASSANE Ibrahim','ISE2'),
('NGOM Fallou','ISE2'),
('ALAGBE Abdou Hamid','ISE2'),
('KONE Chaka','ISE2'),
('Ndiaye Mame Thierno','ISE2'),
('DIACK Bocar Mamoudou','ISE2'),
('Konlambigue Lakpièguibe Youdan-yamin','ISE2'),
('MATANG KUETE Josette Victoire','ISE2'),
('GADO Seman Giovanni Jocelyn','ISE2'),
('DIOP Ousseynou','ISE2'),
('AWOUTO Koffi Samson','ISE2'),
('Diakité Moussa','ISE2'),
('KPAKOU MMounéné','ISE2'),
('COMPAORE Mohamadi Bassirou','ISE2'),
('YOUM Amadou','ISE2'),
('ATCHOU Amavi Anna Joyce','ISE2'),
('SANDJO Larry Shuman','ISE2'),
('ZAONGO Inoussa','ISE2'),
('SADIO FAMARA','ISE2'),
('Dieme Moussa','ISE2'),
('DIOP Ndèye Fama','ISE2'),
('MANDO Wendvi Abija Déborah','ISE2'),
('MOUSSA MAHAMADOU Oumar Farouk','ISE2'),
('Traoré sié rachid','ISE2'),
('NDIONE Maty','ISE2'),
('SANGARE Gnalén','ISE2'),
('MADJYAM Adoumbaye','ISE2'),
('ndiaye saran','ISE2'),
('TRAORE Mohamed','ISE2'),
('Bamogo Rasmane','ISE2'),
('THIAM Omar','ISE2'),
('Hachim Hania','ISE2'),
('KENNE YONTA Lesline Méralda','ISE2'),
('YATABARE Cheikna Amala','ISE2'),
('Cissé Papa Abdourahmane','ISE2'),
('Goumbane Harouna','ISE2'),
('NDAO Mamadou Lamine','ISE2'),
('Ngom Cheikh sadibou','ISE2'),
('SARR Mame Elhadji','ISE2'),
('Sarr Abdou Karim','ISE2'),
('ZERBO Zoumana','ISE2'),
('ADOGOUN Sèdaminou Dagbégnon Émilia Laurine','ISE3'),
('NGATCHA NOUTCHA Stephy Nadia','ISE3'),
('AYANOU Azaria Eben-Ezer Samuel','ISE3'),
('DIOP Mouhamed El Moustapha','ISE3'),
('LOUGUÉ Nicolas','ISE3'),
('GUEYE Aissata','ISE3'),
('DIOP Fatou','ISE3'),
('TOU Brahima','ISE3'),
('Badji Fallou','ISE3'),
('NFEGUE ZOFOA Stewart','ISE3'),
('Ndao Diakhou','ISE3'),
('Ka Dieynaba','ISE3'),
('NDIAYE Abdoulaye','ISE3'),
('AMADOU Moussa','ISE3'),
('GNING Ibrahima','ISE3'),
('WADE Mouhamadou Moustapha','ISE3'),
('ATHIE Mouhamadou Moustapha','ISE3'),
('KPEKPASSI Laroo Daniel','ISE3'),
('Mossé Isabelle Danielle','ISE3'),
('Tiendrebeogo Bruno','ISE3'),
('Gueye Ousseynou','ISE3'),
('Ibrahim Souleymane Amadou','ISE3'),
('SECK Marie Agathe','ISE3'),
('NDIAYE Jean Pierre Adiouma','ISE3'),
('Diagne Pathe','ISE3'),
('NGONO FONE Yannick Bryan','ISE3'),
('Manga Jonathan David','ISEP1'),
('Aw Yony','ISEP1'),
('Sall Mourtalla','ISEP1'),
('Samb Aissatou','ISEP1'),
('Faye Émile Michel','ISEP1'),
('Diop Ndeye Khoudia','ISEP1'),
('TEUMO DUREL Wilfried','ISEP1'),
('ZONGO Abdoul Kader','ISEP1'),
('SODJINOUTI Karel','ISEP1'),
('GUEYE Sokhna Penda','ISEP1'),
('Diba Boye','ISEP1'),
('Mbodj Ndeye Codou','ISEP1'),
('Ndiaye Mame Diarra','ISEP1'),
('Ndao Anta','ISEP1'),
('Dioum Seydina Omar','ISEP1'),
('Bocoum Thierno','ISEP1'),
('NKWA TSAMO Leslye Patricia','ISEP2'),
('Ndiaye Cheikh Mouhamadou Moustapha','ISEP2'),
('Diop Astou','ISEP2'),
('Seck Mouhamet','ISEP2'),
('FALL Cheikh Ahmadou Bamba','ISEP2'),
('TEVOEDJRE Sènou Michel-Marie Trésor','ISEP2'),
('RIRADJIM NGARMOUNDOU Trésor','ISEP2'),
('NGUEAJIO DONGMO David Frank','ISEP2'),
('NGAKE YAMAHA Herman Parfait','ISEP2'),
('DIABANG Mamadou lamine','ISEP2'),
('Cheikh Thioub','ISEP2'),
('Socé Math','ISEP2'),
('GUEBEDIANG A NKEN Kadidja','ISEP2'),
('DIOP Marème','ISEP2'),
('AGNANGMA SANAM David Landry','ISEP2'),
('ADDJITA GERALD GUERNGUE','ISEP2'),
('DIOP Joo Young Véridique Gabriel','ISEP2'),
('Niang Papa Amadou','ISEP3'),
('SENE Malick','ISEP3'),
('COULIBALY Khadidiatou','ISEP3'),
('RAHERINASOLO Ange Emilson Rayan','ISEP3'),
('Ndong Tamsir','ISEP3'),
('DIENG Samba','ISEP3'),
('Niass Ahmadou','ISEP3'),
('DIAW Awa','ISEP3'),
('Diakhaté Khadidiatou','ISEP3'),
('Kane Alioune Abdou Salam','ISEP3'),
('BIYENDA Hildegarde EDIMA','ISEP3'),
('Ngoumtsa Célina Nguemfouo','ISEP3'),
('FOGWOUNG Djoufack Sarah-Laure','ISEP3'),
('ONANENA AMANA Jeanne De La Flèche','ISEP3'),
('FAYE Ameth','ISEP3'),
('BOUSSO Mame Balla','ISEP3');

-- Table des événements
CREATE TABLE IF NOT EXISTS events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    club_id INT NOT NULL,
    event_type_id INT NOT NULL,
    event_date DATE NOT NULL,
    FOREIGN KEY (club_id) REFERENCES clubs(id) ON DELETE CASCADE,
    FOREIGN KEY (event_type_id) REFERENCES event_types(id) ON DELETE CASCADE
);

-- Insertion des évènements
INSERT INTO events (club_id, event_type_id, event_date) VALUES
(3, 7, "2024-09-15"),
(4, 10, "2024-09-20"),
(2, 4, "2024-09-25"),
(3, 8, "2024-10-02"),
(1, 3, "2024-10-10"),
(4, 11, "2024-10-12"),
(2, 6, "2024-10-18"),
(3, 7, "2024-11-03"),
(4, 10, "2024-11-07"),
(1, 2, "2024-11-15"),
(2, 5, "2024-12-01"),
(3, 9, "2024-12-10"),
(4, 12, "2024-12-14"),
(1, 3, "2024-12-18"),
(2, 5, "2024-12-20"),
(4, 11, "2024-12-22"),
(3, 8, "2024-12-28"),
(2, 4, "2024-12-29"),
(4, 10, "2024-12-30");








-- Table des participants aux événements
CREATE TABLE IF NOT EXISTS event_participants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    student_id INT NOT NULL,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- Insertion des participants aux évènements
INSERT INTO event_participants (event_id, student_id) VALUES
-- Participants for event_id 1
(1, 10), (1, 23), (1, 31), (1, 45), (1, 78), (1, 89), (1, 102), (1, 112), (1, 123), (1, 131), (1, 144), (1, 153), (1, 174), (1, 180), (1, 195), (1, 53), (1, 115),
-- Participants for event_id 2
(2, 5), (2, 11), (2, 19), (2, 34), (2, 50), (2, 61), (2, 78), (2, 94), (2, 115), (2, 124), (2, 139), (2, 164), (2, 172), (2, 185), (2, 189), (2, 10), (2, 23), (2, 31), (2, 45), (2, 78), (2, 89), (2, 102), (2, 112), (2, 123), (2, 131),
-- Participants for event_id 3
(3, 12), (3, 25), (3, 33), (3, 44), (3, 56), (3, 63), (3, 77), (3, 98), (3, 103), (3, 121), (3, 129), (3, 143), (3, 159), (3, 178), (3, 194), (3, 5), (3, 11), (3, 19), (3, 34),
-- Participants for event_id 4
(4, 6), (4, 20), (4, 32), (4, 47), (4, 65), (4, 79), (4, 91), (4, 108), (4, 117), (4, 132), (4, 146), (4, 162), (4, 170), (4, 184), (4, 193), (4, 12), (4, 25), (4, 33), (4, 44), (4, 56), (4, 63), (4, 77),
-- Participants for event_id 5
(5, 11), (5, 18), (5, 29), (5, 40), (5, 54), (5, 67), (5, 76), (5, 86), (5, 100), (5, 120), (5, 135), (5, 141), (5, 156), (5, 174), (5, 182), (5, 6), (5, 20), (5, 32), (5, 47), (5, 78),
-- Participants for event_id 6
(6, 2), (6, 15), (6, 21), (6, 36), (6, 49), (6, 60), (6, 71), (6, 85), (6, 99), (6, 118), (6, 137), (6, 149), (6, 161), (6, 177), (6, 192), (6, 3), (6, 16), (6, 22), (6, 37), (6, 50), (6, 61), (6, 72), (6, 86),
-- Participants for event_id 7
(7, 7), (7, 16), (7, 26), (7, 37), (7, 46), (7, 57), (7, 88), (7, 95), (7, 110), (7, 120), (7, 133), (7, 150), (7, 168), (7, 179), (7, 190), (7, 8), (7, 17),
-- Participants for event_id 8
(8, 3), (8, 14), (8, 30), (8, 41), (8, 55), (8, 66), (8, 81), (8, 92), (8, 105), (8, 125), (8, 142), (8, 157), (8, 169), (8, 181), (8, 191), (8, 6), (8, 17), (8, 33), (8, 44),
-- Participants for event_id 9
(9, 9), (9, 13), (9, 22), (9, 38), (9, 44), (9, 58), (9, 73), (9, 87), (9, 103), (9, 113), (9, 131), (9, 145), (9, 160), (9, 176), (9, 195), (9, 19), (9, 23), (9, 32), (9, 48), (9, 54), (9, 68), (9, 83), (9, 97), (9, 114), (9, 123), (9, 141),
-- Participants for event_id 10
(10, 4), (10, 17), (10, 28), (10, 43), (10, 52), (10, 68), (10, 75), (10, 90), (10, 101), (10, 122), (10, 136), (10, 151), (10, 166), (10, 173), (10, 186), (10, 190),
-- Participants for event_id 11
(11, 1), (11, 24), (11, 39), (11, 53), (11, 64), (11, 80), (11, 93), (11, 106), (11, 126), (11, 140), (11, 154), (11, 171), (11, 183), (11, 188), (11, 194), (11, 9), (11, 32), (11, 47), (11, 61), (11, 72), (11, 88), (11, 101),
-- Participants for event_id 12
(12, 13), (12, 21), (12, 35), (12, 48), (12, 61), (12, 77), (12, 97), (12, 116), (12, 130), (12, 139), (12, 152), (12, 167), (12, 175), (12, 180), (12, 193), (12, 15), (12, 23), (12, 37), (12, 50), (12, 63), (12, 79), (12, 99), (12, 118), (12, 132), (12, 141), (12, 154), (12, 169),
-- Participants for event_id 13
(13, 8), (13, 18), (13, 32), (13, 47), (13, 62), (13, 74), (13, 96), (13, 114), (13, 127), (13, 143), (13, 155), (13, 165), (13, 181), (13, 189), (13, 191), (13, 14), (13, 24), (13, 38), (13, 53), (13, 68), (13, 80), (13, 102),
-- Participants for event_id 14
(14, 5), (14, 15), (14, 34), (14, 51), (14, 59), (14, 72), (14, 84), (14, 102), (14, 119), (14, 138), (14, 147), (14, 158), (14, 171), (14, 178), (14, 190), (14, 16), (14, 26), (14, 45), (14, 62),
-- Participants for event_id 15
(15, 6), (15, 20), (15, 31), (15, 42), (15, 54), (15, 67), (15, 82), (15, 92), (15, 109), (15, 123), (15, 137), (15, 153), (15, 168), (15, 184), (15, 192), (15, 9), (15, 23),
-- Participants for event_id 16
(16, 2), (16, 16), (16, 27), (16, 40), (16, 58), (16, 69), (16, 89), (16, 104), (16, 115), (16, 132), (16, 141), (16, 156), (16, 164), (16, 182), (16, 194), (16, 6), (16, 20),
-- Participants for event_id 17
(17, 22), (17, 26), (17, 50), (17, 71), (17, 85), (17, 98), (17, 113), (17, 125), (17, 148), (17, 157), (17, 174), (17, 185), (17, 188), (17, 195), (17, 191),
-- Participants for event_id 18
(18, 3), (18, 17), (18, 48), (18, 60), (18, 72), (18, 94), (18, 108), (18, 125), (18, 135), (18, 149), (18, 162), (18, 178), (18, 184), (18, 186), (18, 190), (18, 8), (18, 22), (18, 53), (18, 65), (18, 77), (18, 99), (18, 113),
-- Participants for event_id 19
(19, 7), (19, 19), (19, 38), (19, 45), (19, 57), (19, 68), (19, 88), (19, 102), (19, 117), (19, 136), (19, 154), (19, 170), (19, 181), (19, 185), (19, 193);








