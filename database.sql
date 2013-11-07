-- ----------------------------
-- Table structure for `user`
-- ----------------------------
CREATE TABLE users (
	id int(11) ZEROFILL AUTO_INCREMENT ,
	account varchar(30) NOT NULL,
	name varchar(30) NOT NULL,
	password varchar(60) NOT NULL,
	PRIMARY KEY (id)
	);
-- ----------------------------
-- Table structure for `eyesight`
-- ----------------------------
CREATE TABLE eyesights(
	id int(11) ZEROFILL AUTO_INCREMENT ,
	eyesight double(3,2) UNSIGNED,
	time     timestamp,
	PRIMARY KEY (id)
);
-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO users (account,name,password) VALUES('gao','gaoaccount','gaopassword');
INSERT INTO users (account,name,password) VALUES('peng','pengaccount','pengpassword');
