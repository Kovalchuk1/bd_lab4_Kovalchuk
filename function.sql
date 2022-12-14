
--Функцію get_channel(country_arg) виводить всі канали із заданої країни
--видаляється функція, якщо вона існує
DROP FUNCTION IF EXISTS get_channel(varchar); 
--створюємо таблицю та вказуємо, що ця функція повертає
CREATE OR REPLACE FUNCTION get_channel(country_arg varchar) RETURNS TABLE (country_name varchar, country varchar)
    LANGUAGE 'plpgsql'
AS $$
BEGIN
    RETURN QUERY
        SELECT ch_name::varchar, country_name::varchar
		FROM channel JOIN country USING(id_country)
		WHERE country_name = country_arg;
END;
$$
--ТЕСТИ
SELECT * FROM get_channel('US');
SELECT * FROM get_channel('India');
SELECT * FROM get_channel('Japan');
