PRAGMA foreign_keys = OFF;
drop table if exists Country;
drop table if exists State;
drop table if exists Date;
drop table if exists Vaccine;
drop table if exists Age_group;
drop table if exists State_vaccinations;
drop table if exists Vaccination;
drop table if exists Country_data;
drop table if exists Country_data_vaccine;
drop table if exists Country_vaccine;
drop table if exists Vaccination_by_manufacturer;
drop table if exists Vaccination_by_age_group;
PRAGMA foreign_keys = ON;

/*Create R1*/
CREATE TABLE Country (
  C_name VARCHAR(30) NOT NULL PRIMARY KEY,
  Iso_code VARCHAR(10),
  Source_name VARCHAR(100), 
  Source_url VARCHAR(200) 
);

/*Create R2*/
CREATE TABLE State (
  S_name VARCHAR(30) NOT NULL PRIMARY KEY,
  C_name VARCHAR(30),
  FOREIGN KEY (C_name) REFERENCES Country(C_name)
);

/*Create R3*/
CREATE TABLE Date (
  Date DATE NOT NULL PRIMARY KEY
);

/*Create R4*/
CREATE TABLE Vaccine (
  V_name VARCHAR(50) NOT NULL PRIMARY KEY
);

/*Create R5*/
CREATE TABLE Age_group (
  Age_group VARCHAR(30) NOT NULL PRIMARY KEY
);

/*Create R6*/
CREATE TABLE State_vaccinations (
  S_name VARCHAR(30) NOT NULL, 
  Date DATE NOT NULL,
  Total_vaccinations INTEGER, 
  Total_distributed INTEGER, 
  People_vaccinated INTEGER, 
  People_fully_vaccinated_per_hundred NUMERIC, 
  Total_vaccinations_per_hundred NUMERIC, 
  People_fully_vaccinated INTEGER, 
  People_vaccinated_per_hundred NUMERIC, 
  Distributed_per_hundred NUMERIC, 
  Daily_vaccinations_raw INTEGER, 
  Daily_vaccinations INTEGER, 
  Daily_vaccinations_per_million NUMERIC, 
  Share_doses_used INTEGER, 
  Total_boosters INTEGER, 
  Total_boosters_per_hundred NUMERIC,
  FOREIGN KEY (S_name) REFERENCES State(S_name),
  FOREIGN KEY (Date) REFERENCES Date(Date),
  PRIMARY KEY (S_name, Date)
);

/*Create R7*/
CREATE TABLE Vaccination (
  C_name VARCHAR(30) NOT NULL,
  Date DATE NOT NULL,
  Total_vaccinations INTEGER, 
  People_vaccinated INTEGER, 
  People_fully_vaccinated INTEGER, 
  Total_boosters INTEGER, 
  Daily_vaccinations_raw INTEGER, 
  Daily_vaccinations INTEGER, 
  Total_vaccinations_per_hundred NUMERIC, 
  People_vaccinated_per_hundred NUMERIC, 
  People_fully_vaccinated_per_hundred NUMERIC, 
  Total_boosters_per_hundred NUMERIC, 
  Daily_vaccinations_per_million NUMERIC, 
  Daily_people_vaccinated INTEGER, 
  Daily_people_vaccinated_per_hundred NUMERIC, 
  FOREIGN KEY (C_name) REFERENCES Country(C_name),
  FOREIGN KEY (Date) REFERENCES Date(Date),
  PRIMARY KEY (C_name, Date)
);

/*Create R8*/
CREATE TABLE Country_data (
  C_name VARCHAR(30) NOT NULL,
  Date DATE NOT NULL,
  Source_url VARCHAR(200), 
  FOREIGN KEY (C_name) REFERENCES Country(C_name),
  FOREIGN KEY (Date) REFERENCES Date(Date),
  PRIMARY KEY (C_name, Date)
);

/*Create R9*/
CREATE TABLE Country_data_vaccine (
  C_name VARCHAR(30) NOT NULL,
  Date DATE NOT NULL,
  V_name VARCHAR(50) NOT NULL, 
  FOREIGN KEY (C_name) REFERENCES Country(C_name),
  FOREIGN KEY (Date) REFERENCES Date(Date),
  FOREIGN KEY (V_name) REFERENCES Vaccine(V_name),
  PRIMARY KEY (C_name, Date, V_name)
);

/*Create R10*/
CREATE TABLE Country_vaccine (
  C_name VARCHAR(30) NOT NULL,
  V_name VARCHAR(50) NOT NULL, 
  FOREIGN KEY (C_name) REFERENCES Country(C_name),
  FOREIGN KEY (V_name) REFERENCES Vaccine(V_name),
  PRIMARY KEY (C_name, V_name)
);

/*Create R11*/
CREATE TABLE Vaccination_by_manufacturer (
  C_name VARCHAR(30) NOT NULL,
  Date DATE NOT NULL,
  V_name VARCHAR(30) NOT NULL,
  Total_vaccinations INTEGER,
  FOREIGN KEY (C_name) REFERENCES Country(C_name),
  FOREIGN KEY (Date) REFERENCES Date(Date),
  FOREIGN KEY (V_name) REFERENCES Vaccine(V_name),
  PRIMARY KEY (V_name, C_name, Date)
);

/*Create R12*/
CREATE TABLE Vaccination_by_age_group (
  C_name VARCHAR(30) NOT NULL,
  Date DATE NOT NULL,
  Age_group VARCHAR(30) NOT NULL,
  People_vaccinated_per_hundred NUMERIC,
  People_fully_vaccinated_per_hundred NUMERIC, 
  People_with_booster_per_hundred NUMERIC,
  FOREIGN KEY (C_name) REFERENCES Country(C_name),
  FOREIGN KEY (Date) REFERENCES Date(Date),
  FOREIGN KEY (Age_group) REFERENCES Age_group(Age_group),
  PRIMARY KEY (Age_group, C_name, Date)
);