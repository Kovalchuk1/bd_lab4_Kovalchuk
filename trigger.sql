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
