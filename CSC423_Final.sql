CREATE TABLE Staff(
    staffNo NUMBER NOT NULL, 
    fName VARCHAR(20), 
    lName VARCHAR(20), 
    address VARCHAR(100), 
    salary NUMBER, 
    phoneNo CHAR(10) 
        CONSTRAINT staff_phoneNo_valid 
            CHECK (LENGTH(phoneNo) = 10),
    PRIMARY KEY(staffNo)
);
CREATE TABLE Client(
    clientNo NUMBER NOT NULL, 
    fName VARCHAR(20), 
    lName VARCHAR(20), 
    address VARCHAR(100), 
    phoneNo CHAR(10) 
        CONSTRAINT client_phoneNo_valid 
            CHECK (LENGTH(phoneNo) = 10),
    PRIMARY KEY(clientNo)
);

CREATE TABLE Equipment(
    equipmentNo NUMBER NOT NULL, 
    description VARCHAR(100), 
    usage VARCHAR(100), 
    cost NUMBER,
    PRIMARY KEY(equipmentNo)
);

CREATE TABLE Requirement(
    requirementNo NUMBER NOT NULL, 
    clientNo NUMBER NOT NULL, 
    startDate DATE, 
    endDate DATE
        CONSTRAINT endDate_valid
            CHECK(endDate >= startDate),
    days NUMBER
        CONSTRAINT requirement_days_valid
            CHECK (days <= 7),
    hours NUMBER
        CONSTRAINT requirement_hours_valid
            CHECK (hours <= 24),
    PRIMARY KEY(requirementNo),
    FOREIGN KEY(clientNo) REFERENCES Client(clientNo) ON DELETE CASCADE
);

CREATE TABLE Service(
    staffNo NUMBER NOT NULL, 
    requirementNo NUMBER NOT NULL, 
    date DATE, 
    hours NUMBER
        CONSTRAINT service_hours_valid
            CHECK (hours <= 24),
    PRIMARY KEY(staffNo, requirementNo),
    FOREIGN KEY(clientNo) REFERENCES Client(clientNo) ON DELETE CASCADE
);

INSERT INTO Staff
VALUES(1, 'James', 'Brown', '1222 Lake Dr, Miami, FL 33146', 35000, '3054056678');
INSERT INTO Staff
VALUES(2, 'Sally', 'Brown', '1678 Ocean Dr, Miami, FL 33146', 37000, '3052349909');
INSERT INTO Staff
VALUES(3, 'Kate', 'Loll', '602 Cactus St, Miami, FL 33146', 26000, '3054329858');
INSERT INTO Staff
VALUES(4, 'Kate', 'Myner', '434 Rollings Ave, Miami, FL 33146', 28000, '3058986656');
INSERT INTO Staff
VALUES(5, 'Sam', 'Smith', '234 Moss St, Miami, FL 33146', 35000, '3051993844');

INSERT INTO Client
VALUES(1, 'Percy', 'Martin', '654 Carmine Dr, Miami, FL 33146', '3054338575');
INSERT INTO Client
VALUES(2, 'Mira', 'Ramesh', '4949 Marigold St, Miami, FL 33146', '3053339483');
INSERT INTO Client
VALUES(3, 'Ashley', 'Rodriguez', '1700 Gunstock Dr, Suite 104, Miami, FL 33146', '3052227373');
INSERT INTO Client
VALUES(4, 'Lindsey', 'Schmidt', '1144 Cooper Ave, Miami, FL 33146', '3058483332');
INSERT INTO Client
VALUES(5, 'Arnold', 'Schwartz', '3202 Heavens St, Suite 203, Miami, FL 33146', '3051129484');

INSERT INTO Equipment
VALUES(1, 'Industrial floor cleaner', 'Two of five services', 1200);
INSERT INTO Equipment
VALUES(2, 'Stain remover', 'Every three services', 65);
INSERT INTO Equipment
VALUES(3, 'Power washer', 'One of six services', 1200);
INSERT INTO Equipment
VALUES(4, 'Power vacuum', 'Three of six services', 540);
INSERT INTO Equipment
VALUES(5, 'Floor buffer', 'One of eight services', 1000);

INSERT INTO Requirement
VALUES(1, 1, date '2020-12-01', date '2021-12-01', 3, 4);
INSERT INTO Requirement
VALUES(2, 2, date '2020-12-10', date '2020-12-31', 2, 6);
INSERT INTO Requirement
VALUES(3, 3, date '2021-01-10', date '2021-02-25', 1, 2);
INSERT INTO Requirement
VALUES(4, 4, date '2020-12-15', date '2021-03-05', 7, 2);
INSERT INTO Requirement
VALUES(5, 5, date '2021-02-01', date '2021-05-01', 4, 1);

INSERT INTO Service
VALUES(1, 3, date '2021-01-15', 2);
INSERT INTO Service
VALUES(1, 4, date '2021-01-10', 2);
INSERT INTO Service
VALUES(3, 2, date '2020-12-26', 6);
INSERT INTO Service
VALUES(2, 1, date '2021-05-17', 4);
INSERT INTO Service
VALUES(4, 5, date '2021-03-01', 1);

INSERT INTO Use
VALUES(2, 3, date '2021-01-15', 2);
INSERT INTO Use
VALUES(5, 4, date '2021-01-10', 2);
INSERT INTO Use
VALUES(1, 2, date '2020-12-26', 6);
INSERT INTO Use
VALUES(4, 1, date '2021-05-17', 4);
INSERT INTO Use
VALUES(3, 5, date '2021-03-01', 1);

