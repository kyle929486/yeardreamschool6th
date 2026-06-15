
CREATE TABLE Account
(
  account_ID INTEGER NOT NULL,
  Name       VARCHAR NULL    ,
  ID         INTEGER NOT NULL,
  PRIMARY KEY (account_ID),
  FOREIGN KEY (ID) REFERENCES Customer (ID)
);

CREATE TABLE Customer
(
  ID             INTEGER NOT NULL,
  Account_Number VARCHAR NOT NULL,
  Name           VARCHAR NOT NULL DEFAULT 홍길동,
  PRIMARY KEY (ID)
);
