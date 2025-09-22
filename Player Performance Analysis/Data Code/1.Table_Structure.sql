Create Database Player_Performance_Analysis_DB;
use Player_Performance_Analysis_DB;

# Players Table
CREATE TABLE Players (
    player_id INT PRIMARY KEY ,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    nationality VARCHAR(50) NOT NULL,
    position ENUM('Goalkeeper', 'Defender', 'Midfielder', 'Forward') NOT NULL,
    preferred_number INT,
    market_value DECIMAL(10,2)  -- in millions
);

# Teams Table 
CREATE TABLE Teams (
    team_id INT PRIMARY KEY ,
    team_name VARCHAR(100) NOT NULL UNIQUE,
    founded_year INT,
    home_stadium VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL
);


# Competition Table
CREATE TABLE Competitions (
    competition_id INT PRIMARY KEY ,
    competition_name VARCHAR(100) NOT NULL UNIQUE,
    competition_type ENUM('League', 'Cup', 'International', 'Friendly') NOT NULL,
    country VARCHAR(50),
    season VARCHAR(20) NOT NULL  -- e.g., 2023/2024
);

# Matches Table
CREATE TABLE Matches (
    match_id INT PRIMARY KEY ,
    competition_id INT NOT NULL,
    home_team_id INT NOT NULL,
    away_team_id INT NOT NULL,
    match_date DATETIME NOT NULL,
    venue VARCHAR(100),
    home_score INT ,
    away_score INT ,
    FOREIGN KEY (competition_id) REFERENCES Competitions(competition_id),
    FOREIGN KEY (home_team_id) REFERENCES Teams(team_id),
    FOREIGN KEY (away_team_id) REFERENCES Teams(team_id)
);

# PlayerPerformance Table (simplified)
CREATE TABLE PlayerPerformance (
    performance_id INT PRIMARY KEY ,
    player_id INT NOT NULL,
    match_id INT NOT NULL,
    minutes_played INT ,
    goals INT ,
    assists INT ,
    shots INT ,
    shots_on_target INT ,
    passes INT ,
    pass_accuracy DECIMAL(5,2),
    tackles INT ,
    yellow_cards INT ,
    red_cards INT ,
    rating DECIMAL(3,1),            -- player rating (0-10)
    FOREIGN KEY (player_id) REFERENCES Players(player_id),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id)
);

# PlayerFitness Table 
CREATE TABLE PlayerFitness (
    fitness_id INT PRIMARY KEY ,
    player_id INT NOT NULL,
    record_date DATE NOT NULL,
    injury_status ENUM('Fit', 'Injured', 'Recovering') NOT NULL DEFAULT 'Fit',
    injury_type VARCHAR(100),
    injury_severity ENUM('Minor', 'Moderate', 'Severe'),
    expected_recovery_date DATE,
    fitness_level TINYINT ,  -- percentage (0-100)
    FOREIGN KEY (player_id) REFERENCES Players(player_id)
);

# PlayerContracts Table
CREATE TABLE PlayerContracts (
    contract_id INT PRIMARY KEY ,
    player_id INT NOT NULL,
    team_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    salary DECIMAL(12,2) NOT NULL,  -- weekly salary
    jersey_number INT ,
    contract_type ENUM('Full', 'Loan', 'Academy'),
    FOREIGN KEY (player_id) REFERENCES Players(player_id),
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);

show tables;