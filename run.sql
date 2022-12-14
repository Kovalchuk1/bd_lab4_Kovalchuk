CREATE TABLE country(
  id_country INT NOT NULL,
  country_name varchar(50) NOT NULL
);

CREATE TABLE genre(
  id_genre INT NOT NULL,
  genre_name varchar(50) NOT NULL
);

CREATE TABLE channel(
  ch_name char(50) NOT NULL,
  ch_views INT NOT NULL,
  ch_subscribers INT NOT NULL,
  id_genre INT NOT NULL,
  id_country INT NOT NULL
);

ALTER TABLE country ADD PRIMARY KEY (id_country); 
ALTER TABLE genre ADD PRIMARY KEY (id_genre); 
 
 
ALTER TABLE channel ADD CONSTRAINT FK_channel_country FOREIGN KEY (id_country) 
REFERENCES country(id_country);
ALTER TABLE genre ADD CONSTRAINT FK_channel_genre FOREIGN KEY (id_genre) 
REFERENCES genre(id_genre);


select * from channel
select * from genre
select * from country

delete from channel
delete from country
delete from genre

insert into country(id_country, country_name) values
(1, 'India'),
(2, 'US'),
(3, 'Japan'),
(4,'South Korea'),
(5, 'Canada');

insert into genre(id_genre, genre_name) values
(1, 'Music'),
(2, 'Education'),
(3, 'Entertainment'),
(4, 'Games'),
(5, 'Howto');

insert into channel(ch_name, ch_views,  ch_subscribers, id_genre, id_country) values
('T-Series', 201929, 225, 1, 1),
('Cocomelon - Nursery Rhymes', 138918, 143, 2, 2),
('SET India', 129200, 142.0, 3, 1),
('PewDiePie', 28525, 111.0, 4, 3),
('BLACKPINK', 26633, 81.4, 1, 4),
('5-Minute Crafts', 24134, 77.4, 5, 2),
('Justin Bieber', 28838, 70.0, 1, 5),
('Zee TV', 17672, 64.4, 3, 1 );


--ФУНКЦІЯ
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


--ПРОЦЕДУРА
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


--ТРИГЕР
--Тригер, який при додаванні нового рядка в таблицю channel додає 50 переглядів до заданого ch_views
--(за стастикою за час довання рядка переглядів збільшується на 50)

DROP TRIGGER IF EXISTS update_channel ON channel;

--Тригерна функція
CREATE OR REPLACE FUNCTION update_channel_n() RETURNS trigger 
LANGUAGE 'plpgsql'
AS
$$
     BEGIN
          UPDATE сhannel 
          SET ch_views = ch_views + 50 
 		  WHERE сhannel.ch_name = NEW.ch_name; 
		  RETURN NULL; -- результат ігнорується, оскільки це AFTER trigger
     END;
$$;


CREATE TRIGGER update_channel
AFTER INSERT ON channel
FOR EACH ROW EXECUTE FUNCTION update_channel_n()

--ТЕСТ
INSERT INTO channel(ch_name, ch_views,  ch_subscribers, id_genre, id_country) VALUES ('Zee ВВ', 61601, 1767, 3, 1);


select * from channel;

































