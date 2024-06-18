CREATE DATABASE MSPR3;
USE MSPR3;

CREATE TABLE ASSOCIER (
  serial_number VARCHAR(255) NOT NULL,
  incident_id VARCHAR(255) NOT NULL,
  PRIMARY KEY (serial_number, incident_id)
);

CREATE TABLE CLIENT (
  name VARCHAR(255) PRIMARY KEY NOT NULL,
  address VARCHAR(255),
  person_id VARCHAR(255) NOT NULL
);

CREATE TABLE COMPOSANT (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  name VARCHAR(255),
  version VARCHAR(10),
  IAC BOOL
);

CREATE TABLE CONTENIR (
  version_id VARCHAR(255) NOT NULL,
  script_id VARCHAR(255) NOT NULL,
  PRIMARY KEY (version_id, script_id)
);

CREATE TABLE DEPLOYER (
  siret CHAR(14) NOT NULL,
  serial_number VARCHAR(255) NOT NULL,
  PRIMARY KEY (siret, serial_number)
);

CREATE TABLE GERER (
  siret CHAR(14) NOT NULL,
  client_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (siret, client_name)
);

CREATE TABLE HARVESTER (
  serial_number VARCHAR(255) PRIMARY KEY NOT NULL,
  name VARCHAR(255),
  lan_ip VARCHAR(255),
  vpn_ip VARCHAR(255),
  state VARCHAR(255),
  os_id VARCHAR(255) NOT NULL,
  version_id VARCHAR(255) NOT NULL
);

CREATE TABLE INCIDENT (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  date_time TIMESTAMP,
  reason VARCHAR(255),
  person_id VARCHAR(255) NOT NULL
);

CREATE TABLE INCLURE (
  script_id VARCHAR(255) NOT NULL,
  component_id VARCHAR(255) NOT NULL,
  PRIMARY KEY (script_id, component_id)
);

CREATE TABLE OS (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  name VARCHAR(255),
  version VARCHAR(10),
  cpu VARCHAR(42),
  ram VARCHAR(42),
  capacity INTEGER
);

CREATE TABLE PERSON (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  name VARCHAR(255),
  email VARCHAR(255),
  phone VARCHAR(20),
  address VARCHAR(255),
  role VARCHAR(255)
);

CREATE TABLE PRESTATAIRE (
  siret CHAR(14) PRIMARY KEY NOT NULL,
  address VARCHAR(255)
);

CREATE TABLE REPRESENTER (
  siret CHAR(14) NOT NULL,
  person_id VARCHAR(255) NOT NULL,
  PRIMARY KEY (siret, person_id)
);

CREATE TABLE SCRIPT (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  name VARCHAR(255)
);

CREATE TABLE TRAITER (
  incident_id VARCHAR(255) NOT NULL,
  person_id VARCHAR(255) NOT NULL,
  role VARCHAR(255) NOT NULL,
  PRIMARY KEY (incident_id, person_id)
);

CREATE TABLE VERSION (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  version VARCHAR(10)
);

CREATE UNIQUE INDEX ON CLIENT (person_id);

CREATE UNIQUE INDEX ON INCIDENT (person_id);

ALTER TABLE ASSOCIER ADD FOREIGN KEY (serial_number) REFERENCES HARVESTER (serial_number);

ALTER TABLE ASSOCIER ADD FOREIGN KEY (incident_id) REFERENCES INCIDENT (id);

ALTER TABLE CLIENT ADD FOREIGN KEY (person_id) REFERENCES PERSON (id);

ALTER TABLE CONTENIR ADD FOREIGN KEY (version_id) REFERENCES VERSION (id);

ALTER TABLE CONTENIR ADD FOREIGN KEY (script_id) REFERENCES SCRIPT (id);

ALTER TABLE DEPLOYER ADD FOREIGN KEY (siret) REFERENCES PRESTATAIRE (siret);

ALTER TABLE DEPLOYER ADD FOREIGN KEY (serial_number) REFERENCES HARVESTER (serial_number);

ALTER TABLE GERER ADD FOREIGN KEY (siret) REFERENCES PRESTATAIRE (siret);

ALTER TABLE GERER ADD FOREIGN KEY (client_name) REFERENCES CLIENT (name);

ALTER TABLE HARVESTER ADD FOREIGN KEY (os_id) REFERENCES OS (id);

ALTER TABLE HARVESTER ADD FOREIGN KEY (version_id) REFERENCES VERSION (id);

ALTER TABLE INCIDENT ADD FOREIGN KEY (person_id) REFERENCES PERSON (id);

ALTER TABLE INCLURE ADD FOREIGN KEY (script_id) REFERENCES SCRIPT (id);

ALTER TABLE INCLURE ADD FOREIGN KEY (component_id) REFERENCES COMPOSANT (id);

ALTER TABLE REPRESENTER ADD FOREIGN KEY (siret) REFERENCES PRESTATAIRE (siret);

ALTER TABLE REPRESENTER ADD FOREIGN KEY (person_id) REFERENCES PERSON (id);

ALTER TABLE TRAITER ADD FOREIGN KEY (incident_id) REFERENCES INCIDENT (id);

ALTER TABLE TRAITER ADD FOREIGN KEY (person_id) REFERENCES PERSON (id);

-- Création des utilisateurs
CREATE USER 'superuser'@'localhost' IDENTIFIED BY 'super_secure_password';
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY 'readonly_secure_password';
CREATE USER 'readwrite_user'@'localhost' IDENTIFIED BY 'readwrite_secure_password';

-- Attribution des privilèges
GRANT ALL PRIVILEGES ON mydatabase.* TO 'superuser'@'localhost';
GRANT SELECT ON mydatabase.* TO 'readonly_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON mydatabase.* TO 'readwrite_user'@'localhost';

-- Appliquer les changements
FLUSH PRIVILEGES;
