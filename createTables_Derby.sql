/*
  For now I am manually dropping all constraints to prevent the issues I had when
  just simply dropping the tables. Might change this later so there is less code
  needed to do the same thing.
*/

/* PROJECTS Table Constraints */
ALTER TABLE PROJECTS DROP CONSTRAINT fk_CompanyId;
ALTER TABLE PROJECTS DROP CONSTRAINT fk_TeamId;
ALTER TABLE PROJECTS DROP CONSTRAINT fk_InstructorId;

/* TEAMS Table Constraints */
ALTER TABLE TEAMS DROP CONSTRAINT fk_UserId;
ALTER TABLE TEAMS DROP CONSTRAINT fk_ProjectId;

/* COMPANY Table Constraints */
ALTER TABLE COMPANY DROP CONSTRAINT fk_RepId;

/* MILESTONE Table Constraints */
ALTER TABLE MILESTONE DROP CONSTRAINT fk_MilestoneProjectId;

/* DROP ALL TABLES */
DROP TABLE MILESTONE;
DROP TABLE PROJECTS;
DROP TABLE TEAMS;
DROP TABLE COMPANY;
DROP TABLE USERS;

CREATE TABLE USERS (
  userId INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  userFName varchar(16) NOT NULL,
  userLName varchar(16) NOT NULL,
  userEmail varchar(30) NOT NULL,
  userIdentifier varchar(15) NOT NULL,
  userRole char(2) NOT NULL,
  password varchar(40) NOT NULL,
  accountStatus varchar(1) DEFAULT '1',
  CONSTRAINT pk_UserId PRIMARY KEY (userId)
);

CREATE TABLE TEAMS (
  teamId INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  teamIdentifier varchar(16) NOT NULL,
  teamEmail varchar(60) NOT NULL,
  teamStatus varchar(1) DEFAULT '1',
  teamName varchar(20) NOT NULL,
  projectConstraints varchar(100) NOT NULL,
  projectId INTEGER,
  userId INTEGER NOT NULL,
  CONSTRAINT fk_UserId FOREIGN KEY (userId) REFERENCES USERS (userId),
  CONSTRAINT pk_TeamId PRIMARY KEY (teamId)  
);

CREATE TABLE COMPANY (
  companyId INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  companyName varchar(25) NOT NULL,
  companyPhone varchar(12) NOT NULL,
  projectStatus varchar(1) DEFAULT '0',
  repId INTEGER NOT NULL,
  CONSTRAINT fk_RepId FOREIGN KEY (repId) REFERENCES USERS (userId),
  CONSTRAINT pk_CompanyId PRIMARY KEY (companyId)
);

CREATE TABLE PROJECTS (
  projectId INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  prjIdentifier varchar(13) NOT NULL,
  status char(2) NOT NULL,
  prjName varchar(20),
  description varchar(500) NOT NULL,
  prjConstraints varchar(250) NOT NULL,
  agreementDate DATE NOT NULL,
  companyId INTEGER NOT NULL,
  teamId INTEGER,
  instructorId INTEGER,
  CONSTRAINT fk_CompanyId FOREIGN KEY (companyId) REFERENCES COMPANY (companyId),
  CONSTRAINT fk_TeamId FOREIGN KEY (teamId) REFERENCES TEAMS (teamId),
  CONSTRAINT fk_InstructorId FOREIGN KEY (instructorId) REFERENCES USERS(userId),
  CONSTRAINT pk_ProjectId PRIMARY KEY (projectId) 
);

ALTER TABLE TEAMS ADD CONSTRAINT fk_ProjectId FOREIGN KEY (projectId) REFERENCES PROJECTS (projectId);

CREATE TABLE MILESTONE (
  milestoneId INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  description varchar(125) NOT NULL,
  projectId INTEGER NOT NULL,
  milestoneStatus char(2) DEFAULT 'NS',
  dueDate DATE NOT NULL,
  CONSTRAINT pk_MilestoneId PRIMARY KEY (milestoneId),
  CONSTRAINT fk_MilestoneProjectId FOREIGN KEY (projectId) REFERENCES PROJECTS (projectId) 
);