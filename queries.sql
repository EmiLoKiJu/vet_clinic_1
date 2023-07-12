/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;
SELECT * from animals;
BEGIN;
UPDATE animals
SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon' WHERE species IS null;
COMMIT;
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * from animals;
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sv1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK to sv1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT SUM(escape_attempts) FROM animals WHERE neutered IS true;
SELECT CASE
  WHEN (SELECT SUM(escape_attempts) FROM animals WHERE neutered IS true) >
       (SELECT SUM(escape_attempts) FROM animals WHERE neutered IS false)
    THEN 'Neutered Animals'
  ELSE 'Not Neutered Animals'
END AS result;
SELECT MAX(weight_kg), MIN(weight_kg) FROM animals;
SELECT
  AVG(CASE WHEN species = 'pokemon' THEN escape_attempts END) AS pokemon,
  AVG(CASE WHEN species = 'digimon' THEN escape_attempts END) AS digimon
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'