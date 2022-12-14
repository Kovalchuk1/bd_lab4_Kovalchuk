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




































