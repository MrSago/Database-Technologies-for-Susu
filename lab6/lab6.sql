
-- Запросы
 
 
-- Запросы Экономиста

-- 1.1 Все надежные поставщики
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
 