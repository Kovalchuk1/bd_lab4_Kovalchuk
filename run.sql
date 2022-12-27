CREATE TABLE country(
  id_country INT NOT NULL,
  country_name varchar(50) NOT NULL
);

CREATE TABLE genre(
  id_genre INT NOT NULL,
  genre_name varchar(50) NOT NULL
);

CREATE TABLE viewss(
  id_views INT NOT NULL,
  views_v INT NOT NULL,
  date_first  DATE DEFAULT CURRENT_DATE,
  date_last  DATE DEFAULT CURRENT_DATE
);

CREATE TABLE channel(
  ch_name char(50) NOT NULL,
  id_views INT NOT NULL,
  id_genre INT NOT NULL,
  id_country INT NOT NULL
);

ALTER TABLE channel ADD PRIMARY KEY (ch_name); 
ALTER TABLE viewss ADD PRIMARY KEY (id_views); 
ALTER TABLE country ADD PRIMARY KEY (id_country); 
ALTER TABLE genre ADD PRIMARY KEY (id_genre); 
 
 
ALTER TABLE channel ADD CONSTRAINT FK_channel_country FOREIGN KEY (id_country) 
REFERENCES country(id_country);
ALTER TABLE genre ADD CONSTRAINT FK_channel_genre FOREIGN KEY (id_genre) 
REFERENCES genre(id_genre);
ALTER TABLE viewss ADD CONSTRAINT FK_channel_viewss FOREIGN KEY (id_views) 
REFERENCES viewss(id_views);



select * from channel
select * from genre
select * from country
select * from viewss
delete from channel
delete from country
delete from genre
delete from viewss

CREATE TABLE country(
  id_country INT NOT NULL,
  country_name varchar(50) NOT NULL
);

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

insert into viewss(id_views,  views_v, date_first, date_last) values
( 1, 86234, '2022-09-01', '2022-10-01'),
( 2, 80342, '2022-09-01', '2022-10-01'),
( 3, 23443, '2022-09-01', '2022-10-01'),
( 4, 4567, '2022-09-01', '2022-10-01'),
( 5, 3456, '2022-09-01', '2022-10-01'),
(6, 1456, '2022-09-01', '2022-10-01'),
(7, 978, '2022-09-01', '2022-10-01'),
( 8, 950,'2022-09-01', '2022-10-01');

insert into channel(ch_name,id_views, id_genre, id_country) values
('T-Series', 1, 1, 1),
('Cocomelon - Nursery Rhymes', 2, 2, 2),
('SET India', 3, 3, 1),
('PewDiePie', 4, 4, 3),
('BLACKPINK', 5, 1, 4),
('5-Minute Crafts', 6, 5, 2),
('Justin Bieber', 7, 1, 5),
('Zee TV', 8, 3, 1 );


select * from channel
select * from genre
select * from country
select * from viewss

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
--Процедура insert_channel(varchar, integer, integer, integer) додає в таблицю channel новий рядок із вказаними аргументами
DROP PROCEDURE IF EXISTS insert_channel(varchar, integer, integer, integer);
CREATE OR REPLACE PROCEDURE insert_channel(name_c varchar, views_c integer, genre integer, country integer)
LANGUAGE 'plpgsql'
AS $$
BEGIN
    INSERT INTO channel(ch_name, id_views,   id_genre, id_country) VALUES (name_c, views_c, genre, country);
END;
$$;

SELECT * FROM channel
-- ТЕСТИ
CALL insert_channel('Zee ВВ', 1, 3, 1);
CALL insert_channel('Pinkfong Baby Shark',2, 2, 3);
CALL insert_channel('Movieclips', 3, 5, 4);


--ТРИГЕР
--ТРИГЕР
--Тригер, який при додаванні нового рядка в таблицю views додає 50 переглядів до заданого id_views
--(за стастикою за час довання рядка переглядів збільшується на 50)


DROP TRIGGER IF EXISTS updaten_viewss ON viewss;

--Тригерна функція
CREATE OR REPLACE FUNCTION update_viewss() RETURNS trigger 
LANGUAGE plpgsql
AS
$$
     BEGIN
          UPDATE viewss
		  SET views_v = views_v + 50 
 		  WHERE viewss.id_views = NEW.id_views; 
		  RETURN NULL;
     END;
$$;


CREATE TRIGGER updaten_viewss
AFTER INSERT ON viewss
FOR EACH ROW EXECUTE FUNCTION update_viewss();

--ТЕСТ
INSERT INTO viewss(id_views, views_v, date_first, date_last) VALUES (51,3453,'2022-09-01', '2022-10-01');

select * from  viewss
































