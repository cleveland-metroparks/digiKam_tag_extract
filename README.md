# digiKam_tag_extract

This is designed as a simple example of how to set up `camtrapR` functions to extract image data from images tagged using digiKam.

To digiKam_tag_extract saves a record table locally and in outdir.

The output can be used to create database tables to get this into postgres using recordTable_to_postgre.Rmd

To create a primary key, I first used combination of projectname, and row number, but that will not work as more columns get added to make tracking different kinds of output easier.

    Added autogenerating uuid column and made it primary key with, entered in sql console after initial table creation with recordTable_to_postgre.Rmd (so you don't have to specify table columns explicitly).

```
ALTER TABLE camera_trap.digikam_record_table ADD uuid uuid NOT NULL DEFAULT uuid_generate_v1();`
ALTER TABLE camera_trap.digikam_record_table ADD CONSTRAINT digikam_record_table_pk PRIMARY KEY (uuid);

```

It should be possible for others to change this to do something similar.
