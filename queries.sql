/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon%';
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name from animals WHERE neutered = true and escape_attempts < 3;
SELECT date_of_birth from animals where name LIKE 'Agumon' or name LIKE 'Pikachu';
SELECT name, escape_attempts from animals where weight_kg > 10.5;
SELECT * from animals where neutered = true;
SELECT * from animals where name != 'Gabumon';
SELECT * from animals where weight_kg >= 10.4 and weight_kg <= 17.3;

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

-- Number of Animals
select count(*) from animals;

-- How many didn't try to escape
select count(*) from animals where escape_attempts = 0;

-- Average weight
select avg(weight_kg) from animals;

-- Who escapes the most
select neutered, count(escape_attempts) from animals
group by neutered;

-- Minimum and Maximum weight
select min(weight_kg), max(weight_kg) from animals group by species;

-- Average number of escapes born between 1990 and 2000
select avg(escape_attempts) from animals where date_of_birth between '1990-01-01' and '2000-01-01' group by species;