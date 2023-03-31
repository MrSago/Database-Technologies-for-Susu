-- Drop existing
 
DROP VIEW IF EXISTS e_suppliers_view;
DROP VIEW IF EXISTS e_details_view;
DROP VIEW IF EXISTS e_projects_view;
DROP VIEW IF EXISTS e_supplies_view;
 
DROP VIEW IF EXISTS d_suppliers_view;
DROP VIEW IF EXISTS d_details_view;
DROP VIEW IF EXISTS d_projects_view;
DROP VIEW IF EXISTS d_supplies_view;
 
DROP TABLE IF EXISTS supplies;
DROP TABLE IF EXISTS details;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS projects;
 
DROP ROLE IF EXISTS economist;
DROP ROLE IF EXISTS director;
 
 
-- Create tables
 
CREATE TABLE details
(
    id        INT generated ALWAYS AS IDENTITY,
    NAME      VARCHAR    NOT NULL,
    price     NUMERIC    NOT NULL,
    color     varchar(7) NOT NULL,
    weight    INT,
    cheapness TEXT generated ALWAYS AS ( CASE WHEN (price > 1000) THEN 'expensive' ELSE 'cheap' END ) stored,
    PRIMARY KEY (id),
    CHECK (color IN ('white', 'black', 'grey', 'red', 'blue', 'green', 'yellow', 'orange')),
    CHECK (price > 0),
    CHECK (weight > 0)
);
 
CREATE TABLE suppliers
(
    id          INT generated ALWAYS AS IDENTITY,
    NAME        VARCHAR NOT NULL,
    city        VARCHAR NOT NULL,
    address     VARCHAR NOT NULL DEFAULT 'unknown',
    rating      NUMERIC          DEFAULT 1.0,
    reliability VARCHAR generated ALWAYS AS ( CASE WHEN rating > 6 THEN 'reliable' ELSE 'unreliable' END ) stored,
    PRIMARY KEY (id),
    CHECK (rating >= 1 AND rating <= 10),
    UNIQUE (NAME, city)
);
 
CREATE TABLE projects
(
    id      INT generated ALWAYS AS IDENTITY,
    NAME    VARCHAR NOT NULL,
    city    VARCHAR NOT NULL,
    address VARCHAR NOT NULL,
    budget  NUMERIC DEFAULT 0,
    PRIMARY KEY (id),
    CHECK (budget > 0)
);
 
CREATE TABLE supplies
(
    id          INT generated ALWAYS AS IDENTITY,
    detail_id   INT NOT NULL,
    supplier_id INT NOT NULL,
    project_id  INT NOT NULL,
    amount      INT DEFAULT 1,
    PRIMARY KEY (id),
    CHECK (amount > 0),
    FOREIGN KEY (detail_id) REFERENCES details (id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES suppliers (id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE CASCADE
);
 
 
-- Insert data
 
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
       ('Строймаркет Сатурн', 'Челябинск', 'Свердловский тракт, 3В', 8.8),
       ('Леруа Мерлен', 'Челябинск', 'Копейское ш., 64', 9.8),
       ('Строй Мастер', 'Челябинск', 'ул. Дзержинского, 110', 8.8),
       ('ТехноНИКОЛЬ Торговая Сеть', 'Челябинск', 'ул. Валдайская, 7А', 8.4),
       ('Строительныйдвор', 'Копейск', 'ул. Славы, 12', 8.8),
       ('Всеинструментыру', 'Копейск', 'пр. Победы, 42Б', 8.9),
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
 
 
-- Economist Views
 
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
 
 
-- Director Views
 
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
 
 
-- Roles
 
CREATE ROLE economist WITH LOGIN;
GRANT ALL ON suppliers TO economist;
GRANT ALL ON supplies TO economist;
GRANT SELECT ON details TO economist;
GRANT SELECT ON projects TO economist;
GRANT SELECT ON e_suppliers_view TO economist;
GRANT SELECT ON e_details_view TO economist;
GRANT SELECT ON e_projects_view TO economist;
 
CREATE ROLE director WITH LOGIN;
GRANT ALL ON suppliers TO director;
GRANT ALL ON details TO director;
GRANT ALL ON projects TO director;
GRANT SELECT ON supplies TO director;
GRANT DELETE ON supplies TO director;
 
 
-- Queries
 
-- Запросы Экономиста
-- 1.1. Все надежные поставщики
SELECT *
FROM suppliers
WHERE reliability = 'reliable';
-- 1.2. Все ненадежные поставщики
SELECT *
FROM suppliers
WHERE reliability = 'reliable';
-- 2.1. Все дорогие детали
SELECT *
FROM details
WHERE cheapness = 'expensive';
-- 2.2. Все недорогие детали
SELECT *
FROM details
WHERE cheapness = 'cheap';
-- 3. Список всех проектов в городе Челябниск и с бюджетом в диапазоне от 10000 до 50000
SELECT *
FROM projects
WHERE city = 'Челябинск'
  AND budget > 10000
  AND budget < 50000;
-- 4. Список всех поставок дешевых деталей от надежных поставщиков с общей стоимостью в диапазоне от 5000 до 10000
SELECT *
FROM supplies
         INNER JOIN details detail ON detail.id = supplies.detail_id
         INNER JOIN suppliers supplier ON supplier.id = supplies.supplier_id
WHERE detail.cheapness = 'cheap'
  AND supplier.reliability = 'reliable'
  AND (detail.price * amount) > 5000
  AND (detail.price * amount) < 10000;
 
-- Запросы Директора
-- 1. Список всех поставщиков
SELECT *,
       (SELECT COALESCE(SUM(detail.price * supply.amount), 0)
        FROM supplies supply
                 INNER JOIN details detail ON detail.id = supply.detail_id
        WHERE supplier_id = supplier.id) AS supplied
FROM suppliers supplier;
-- 1.2. Список поставщиков с рейтингом выше среднего
SELECT *,
       (SELECT COALESCE(SUM(detail.price * supply.amount), 0)
        FROM supplies supply
                 INNER JOIN details detail ON detail.id = supply.detail_id
        WHERE supplier_id = supplier.id) AS supplied
FROM suppliers supplier
WHERE supplier.rating > (SELECT AVG(rating) FROM suppliers);
-- 1.3. Список поставщиков с максимальным рейтингом
SELECT *,
       (SELECT COALESCE(SUM(detail.price * supply.amount), 0)
        FROM supplies supply
                 INNER JOIN details detail ON detail.id = supply.detail_id
        WHERE supplier_id = supplier.id) AS supplied
FROM suppliers supplier
WHERE supplier.rating = (SELECT MAX(rating) FROM suppliers);
-- 2.1. Список всех деталей
SELECT *,
       (SELECT COALESCE(SUM(detail.price * supply.amount), 0)
        FROM supplies supply
        WHERE detail_id = detail.id) AS sold
FROM details detail;
-- 2.2. Список деталей с ценой выше средней
SELECT *,
       (SELECT COALESCE(SUM(detail.price * supply.amount), 0)
        FROM supplies supply
        WHERE detail_id = detail.id) AS sold
FROM details detail
WHERE detail.price > (SELECT AVG(price) FROM details);
-- 2.3. Список деталей с минимальной ценой
SELECT *,
       (SELECT COALESCE(SUM(detail.price * supply.amount), 0)
        FROM supplies supply
        WHERE detail_id = detail.id) AS sold
FROM details detail
WHERE detail.price = (SELECT MIN(price) FROM details);
-- 3.1. Список всех проектов
SELECT *,
       (SELECT COALESCE(SUM(detail.price * supply.amount), 0)
        FROM supplies supply
                 INNER JOIN details detail ON detail.id = supply.detail_id
        WHERE project_id = project.id) AS used
FROM projects project;
-- 3.2. Список проектов с бюджетом выше средней
SELECT *,
       (SELECT COALESCE(SUM(detail.price * supply.amount), 0)
        FROM supplies supply
                 INNER JOIN details detail ON detail.id = supply.detail_id
        WHERE project_id = project.id) AS used
FROM projects project
WHERE project.budget > (SELECT AVG(budget) FROM projects);
-- 3.3. Список проектов с максимальным бюджетом
SELECT *,
       (SELECT COALESCE(SUM(detail.price * supply.amount), 0)
        FROM supplies supply
                 INNER JOIN details detail ON detail.id = supply.detail_id
        WHERE project_id = project.id) AS "used (₽)"
FROM projects project
WHERE project.budget = (SELECT MAX(budget) FROM projects);
-- 4.1. Сумма всех поставок
SELECT SUM(detail.price * supply.amount)
FROM supplies supply
         INNER JOIN details detail ON detail.id = supply.detail_id;
-- 4.2. Сумма поставок дорогих деталей
SELECT SUM(detail.price * supply.amount)
FROM supplies supply
         INNER JOIN details detail ON detail.id = supply.detail_id
WHERE detail.cheapness = 'cheap';
-- 4.3. Сумма поставок от ненадежных поставщиков
SELECT SUM(detail.price * supply.amount)
FROM supplies supply
         INNER JOIN details detail ON detail.id = supply.detail_id
         INNER JOIN suppliers supplier ON supplier.id = supply.supplier_id
WHERE supplier.reliability = 'reliable';
-- 4.4. Сумма поставок от заданного поставщика
SELECT SUM(detail.price * supply.amount)
FROM supplies supply
         INNER JOIN details detail ON detail.id = supply.detail_id
WHERE supply.supplier_id = 8;
 
 
-- Queries
 
-- 1. Ненадежный поставщик не может поставлять дорогую деталь
 
CREATE OR REPLACE FUNCTION block_supply_with_unreliable_suppliers_and_expensive_detail()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN CASE
               WHEN (SELECT reliability = 'unreliable' FROM suppliers WHERE id = NEW.supplier_id) AND
                    (SELECT cheapness = 'expensive' FROM details WHERE id = NEW.detail_id) THEN NULL
               ELSE NEW END;
END;
$$;
 
CREATE OR REPLACE TRIGGER unreliable_supplier_cannot_supply_expensive_detail_insert
    BEFORE INSERT
    ON supplies
    FOR EACH ROW
EXECUTE FUNCTION block_supply_with_unreliable_suppliers_and_expensive_detail();
 
CREATE OR REPLACE TRIGGER unreliable_supplier_cannot_supply_expensive_detail_update
    BEFORE UPDATE
    ON supplies
    FOR EACH ROW
EXECUTE FUNCTION block_supply_with_unreliable_suppliers_and_expensive_detail();
 
-- 2. Вес поставки не должен превышать 1.5 т
 
CREATE OR REPLACE FUNCTION block_overweight_supplies()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN CASE
               WHEN (SELECT MAX(weight) FROM details WHERE id = NEW.detail_id) * NEW.amount > 1500000 THEN NULL
               ELSE NEW END;
END;
$$;
 
CREATE OR REPLACE TRIGGER overweight_supplies_not_allowed_insert
    BEFORE INSERT
    ON supplies
    FOR EACH ROW
EXECUTE FUNCTION block_overweight_supplies();
 
CREATE OR REPLACE TRIGGER overweight_supplies_not_allowed_update
    BEFORE UPDATE
    ON supplies
    FOR EACH ROW
EXECUTE FUNCTION block_overweight_supplies();
 
-- 3. Суммарная стоимость всех поставок по проекту не должна превышать бюджет проекта
 
CREATE OR REPLACE FUNCTION block_supply_if_project_overdraft()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN CASE
               WHEN (SELECT SUM(detail.price * supply.amount)
                     FROM supplies supply
                              INNER JOIN details detail ON detail.id = supply.detail_id
                     WHERE project_id = NEW.project_id) +
                    NEW.amount * (SELECT SUM(price) FROM details WHERE id = NEW.detail_id) >
                    (SELECT SUM(budget) FROM projects WHERE id = NEW.project_id)
                   THEN NULL
               ELSE NEW END;
END;
$$;
 
CREATE OR REPLACE TRIGGER overdraft_projects_now_allowed_insert
    BEFORE INSERT
    ON supplies
    FOR EACH ROW
EXECUTE FUNCTION block_supply_if_project_overdraft();
 
CREATE OR REPLACE TRIGGER overdraft_projects_now_allowed_update
    BEFORE UPDATE
    ON supplies
    FOR EACH ROW
EXECUTE FUNCTION block_supply_if_project_overdraft();