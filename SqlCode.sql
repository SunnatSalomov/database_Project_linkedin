create  table users(
    id serial primary key,
    first_name varchar,
    last_name varchar,
    email varchar,
    password varchar,
    join_date date
);
create table experience(
    id serial primary key,
    user_id int,
    foreign key(user_id) references users(id),
    company_name varchar,
    title varchar,
    location varchar,
    start_date date,
    end_date date
);