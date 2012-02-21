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
  userId int AUTO_INCREMENT PRIMARY KEY,
  userIdentifier varchar(25) NOT NULL UNIQUE,
  userFName varchar(16) NOT NULL,
  userLName varchar(16) NOT NULL,
  userEmail varchar(50) NOT NULL,
  userRole varchar(2) NOT NULL,
  password varchar(50) NOT NULL,
  accountStatus int DEFAULT 1
);

CREATE TABLE teams (
  teamId int AUTO_INCREMENT PRIMARY KEY,
  teamEmail varchar(400) NOT NULL,
  teamStatus int DEFAULT 1,
  teamName varchar(20),
  teamConstraints varchar(120),
  teamDescription varchar(400),
  /*
    teamLogo will contain the address of the location of the picture
    that was saved to the server.
  */
  teamLogo varchar(200),
  projectId int,
  hasRegistered int DEFAULT 0,
  userId int NOT NULL,
  CONSTRAINT fk_TeamAccount FOREIGN KEY (userId) REFERENCES accounts (userId) 
);

CREATE TABLE company (
  companyId int AUTO_INCREMENT PRIMARY KEY,
  companyName varchar(25) NOT NULL,
  companyPhone varchar(12) NOT NULL,
  userId int NOT NULL,
  CONSTRAINT fk_CompanyAccount FOREIGN KEY (userId) REFERENCES accounts (userId)
);

CREATE TABLE projects (
  projectId int AUTO_INCREMENT PRIMARY KEY,
  status varchar(2) NOT NULL,
  prjName varchar(20) NOT NULL,
  description varchar(500) NOT NULL,
  prjConstraints varchar(250) NOT NULL,
  agreementDate TIMESTAMP DEFAULT NOW(),
  companyId int NOT NULL,
  teamId int,
  instructorId int,
  CONSTRAINT fk_CompanyId FOREIGN KEY (companyId) REFERENCES COMPANY (companyId),
  CONSTRAINT fk_TeamId FOREIGN KEY (teamId) REFERENCES teams (teamId),
  CONSTRAINT fk_InstructorId FOREIGN KEY (instructorId) REFERENCES accounts(userId)
);

ALTER TABLE teams ADD CONSTRAINT fk_ProjectId FOREIGN KEY (projectId) REFERENCES projects (projectId);

CREATE TABLE milestone (
  milestoneId int AUTO_INCREMENT PRIMARY KEY,
  description varchar(125) NOT NULL,
  projectId INTEGER NOT NULL,
  milestoneStatus char(2) DEFAULT 'NS',
  dueDate TIMESTAMP DEFAULT NOW(),
  CONSTRAINT fk_MilestoneProjectId FOREIGN KEY (projectId) REFERENCES projects (projectId) 
);

CREATE TABLE comments (
  commentId int AUTO_INCREMENT PRIMARY KEY,
  commentStatus INT DEFAULT 0,
  commentDescription varchar(500) NOT NULL,
  projectId INT NOT NULL,
  CONSTRAINT fk_CommentProjectId FOREIGN KEY (projectId) REFERENCES projects (projectId)
);

CREATE TABLE teammember (
  memberId int AUTO_INCREMENT PRIMARY KEY,
  firstName varchar(15) NOT NULL,
  lastName varchar(15) NOT NULL,
  email varchar(50) NOT NULL,
  /*
    memberImage will contain the address of the location of the picture
    that was saved to the server.
  */
  memberImage varchar(200),
  description varchar(250),
  teamLeader INT DEFAULT 0,
  teamId INTEGER NOT NULL,
  CONSTRAINT fk_MemberTeamId FOREIGN KEY (teamId) REFERENCES teams (teamId)
);

CREATE TABLE teamprojectranking (
  rankId int AUTO_INCREMENT PRIMARY KEY,
  teamId INT NOT NULL,
  projectId INT NOT NULL,
  whoRanked varchar(1) NOT NULL,
  ranking INT NOT NULL,
  whenRanked varchar(3),
  CONSTRAINT fk_RankingTeamId FOREIGN KEY (teamId) REFERENCES teams (teamId),
  CONSTRAINT fk_RankingProjectId FOREIGN KEY (projectId) REFERENCES projects (projectId)
);

CREATE TABLE projectfile (
  fileId int AUTO_INCREMENT PRIMARY KEY,
  fileName varchar(40) NOT NULL,
  fileDescription varchar(120) NOT NULL,
  theFile varchar(500) NOT NULL,
  projectId INT NOT NULL,
  CONSTRAINT fk_FileProjectId FOREIGN KEY (projectId) REFERENCES projects (projectId)
);

SET FOREIGN_KEY_CHECKS = 1;
