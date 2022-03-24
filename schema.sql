/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id               INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
    name             VARCHAR(250) NOT NULL,
    date_of_birth    DATE NOT NULL,
    escape_attempts  INT NOT NULL,
    neutered         BOOLEAN NOT NULL,
    weight_kg        DECIMAL NOT NULL
);

/* Add a species column */
ALTER TABLE animals
ADD species VARCHAR(350);


CREATE TABLE owners (
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(400) NOT NULL,
	age INT,
  PRIMARY KEY (id)
);

/* Create owners table */
CREATE TABLE owners (
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(400) NOT NULL,
	age INT,
  PRIMARY KEY (id)
);

/* Create species table */
CREATE TABLE species (
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(200) NOT NULL,
  PRIMARY KEY (id)
);

LTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species (id);

ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners (id);

