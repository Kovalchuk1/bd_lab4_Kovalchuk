
--Процедура insert_channel(varchar, integer, integer, integer, integer) додає в таблицю channel новий рядок із вказаними аргументами
DROP PROCEDURE IF EXISTS insert_channel(varchar, integer, integer, integer, integer);
CREATE OR REPLACE PROCEDURE insert_channel(name_c varchar, views_c integer, subscribers_c integer, genre integer, country integer)
LANGUAGE 'plpgsql'
AS $$
BEGIN
    INSERT INTO channel(ch_name, ch_views,  ch_subscribers, id_genre, id_country) VALUES (name_c, views_c, subscribers_c, genre, country);
END;
$$;

SELECT * FROM channel
-- ТЕСТИ
CALL insert_channel('Zee ВВ', 61601, 1767, 3, 1);
CALL insert_channel('Pinkfong Baby Shark', 23601, 1567, 2, 3);
CALL insert_channel('Movieclips', 5781, 367, 5, 4);


