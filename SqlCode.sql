--  shotta kod yoziladi
create table a(id serial primary key ,
b int);

create table users
(
    id         serial primary key,
    first_name varchar,
    last_name  varchar,
    email      varchar,
    password   varchar,
    join_date  date
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
    content      character varying,
    comment_date date default now()
);