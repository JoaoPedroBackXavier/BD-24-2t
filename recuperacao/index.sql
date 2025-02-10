CREATE DATABASE GAME

/*
	já que todas as tabelas tinham Fore keys eu criei as tabelas com as Primary keys e depois alterei pra botar as fore keys
*/


CREATE TABLE Team(
   ID_Team NUMERIC PRIMARY KEY,
    team_name VARCHAR(255)
);

CREATE TABLE GameMatch(
    ID_GameMatch NUMERIC PRIMARY KEY,
    match_Results NUMERIC,
    match_Duration TIME,
    match_Date_Time DATE
);

CREATE TABLE Player (
    ID_Player NUMERIC PRIMARY KEY,
    player_Level NUMERIC,
    player_Score NUMERIC,
    player_Region VARCHAR(255),
    player_User_name VARCHAR(255)
);

CREATE TABLE Champion(
    ID_Champion NUMERIC PRIMARY KEY,
    champion_Name VARCHAR(255),
    Ability VARCHAR(255),
    Damage_Type VARCHAR(50),
    champion_Function VARCHAR(255)
);

CREATE TABLE Player_Match_Game(
    Player_Points NUMERIC,
    Teams_Points NUMERIC,
    fk_Player_ID_Player NUMERIC,
    fk_Match_ID_Match NUMERIC
);

CREATE TABLE Item(
    ID_Item NUMERIC primary key,
    item_Cost NUMERIC,
    item_Description VARCHAR(255),
    item_Effect VARCHAR(255),
    item_Name VARCHAR(255)
);

CREATE TABLE Offensive(
    Physic_Damage NUMERIC,
    Magic_Damage NUMERIC,
    fk_Item_ID_Item NUMERIC PRIMARY KEY
);

CREATE TABLE Defensive(
    Armor NUMERIC,
    Res_Magic NUMERIC,
    fk_Item_ID_Item NUMERIC PRIMARY KEY
);

CREATE TABLE Consumable(
    Potion NUMERIC,
    fk_Item_ID_Item NUMERIC PRIMARY KEY
);

ALTER TABLE Team ADD COLUMN fk_Match_ID_Match NUMERIC;
ALTER TABLE Team ADD CONSTRAINT fk_team_match FOREIGN KEY (fk_Match_ID_Match) references GameMatch(ID_GameMatch)

ALTER TABLE Player ADD COLUMN fk_Team_ID_Team NUMERIC;
ALTER TABLE Player ADD CONSTRAINT fk_player_team FOREIGN KEY (fk_Team_ID_Team) references Team(ID_Team)

ALTER TABLE Champion ADD COLUMN fk_Player_ID_Player NUMERIC;
ALTER TABLE Champion ADD CONSTRAINT fk_champion_player FOREIGN KEY (fk_Player_ID_Player) references Player(ID_Player)

ALTER TABLE GameMatch ADD COLUMN fk_Champion_ID_Champion NUMERIC;
ALTER TABLE GameMatch ADD CONSTRAINT fk_match_champion FOREIGN KEY (fk_Champion_ID_Champion) references Champion(ID_Champion)

ALTER TABLE Player_Match_Game ADD CONSTRAINT fk_player_match FOREIGN KEY (fk_Player_ID_Player) references Player(ID_Player)
ALTER TABLE Player_Match_Game ADD CONSTRAINT fk_match_player FOREIGN KEY (fk_Match_ID_Match) references GameMatch(ID_GameMatch)

ALTER TABLE Item ADD COLUMN fk_Match_ID_Match NUMERIC;
ALTER TABLE Item ADD CONSTRAINT fk_item_match FOREIGN KEY (fk_Match_ID_Match) references GameMatch(ID_GameMatch)

ALTER TABLE Offensive ADD CONSTRAINT fk_offensive_item FOREIGN KEY (fk_Item_ID_Item) references Item(ID_Item)
ALTER TABLE Defensive ADD CONSTRAINT fk_defensive_item FOREIGN KEY (fk_Item_ID_Item) references Item(ID_Item)
ALTER TABLE Consumable ADD CONSTRAINT fk_consumable_item FOREIGN KEY (fk_Item_ID_Item) references Item(ID_Item)

INSERT INTO Team (ID_Team, team_name) VALUES
(1, 'Warriors'),
(2, 'Titans'),
(3, 'Dragons'),
(4, 'Shadow Ninjas'),
(5, 'Storm Bringers')

INSERT INTO GameMatch (ID_GameMatch, match_Results, match_Duration, match_Date_Time) VALUES
(1, 10, '00:30:00', '2024-02-01'),
(2, 15, '00:45:00', '2024-02-02'),
(3, 8, '00:25:00', '2024-02-03'),
(4, 20, '01:00:00', '2024-02-04'),
(5, 12, '00:40:00', '2024-02-05')

INSERT INTO Player (ID_Player, player_Level, player_Score, player_Region, player_User_name, fk_Team_ID_Team) VALUES
(1, 5, 1200, 'NA', 'PlayerOne', 1),
(2, 7, 1500, 'EU', 'ShadowMaster', 2),
(3, 6, 1400, 'ASIA', 'DragonSlayer', 3),
(4, 4, 1000, 'NA', 'StealthNinja', 4),
(5, 8, 1800, 'EU', 'StormBreaker', 5)

INSERT INTO Champion (ID_Champion, champion_Name, Ability, Damage_Type, champion_Function, fk_Player_ID_Player) VALUES
(1, 'Blaze', 'Fireball', 'Magic', 'Mage', 1),
(2, 'Thor', 'Hammer Strike' ,'Physical', 'Warrior', 2),
(3, 'Aqua', 'Water Shield' ,'Magic', 'Support', 3),
(4, 'Rogue' ,'Shadow Step', 'Physical', 'Assassin', 4),
(5, 'Titan', 'Earthquake', 'Physical', 'Tank', 5)

INSERT INTO Player_Match_Game (Player_Points, Teams_Points, fk_Player_ID_Player, fk_Match_ID_Match) VALUES
(10, 50, 1, 1),
(15, 60, 2, 2),
(8, 45, 3, 3),
(20, 80, 4, 4),
(12, 55, 5, 5);

INSERT INTO Item (ID_Item, item_Cost, item_Description, item_Effect, item_Name, fk_Match_ID_Match) VALUES
(1,500, 'Boosts magic power', 'Increase Magic Damage' ,'Magic Wand',1),
(2,700, 'Enhances physical attacks', 'Increase Attack Damage', 'Warrior Sword',2),
(3,300, 'Restores health', 'Health Regen' ,'Healing Potion',3),
(4,400, 'Provides extra shield' ,'Increase Defense', 'Shield of Valor',4),
(5,600, 'Increases agility', 'Speed Boost' ,'Swift Boots',5);

INSERT INTO Offensive (Physic_Damage, Magic_Damage, fk_Item_ID_Item) VALUES
(50,0, 2),
(0, 60, 1),
(30, 30, 5),
(70, 0, 4),
(0, 80, 3);

INSERT INTO Defensive (Armor, Res_Magic, fk_Item_ID_Item) VALUES
(20, 30, 4),
(50, 0, 2),
(0, 40, 1),
(35, 25, 5),
(45, 10, 3);

INSERT INTO Consumable (Potion, fk_Item_ID_Item) VALUES
(1, 3),
(2, 1),
(1, 5),
(3, 4),
(2, 2);

-- só vou usar o inner join porque eu ja tenho todos os dados com correspondecias diretas

CREATE VIEW Partida AS
select GameMatch.match_Results AS "Match results",GameMatch.match_Duration AS "Duration", GameMatch.match_Date_Time AS "Date and Time",
Item.item_Name AS "item",
Champion.champion_Name AS "champion"
from GameMatch
join Item ON GameMatch.ID_GameMatch = Item.fk_Match_ID_Match
join Champion ON GameMatch.ID_GameMatch = Champion.fk_Player_ID_Player

CREATE VIEW Player_view AS
select Player.Player_User_Name AS "user name", Player.Player_Level AS "level", Player.Player_Score AS "Score",
Team.team_name AS "Team name"
from Player
join Team on Player.ID_Player = Team.ID_Team

CREATE VIEW Team_view AS
select Team.Team_Name AS "name",
Player.player_User_name AS "player name",
GameMatch.match_Duration AS "match duration", GameMatch.match_Date_Time AS "Match date and time"
from Team
join Player ON Team.ID_Team = Player.ID_Player
join GameMatch ON Team.ID_Team = GameMatch.ID_GameMatch

CREATE INDEX TeamName_index ON Team(Team_Name);
CREATE INDEX MatchDateTime_index ON GameMatch(match_Date_Time);
CREATE INDEX MatchDuration_index ON GameMatch(match_Duration);
CREATE INDEX PlayerUserName_index ON Player(Player_User_Name);
CREATE INDEX PlayerLevel_index ON Player(player_Level);