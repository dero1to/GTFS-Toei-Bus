
---- 【drop】 ----
-- DROP TABLE IF EXISTS agency;
-- DROP TABLE IF EXISTS agency_jp;
-- DROP TABLE IF EXISTS attributions;
-- DROP TABLE IF EXISTS calendar;
-- DROP TABLE IF EXISTS calendar_dates;
-- DROP TABLE IF EXISTS fare_attributes;
-- DROP TABLE IF EXISTS fare_rules;
-- DROP TABLE IF EXISTS feed_info;
-- DROP TABLE IF EXISTS office_jp;
-- DROP TABLE IF EXISTS routes;
-- DROP TABLE IF EXISTS shapes;
-- DROP TABLE IF EXISTS stop_times;
-- DROP TABLE IF EXISTS stops;
-- DROP TABLE IF EXISTS trips;
---- 【drop】 ----




---- 【Create】 ----
create table IF not exists agency(
    id INT(20) AUTO_INCREMENT,
    agency_id VARCHAR(255) NOT NULL,
    agency_name VARCHAR(255) NOT NULL,
    agency_url TEXT NOT NULL,
    agency_timezone VARCHAR(255) NOT NULL,
    agency_lang VARCHAR(255) NOT NULL,
    agency_phone VARCHAR(255) NOT NULL,
    agency_fare_url TEXT DEFAULT NULL,
    agency_email VARCHAR(255) DEFAULT NULL,
    created_at Datetime DEFAULT NULL,
    updated_at Datetime DEFAULT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

create table IF not exists agency_jp(
    id INT(20) AUTO_INCREMENT,
    agency_id	VARCHAR(255) NOT NULL,
    agency_official_name VARCHAR(255) DEFAULT NULL,
    agency_zip_number	INT(10) DEFAULT NULL,
    agency_address VARCHAR(255) DEFAULT NULL,
    agency_president_pos VARCHAR(255) DEFAULT NULL,
    agency_president_name	VARCHAR(255) DEFAULT NULL,
    created_at Datetime DEFAULT NULL,
    updated_at Datetime DEFAULT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

create table IF not exists attributions(
    id INT(20) AUTO_INCREMENT,
    attribution_id	VARCHAR(255) DEFAULT NULL,
    agency_id	VARCHAR(255) DEFAULT NULL,
    route_id VARCHAR(255)	DEFAULT NULL,
    trip_id	VARCHAR(255) DEFAULT NULL,
    organization_name	VARCHAR(255) DEFAULT NULL,
    is_producer	INT(10)	NOT NULL,
    is_operator	INT(10)	NOT NULL,
    is_authority INT(10)	NOT NULL,
    is_data_source INT(10)	NOT NULL,
    attribution_url	TEXT NOT NULL,
    attribution_email	VARCHAR(255) DEFAULT NULL,
    created_at Datetime DEFAULT NULL,
    updated_at Datetime DEFAULT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

create table IF not exists calendar(
    id INT(20) AUTO_INCREMENT,
    service_id VARCHAR(255) NOT NULL,
    monday INT(10) NOT NULL,
    tuesday	INT(10)	NOT NULL,
    wednesday	INT(10)	NOT NULL,
    thursday INT(10) NOT NULL,
    friday INT(10) NOT NULL,
    sunday INT(10) NOT NULL,
    start_date INT(10) NOT NULL,
    end_date INT(10) NOT NULL,
    created_at Datetime DEFAULT NULL,
    updated_at Datetime DEFAULT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

create table IF not exists calendar_dates(
    id INT(20) AUTO_INCREMENT,
    service_id VARCHAR(255) NOT NULL,
    date INT(10) NOT NULL,
    exception_type INT(10)	NOT NULL,
    created_at Datetime DEFAULT NULL,
    updated_at Datetime DEFAULT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

create table IF not exists fare_attributes(
    id INT(20) AUTO_INCREMENT,
    fare_id	VARCHAR(255) NOT NULL,
    price	INT(10) NOT NULL,
    ic_price INT(10) NOT NULL,
    currency_type	VARCHAR(255) NOT NULL,
    payment_method INT(10) NOT NULL,
    transfers	INT(10) NOT NULL,
    transfer_duration	INT(10) NOT NULL,
    created_at Datetime DEFAULT NULL,
    updated_at Datetime DEFAULT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

create table IF not exists fare_rules(
    id INT(20) AUTO_INCREMENT,
    fare_id	VARCHAR(255) NOT NULL,
    route_id INT(10) NOT NULL,
    origin_id	VARCHAR(255) DEFAULT NULL,
    destination_id VARCHAR(255) DEFAULT NULL,
    contains_id	VARCHAR(255) DEFAULT NULL,
    created_at Datetime DEFAULT NULL,
    updated_at Datetime DEFAULT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

create table IF not exists feed_info(
    id INT(20) AUTO_INCREMENT,
    feed_publisher_name	VARCHAR(255) NOT NULL,
    feed_publisher_url TEXT NOT NULL,
    feed_lang	VARCHAR(255) NOT NULL,
    feed_start_date	INT(10) NOT NULL,
    feed_end_date	INT(10)	NOT NULL,
    feed_version	VARCHAR(255) NOT NULL,
    created_at Datetime DEFAULT NULL,
    updated_at Datetime DEFAULT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

create table IF not exists office_jp(
    id INT(20) AUTO_INCREMENT,
    office_id	INT(10)	NOT NULL,
    office_name	VARCHAR(255) NOT NULL,
    office_url TEXT	DEFAULT NULL,
    office_phone VARCHAR(255) DEFAULT NULL,
    created_at Datetime DEFAULT NULL,
    updated_at Datetime DEFAULT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

create table IF not exists routes(
    id INT(20) AUTO_INCREMENT,
    route_id INT(10) NOT NULL,
    agency_id	BIGINT(20) NOT NULL,
    route_short_name VARCHAR(255)	NOT NULL,
    route_long_name	VARCHAR(255) DEFAULT NULL,
    route_desc VARCHAR(255) DEFAULT NULL,
    route_type INT(10) NOT NULL,
    route_url	TEXT NOT NULL,
    route_color	VARCHAR(255) DEFAULT NULL,
    route_text_color VARCHAR(255) DEFAULT NULL,
    jp_parent_route_id INT(10) DEFAULT NULL,
    created_at Datetime DEFAULT NULL,
    updated_at Datetime DEFAULT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

create table IF not exists shapes(
    id INT(20) AUTO_INCREMENT,
    shape_id VARCHAR(255)	NOT NULL,
    shape_pt_lat DECIMAL(12,9) NOT NULL,
    shape_pt_lon DECIMAL(12,9) NOT NULL,
    shape_pt_sequence	INT(10)	NOT NULL,
    shape_dist_traveleded	VARCHAR(255) DEFAULT NULL,
    created_at Datetime DEFAULT NULL,
    updated_at Datetime DEFAULT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

create table IF not exists stop_times(
    id INT(20) AUTO_INCREMENT,
    trip_id	VARCHAR(255) NOT NULL,
    arrival_time TIME NOT NULL,
    departure_time TIME	NOT NULL,
    stop_id	VARCHAR(255) NOT NULL,
    stop_sequence	INT(10)	NOT NULL,
    stop_headsign	VARCHAR(255) NOT NULL,
    pickup_type	INT(10) DEFAULT NULL,
    drop_off_type	INT(10) DEFAULT NULL,
    shape_dist_traveled	INT(10) DEFAULT NULL,
    timepoint	VARCHAR(255) DEFAULT NULL,
    created_at Datetime DEFAULT NULL,
    updated_at Datetime DEFAULT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

create table IF not exists stops(
    id INT(20) AUTO_INCREMENT,
    stop_id	VARCHAR(255) NOT NULL,
    stop_code	VARCHAR(255) DEFAULT NULL,
    stop_name	VARCHAR(255) NOT NULL,
    stop_desc	VARCHAR(255) DEFAULT NULL,
    stop_lat DECIMAL(11,8) NOT NULL,
    stop_lon DECIMAL(11,8) NOT NULL,
    zone_id	VARCHAR(255) NOT NULL,
    stop_url TEXT	NOT NULL,
    location_type	INT(10)	NOT NULL,
    parent_station INT(10) DEFAULT NULL,
    stop_timezone	VARCHAR(255) DEFAULT NULL,
    wheelchair_boarding	VARCHAR(255) DEFAULT NULL,
    platform_code	VARCHAR(255) DEFAULT NULL,
    created_at Datetime DEFAULT NULL,
    updated_at Datetime DEFAULT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

create table IF not exists trips(
    id INT(20) AUTO_INCREMENT,
    route_id INT(10) NOT NULL,
    service_id VARCHAR(255)	NOT NULL,
    trip_id	VARCHAR(255) NOT NULL,
    trip_headsign	VARCHAR(255) NOT NULL,
    trip_short_name	VARCHAR(255) DEFAULT NULL,
    direction_id INT(10) DEFAULT NULL,
    block_id VARCHAR(255) DEFAULT NULL,
    shape_id VARCHAR(255)	NOT NULL,
    wheelchair_accessible	INT(10)	NOT NULL,
    bikes_allowed	INT(10)	NOT NULL,
    jp_trip_desc VARCHAR(255) DEFAULT NULL,
    jp_trip_desc_symbol	VARCHAR(255) DEFAULT NULL,
    jp_office_id INT(10) DEFAULT NULL,
    created_at Datetime DEFAULT NULL,
    updated_at Datetime DEFAULT NULL,
    PRIMARY KEY (id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
---- 【Create】 ----
