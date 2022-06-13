/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals(
    id serial PRIMARY KEY NOT NULL,
    name varchar(100) NOT NULL,
    date_of_birth date NOT NULL,
    escape_attempts int NOT NULL,
    neutered boolean NOT NULL,
    weight_kg decimal NOT NULL
);

ALTER TABLE animals ADD species varchar(100);

create table owners(
    id serial primary key,
    full_name varchar(100) NOT NULL,
    age int NOT NULL
)

create table species(
    id serial primary key,
    name varchar(100) NOT NULL
)

/* Remove column species */
alter table animals drop column species;

/* add species_id column - Foreign key referencing species*/
alter table animals add species_id int;
alter table animals add constraint FK_speciesID
foreign key (species_id)
references species(id)

/* add owner_id column - Foreign key referencing owners*/
alter table animals add owner_id int;
alter table animals add constraint FK_animalOwner
foreign key (owner_id)
references owners(id)

/* Update species column with 'digimon' or 'pokemon' */
update animals set species_id = 2
where name like '%mon';

update animals set species_id = 1
where species_id is null;

/* Update animals table to include owner information */
update animals set owner_id = 1
where name = 'Agumon';

update animals set owner_id = 2
where name in ('Gabumon','Pikachu')

update animals set owner_id = 3
where name in ('Devimon','Plantmon')

update animals set owner_id = 4
where name in ('Charmander','Squirtle','Blossom')

update animals set owner_id = 5
where name in ('Angemon','Boarmon')

--Vets table
create table vets (
    id serial primary key,
    name varchar(100) not null,
    age int not null,
    date_of_graduation date,
);

--join table - specializations
create table specializations (
    species_id int,
    vets_id int,
    primary key (species_id, vets_id),
    foreign key (species_id) references species (id),
    foreign key (vets_id) references vets (id)
);

-- Join table - Visits
create table visits (
    animals_id int,
    vets_id int,
    date_of_visit DATE,
    primary key (animals_id, vets_id, date_of_visit),
    foreign key (animals_id) references animals (id),
    foreign key (vets_id) references vets (id)
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

--SELECT COUNT(*) FROM visits where animal_id = 4; -Execution time 168.694 ms
create index animals_id_index on visits(animals_id);
--New execution time 39.944 ms

--SELECT * FROM visits where vet_id = 2; -Execution time 168.694 ms 330.095 ms
create index vets_id_index on visits(vets_id);
--New execution time 225.550 ms

--SELECT * FROM owners where email = 'owner_18327@mail.com'; -Execution time 168.694 ms 139.164 ms
create index email_index on owners(email);
--New execution time 0.117 ms