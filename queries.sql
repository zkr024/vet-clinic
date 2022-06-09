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

-- Which animals belong to Melody Pond?
select animals.name from animals
join owners on animals.owner_id = owners.id
where owners.full_name = 'Melody Pond';

--List of all animals that are pokemon
select animals.name from animals
join species on animals.species_id = species.id
where species.name = 'Pokemon';

--List of owners with and w/out animals and their animals
select owners.full_name, animals.name from animals
full join owners on animals.owner_id = owners.id;

-- How many animals per species?
select species.name, count(*) from species
join animals on species.id = animals.species_id
group by species.name;

--List all Digimon owned by Jennifer Orwell.
select animals.name from animals
join owners on animals.owner_id = owners.id
join species on animals.species_id = species.id
where owners.full_name = 'Jennifer Orwell' and species.name = 'Digimon';

--List all animals owned by Dean Winchester that haven't tried to escape
select animals.name from animals
join owners on animals.owner_id = owners.id
where owners.full_name = 'Dean Winchester' and animals.escape_attempts = 0;

--Who owns the most animals?
select owners.full_name from owners
join animals on owners.id = animals.owner_id
group by owners.full_name
order by count(*) desc
limit 1;
*****
-- Who was the last animal seen by William Tatcher?
select animals.name from animals
join visits on visits.animals_id = animals.id
join vets on visits.vets_id = vets.id
where vets.name = 'William Tatcher'
order by visits.date_of_visit desc
limit 1;

-- How many different animals did Stephanie Mendez see?
select count(animals.name) from animals
join visits on visits.animals_id = animals.id
join vets on visits.vets_id = vets.id
where vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
select vets.name, species.name from vets
FULL join specializations on specializations.vets_id = vets.id
FULL join species on species.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
select animals.name from animals
join visits on visits.animals_id = animals.id
join vets on visits.vets_id = vets.id
where vets.name = 'Stephanie Mendez' and visits.date_of_visit between '2020-04-01' and '2020-08-30';

-- What animal has the most visits to vets?
select animals.name, count(*) from animals
join visits on visits.animals_id = animals.id
group by animals.name
order by count(*) desc
limit 1;

-- Who was Maisy Smith's first visit?
select animals.name from animals
join visits on visits.animals_id = animals.id
join vets on visits.vets_id = vets.id
where vets.name = 'Maisy Smith'
order by visits.date_of_visit
limit 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
select animals.*, vets.*, visits.date_of_visit from animals
join visits on visits.animals_id = animals.id
join vets on visits.vets_id = vets.id
order by visits.date_of_visit desc
limit 1;

-- How many visits were with a vet that did not specialize in that animal's species?
select count(*) from visits
FULL join animals on animals.id = visits.animals_id
FULL join vets on visits.vets_id = vets.id
FULL join specializations on specializations.vets_id = vets.id
where specializations.species_id is null;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
select species.name, count(*) from visits
join animals on animals.id = visits.animals_id
join vets on visits.vets_id = vets.id
join species on species.id = animals.species_id
where vets.name = 'Maisy Smith'
group by species.name
order by count(*) desc;