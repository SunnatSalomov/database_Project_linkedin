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
