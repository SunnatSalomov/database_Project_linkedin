create or replace function get_users(
    i_first_name varchar default null,
    i_last_name varchar default null,
    i_email varchar default null,
    i_password varchar default null,
    i_join_date date default null
) returns setof users
    language plpgsql as
$$
declare
    v_condition varchar := '';
BEGIN
    if i_first_name is not null then
        v_condition := v_condition || ' and first_name like ''' || i_first_name || '%''';
    end if;
    if i_last_name is not null then
        v_condition := v_condition || ' and last_name like ''' || i_last_name || '%''';
    end if;
    if i_email is not null then
        v_condition := v_condition || ' and email like ''' || i_email || '%''';
    end if;
    if i_password is not null then
        v_condition := v_condition || ' and password like ''' || i_password || '%''';
    end if;
    if i_join_date is not null then
        v_condition := v_condition || ' and join_date like ''' || i_join_date || '%''';
    end if;

    return query execute 'select * from users where true' || v_condition;
end
$$;

create or replace function update_user(
    i_user_id integer,
    i_first_name varchar default null,
    i_last_name varchar default null,
    i_email varchar default null,
    i_password varchar default null,
    i_join_date date default null
) RETURNS void
LANGUAGE plpgsql AS
$$
DECLARE
    v_updates varchar := '';
BEGIN
    IF i_first_name IS NOT NULL THEN
        v_updates := v_updates || ', first_name = ''' || i_first_name || '''';
    END IF;
    IF i_last_name IS NOT NULL THEN
        v_updates := v_updates || ', last_name = ''' || i_last_name || '''';
    END IF;
    IF i_email IS NOT NULL THEN
        v_updates := v_updates || ', email = ''' || i_email || '''';
    END IF;
    IF i_password IS NOT NULL THEN
        v_updates := v_updates || ', password = ''' || i_password || '''';
    END IF;
    IF i_join_date IS NOT NULL THEN
        v_updates := v_updates || ', join_date = ''' || i_join_date || '''';
    END IF;

    v_updates := TRIM(LEADING ',' FROM v_updates);

    EXECUTE 'UPDATE users SET ' || v_updates || ' WHERE user_id = ' || i_user_id;
END
$$;

create or replace function add_users(
    i_first_name varchar,
    i_last_name varchar,
    i_email varchar,
    i_password varchar,
    i_join_date date
)
    returns void
    language plpgsql as

$$
BEGIN
    insert into users (first_name, last_name, email, password, join_date)
    values (i_first_name, i_last_name, i_email, i_password, i_join_date);


end;

$$;

create or replace function delete_user(i_id int)
returns void
language plpgsql as
$$BEGIN
    delete from users where id=i_id;
END $$;
end;