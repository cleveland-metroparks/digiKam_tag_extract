-- Code for creating postgres stuff for digikam project tracking

--   If the code below does not show an installed version, it needs to be created
select * from pg_catalog.pg_available_extensions where name = 'ltree';
CREATE extension if not exists ltree;

-- I run the r code in recordTable_to_postgre.Rmd to create the table 
--   (so you don't have to specify table columns explicitly)
--   then run this to set up a uuid for the very large numbers of eventual entries
ALTER TABLE camera_trap.digikam_record_table ADD uuid uuid NOT NULL DEFAULT uuid_generate_v1();`
ALTER TABLE camera_trap.digikam_record_table ADD CONSTRAINT digikam_record_table_pk PRIMARY KEY (uuid);

-- create tag hierarchy table
create TABLE if not exists camera_trap.digikam_tag_hierarchy (
	id serial primary key,
	tag_tree_name varchar,
	path ltree);
create index digikam_record_table_path_idx on camera_trap.digikam_tag_hierarchy using gist (path);

comment on table camera_trap.digikam_tag_hierarchy is 'store tag hierarchy used for one or more analysis project';

-- fill with data
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.BIKE');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.BIRD');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.CAR');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.CATDOM');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.CHIPMK');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.COYOTE');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.DEER');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.DOGDOM');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.ERROR');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.FLYSQL');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.FOXSQL');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.GRFOX');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.GRYSQL');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.HORSE');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.HUMAN');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.LEASHOFF');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.LEASHON');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.MMV');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.NONTERR');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.NOTHING');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.OPOSSM');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.RABBIT');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.RCOON');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.RDFOX');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.RUNNING');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.SKUNK');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.TRLCREW');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.TURKEY');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.UNKNOWN');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.WALKING');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.2');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.3');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.4');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.5');
insert into camera_trap.digikam_tag_hierarchy (tag_tree_name, path) values ('WC trail corridors', 'SPECIES.6PLUS');


-- create project table and other table needed
--   This will be added to a lot as I develop how to capture projects here
create TABLE if not exists camera_trap.digikam_project (
	id serial primary key,
	project_name varchar references camera_trap.project (project_name),
	digiKam_version varchar,
	tag_tree_used varchar, -- constrain by unique tag_tree_name in camera_trap.digikam_tag_hierarchy
	notes varchar);

comment on table camera_trap.digikam_project is 'store project info used for one analysis project';


create table if not exists camera_trap.project (
--	id serial,
	project_name varchar unique not null primary key,
	project_objectives varchar,
	project_design varchar,
	start_date date,
	end_date date,
	array_id integer, -- constrain these by array unique IDs
	array_name varchar, -- constrain these by array unique names
	notes varchar);

comment on table camera_trap.project is 'store camera trap project info used for one project';
comment on column project.project_name is 'unique names will be used to constrain another table';


create table if not exists camera_trap.array (
	array_id serial primary key,
	array_name varchar,
	deployment_id integer, 
	notes varchar);

comment on table camera_trap.array is 'store list of deployments (cameras) with one entry for each deployment';


create table if not exists camera_trap.deployment (
	deployment_id serial primary key,
	deployment_name varchar,
	start_date timestamp,
	end_date timestamp,  
	trigger_delay integer,
	latitude numeric,
	longitude numeric,
	geom geometry(POINT,4326),
	camera_make varchar,
	camera_model varchar,
	bait varchar references camera_trap.bait (bait_type), -- constrain to a bait.bait_type 
	feature varchar references camera_trap.feature (feature_type), -- constrain to feature.feature_type
	status_at_end varchar references camera_trap. status (status_type), -- constrain to status.status_type
	notes varchar);

comment on table camera_trap.deployment is 'this is a camera deployed on one project';
comment on column deployment.deployment_name is 'short name like PCAP plot ID with integers for secondary deployments when lost/broken';
comment on column deployment.end_date is 'datetime removed or failed/disapeared';
comment on column deployment.trigger_delay is 'in minutes';

create table if not exists camera_trap.bait (
	bait_type varchar primary key);
	
insert into camera_trap.bait (bait_type) values ('None');
insert into camera_trap.bait (bait_type) values ('Scent');
insert into camera_trap.bait (bait_type) values ('Meat');	
insert into camera_trap.bait (bait_type) values ('Visual');	
insert into camera_trap.bait (bait_type) values ('Acoustic');	
insert into camera_trap.bait (bait_type) values ('Other');	


create table if not exists camera_trap.feature (
	feature_type varchar primary key);

insert into camera_trap.feature (feature_type) values ('Road, paved');
insert into camera_trap.feature (feature_type) values ('Road, dirt');
insert into camera_trap.feature (feature_type) values ('Trail, hiking/people');
insert into camera_trap.feature (feature_type) values ('Trail, game');
insert into camera_trap.feature (feature_type) values ('Road underpass/overpass/bridge');
insert into camera_trap.feature (feature_type) values ('Culvert');
insert into camera_trap.feature (feature_type) values ('Burrow');
insert into camera_trap.feature (feature_type) values ('Nest site');
insert into camera_trap.feature (feature_type) values ('Carcass');
insert into camera_trap.feature (feature_type) values ('Water source/spring');
insert into camera_trap.feature (feature_type) values ('Fruiting tree');
insert into camera_trap.feature (feature_type) values ('Other');
	

create table if not exists camera_trap.status (
	status_type varchar primary key);
	
insert into camera_trap.status (status_type) values ('Camera Functioning');
insert into camera_trap.status (status_type) values ('Unknown Failure');
insert into camera_trap.status (status_type) values ('Vandalism/Theft');
insert into camera_trap.status (status_type) values ('Memory Card/Film Failure');
insert into camera_trap.status (status_type) values ('Camera Hardware Failure');
insert into camera_trap.status (status_type) values ('Wildlife Damage');
insert into camera_trap.status (status_type) values ('Other');
	
-- still may need to add stuff for image sets and images