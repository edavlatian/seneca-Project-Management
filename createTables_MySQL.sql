/*
  NOTE:
  
  IF YOU ARE CREATING THE TABLES FOR THE FIRST TIME YOU MUST REMOVE THE DROP TABLE COMMANDS SINCE THOSE TABLES
  WON'T EXIST YET.
*/

SET FOREIGN_KEY_CHECKS = 0;

/* DROP ALL TABLES */
DROP TABLE projectfile;
DROP TABLE teamprojectranking;
DROP TABLE teammember;
DROP TABLE comments;
DROP TABLE milestone;
DROP TABLE projects;
DROP TABLE teams;
DROP TABLE company;
DROP TABLE accounts;

CREATE TABLE accounts (
  userId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  userFName varchar(16) NOT NULL,
  userLName varchar(16) NOT NULL,
  userEmail varchar(50) NOT NULL,
  userIdentifier varchar(25) NOT NULL,
  userRole varchar(2) NOT NULL,
  password varchar(50) NOT NULL,
  accountStatus int DEFAULT 1
)TYPE=innodb;

CREATE TABLE teams (
  teamId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  teamIdentifier varchar(16) NOT NULL,
  teamEmail varchar(200) NOT NULL,
  teamStatus int DEFAULT 1,
  teamName varchar(20) NOT NULL,
  teamConstraints varchar(100) NOT NULL,
  projectId int,
  userId int NOT NULL,
  hasRegistered int DEFAULT 0,
  CONSTRAINT fk_UserId FOREIGN KEY (userId) REFERENCES accounts (userId) 
)TYPE=innodb;

CREATE TABLE company (
  companyId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  companyName varchar(25) NOT NULL,
  companyPhone varchar(12) NOT NULL,
  projectStatus int DEFAULT 0,
  repId int NOT NULL,
  CONSTRAINT fk_RepId FOREIGN KEY (repId) REFERENCES accounts (userId)
)TYPE=innodb;

CREATE TABLE projects (
  projectId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  prjIdentifier varchar(13) NOT NULL,
  status char(2) NOT NULL,
  prjName varchar(20),
  description varchar(500) NOT NULL,
  prjConstraints varchar(250) NOT NULL,
  agreementDate TIMESTAMP DEFAULT NOW(),
  companyId int NOT NULL,
  teamId int,
  instructorId int,
  CONSTRAINT fk_CompanyId FOREIGN KEY (companyId) REFERENCES COMPANY (companyId),
  CONSTRAINT fk_TeamId FOREIGN KEY (teamId) REFERENCES teams (teamId),
  CONSTRAINT fk_InstructorId FOREIGN KEY (instructorId) REFERENCES accounts(userId)
)TYPE=innodb;

ALTER TABLE teams ADD CONSTRAINT fk_ProjectId FOREIGN KEY (projectId) REFERENCES projects (projectId);

CREATE TABLE milestone (
  milestoneId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  description varchar(125) NOT NULL,
  projectId INTEGER NOT NULL,
  milestoneStatus char(2) DEFAULT 'NS',
  dueDate TIMESTAMP DEFAULT NOW(),
  CONSTRAINT fk_MilestoneProjectId FOREIGN KEY (projectId) REFERENCES projects (projectId) 
)TYPE=innodb;

CREATE TABLE comments (
  commentId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  commentStatus INT DEFAULT 0,
  commentDescription varchar(500) NOT NULL,
  projectId INT NOT NULL,
  CONSTRAINT fk_CommentProjectId FOREIGN KEY (projectId) REFERENCES projects (projectId)
)TYPE=innodb;

CREATE TABLE teammember (
  memberId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  firstName varchar(15) NOT NULL,
  lastName varchar(15) NOT NULL,
  email varchar(50) NOT NULL,
  image BLOB,
  description varchar(250),
  teamLeader INT DEFAULT 0,
  teamId INTEGER NOT NULL,
  CONSTRAINT fk_MemberTeamId FOREIGN KEY (teamId) REFERENCES teams (teamId)
)TYPE=innodb;

CREATE TABLE teamprojectranking (
  rankid int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  teamId INT NOT NULL,
  projectId INT NOT NULL,
  whoRanked varchar(1) NOT NULL,
  ranking INT NOT NULL,
  CONSTRAINT fk_RankingTeamId FOREIGN KEY (teamId) REFERENCES teams (teamId),
  CONSTRAINT fk_RankingProjectId FOREIGN KEY (projectId) REFERENCES projects (projectId)
)TYPE=innodb;

CREATE TABLE projectfile (
  fileId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  fileName varchar(16) NOT NULL,
  fileDescription varchar(120) NOT NULL,
  theFile varchar(500) NOT NULL,
  projectId INT NOT NULL,
  CONSTRAINT fk_FileProjectId FOREIGN KEY (projectId) REFERENCES projects (projectId)
)TYPE=innodb;

SET FOREIGN_KEY_CHECKS = 1;
