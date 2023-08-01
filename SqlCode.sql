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
    user_id      int,
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
)

