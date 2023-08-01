create table users
(
    id         serial primary key,
    first_name varchar,
    last_name  varchar,
    email      varchar,
    password   varchar,
    join_date  date
);
create table experience
(
    id           serial primary key,
    user_id      int,
    foreign key (user_id) references users (id),
    company_name varchar,
    title        varchar,
    location     varchar,
    start_date   date,
    end_date     date
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
create table profile
(
    id          serial primary key,
    user_id     int references users (id),
    headline    varchar,
    connections int
)

