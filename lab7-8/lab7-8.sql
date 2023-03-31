
DROP ROLE IF EXISTS economist;
DROP ROLE IF EXISTS director;

-- Роли
 
CREATE ROLE economist WITH LOGIN;
GRANT ALL ON suppliers TO economist;
GRANT ALL ON supplies TO economist;
GRANT SELECT ON details TO economist;
GRANT SELECT ON projects TO economist;
GRANT SELECT ON e_suppliers_view TO economist;
GRANT SELECT ON e_details_view TO economist;
GRANT SELECT ON e_projects_view TO economist;
GRANT SELECT ON e_supplies_view TO economist;
 
CREATE ROLE director WITH LOGIN;
GRANT ALL ON suppliers TO director;
GRANT ALL ON details TO director;
GRANT ALL ON projects TO director;
GRANT SELECT ON supplies TO director;
GRANT SELECT ON d_suppliers_view TO director;
GRANT SELECT ON d_details_view TO director;
GRANT SELECT ON d_projects_view TO director;
GRANT SELECT ON d_supplies_view TO director;


-- Триггеры
 
-- 1. Ненадежный поставщик не может поставлять дорогую деталь
 
CREATE OR REPLACE FUNCTION unreliable_suppliers()
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
 
CREATE OR REPLACE TRIGGER unreliable_supplier_insert
    BEFORE INSERT
    ON supplies
    FOR EACH ROW
EXECUTE FUNCTION unreliable_suppliers();
 
CREATE OR REPLACE TRIGGER unreliable_supplier_update
    BEFORE UPDATE
    ON supplies
    FOR EACH ROW
EXECUTE FUNCTION unreliable_suppliers();
 
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
 
CREATE OR REPLACE TRIGGER overweight_supplies_insert
    BEFORE INSERT
    ON supplies
    FOR EACH ROW
EXECUTE FUNCTION block_overweight_supplies();
 
CREATE OR REPLACE TRIGGER overweight_supplies_update
    BEFORE UPDATE
    ON supplies
    FOR EACH ROW
EXECUTE FUNCTION block_overweight_supplies();
 
-- 3. Суммарная стоимость всех поставок по проекту не должна превышать бюджет проекта
 
CREATE OR REPLACE FUNCTION project_overdraft()
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
 
CREATE OR REPLACE TRIGGER overdraft_projects_insert
    BEFORE INSERT
    ON supplies
    FOR EACH ROW
EXECUTE FUNCTION project_overdraft();
 
CREATE OR REPLACE TRIGGER overdraft_projects_update
    BEFORE UPDATE
    ON supplies
    FOR EACH ROW
EXECUTE FUNCTION project_overdraft();

