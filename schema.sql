/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id int,
    name varchar(100),
    date_of_birth date,
    escape_attempts int,
    neutered bool,
    weight_kg float8,
);

ALTER TABLE animals
ADD COLUMN species varchar(100);

CREATE TABLE owners (
    id serial PRIMARY KEY,
    full_name varchar(255),
    age int
);

CREATE TABLE species (
    id serial PRIMARY KEY,
    name varchar(255)
);

ALTER TABLE animals DROP COLUMN id;
ALTER TABLE animals
ADD COLUMN id SERIAL PRIMARY KEY;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id int REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id int REFERENCES owners(id);

CREATE TABLE vets (
    id serial PRIMARY KEY,
    name varchar(255),
    age int,
	date_of_graduatio date
);

CREATE TABLE specializations (
	vet_id int REFERENCES vets(id),
	species_id int REFERENCES species(id)
);

CREATE TABLE visits (
	vet_id int REFERENCES vets(id),
	animal_id int REFERENCES animals(id)
);

ALTER TABLE vets RENAME COLUMN date_of_graduatio TO date_of_graduation;
ALTER TABLE visits ADD COLUMN date_of_visit date;