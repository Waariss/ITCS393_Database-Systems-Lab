-- Credit: https://github.com/bbrumm/databasestar/blob/main/sample_databases/sample_db_superheroes/mysql/01_reference_data.sql
DROP DATABASE IF EXISTS superhero;
CREATE DATABASE superhero;

USE superhero;

DROP TABLE IF EXISTS superhero.alignment;
CREATE TABLE superhero.alignment (
  id INT NOT NULL AUTO_INCREMENT,
  alignment varchar(10) DEFAULT NULL,
  CONSTRAINT pk_alignment PRIMARY KEY (id)
);

INSERT INTO superhero.alignment (id, alignment) VALUES
(1,'Good'),
(2,'Bad'),
(3,'Neutral'),
(4,'N/A');

DROP TABLE IF EXISTS superhero.attribute;
CREATE TABLE superhero.attribute (
  id INT NOT NULL AUTO_INCREMENT,
  attribute_name varchar(200) DEFAULT NULL,
  CONSTRAINT pk_attribute PRIMARY KEY (id)
);

INSERT INTO superhero.attribute (id, attribute_name) VALUES
(1,'Intelligence'),
(2,'Strength'),
(3,'Speed'),
(4,'Durability'),
(5,'Power'),
(6,'Combat');


DROP TABLE IF EXISTS superhero.color;
CREATE TABLE superhero.color (
  id INT NOT NULL AUTO_INCREMENT,
  color varchar(20) DEFAULT NULL,
  CONSTRAINT pk_color PRIMARY KEY (id)
);


DROP TABLE IF EXISTS superhero.gender;
CREATE TABLE superhero.gender (
  id INT NOT NULL AUTO_INCREMENT,
  gender varchar(20) DEFAULT NULL,
  CONSTRAINT pk_gender PRIMARY KEY (id)
);
INSERT INTO superhero.gender (id, gender) VALUES
(1,'Male'),
(2,'Female'),
(3,'N/A');

DROP TABLE IF EXISTS superhero.publisher;
CREATE TABLE superhero.publisher (
  id INT NOT NULL AUTO_INCREMENT,
  publisher_name varchar(50) DEFAULT NULL,
  CONSTRAINT pk_publisher PRIMARY KEY (id)
);

INSERT INTO superhero.publisher (id, publisher_name) VALUES
(1,''),
(2,'ABC Studios'),
(3,'Dark Horse Comics'),
(4,'DC Comics'),
(5,'George Lucas'),
(6,'Hanna-Barbera'),
(7,'HarperCollins'),
(8,'Icon Comics'),
(9,'IDW Publishing'),
(10,'Image Comics'),
(11,'J. K. Rowling'),
(12,'J. R. R. Tolkien'),
(13,'Marvel Comics'),
(14,'Microsoft'),
(15,'NBC - Heroes'),
(16,'Rebellion'),
(17,'Shueisha'),
(18,'Sony Pictures'),
(19,'South Park'),
(20,'Star Trek'),
(21,'SyFy'),
(22,'Team Epic TV'),
(23,'Titan Books'),
(24,'Universal Studios'),
(25,'Wildstorm');

DROP TABLE IF EXISTS superhero.race;
CREATE TABLE superhero.race (
  id INT NOT NULL AUTO_INCREMENT,
  race varchar(100) DEFAULT NULL,
  CONSTRAINT pk_race PRIMARY KEY (id)
);


DROP TABLE IF EXISTS superhero.superhero;
CREATE TABLE superhero.superhero (
  id INT NOT NULL AUTO_INCREMENT,
  superhero_name VARCHAR(200) DEFAULT NULL,
  full_name VARCHAR(200) DEFAULT NULL,
  gender_id INT DEFAULT NULL,
  eye_color_id INT DEFAULT NULL,
  hair_color_id INT DEFAULT NULL,
  skin_color_id INT DEFAULT NULL,
  race_id INT DEFAULT NULL,
  publisher_id INT DEFAULT NULL,
  alignment_id INT DEFAULT NULL,
  height_cm INT DEFAULT NULL,
  weight_kg INT DEFAULT NULL,
  CONSTRAINT pk_superhero PRIMARY KEY (id),
  CONSTRAINT fk_sup_align FOREIGN KEY (alignment_id) REFERENCES superhero.alignment (id),
  CONSTRAINT fk_sup_eyecol FOREIGN KEY (eye_color_id) REFERENCES superhero.color (id),
  CONSTRAINT fk_sup_gen FOREIGN KEY (gender_id) REFERENCES superhero.gender (id),
  CONSTRAINT fk_sup_haircol FOREIGN KEY (hair_color_id) REFERENCES superhero.color (id),
  CONSTRAINT fk_sup_pub FOREIGN KEY (publisher_id) REFERENCES superhero.publisher (id),
  CONSTRAINT fk_sup_race FOREIGN KEY (race_id) REFERENCES superhero.race (id),
  CONSTRAINT fk_sup_skincol FOREIGN KEY (skin_color_id) REFERENCES superhero.color (id)
);


DROP TABLE IF EXISTS superhero.superpower;
CREATE TABLE superhero.superpower (
  id INT NOT NULL AUTO_INCREMENT,
  power_name varchar(200) DEFAULT NULL,
  CONSTRAINT pk_superpower PRIMARY KEY (id)
);


COMMIT;

DROP TABLE IF EXISTS superhero.hero_attribute;
CREATE TABLE superhero.hero_attribute (
  hero_id INT DEFAULT NULL,
  attribute_id INT DEFAULT NULL,
  attribute_value INT DEFAULT NULL,
  CONSTRAINT fk_hat_at FOREIGN KEY (attribute_id) REFERENCES attribute (id),
  CONSTRAINT fk_hat_hero FOREIGN KEY (hero_id) REFERENCES superhero (id)
);


DROP TABLE IF EXISTS superhero.hero_power;
CREATE TABLE superhero.hero_power (
  hero_id INT DEFAULT NULL,
  power_id INT DEFAULT NULL,
  CONSTRAINT fk_hpo_hero FOREIGN KEY (hero_id) REFERENCES superhero.superhero (id),
  CONSTRAINT fk_hpo_po FOREIGN KEY (power_id) REFERENCES superhero.superpower (id)
);

COMMIT;