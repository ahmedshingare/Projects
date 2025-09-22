create database Player_Performance_Analysis;
use Player_Performance_Analysis;

create table Teams (
Team_Id int primary key,
Team_Name varchar(25) not null,
Coach_Name varchar(25),
Founded_Year date not null
);

insert into Teams values
(1, 'Thunder FC', 'John Smith', '2001-03-01'),
(2, 'Blaze United', 'Alice Brown', '1999-05-20'),
(3, 'Storm Riders', 'Carlos Vega', '2005-01-15'),
(4, 'Rapid Strikers', 'Liam Khan', '1990-07-10'),
(5, 'Desert Kings', 'Zara Lee', '1985-04-22'),
(6, 'Ocean Warriors', 'Ravi Patel', '2002-09-30'),
(7, 'Sky Hawks', 'Elena Ruiz', '1996-12-05'),
(8, 'Mountain Giants', 'David Nair', '1993-08-18'),
(9, 'Valley Knights', 'Emma Lin', '2000-11-09'),
(10, 'Metro Stars', 'Tom Hardy', '1997-02-14');


create table Players (
Player_Id int primary key,
Name varchar(25) not null,
Age int not null,
Position varchar(20),
Team_Id int,
foreign key (Team_Id) references Teams(Team_Id)
);

insert into Players (Player_Id, Name, Age, Position, Team_Id) values
-- Thunder FC (Team 1)
(1, 'Aaron Lee', 24, 'Forward', 1),
(2, 'Brian Cruz', 26, 'Midfielder', 1),
(3, 'Chris Wong', 28, 'Defender', 1),
(4, 'Daniel Roy', 23, 'Goalkeeper', 1),
(5, 'Ethan Gill', 27, 'Midfielder', 1),
(6, 'Felix Dean', 25, 'Forward', 1),
(7, 'George Kim', 29, 'Defender', 1),
(8, 'Harry Jain', 22, 'Midfielder', 1),
(9, 'Isaac Paul', 26, 'Defender', 1),
(10, 'Jack Neo', 24, 'Forward', 1),
(11, 'Kevin Mo', 28, 'Goalkeeper', 1),

-- Blaze United (Team 2)
(12, 'Liam Gray', 25, 'Forward', 2),
(13, 'Mason Hill', 24, 'Midfielder', 2),
(14, 'Noah Reed', 29, 'Defender', 2),
(15, 'Oliver Dale', 22, 'Goalkeeper', 2),
(16, 'Parker Ross', 27, 'Midfielder', 2),
(17, 'Quinn Ray', 26, 'Forward', 2),
(18, 'Ryan Cook', 23, 'Defender', 2),
(19, 'Sean Wood', 28, 'Midfielder', 2),
(20, 'Tyler Kent', 25, 'Defender', 2),
(21, 'Umar Singh', 24, 'Forward', 2),
(22, 'Victor Lim', 26, 'Goalkeeper', 2),

-- Storm Riders (Team 3)
(23, 'Will Nash', 24, 'Forward', 3),
(24, 'Xavier Luu', 25, 'Midfielder', 3),
(25, 'Yusuf Bell', 28, 'Defender', 3),
(26, 'Zane Cox', 23, 'Goalkeeper', 3),
(27, 'Ayaan Rao', 27, 'Midfielder', 3),
(28, 'Brett Seo', 26, 'Forward', 3),
(29, 'Cory Tan', 29, 'Defender', 3),
(30, 'Dev Shah', 22, 'Midfielder', 3),
(31, 'Eli Hunt', 26, 'Defender', 3),
(32, 'Finn Lowe', 24, 'Forward', 3),
(33, 'Gabe Yu', 28, 'Goalkeeper', 3),

-- Rapid Strikers (Team 4)
(34, 'Hugo Ice', 25, 'Forward', 4),
(35, 'Ivan Blaze', 24, 'Midfielder', 4),
(36, 'Jake Storm', 29, 'Defender', 4),
(37, 'Kyle Rock', 22, 'Goalkeeper', 4),
(38, 'Leo Fire', 27, 'Midfielder', 4),
(39, 'Max Thunder', 26, 'Forward', 4),
(40, 'Nico Jet', 23, 'Defender', 4),
(41, 'Omar Flash', 28, 'Midfielder', 4),
(42, 'Pete Spark', 25, 'Defender', 4),
(43, 'Quincy Bolt', 24, 'Forward', 4),
(44, 'Ravi Gale', 26, 'Goalkeeper', 4),

-- Desert Kings (Team 5)
(45, 'Sam Blaze', 24, 'Forward', 5),
(46, 'Tariq Dust', 25, 'Midfielder', 5),
(47, 'Uday Flame', 28, 'Defender', 5),
(48, 'Victor Dune', 23, 'Goalkeeper', 5),
(49, 'Waleed Sun', 27, 'Midfielder', 5),
(50, 'Xeno Burn', 26, 'Forward', 5),
(51, 'Yash Heat', 29, 'Defender', 5),
(52, 'Zubair Storm', 22, 'Midfielder', 5),
(53, 'Ali Mirage', 26, 'Defender', 5),
(54, 'Bilal Camel', 24, 'Forward', 5),
(55, 'Cyrus Sand', 28, 'Goalkeeper', 5),

-- Ocean Warriors (Team 6)
(56, 'Dinesh Wave', 24, 'Forward', 6),
(57, 'Eshan Tide', 25, 'Midfielder', 6),
(58, 'Farhan Coral', 28, 'Defender', 6),
(59, 'Girish Deep', 23, 'Goalkeeper', 6),
(60, 'Harsh Salt', 27, 'Midfielder', 6),
(61, 'Imran Sea', 26, 'Forward', 6),
(62, 'Jay Surf', 29, 'Defender', 6),
(63, 'Karan Reef', 22, 'Midfielder', 6),
(64, 'Laksh Aqua', 26, 'Defender', 6),
(65, 'Manav Shore', 24, 'Forward', 6),
(66, 'Nihal Ship', 28, 'Goalkeeper', 6),

-- Sky Hawks (Team 7)
(67, 'Owen Hawk', 24, 'Forward', 7),
(68, 'Pranav Sky', 25, 'Midfielder', 7),
(69, 'Qadir Wing', 28, 'Defender', 7),
(70, 'Rohan Cloud', 23, 'Goalkeeper', 7),
(71, 'Sahil Storm', 27, 'Midfielder', 7),
(72, 'Tarun Glide', 26, 'Forward', 7),
(73, 'Utsav Jet', 29, 'Defender', 7),
(74, 'Veer Drift', 22, 'Midfielder', 7),
(75, 'Wasim Lift', 26, 'Defender', 7),
(76, 'Xander Soar', 24, 'Forward', 7),
(77, 'Yug Falcon', 28, 'Goalkeeper', 7),

-- Mountain Giants (Team 8)
(78, 'Zane Cliff', 24, 'Forward', 8),
(79, 'Arjun Peak', 25, 'Midfielder', 8),
(80, 'Bhav Hill', 28, 'Defender', 8),
(81, 'Chirag Rock', 23, 'Goalkeeper', 8),
(82, 'Deep Summit', 27, 'Midfielder', 8),
(83, 'Eshan Boulder', 26, 'Forward', 8),
(84, 'Fahad Ridge', 29, 'Defender', 8),
(85, 'Gaurav Crag', 22, 'Midfielder', 8),
(86, 'Harsh Slope', 26, 'Defender', 8),
(87, 'Ishan Trail', 24, 'Forward', 8),
(88, 'Jay Trek', 28, 'Goalkeeper', 8),

-- Valley Knights (Team 9)
(89, 'Kunal Vale', 24, 'Forward', 9),
(90, 'Lalit Grove', 25, 'Midfielder', 9),
(91, 'Mihir Leaf', 28, 'Defender', 9),
(92, 'Naman Brook', 23, 'Goalkeeper', 9),
(93, 'Om Forest', 27, 'Midfielder', 9),
(94, 'Pratik Root', 26, 'Forward', 9),
(95, 'Qasim Stem', 29, 'Defender', 9),
(96, 'Raghav Field', 22, 'Midfielder', 9),
(97, 'Sanjay Petal', 26, 'Defender', 9),
(98, 'Tanay Hill', 24, 'Forward', 9),
(99, 'Uday Tree', 28, 'Goalkeeper', 9),

-- Metro Stars (Team 10)
(100, 'Vishal City', 24, 'Forward', 10),
(101, 'Wasim Block', 25, 'Midfielder', 10),
(102, 'Xavi Grid', 28, 'Defender', 10),
(103, 'Yash Lane', 23, 'Goalkeeper', 10),
(104, 'Zaid Street', 27, 'Midfielder', 10),
(105, 'Amit Rail', 26, 'Forward', 10),
(106, 'Bhanu Metro', 29, 'Defender', 10),
(107, 'Chetan Light', 22, 'Midfielder', 10),
(108, 'Dev Neon', 26, 'Defender', 10),
(109, 'Eshan Park', 24, 'Forward', 10),
(110, 'Faraz Bridge', 28, 'Goalkeeper', 10);


create table Stadiums (
Stadium_Id int primary key,
Stadium_Name varchar(25) not null,
City varchar(25) not null,
Capacity int not null
);

INSERT INTO Stadiums (Stadium_Id, Stadium_Name, City, Capacity) VALUES
(1, 'Thunder Arena', 'New York', 45000),
(2, 'Eagle Nest', 'Los Angeles', 40000),
(3, 'Dragon Dome', 'Chicago', 50000),
(4, 'Storm Field', 'Houston', 38000),
(5, 'Falcon Park', 'Dallas', 36000),
(6, 'Titan Grounds', 'Miami', 42000),
(7, 'Phoenix Stadium', 'Atlanta', 39000),
(8, 'Hawk Arena', 'Seattle', 41000),
(9, 'Lion’s Den', 'Boston', 37000),
(10, 'Shark Tank', 'San Diego', 44000);


create table Matches (
Match_Id int primary key,
Match_Date Date not null,
Home_Team_Id int not null,
Away_Team_Id int not null,
Stadium_Id int not null,
result varchar(20),
foreign key (Home_Team_Id) references Teams(Team_Id),
foreign key (Away_Team_Id) references Teams(Team_Id),
foreign key (Stadium_Id) references Stadiums(Stadium_Id)
);

INSERT INTO Matches (Match_Id, Match_Date, Home_Team_Id, Away_Team_Id, Stadium_Id, result) VALUES
(1, '2024-01-05', 1, 2, 1, '2-1'),
(2, '2024-01-12', 3, 4, 4, '0-0'),
(3, '2024-01-19', 5, 6, 5, '1-3'),
(4, '2024-01-26', 7, 8, 8, '2-2'),
(5, '2024-02-02', 9, 10, 9, '0-1'),
(6, '2024-02-09', 2, 3, 2, '3-2'),
(7, '2024-02-16', 4, 1, 4, '1-2'),
(8, '2024-02-23', 6, 7, 6, '1-1'),
(9, '2024-03-01', 8, 9, 8, '0-0'),
(10, '2024-03-08', 10, 5, 10, '4-1'),
(11, '2024-03-15', 1, 3, 1, '2-2'),
(12, '2024-03-22', 2, 5, 2, '1-0'),
(13, '2024-03-29', 6, 4, 6, '0-3'),
(14, '2024-04-05', 7, 10, 7, '1-2'),
(15, '2024-04-12', 9, 8, 9, '3-3'),
(16, '2024-04-19', 3, 2, 3, '2-0'),
(17, '2024-04-26', 5, 1, 5, '0-2'),
(18, '2024-05-03', 8, 6, 8, '1-1'),
(19, '2024-05-10', 10, 4, 10, '2-2'),
(20, '2024-05-17', 9, 7, 9, '1-0');



create table PlayerStats (
Stat_Id int primary key,
Player_Id int not null,
Match_Id int not null,
Goals int not null,
Assists int not null,
Minutes_Played int not null,
Yellow_Cards int not null , 
Red_Cards int not null , 
foreign key (Player_Id) references Players(Player_Id),
foreign key (Match_Id) references Matches(Match_Id)
);

INSERT INTO PlayerStats (Stat_Id, Player_Id, Match_Id, Goals, Assists, Minutes_Played, Yellow_Cards, Red_Cards) VALUES
-- Match 1: Thunder FC (1) vs Blaze United (2) - 2-1
(1, 1, 1, 1, 0, 90, 0, 0),   -- Aaron Lee (Thunder) scored 1 goal
(2, 6, 1, 1, 0, 85, 1, 0),   -- Felix Dean (Thunder) scored 1 goal, yellow card
(3, 2, 1, 0, 1, 90, 0, 0),   -- Brian Cruz (Thunder) with 1 assist
(4, 12, 1, 1, 0, 90, 0, 0),  -- Liam Gray (Blaze) scored 1 goal
(5, 13, 1, 0, 1, 90, 0, 0),  -- Mason Hill (Blaze) with 1 assist
(6, 14, 1, 0, 0, 90, 1, 0),  -- Noah Reed (Blaze) yellow card
(7, 4, 1, 0, 0, 90, 0, 0),   -- Daniel Roy (Thunder) full match
(8, 15, 1, 0, 0, 90, 0, 0),  -- Oliver Dale (Blaze) full match

-- Match 2: Storm Riders (3) vs Rapid Strikers (4) - 0-0
(9, 26, 2, 0, 0, 90, 0, 0),  -- Zane Cox (Storm) clean sheet
(10, 37, 2, 0, 0, 90, 0, 0), -- Kyle Rock (Rapid) clean sheet
(11, 25, 2, 0, 0, 90, 1, 0), -- Yusuf Bell (Storm) yellow card
(12, 36, 2, 0, 0, 90, 1, 0), -- Jake Storm (Rapid) yellow card
(13, 23, 2, 0, 0, 80, 0, 0), -- Will Nash (Storm) played 80 mins
(14, 34, 2, 0, 0, 75, 0, 0), -- Hugo Ice (Rapid) played 75 mins

-- Match 3: Desert Kings (5) vs Ocean Warriors (6) - 1-3
(15, 45, 3, 1, 0, 90, 0, 0), -- Sam Blaze (Desert) scored 1 goal
(16, 56, 3, 1, 1, 90, 0, 0), -- Dinesh Wave (Ocean) 1 goal, 1 assist
(17, 61, 3, 2, 0, 90, 0, 0),  -- Imran Sea (Ocean) scored 2 goals
(18, 57, 3, 0, 2, 90, 0, 0),  -- Eshan Tide (Ocean) 2 assists
(19, 47, 3, 0, 0, 90, 1, 0),  -- Uday Flame (Desert) yellow card
(20, 58, 3, 0, 0, 90, 1, 0), -- Farhan Coral (Ocean) yellow card

-- Match 4: Sky Hawks (7) vs Mountain Giants (8) - 2-2
(21, 67, 4, 1, 0, 90, 0, 0), -- Owen Hawk (Sky) 1 goal
(22, 72, 4, 1, 0, 85, 0, 0), -- Tarun Glide (Sky) 1 goal
(23, 68, 4, 0, 2, 90, 0, 0),  -- Pranav Sky (Sky) 2 assists
(24, 78, 4, 1, 1, 90, 0, 0),  -- Zane Cliff (Mountain) 1 goal, 1 assist
(25, 83, 4, 1, 0, 80, 1, 0),  -- Eshan Boulder (Mountain) 1 goal, yellow
(26, 79, 4, 0, 1, 90, 0, 0),  -- Arjun Peak (Mountain) 1 assist

-- Match 5: Valley Knights (9) vs Metro Stars (10) - 0-1
(27, 100, 5, 1, 0, 90, 0, 0), -- Vishal City (Metro) scored 1 goal
(28, 101, 5, 0, 1, 90, 0, 0), -- Wasim Block (Metro) 1 assist
(29, 92, 5, 0, 0, 90, 0, 0),  -- Naman Brook (Valley) full match
(30, 103, 5, 0, 0, 90, 0, 0), -- Yash Lane (Metro) clean sheet
(31, 89, 5, 0, 0, 90, 1, 0),  -- Kunal Vale (Valley) yellow card

-- Match 6: Blaze United (2) vs Storm Riders (3) - 3-2
(32, 12, 6, 2, 0, 90, 0, 0),  -- Liam Gray (Blaze) 2 goals
(33, 17, 6, 1, 1, 90, 0, 0),  -- Quinn Ray (Blaze) 1 goal, 1 assist
(34, 13, 6, 0, 2, 90, 0, 0),  -- Mason Hill (Blaze) 2 assists
(35, 23, 6, 1, 0, 90, 1, 0),  -- Will Nash (Storm) 1 goal, yellow
(36, 28, 6, 1, 0, 85, 0, 0),  -- Brett Seo (Storm) 1 goal
(37, 24, 6, 0, 1, 90, 0, 0),  -- Xavier Luu (Storm) 1 assist
(38, 14, 6, 0, 0, 90, 1, 0),  -- Noah Reed (Blaze) yellow card

-- Match 7: Rapid Strikers (4) vs Thunder FC (1) - 1-2
(39, 1, 7, 1, 0, 90, 0, 0),   -- Aaron Lee (Thunder) 1 goal
(40, 5, 7, 1, 0, 90, 0, 0),   -- Ethan Gill (Thunder) 1 goal
(41, 2, 7, 0, 1, 90, 0, 0),   -- Brian Cruz (Thunder) 1 assist
(42, 34, 7, 1, 0, 90, 0, 0),  -- Hugo Ice (Rapid) 1 goal
(43, 35, 7, 0, 1, 90, 1, 0),  -- Ivan Blaze (Rapid) 1 assist, yellow
(44, 3, 7, 0, 0, 90, 1, 0),   -- Chris Wong (Thunder) yellow card

-- Match 8: Ocean Warriors (6) vs Sky Hawks (7) - 1-1
(45, 56, 8, 1, 0, 90, 0, 0),  -- Dinesh Wave (Ocean) 1 goal
(46, 57, 8, 0, 1, 90, 0, 0),  -- Eshan Tide (Ocean) 1 assist
(47, 67, 8, 1, 0, 90, 0, 0),  -- Owen Hawk (Sky) 1 goal
(48, 68, 8, 0, 1, 90, 0, 0),  -- Pranav Sky (Sky) 1 assist
(49, 58, 8, 0, 0, 90, 1, 0),  -- Farhan Coral (Ocean) yellow card
(50, 69, 8, 0, 0, 90, 1, 0),  -- Qadir Wing (Sky) yellow card

-- Match 9: Mountain Giants (8) vs Valley Knights (9) - 0-0
(51, 81, 9, 0, 0, 90, 0, 0),  -- Chirag Rock (Mountain) clean sheet
(52, 92, 9, 0, 0, 90, 0, 0), -- Naman Brook (Valley) clean sheet
(53, 80, 9, 0, 0, 90, 1, 0),  -- Bhav Hill (Mountain) yellow card
(54, 91, 9, 0, 0, 90, 1, 0),  -- Mihir Leaf (Valley) yellow card
(55, 78, 9, 0, 0, 80, 0, 0),  -- Zane Cliff (Mountain) played 80 mins
(56, 89, 9, 0, 0, 85, 0, 0),  -- Kunal Vale (Valley) played 85 mins

-- Match 10: Metro Stars (10) vs Desert Kings (5) - 4-1
(57, 100, 10, 2, 1, 90, 0, 0), -- Vishal City (Metro) 2 goals, 1 assist
(58, 105, 10, 1, 0, 90, 0, 0), -- Amit Rail (Metro) 1 goal
(59, 109, 10, 1, 0, 75, 0, 0), -- Eshan Park (Metro) 1 goal
(60, 101, 10, 0, 2, 90, 0, 0), -- Wasim Block (Metro) 2 assists
(61, 45, 10, 1, 0, 90, 0, 0),  -- Sam Blaze (Desert) 1 goal
(62, 46, 10, 0, 1, 90, 1, 0),  -- Tariq Dust (Desert) 1 assist, yellow
(63, 51, 10, 0, 0, 90, 1, 0),  -- Yash Heat (Desert) yellow card

-- Match 11: Thunder FC (1) vs Storm Riders (3) - 2-2
(64, 1, 11, 1, 0, 90, 0, 0),  -- Aaron Lee (Thunder) 1 goal
(65, 6, 11, 1, 0, 85, 0, 0),  -- Felix Dean (Thunder) 1 goal
(66, 2, 11, 0, 1, 90, 0, 0),  -- Brian Cruz (Thunder) 1 assist
(67, 5, 11, 0, 1, 90, 0, 0),  -- Ethan Gill (Thunder) 1 assist
(68, 23, 11, 1, 0, 90, 0, 0), -- Will Nash (Storm) 1 goal
(69, 28, 11, 1, 0, 80, 0, 0), -- Brett Seo (Storm) 1 goal
(70, 24, 11, 0, 1, 90, 0, 0), -- Xavier Luu (Storm) 1 assist
(71, 27, 11, 0, 1, 90, 1, 0), -- Ayaan Rao (Storm) 1 assist, yellow

-- Match 12: Blaze United (2) vs Desert Kings (5) - 1-0
(72, 12, 12, 1, 0, 90, 0, 0), -- Liam Gray (Blaze) 1 goal
(73, 13, 12, 0, 1, 90, 0, 0), -- Mason Hill (Blaze) 1 assist
(74, 15, 12, 0, 0, 90, 0, 0), -- Oliver Dale (Blaze) clean sheet
(75, 45, 12, 0, 0, 90, 1, 0), -- Sam Blaze (Desert) yellow card
(76, 47, 12, 0, 0, 90, 1, 0), -- Uday Flame (Desert) yellow card

-- Match 13: Ocean Warriors (6) vs Rapid Strikers (4) - 0-3
(77, 34, 13, 2, 0, 90, 0, 0), -- Hugo Ice (Rapid) 2 goals
(78, 39, 13, 1, 0, 80, 0, 0), -- Max Thunder (Rapid) 1 goal
(79, 35, 13, 0, 2, 90, 0, 0), -- Ivan Blaze (Rapid) 2 assists
(80, 38, 13, 0, 1, 90, 0, 0), -- Leo Fire (Rapid) 1 assist
(81, 59, 13, 0, 0, 90, 0, 0), -- Girish Deep (Ocean) full match
(82, 56, 13, 0, 0, 90, 1, 0), -- Dinesh Wave (Ocean) yellow card

-- Match 14: Sky Hawks (7) vs Metro Stars (10) - 1-2
(83, 67, 14, 1, 0, 90, 0, 0), -- Owen Hawk (Sky) 1 goal
(84, 68, 14, 0, 1, 90, 0, 0), -- Pranav Sky (Sky) 1 assist
(85, 100, 14, 1, 1, 90, 0, 0),-- Vishal City (Metro) 1 goal, 1 assist
(86, 105, 14, 1, 0, 80, 0, 0),-- Amit Rail (Metro) 1 goal
(87, 101, 14, 0, 1, 90, 0, 0),-- Wasim Block (Metro) 1 assist
(88, 73, 14, 0, 0, 90, 1, 0), -- Utsav Jet (Sky) yellow card

-- Match 15: Valley Knights (9) vs Mountain Giants (8) - 3-3
(89, 89, 15, 1, 1, 90, 0, 0), -- Kunal Vale (Valley) 1 goal, 1 assist
(90, 94, 15, 1, 0, 85, 0, 0), -- Pratik Root (Valley) 1 goal
(91, 98, 15, 1, 0, 80, 0, 0), -- Tanay Hill (Valley) 1 goal
(92, 90, 15, 0, 2, 90, 0, 0), -- Lalit Grove (Valley) 2 assists
(93, 78, 15, 2, 0, 90, 0, 0), -- Zane Cliff (Mountain) 2 goals
(94, 83, 15, 1, 0, 85, 0, 0), -- Eshan Boulder (Mountain) 1 goal
(95, 79, 15, 0, 2, 90, 0, 0), -- Arjun Peak (Mountain) 2 assists
(96, 80, 15, 0, 1, 90, 1, 0),-- Bhav Hill (Mountain) 1 assist, yellow

-- Match 16: Storm Riders (3) vs Blaze United (2) - 2-0
(97, 23, 16, 1, 0, 90, 0, 0), -- Will Nash (Storm) 1 goal
(98, 28, 16, 1, 0, 85, 0, 0), -- Brett Seo (Storm) 1 goal
(99, 24, 16, 0, 1, 90, 0, 0), -- Xavier Luu (Storm) 1 assist
(100, 27, 16, 0, 1, 90, 0, 0),-- Ayaan Rao (Storm) 1 assist
(101, 26, 16, 0, 0, 90, 0, 0),-- Zane Cox (Storm) clean sheet
(102, 14, 16, 0, 0, 90, 1, 0),-- Noah Reed (Blaze) yellow card
(103, 17, 16, 0, 0, 90, 1, 0),-- Quinn Ray (Blaze) yellow card

-- Match 17: Desert Kings (5) vs Thunder FC (1) - 0-2
(104, 1, 17, 1, 0, 90, 0, 0), -- Aaron Lee (Thunder) 1 goal
(105, 10, 17, 1, 0, 80, 0, 0),-- Jack Neo (Thunder) 1 goal
(106, 2, 17, 0, 1, 90, 0, 0), -- Brian Cruz (Thunder) 1 assist
(107, 5, 17, 0, 1, 90, 0, 0), -- Ethan Gill (Thunder) 1 assist
(108, 4, 17, 0, 0, 90, 0, 0), -- Daniel Roy (Thunder) clean sheet
(109, 47, 17, 0, 0, 90, 1, 0),-- Uday Flame (Desert) yellow card

-- Match 18: Mountain Giants (8) vs Ocean Warriors (6) - 1-1
(110, 78, 18, 1, 0, 90, 0, 0),-- Zane Cliff (Mountain) 1 goal
(111, 79, 18, 0, 1, 90, 0, 0),-- Arjun Peak (Mountain) 1 assist
(112, 56, 18, 1, 0, 90, 0, 0),-- Dinesh Wave (Ocean) 1 goal
(113, 57, 18, 0, 1, 90, 0, 0),-- Eshan Tide (Ocean) 1 assist
(114, 80, 18, 0, 0, 90, 1, 0),-- Bhav Hill (Mountain) yellow card
(115, 58, 18, 0, 0, 90, 1, 0),-- Farhan Coral (Ocean) yellow card

-- Match 19: Metro Stars (10) vs Rapid Strikers (4) - 2-2
(116, 100, 19, 1, 0, 90, 0, 0),-- Vishal City (Metro) 1 goal
(117, 105, 19, 1, 0, 85, 0, 0),-- Amit Rail (Metro) 1 goal
(118, 101, 19, 0, 1, 90, 0, 0),-- Wasim Block (Metro) 1 assist
(119, 104, 19, 0, 1, 90, 0, 0),-- Zaid Street (Metro) 1 assist
(120, 34, 19, 1, 0, 90, 0, 0), -- Hugo Ice (Rapid) 1 goal
(121, 39, 19, 1, 0, 80, 0, 0), -- Max Thunder (Rapid) 1 goal
(122, 35, 19, 0, 1, 90, 1, 0), -- Ivan Blaze (Rapid) 1 assist, yellow
(123, 38, 19, 0, 1, 90, 0, 0), -- Leo Fire (Rapid) 1 assist

-- Match 20: Valley Knights (9) vs Sky Hawks (7) - 1-0
(124, 89, 20, 1, 0, 90, 0, 0), -- Kunal Vale (Valley) 1 goal
(125, 90, 20, 0, 1, 90, 0, 0), -- Lalit Grove (Valley) 1 assist
(126, 92, 20, 0, 0, 90, 0, 0), -- Naman Brook (Valley) clean sheet
(127, 67, 20, 0, 0, 90, 1, 0), -- Owen Hawk (Sky) yellow card
(128, 69, 20, 0, 0, 90, 1, 0); -- Qadir Wing (Sky) yellow card

show tables;

select * from Teams;
select * from Players;
select * from Stadiums;
select * from Matches;
select * from PlayerStats;

SELECT P.Name,Ps.Goals,T.Team_Name
FROM Players P 
JOIN PlayerStats PS ON P.Player_Id = PS.Player_Id 
JOIN Teams T ON P.Team_Id = T.Team_Id 
WHERE PS.Goals = (SELECT MAX(Goals) FROM PlayerStats) and Team_Name="Ocean Warriors";

-- Queries 
-- 1
select P.Player_ID,P.Name,P.Position,T.Team_Name from Players P 
join Teams T 
on P.Team_Id = T.Team_Id 
where Team_Name="Thunder FC";

-- 2
Select * from Players where position="Midfielder" order by Age desc;

-- 3 
select Position,count(*) as No_of_Players from Players group by Position;