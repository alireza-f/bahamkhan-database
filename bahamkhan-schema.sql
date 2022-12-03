DROP SCHEMA IF EXISTS bahamkhan;
CREATE SCHEMA bahamkhan;
USE bahamkhan;

CREATE TABLE sgroup (
  sgroup_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  group_name VARCHAR(45) NOT NULL,
  create_date DATETIME NOT NULL,
  PRIMARY KEY (sgroup_id)
);

CREATE TABLE city (
  city_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  city VARCHAR(50) NOT NULL,
  PRIMARY KEY  (city_id)
);

CREATE TABLE siteuser (
  siteuser_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  city_id SMALLINT UNSIGNED NOT NULL,
  telephone VARCHAR(20) NOT NULL,
  mobile VARCHAR(20) NOT NULL,
  PRIMARY KEY (siteuser_id),
  CONSTRAINT `fk_city` FOREIGN KEY (city_id) REFERENCES city (city_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE category (
  category_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  category_name VARCHAR(25) NOT NULL,
  PRIMARY KEY  (category_id)
);

CREATE TABLE postcomment (
  comment_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  author_name VARCHAR(45) NOT NULL,
  email VARCHAR(50) NOT NULL,
  body TEXT DEFAULT NULL,

  PRIMARY KEY (comment_id)  
);

CREATE TABLE blogpost (
  post_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  siteuser_id SMALLINT UNSIGNED NOT NULL,
  post_title VARCHAR(45) NOT NULL,
  create_date DATETIME NOT NULL,
  post_text TEXT DEFAULT NULL,
  category_id TINYINT UNSIGNED NOT NULL,
  comment_id SMALLINT UNSIGNED NOT NULL,
  
  PRIMARY KEY (post_id, siteuser_id),
  
  CONSTRAINT `fk_category` FOREIGN KEY (category_id) REFERENCES category (category_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_siteuser` FOREIGN KEY (siteuser_id) REFERENCES siteuser (siteuser_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_postcomment` FOREIGN KEY (comment_id) REFERENCES postcomment (comment_id) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE groupmessage (
  message_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  create_date DATETIME NOT NULL,
  body TEXT DEFAULT NULL,

  PRIMARY KEY (message_id)
);

CREATE TABLE membership (
  sgroup_id SMALLINT UNSIGNED NOT NULL,
  siteuser_id SMALLINT UNSIGNED NOT NULL,
  membership_status BOOLEAN NOT NULL DEFAULT TRUE,
  message_id SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (sgroup_id, siteuser_id),
  
  CONSTRAINT `fk_sgroup` FOREIGN KEY (sgroup_id) REFERENCES sgroup (sgroup_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_message` FOREIGN KEY (message_id) REFERENCES groupmessage (message_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_user` FOREIGN KEY (siteuser_id) REFERENCES siteuser (siteuser_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

