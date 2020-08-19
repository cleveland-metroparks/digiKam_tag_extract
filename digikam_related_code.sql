-- Code for creating postgres stuff for digikam project tracking

--   If the code below does not show an installed version, it needs to be created
select * from pg_catalog.pg_available_extensions where name = 'ltree';
CREATE extension if not exists ltree;

-- I run the r code in recordTable_to_postgre.Rmd to create the table 
--   (so you don't have to specify table columns explicitly)
--   then run this to set up a uuid for the very large numbers of eventual entries
ALTER TABLE camera_trap.digikam_record_table ADD uuid uuid NOT NULL DEFAULT uuid_generate_v1();`
ALTER TABLE camera_trap.digikam_record_table ADD CONSTRAINT digikam_record_table_pk PRIMARY KEY (uuid);

-- create table
create TABLE if not exists camera_trap.digikam_tag_hierarchy (
	id serial primary key,
	project_name varchar,
	path ltree);
create index digikam_record_table_path_idx on camera_trap.digikam_tag_hierarchy using gist (path);

-- fill with data
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.BIKE');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.BIRD');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.CAR');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.CATDOM');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.CHIPMK');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.COYOTE');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.DEER');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.DOGDOM');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.ERROR');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.FLYSQL');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.FOXSQL');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.GRFOX');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.GRYSQL');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.HORSE');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.HUMAN');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.LEASHOFF');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.LEASHON');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.MMV');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.NONTERR');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.NOTHING');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.OPOSSM');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.RABBIT');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.RCOON');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.RDFOX');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.RUNNING');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.SKUNK');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.TRLCREW');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.TURKEY');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.UNKNOWN');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.WALKING');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.2');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.3');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.4');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.5');
insert into camera_trap.digikam_tag_hierarchy (project_name, path) values ('WC trail corridors', 'SPECIES.6PLUS');

