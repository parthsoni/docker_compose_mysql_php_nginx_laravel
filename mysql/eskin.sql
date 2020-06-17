create schema eskin collate utf8_general_ci;

create table channel
(
	channel_id int null,
	channel_name varchar(255) null,
	created_at timestamp null,
	updated_at timestamp null
);

create table cities
(
	city_id int not null
		primary key,
	city_name varchar(255) null,
	city_state varchar(255) null,
	created_at timestamp null,
	updated_at timestamp null
);

create table countries
(
	code int not null
		primary key,
	name varchar(255) null,
	continent_name varchar(255) null,
	created_at timestamp null,
	updated_at timestamp null
);

create table diseases
(
	disease_id int auto_increment
		primary key,
	name varchar(255) null,
	description longtext null,
	segment varchar(255) null,
	treatmentTime double null,
	whatIsTheDisease longtext null,
	whoIsAtRisk longtext null,
	whatIsTheCause longtext null,
	medications longtext null,
	otherPotentialCauses longtext null,
	treatment longtext null,
	cosmetics longtext null,
	sampleImagesLocation varchar(255) null,
	bestTest longtext null,
	diagnosisPitfalls longtext null,
	created_at timestamp null,
	updated_at timestamp null
);

create index diseases__name_index
	on diseases (name);

create table doctors
(
	doctor_id int auto_increment
		primary key,
	firstname varchar(255) null,
	lastname varchar(255) null,
	password varchar(255) null,
	mobile int null,
	email varchar(255) null,
	gender enum('M', 'F') null,
	country varchar(255) null,
	city varchar(255) null,
	status enum('ACTIVE', 'INACTIVE') default 'ACTIVE' null,
	speciality enum('dermatologist', 'cosmotologist') null,
	photoLocation varchar(255) null,
	degree varchar(255) null,
	photoLocationDegree varchar(255) null,
	college varchar(255) null,
	practicingSince date null,
	pincode int null,
	specialization enum('dermatologist', 'cosmotologist') null,
	perSessionConsultingFees double null,
	timeLimitMinutes int null,
	created_at timestamp null,
	updated_at timestamp null,
	country_code int null,
	cookie_id varchar(255) null
);

create table failed_jobs
(
	id bigint unsigned auto_increment
		primary key,
	connection text not null,
	queue text not null,
	payload longtext not null,
	exception longtext not null,
	failed_at timestamp default CURRENT_TIMESTAMP not null
)
collate=utf8mb4_unicode_ci;

create table migrations
(
	id int unsigned auto_increment
		primary key,
	migration varchar(255) not null,
	batch int not null
)
collate=utf8mb4_unicode_ci;

create table patients
(
	patient_id int auto_increment
		primary key,
	cookie_id varchar(255) null,
	firstname varchar(255) null,
	lastname varchar(255) null,
	password varchar(255) null,
	mobile int null,
	email varchar(255) null,
	gender enum('M', 'F') null,
	country varchar(255) null,
	city varchar(255) null,
	pincode varchar(255) null,
	status enum('ACTIVE', 'INACTIVE') default 'ACTIVE' null,
	created_at timestamp null,
	updated_at timestamp null,
	country_code int null,
	constraint patients_ibfk_1
		foreign key (country_code) references countries (code)
);

create table interactions
(
	interaction_id int auto_increment
		primary key,
	patient_id int null,
	created_at timestamp null,
	updated_at timestamp null,
	result json null,
	channel int null,
	constraint interactions_ibfk_1
		foreign key (patient_id) references patients (patient_id)
);

create table doctorsTransactions
(
	transactionid int null,
	interaction_id int null,
	doctor_id int null,
	patient_id int null,
	baseRate double null,
	discount double null,
	platformFees double null,
	created_at timestamp null,
	updated_at timestamp null,
	fulfilledFlag tinyint(1) null,
	constraint doctorsTransactions_ibfk_1
		foreign key (interaction_id) references interactions (interaction_id),
	constraint doctorsTransactions_ibfk_2
		foreign key (doctor_id) references doctors (doctor_id),
	constraint doctorsTransactions_ibfk_3
		foreign key (patient_id) references patients (patient_id)
);

create index doctor_id
	on doctorsTransactions (doctor_id);

create index interaction_id
	on doctorsTransactions (interaction_id);

create index patient_id
	on doctorsTransactions (patient_id);

create index patient_id
	on interactions (patient_id);

create index country_code
	on patients (country_code);

create table pincode_city
(
	pincode varchar(255) not null,
	divisionname varchar(255) not null,
	regionname varchar(255) not null,
	circlename varchar(255) not null,
	Taluk varchar(255) not null,
	Districtname varchar(255) not null,
	statename varchar(255) not null,
	longitude varchar(255) not null,
	latitude varchar(255) not null
);

create table pincodes
(
	pincode varchar(255) not null,
	T varchar(255) not null
);

create table questions
(
	question_id int auto_increment
		primary key,
	question varchar(255) null,
	type enum('TEXT', 'MULTIPLE_CHOICE') null,
	created_at timestamp null,
	updated_at timestamp null
);

create table question_options
(
	question_option_id int auto_increment
		primary key,
	question_id int null,
	`option` varchar(255) null,
	created_at timestamp null,
	updated_at timestamp null,
	constraint question_options_ibfk_1
		foreign key (question_id) references questions (question_id)
);

create index question_id
	on question_options (question_id);

create table scan_images
(
	scan_image_id int auto_increment
		primary key,
	interaction_id int null,
	img_path varchar(255) null,
	created_at timestamp null,
	updated_at timestamp null,
	constraint scan_images_ibfk_1
		foreign key (interaction_id) references interactions (interaction_id)
);

create index interaction_id
	on scan_images (interaction_id);

create table scan_questions
(
	scan_question_id int auto_increment
		primary key,
	question_id int null,
	answer varchar(255) null,
	interaction_id int null,
	created_at timestamp null,
	updated_at timestamp null,
	constraint scan_questions_ibfk_1
		foreign key (question_id) references questions (question_id),
	constraint scan_questions_ibfk_2
		foreign key (interaction_id) references interactions (interaction_id)
);

create index interaction_id
	on scan_questions (interaction_id);

create index question_id
	on scan_questions (question_id);

create table scan_results
(
	scan_result_id int auto_increment
		primary key,
	interaction_id int null,
	scan_image_id int null,
	diseases_found_id int null,
	created_at timestamp null,
	updated_at timestamp null,
	result longtext null,
	constraint scan_results_ibfk_1
		foreign key (interaction_id) references interactions (interaction_id),
	constraint scan_results_ibfk_2
		foreign key (scan_image_id) references scan_images (scan_image_id)
);

create index diseases_found_id
	on scan_results (diseases_found_id);

create index interaction_id
	on scan_results (interaction_id);

create index scan_images_id
	on scan_results (scan_image_id);

create table scan_results_disease
(
	diseases_found_id int auto_increment
		primary key,
	interaction_id int null,
	scan_images_id int null,
	created_at timestamp null,
	updated_at timestamp null,
	constraint scan_results_disease_ibfk_1
		foreign key (interaction_id) references interactions (interaction_id),
	constraint scan_results_disease_ibfk_2
		foreign key (scan_images_id) references scan_images (scan_image_id)
);

create index interaction_id
	on scan_results_disease (interaction_id);

create index scan_images_id
	on scan_results_disease (scan_images_id);

create table users
(
	id bigint unsigned auto_increment
		primary key,
	name varchar(255) not null,
	email varchar(255) not null,
	email_verified_at timestamp null,
	password varchar(255) not null,
	remember_token varchar(100) null,
	created_at timestamp null,
	updated_at timestamp null,
	constraint users_email_unique
		unique (email)
)
collate=utf8mb4_unicode_ci;


