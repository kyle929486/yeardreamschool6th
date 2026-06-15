
CREATE TABLE ATM
(
  ID       INTEGER NOT NULL,
  Location VARCHAR NULL    ,
  ID       INTEGER NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE Customer
(
  ID              INTEGER NOT NULL,
  Name            VARCHAR NOT NULL,
  Account_Number  VARCHAR NULL    ,
  PIN             VARCHAR NULL    ,
  Account_Balance DECIMAL NULL    ,
  PRIMARY KEY (ID)
);

CREATE TABLE Transaction
(
  ID     INTEGER NOT NULL,
  Date   DATE    NULL    ,
  Time   TIME    NULL    ,
  Amount DECIMAL NULL    ,
  ID     INTEGER NOT NULL,
  PRIMARY KEY (ID)
);

ALTER TABLE Transaction
  ADD CONSTRAINT FK_Customer_TO_Transaction
    FOREIGN KEY (ID)
    REFERENCES Customer (ID);

ALTER TABLE ATM
  ADD CONSTRAINT FK_Transaction_TO_ATM
    FOREIGN KEY (ID)
    REFERENCES Transaction (ID);
