create  table users(
    id int serial primary key,
    first_name varchar,
    last_name varchar,
    email varchar,
    password varchar,
    join_date date
);