drop table if exists kernel_t;
drop table if exists bios_t;
drop table if exists hardware_t;
drop table if exists api_t;
drop table if exists engineexecutable_t;
drop table if exists engine_t;
drop table if exists memoryblock_t;
drop table if exists compiler_t;
drop table if exists os_t;
drop table if exists component_t;
drop table if exists datatype_t;
drop table if exists language_t;

create table language_t(
	language_uuid				int not null,
	language_name				varchar(20),
	language_fileExtension		varchar(4),
	language_runtype			varchar(20),
	
	constraint language_pk primary key (language_uuid)
	);

create table datatype_t(
	datatype_uuid 				int not null,
	language_uuid				int,
	datatype_numbytes			int,
	datatype_englishequiv       varchar(15),
	
	constraint datatype_pk primary key (datatype_uuid),
	constraint datatype_fk1 foreign key (language_uuid) references language_t(language_uuid)
	);
	
create table component_t(
	header_uuid					int not null,
	language_uuid				int,
	component_tier				varchar(10),
	component_canbeinstantiated	varchar(5),
	
	constraint component_pk primary key (header_uuid),
	constraint component_fk1 foreign key (language_uuid) references language_t(language_uuid)
	);
	
create table os_t(
	os_uuid						int not null,
	os_name						varchar(15),
	
	constraint os_pk primary key (os_uuid)
	);
	

create table compiler_t(
	language_uuid				int not null,
	os_uuid						int not null,
	
	constraint compiler_pk primary key (language_uuid, os_uuid),
	constraint compiler_fk1 foreign key (language_uuid) references language_t(language_uuid),
	constraint compiler_fk2 foreign key (os_uuid) references os_t(os_uuid)
	);
	
create table memoryblock_t(
 	language_uuid				int not null,
	datatype_uuid				int not null,
	
	constraint memoryblock_pk primary key (language_uuid, datatype_uuid),
	constraint memoryblock_fk1 foreign key (language_uuid) references language_t(language_uuid),
	constraint memoryblock_fk2 foreign key (datatype_uuid) references datatype_t(datatype_uuid)
	);
	
create table engine_t(
	engine_uuid						int not null,
	engine_name						varchar(15),
	
	constraint engine_pk primary key (engine_uuid)
	);

create table engineexecutable_t(
	os_uuid							int not null,
	engine_uuid						int not null,
	
	constraint engineexecutable_pk primary key (os_uuid, engine_uuid),
	constraint engineexecutable_fk1 foreign key (os_uuid) references os_t (os_uuid),
	constraint engineexecutable_fk2 foreign key (engine_uuid) references engine_t (engine_uuid)
	);

create table api_t(
	language_uuid					int not null,
	engine_uuid						int not null,
	
	constraint api_pk primary key (language_uuid, engine_uuid),
	constraint api_fk1 foreign key (language_uuid) references language_t (language_uuid),
	constraint api_fk2 foreign key (engine_uuid) references engine_t (engine_uuid)
	);
	
create table hardware_t(
	hardware_mtm					int not null,
	hardware_acpi					int,
	
	constraint hardware_pk primary key (hardware_mtm)
	);
	
create table bios_t(
	hardware_mtm					int not null,
	os_uuid							int not null,
	
	constraint bios_pk primary key (hardware_mtm, os_uuid),
	constraint bios_fk1 foreign key (hardware_mtm) references hardware_t (hardware_mtm),
	constraint bios_fk2 foreign key (os_uuid) references os_t (os_uuid)
	);

create table kernel_t(
	hardware_mtm					int not null,
	os_uuid							int not null,
	
	constraint kernel_pk primary key (hardware_mtm, os_uuid),
	constraint kernel_fk1 foreign key (hardware_mtm) references hardware_t (hardware_mtm),
	constraint kernel_fk2 foreign key (os_uuid) references os_t (os_uuid)
	);
	
	