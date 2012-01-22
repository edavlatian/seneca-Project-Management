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

/* COMMENT Table Constraints */
ALTER TABLE COMMENTS DROP CONSTRAINT fk_CommentProjectId;

/* TEAMMEMBER Table Constraints */
ALTER TABLE TEAMMEMBER DROP CONSTRAINT fk_MemberTeamId;

/* TEAMPROJECTRANKING Table Constraints */
ALTER TABLE TEAMPROJECTRANKING DROP CONSTRAINT fk_RankingTeamId;
ALTER TABLE TEAMPROJECTRANKING DROP CONSTRAINT fk_RankingProjectId;

/* PROJECTFILE Table Constraints */
ALTER TABLE PROJECTFILE DROP CONSTRAINT fk_FileProjectId;

/* DROP ALL TABLES */
DROP TABLE PROJECTFILE;
DROP TABLE TEAMPROJECTRANKING;
DROP TABLE TEAMMEMBER;
DROP TABLE COMMENTS;
DROP TABLE MILESTONE;
DROP TABLE PROJECTS;
DROP TABLE TEAMS;
DROP TABLE COMPANY;
DROP TABLE USERS;

CREATE TABLE USERS (
  userId INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  userFName varchar(16) NOT NULL,
  userLName varchar(16) NOT NULL,
  userEmail varchar(50) NOT NULL,
  userIdentifier varchar(25) NOT NULL,
  userRole char(2) NOT NULL,
  password varchar(50) NOT NULL,
  accountStatus SMALLINT DEFAULT 1,
  CONSTRAINT pk_UserId PRIMARY KEY (userId)
);

CREATE TABLE TEAMS (
  teamId INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  teamIdentifier varchar(16) NOT NULL,
  teamEmail varchar(200) NOT NULL,
  teamStatus SMALLINT DEFAULT 1,
  teamName varchar(20) NOT NULL,
  teamConstraints varchar(100) NOT NULL,
  projectId INTEGER,
  userId INTEGER NOT NULL,
  hasRegistered SMALLINT DEFAULT 0,
  CONSTRAINT fk_UserId FOREIGN KEY (userId) REFERENCES USERS (userId),
  CONSTRAINT pk_TeamId PRIMARY KEY (teamId)  
);

CREATE TABLE COMPANY (
  companyId INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  companyName varchar(25) NOT NULL,
  companyPhone varchar(12) NOT NULL,
  projectStatus SMALLINT DEFAULT 0,
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

CREATE TABLE COMMENTS (
  commentId INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  commentStatus SMALLINT DEFAULT 0,
  commentDescription varchar(500) NOT NULL,
  projectId INTEGER NOT NULL,
  CONSTRAINT pk_CommentId PRIMARY KEY (commentId),
  CONSTRAINT fk_CommentProjectId FOREIGN KEY (projectId) REFERENCES PROJECTS (projectId)
);

CREATE TABLE TEAMMEMBER (
  memberId INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  firstName varchar(15) NOT NULL,
  lastName varchar(15) NOT NULL,
  email varchar(50) NOT NULL,
  image BLOB,
  description varchar(250),
  teamLeader SMALLINT DEFAULT 0,
  teamId INTEGER,
  CONSTRAINT pk_MemberId PRIMARY KEY (memberId),
  CONSTRAINT fk_MemberTeamId FOREIGN KEY (teamId) REFERENCES TEAMS (teamId)
);

CREATE TABLE TEAMPROJECTRANKING (
  teamId INTEGER NOT NULL,
  projectId INTEGER NOT NULL,
  whoRanked char(1) NOT NULL,
  ranking SMALLINT NOT NULL,
  CONSTRAINT pk_TeamProjectRanking PRIMARY KEY (teamId, projectId, whoRanked),
  CONSTRAINT fk_RankingTeamId FOREIGN KEY (teamId) REFERENCES TEAMS (teamId),
  CONSTRAINT fk_RankingProjectId FOREIGN KEY (projectId) REFERENCES PROJECTS (projectId)
);

CREATE TABLE PROJECTFILE (
  fileId INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
  fileName varchar(16) NOT NULL,
  fileDescription varchar(120) NOT NULL,
  theFile BLOB NOT NULL,
  projectId INTEGER NOT NULL,
  CONSTRAINT pk_FileId PRIMARY KEY (fileId),
  CONSTRAINT fk_FileProjectId FOREIGN KEY (projectId) REFERENCES PROJECTS (projectId)
);

