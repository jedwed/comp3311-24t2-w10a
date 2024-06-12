CREATE TABLE players (
    name text PRIMARY KEY,
    playsFor text NOT NULL
);

CREATE TABLE teams (
    name text PRIMARY KEY,
    captain text REFERENCES players (name)
);

ALTER TABLE players ADD FOREIGN KEY (playsFor) REFERENCES teams (name);

CREATE TABLE fans (
    name text PRIMARY KEY
);

CREATE TABLE teamColors (
    team text REFERENCES teams (name),
    color text,
    PRIMARY KEY (team, color)
);

CREATE TABLE fanFavColors (
    fan text REFERENCES fans (name),
    color text,
    PRIMARY KEY (fan, color)
);

CREATE TABLE favPlayers (
    fan text REFERENCES fans (name),
    player text REFERENCES players (name),
    PRIMARY KEY (fan, player)
);

CREATE TABLE favTeams (
    fan text REFERENCES fans (name),
    team text REFERENCES teams (name),
    PRIMARY KEY (fan, team)
);
