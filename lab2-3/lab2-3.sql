
DROP TABLE IF EXISTS supplies;
DROP TABLE IF EXISTS details;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS projects;

-- Создание таблиц
 
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
    FOREIGN KEY (detail_id) REFERENCES details (id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES suppliers (id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects (id) ON UPDATE CASCADE ON DELETE CASCADE
);

