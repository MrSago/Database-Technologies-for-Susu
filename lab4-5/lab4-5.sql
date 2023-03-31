
DROP VIEW IF EXISTS e_suppliers_view;
DROP VIEW IF EXISTS e_details_view;
DROP VIEW IF EXISTS e_projects_view;
DROP VIEW IF EXISTS e_supplies_view;
 
DROP VIEW IF EXISTS d_suppliers_view;
DROP VIEW IF EXISTS d_details_view;
DROP VIEW IF EXISTS d_projects_view;
DROP VIEW IF EXISTS d_supplies_view;


-- Вставка данных
 
INSERT INTO details(NAME, price, color, weight)
VALUES ('Гвоздь 50 мм', 5, 'grey', 10),
       ('Вагонка 5 м', 100, 'yellow', 1000),
       ('Колышки усиленные стальные', 590, 'grey', 350),
       ('Скоба СП-40', 510, 'black', 240),
       ('Комплект крепежа Knauf для профилей UA 50', 919, 'white', 200),
       ('Шпильки для крепежа монтажного короба Wisa с одинарным смывом', 200, 'white', 100),
       ('Гвозди строительный (3мм х 70мм)', 600, 'black', 5000),
       ('Гвоздь строительный Тундра krep 2400482 3x80', 1270, 'grey', 5000),
       ('Вагонка сосна сорт "B" 200х8,8х1,3см в упаковке (1,936м2)', 150, 'yellow', 500),
       ('Вагонка осиновая - 2000x92x16 Сорт В', 95, 'yellow', 500),
       ('Вагонка штиль из лиственницы 14х110 мм сорт А, длина: 3,0 м', 1220, 'yellow', 10000),
       ('Вагонка Штиль Хвоя 14х120х6000 мм Сорт АВ м2', 484, 'orange', 2000),
       ('Аккумуляторная дрель-шуруповерт Zitrek Green 12 063-4071', 900, 'green', 1000),
       ('Аккумуляторная дрель-шуруповерт Makita DF457DWE', 7000, 'blue', 2000),
       ('керамическая плитка Monopole Antique 10x20', 4140, 'white', 2000),
       ('Керамическая плитка Azori Eclipse Ornament 42x42', 1228, 'white', 4000),
       ('Керамическая плитка Monopole Antique Sky 10x20', 4048, 'white', 2000),
       ('Плитка из керамогранита М-Квадрат Напольная плитка 725962 мюнхен - Коричн.', 897, 'orange', 2000);
 
INSERT INTO suppliers(NAME, city, address, rating)
VALUES ('Строительный двор', 'Челябинск', 'ул. Гостевая, 1', 8.8),
       ('Всеинструменты.ру', 'Челябинск', 'ул. Чичерина, 42Б', 8.9),
       ('КасКадСтрой', 'Челябинск', 'пр. Комсомольский, 39А', 9.0),
       ('Дом Сад Огород', 'Челябинск', 'ул. Косарева, 22А', 8.6),
       ('Castorama', 'Челябинск', 'ул. Труда, 203', 9.4),
       ('Самоделкин', 'Челябинск', 'ул. Российская, 222', 9.4),
       ('Строймаркет Сатурн', 'Челябинск', 'Свердловский тракт, 3В', 4),
       ('Леруа Мерлен', 'Челябинск', 'Копейское ш., 64', 9.8),
       ('Строй Мастер', 'Челябинск', 'ул. Дзержинского, 110', 4.5),
       ('ТехноНИКОЛЬ Торговая Сеть', 'Челябинск', 'ул. Валдайская, 7А', 8.4),
       ('Строительныйдвор', 'Копейск', 'ул. Славы, 12', 8.8),
       ('Всеинструментыру', 'Копейск', 'пр. Победы, 42Б', 3),
       ('КасКадСтрой', 'Копейск', 'пр. Победы, 24', 9.0),
       ('СтройMarket', 'Копейск', 'ул. Грибоедова, 32/1', 8.0),
       ('Castorama', 'Копейск', 'ул. Славы, 48', 9.4),
       ('Мастерок', 'Копейск', 'ул. Кирова, 21', 8.0),
       ('Металлобаза Копейская', 'Копейск', '1-й Снайперский пер., 16', 7.0),
       ('Магазин строительных материалов', 'Копейск', 'ул. Кемеровская, 26', 6.4),
       ('Десятка', 'Копейск', 'пр. Ильича, 13', 8.2),
       ('Все для стройки и ремонта', 'Копейск', 'ул. 4-й Пятилетки, 64', 7.6);
 
INSERT INTO projects(NAME, city, address, budget)
VALUES ('Ремонт квартиры', 'Челябинск', 'пр. Ленина 25', 50000),
       ('Ремонт садового домика', 'Челябинск', 'пр. Ленина 24', 100000),
       ('Ремонт кабинета', 'Челябинск', 'пр. Ленина 26', 100000),
       ('Ремонт бани', 'Челябинск', 'пр. Ленина 27', 100000),
       ('Ремонт дачи', 'Челябинск', 'пр. Ленина 28', 100000),
       ('Постройка бани', 'Челябинск', 'пр. Ленина 29', 1000000),
       ('Постройка дачи', 'Челябинск', 'пр. Ленина 30', 1000000),
       ('Ремонт квартиры', 'Челябинск', 'пр. Ленина 31', 100000),
       ('Ремонт садового домика', 'Копейск', 'пр. Свободы 24', 200000),
       ('Ремонт кабинета', 'Копейск', 'пр. Свободы 26', 200000),
       ('Ремонт бани', 'Копейск', 'пр. Свободы 27', 200000),
       ('Ремонт дачи', 'Копейск', 'пр. Свободы 28', 200000),
       ('Постройка бани', 'Копейск', 'пр. Свободы 29', 2000000),
       ('Постройка дачи', 'Челябинск', 'пр. Свободы 30', 2000000),
       ('Ремонт квартиры', 'Златоуст', 'пр. Свободы 31', 200000),
       ('Постройка бани', 'Златоуст', 'пр. Ленина 29', 1000000),
       ('Постройка дачи', 'Златоуст', 'пр. Ленина 30', 1000000),
       ('Ремонт квартиры', 'Златоуст', 'пр. Ленина 31', 100000),
       ('Ремонт садового домика', 'Копейск', 'пр. Свободы 24', 200000),
       ('Ремонт кабинета', 'Златоуст', 'пр. Свободы 26', 200000),
       ('Ремонт бани', 'Копейск', 'пр. Свободы 27', 200000);
 
INSERT INTO supplies(detail_id, supplier_id, project_id, amount)
VALUES (1, 1, 1, 1000),
       (1, 2, 2, 5000),
       (12, 20, 1, 12),
       (10, 17, 4, 1),
       (4, 8, 7, 16),
       (6, 15, 8, 13),
       (11, 17, 8, 11),
       (13, 4, 16, 7),
       (12, 14, 1, 15),
       (3, 8, 20, 17),
       (3, 16, 2, 9),
       (17, 20, 17, 7),
       (1, 20, 7, 13),
       (5, 2, 3, 13),
       (17, 4, 17, 15),
       (15, 12, 18, 18),
       (11, 1, 18, 5),
       (16, 7, 17, 20),
       (17, 18, 6, 6),
       (10, 14, 3, 4);
 
 
COPY (SELECT * FROM details) TO 'C:\Users\sago0\source\repos\Database-Technologies\lab4-5\details.csv' DELIMITER ',' CSV HEADER
COPY (SELECT * FROM suppliers) TO 'C:\Users\sago0\source\repos\Database-Technologies\lab4-5\suppliers.csv' DELIMITER ',' CSV HEADER
COPY (SELECT * FROM projects) TO 'C:\Users\sago0\source\repos\Database-Technologies\lab4-5\projects.csv' DELIMITER ',' CSV HEADER
COPY (SELECT * FROM supplies) TO 'C:\Users\sago0\source\repos\Database-Technologies\lab4-5\supplies.csv' DELIMITER ',' CSV HEADER

COPY details FROM 'C:\Users\sago0\source\repos\Database-Technologies\lab4-5\details.csv'
COPY suppliers FROM 'C:\Users\sago0\source\repos\Database-Technologies\lab4-5\suppliers.csv'
COPY projects FROM 'C:\Users\sago0\source\repos\Database-Technologies\lab4-5\projects.csv'
COPY supplies FROM 'C:\Users\sago0\source\repos\Database-Technologies\lab4-5\supplies.csv'
 
 
-- Представление Экономиста
 
CREATE VIEW e_suppliers_view AS
SELECT s.NAME,
       s.city,
       s.address,
       s.rating,
       s.reliability
FROM suppliers s
ORDER BY city, address, rating DESC;
 
CREATE VIEW e_details_view AS
SELECT d.NAME,
       d.price / 1000  AS "price (1000₽)",
       d.weight / 1000 AS "weight (kg)",
       d.cheapness
FROM details d
ORDER BY price DESC, NAME, color, weight;
 
CREATE VIEW e_projects_view AS
SELECT p.NAME,
       p.city,
       p.address,
       p.budget
FROM projects p
ORDER BY city, address, budget DESC;
 
CREATE VIEW e_supplies_view AS
SELECT detail.NAME                          AS "detail name",
       detail.color                         AS "detail color",
       detail.cheapness,
       supplier.NAME                        AS "supplier name",
       supplier.city                        AS "supplier city",
       supplier.reliability,
       supply.amount,
       detail.weight * supply.amount / 1000 AS "weight (kg)",
       detail.price * supply.amount         AS "price (1000₽)"
FROM supplies supply
         JOIN details detail ON detail.id = supply.detail_id
         JOIN projects project ON project.id = supply.project_id
         JOIN suppliers supplier ON supplier.id = supply.supplier_id
ORDER BY detail.NAME, supplier.NAME, "price (1000₽)", "weight (kg)" DESC;
 
 
-- Представление директора
 
CREATE VIEW d_suppliers_view AS
SELECT s.NAME,
       s.city,
       s.reliability
FROM suppliers s
ORDER BY reliability, city, NAME;
 
CREATE VIEW d_details_view AS
SELECT d.NAME,
       d.price / 1000 AS "price (1000₽)",
       d.color,
       d.cheapness
FROM details d
ORDER BY price DESC, NAME;
 
CREATE VIEW d_projects_view AS
SELECT p.NAME,
       p.city,
       p.budget
FROM projects p
ORDER BY budget DESC, city, NAME;
 
CREATE VIEW d_supplies_view AS
SELECT detail.NAME                          AS "detail name",
       detail.color                         AS "detail color",
       detail.cheapness                     AS "detail cheapness",
       supplier.NAME                        AS "supplier name",
       supplier.city                        AS "supplier city",
       supplier.reliability                 AS "supplier reliability",
       supply.amount                        AS "details amount",
       detail.weight * supply.amount / 1000 AS "weight (kg)",
       detail.price * supply.amount         AS "price (1000₽)"
FROM supplies supply
         JOIN details detail ON detail.id = supply.detail_id
         JOIN projects project ON project.id = supply.project_id
         JOIN suppliers supplier ON supplier.id = supply.supplier_id
ORDER BY "detail cheapness",
         "supplier reliability",
         "supplier city",
         "detail name",
         "supplier name",
         "price (1000₽)" DESC,
         "weight (kg)" DESC;
 
 
