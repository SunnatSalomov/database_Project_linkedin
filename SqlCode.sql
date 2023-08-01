create table users
(
    id            serial primary key,
    first_name    varchar(50),
    last_name     varchar(50),
    email         varchar(100) unique,
    password_hash varchar(255),
    join_date     date
);

create table experience
(
    id           serial primary key,
    user_id       int,
    foreign key (user_id) references users (id) on delete cascade,
    company_name varchar(100),
    title        varchar(100),
    location     varchar(100),
    start_date   date,
    end_date     date,
    check (start_date <= end_date)
);
create table post
(
    id        serial primary key,
    user_id   int references users (id),
    content   varchar,
    post_date date
);
create table comment
(
    id           serial primary key,
    user_id      int references users (id),
    post_id      int references post (id),
    content      varchar,
    comment_date date default now()
);
create table education
(
    id          serial primary key,
    user_id     int,
    foreign key (user_id) references users (id),
    school_name varchar,
    degree      varchar,
    start_date  varchar,
    end_date    varchar,
    check ( start_date <= education.end_date )
);


create table profile
(
    id          serial primary key,
    user_id     int references users (id),
    headline    varchar,
    connections int
);
create table skill(
    id serial primary key ,
    name varchar,
    user_id int references users(id)
);

-- function to create a new education entry
create or replace function create_education_entry(
    in_user_id int,
    in_school_name varchar,
    in_degree varchar,
    in_start_date varchar,
    in_end_date varchar
) returns int as
$$
declare
    education_id int;
begin
    insert into education (user_id, school_name, degree, start_date, end_date)
    values (in_user_id, in_school_name, in_degree, in_start_date, in_end_date)
    returning id into education_id;

    return education_id;
end;
$$
language plpgsql;

-- function to read an education entry by id
create or replace function read_education_entry(in_education_id int) returns setof education as
$$
begin
    return query select * from education where id = in_education_id;
end;
$$
language plpgsql;

-- function to update an education entry
create or replace function update_education_entry(
    in_education_id int,
    in_school_name varchar,
    in_degree varchar,
    in_start_date varchar,
    in_end_date varchar
) returns void as
$$
begin
    update education
    set school_name = in_school_name,
        degree = in_degree,
        start_date = in_start_date,
        end_date = in_end_date
    where id = in_education_id;
end;
$$
language plpgsql;

-- function to delete an education entry
create or replace function delete_education_entry(in_education_id int) returns void as
$$
begin
    delete from education where id = in_education_id;
end;
$$
language plpgsql;


-- function to create a new experience entry
create or replace function create_experience_entry(
    in_user_id int,
    in_company_name varchar,
    in_title varchar,
    in_location varchar,
    in_start_date date,
    in_end_date date
) returns int as
$$
declare
    experience_id int;
begin
    insert into experience (user_id, company_name, title, location, start_date, end_date)
    values (in_user_id, in_company_name, in_title, in_location, in_start_date, in_end_date)
    returning id into experience_id;

    return experience_id;
end;
$$
language plpgsql;

-- function to read an experience entry by id
create or replace function read_experience_entry(in_experience_id int) returns setof experience as
$$
begin
    return query select * from experience where id = in_experience_id;
end;
$$
language plpgsql;

-- function to update an experience entry
create or replace function update_experience_entry(
    in_experience_id int,
    in_company_name varchar,
    in_title varchar,
    in_location varchar,
    in_start_date date,
    in_end_date date
) returns void as
$$
begin
    update experience
    set company_name = in_company_name,
        title = in_title,
        location = in_location,
        start_date = in_start_date,
        end_date = in_end_date
    where id = in_experience_id;
end;
$$
language plpgsql;

-- function to delete an experience entry
create or replace function delete_experience_entry(in_experience_id int) returns void as
$$
begin
    delete from experience where id = in_experience_id;
end;
$$
language plpgsql;




