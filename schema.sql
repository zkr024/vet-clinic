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
