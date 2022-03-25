/*Queries that provide answers to the questions from all projects.*/

/* Find all animals whose name ends in "mon" */
SELECT * FROM animals WHERE name LIKE '%mon';

/* List the name of all animals born between 2016 and 2019 */
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';

/* List the name of all animals that are neutered and have less than 3 escape attempts */
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

/* List date of birth of all animals named either "Agumon" or "Pikachu" */
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

/* List name and escape attempts of animals that weigh more than 10.5kg */
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

/* Find all animals that are neutered */
SELECT * FROM animals WHERE neutered = true;

/* Find all animals not named Gabumon */
SELECT * FROM animals WHERE name NOT IN ('Gabumon');

/* Find all animals with a weight between 10.4kg and 17.3kg */
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*  update the animals table by setting the species column to unspecified inside transaction and roll back */
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;

/* Update species */
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

/* Delete all records inside transaction */
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* Update species */
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_by_date;

UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO delete_by_date;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/* How many animals are there? */
SELECT COUNT(*) FROM animals;

/* How many animals have never tried to escape? */
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
 SELECT MAX(escape_attempts), neutered FROM animals GROUP BY neutered;
 
 /* What is the minimum and maximum weight of each type of animal? */
 SELECT MAX(weight_kg), MIN(weight_kg), species FROM animals GROUP BY species;
 
 /* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
 SELECT AVG(escape_attempts), species FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;


/* What animals belong to Melody Pond? */
SELECT name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon). */
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'pokemon';

/* List all owners and their animals */
SELECT owners.full_name, animals.name  FROM owners  LEFT OUTER JOIN animals ON owners.id = animals.owner_id;

/* How many animals are there per species? */
SELECT species.name, COUNT(*) FROM animals JOIN species ON animals.species_id = species.id GROUP BY (species.name);

/* List all Digimon owned by Jennifer Orwell. */
SELECT animals.name FROM animals 
                    JOIN owners ON animals.owner_id = owners.id
                    JOIN species ON animals.species_id = species.id
		    WHERE species.name = 'Digimon'
		    AND owners.full_name = 'Jennifer Orwell';
									
/* List all animals owned by Dean Winchester that haven't tried to escape. */
SELECT animals.name FROM animals 
                    JOIN owners ON animals.owner_id = owners.id
	            WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

/* Who owns the most animals? */
SELECT owners.full_name, COUNT(*) FROM owners
                                  JOIN animals ON owners.id = animals.owner_id
				  GROUP BY (owners.full_name)
                                  ORDER BY count DESC 
				  LIMIT 1;
