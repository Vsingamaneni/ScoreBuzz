
--REGISTRATION TABLE SCHEMA
CREATE TABLE `REGISTER` (
  memberId INT(11) NOT NULL AUTO_INCREMENT,
  fname varchar(30),
  lname varchar(30),
  registeredTime varchar(30),
  email  VARCHAR(50),
  country VARCHAR(30),
  encryptedPass VARCHAR(50),
  saltKey VARCHAR(50),
  securityQuestion VARCHAR(50),
  securityAnswer VARCHAR(50),
  isActive VARCHAR(30),
  role VARCHAR(30),
  choice VARCHAR(30),
  PRIMARY KEY (memberId)
) ENGINE=InnoDB;
