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

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species (id);

ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners (id);

/* Create vets table */
CREATE TABLE vets (
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(400) NOT NULL,
	age INT,
	date_of_graduation DATE,
  PRIMARY KEY (id)
);

/* create specializations table */
CREATE TABLE specializations (
	vet_id INT, 
	species_id INT,
	 FOREIGN KEY (species_id) REFERENCES species (id),
   FOREIGN KEY (vet_id) REFERENCES vets (id) 
);

/* create visits table */
CREATE TABLE visits (
    animal_id INT NOT NULL,
    vet_id INT NOT NULL,
    date_of_visit DATE,
    FOREIGN KEY (animal_id) REFERENCES animals (id),
    FOREIGN KEY (vet_id) REFERENCES vets (id) 
);


-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);
