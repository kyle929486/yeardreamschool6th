
CREATE TABLE Match
(
  ID        INT          NOT NULL,
  MatchDate DATETIME     NULL    ,
  Stadium   VARCHAR(255) NULL    ,
  Opponent  VARCHAR(255) NULL    ,
  Own_Score INT          NULL    ,
  Opp_Score INT          NULL    ,
  PRIMARY KEY (ID)
);

CREATE TABLE Match_Player
(
  MatchID  INT         NOT NULL,
  PlayerID INT         NOT NULL,
  Score    VARCHAR(10) NULL    ,
  ID       INT         NOT NULL,
  ID       INT         NOT NULL,
  PRIMARY KEY (MatchID, PlayerID),
  FOREIGN KEY (ID) REFERENCES Match (ID),
  FOREIGN KEY (ID) REFERENCES Player (ID)
);

CREATE TABLE Player
(
  ID           INT          NOT NULL,
  Name         VARCHAR(255) NULL    ,
  Age          INT          NULL    ,
  Season_Score INT          NULL    ,
  PRIMARY KEY (ID)
);
