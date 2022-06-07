/* Populate database with sample data. */

INSERT INTO public.animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Agumon', '03-02-2020', 0, true, 10.23);
INSERT INTO public.animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Gabumon', '15-11-2018', 2, true, 8);
INSERT INTO public.animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Pikachu', '07-01-2021', 1, false, 15.04);
INSERT INTO public.animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Devimon', '12-05-2017', 5, true, 11);
INSERT INTO public.animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Charmander', '2020-02-08', 0, false, -11);
INSERT INTO public.animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Plantmon', '2021-11-15', 2, true, -5.7);
INSERT INTO public.animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Squirtle', '1993-04-02', 3, false, -12.13);
INSERT INTO public.animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Angemon', '2005-06-12', 1, true, -45);
INSERT INTO public.animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO public.animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Blossom', '1998-10-13', 3, true, 17);
INSERT INTO public.animals(
	name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES ('Ditto', '2022-05-14', 4, true, 22);

BEGIN;
SAVEPOINT speciespoint;
UPDATE animals SET species = 'unspecified';
SELECT * FROM ANIMALS;
ROLLBACK TO SAVEPOINT speciespoint;
COMMIT;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
update animals set species = 'pokemon' where species is null;
commit;
select * from animals;

begin;
delete from animals;
select * from animals;
rollback;
select * from animals;

begin;
delete from animals where date_of_birth > '2022-01-01';
select * from animals;
SAVEPOINT deleted;
update animals set weight_kg = weight_kg * - 1;
select * from animals;
update animals set weight_kg = weight_kg * - 1 where weight_kg < 0;
select * from animals;
commit;