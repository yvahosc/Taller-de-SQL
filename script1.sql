-- 1. Creación de tablas

-- Creación del esquema store
CREATE SCHEMA IF NOT EXISTS store DEFAULT CHARACTER SET utf8;
USE store;

-- Creación tabla supplier
CREATE TABLE IF NOT EXISTS supplier (
    sup_id INT NOT NULL AUTO_INCREMENT,
    sup_name VARCHAR(80) NOT NULL,
    PRIMARY KEY (sup_id),
    UNIQUE INDEX sup_name_UNIQUE (sup_name ASC) VISIBLE)
ENGINE = InnoDB;

-- Creación tabla product
CREATE TABLE IF NOT EXISTS product (
    prod_id INT NOT NULL AUTO_INCREMENT,
    sup_id INT NOT NULL,
    prod_name VARCHAR(80) NOT NULL,
    prod_updated_at DATETIME NULL,
    PRIMARY KEY (prod_id),
    UNIQUE INDEX fk_product_supplier_idx (prod_name ASC) VISIBLE,
    CONSTRAINT fk_product_supplier
        FOREIGN KEY (sup_id)
        REFERENCES supplier (sup_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE)
ENGINE = InnoDB;

-- Creación tabla customer
CREATE TABLE IF NOT EXISTS customer (
    cust_id INT NOT NULL AUTO_INCREMENT,
    cust_type_id VARCHAR(4) NOT NULL,
    cust_id_number VARCHAR(11) NOT NULL,
    PRIMARY KEY (cust_id),
    UNIQUE INDEX cust_document_unique (cust_type_id ASC, cust_id_number ASC) INVISIBLE
) ENGINE = InnoDB;

-- Creación tabla sale
CREATE TABLE IF NOT EXISTS sale (
    sale_id INT NOT NULL AUTO_INCREMENT,
    cust_id INT NOT NULL,
    sale_deleted_at DATETIME NULL,
    PRIMARY KEY (sale_id),
    UNIQUE INDEX fk_sale_customer1_idx (sale_id ASC) VISIBLE,
    CONSTRAINT fk_sale_customer1
        FOREIGN KEY (cust_id)
        REFERENCES customer (cust_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE)
ENGINE = InnoDB;

-- Creación tabla product_in_sale
CREATE TABLE IF NOT EXISTS product_in_sale (
    sale_id INT NOT NULL,
    prod_id INT NOT NULL,
    product_quantity_per_sale INT NOT NULL,
    PRIMARY KEY (sale_id, prod_id),
    INDEX fk_sale_has_product_product1_idx (prod_id ASC) VISIBLE,
    INDEX fk_sale_has_product_sale1_idx (sale_id ASC) VISIBLE,
    CONSTRAINT fk_sale_has_product_sale1
        FOREIGN KEY (sale_id)
        REFERENCES sale (sale_id)
        ON DELETE CASCADE sale_id
        ON UPDATE CASCADE,
    CONSTRAINT fk_sale_has_product_product1
        FOREIGN KEY (prod_id)
        REFERENCES product (prod_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE)
ENGINE = InnoDB;


-- 2. Creación de información para las tablas

-- Inserción en tabla supplier
INSERT INTO supplier (sup_name) VALUES ('LG');
INSERT INTO supplier (sup_name) VALUES ('HP');
INSERT INTO supplier (sup_name) VALUES ('SONY');
INSERT INTO supplier (sup_name) VALUES ('LENOVO');
INSERT INTO supplier (sup_name) VALUES ('PANASONIC');

-- Inserción en tabla product
INSERT INTO product (sup_id, prod_name) VALUES (1, 'Aire acondicionado');
INSERT INTO product (sup_id, prod_name) VALUES (1, 'Lavadora');
INSERT INTO product (sup_id, prod_name) VALUES (2, 'Computador');
INSERT INTO product (sup_id, prod_name) VALUES (3, 'Equipo de sonido');
INSERT INTO product (sup_id, prod_name) VALUES (3, 'Play Station');
INSERT INTO product (sup_id, prod_name) VALUES (4, 'Celular inteligente');
INSERT INTO product (sup_id, prod_name) VALUES (5, 'Televisor');

-- Inserción en tabla customer
INSERT INTO customer (cust_type_id, cust_id_number) VALUES ('CC', '0000000001');
INSERT INTO customer (cust_type_id, cust_id_number) VALUES ('CC', '0000000002');
INSERT INTO customer (cust_type_id, cust_id_number) VALUES ('CE', '0000000003');

-- Inserción en tabla sale
INSERT INTO sale (cust_id) VALUES (1);
INSERT INTO sale (cust_id) VALUES (1);
INSERT INTO sale (cust_id) VALUES (3);
INSERT INTO sale (cust_id) VALUES (2);
INSERT INTO sale (cust_id) VALUES (3);


-- Inserción en tabla product_in_sale
-- Venta 1
INSERT INTO product_in_sale (sale_id, prod_id, product_quantity_per_sale) VALUES (1, 5, 1);
INSERT INTO product_in_sale (sale_id, prod_id, product_quantity_per_sale) VALUES (1, 3, 2);
INSERT INTO product_in_sale (sale_id, prod_id, product_quantity_per_sale) VALUES (1, 7, 5);

-- Venta 2
INSERT INTO product_in_sale (sale_id, prod_id, product_quantity_per_sale) VALUES (2, 1, 8);
INSERT INTO product_in_sale (sale_id, prod_id, product_quantity_per_sale) VALUES (2, 2, 4);

-- Venta 3
INSERT INTO product_in_sale (sale_id, prod_id, product_quantity_per_sale) VALUES (3, 4, 3);

-- Venta 4
INSERT INTO product_in_sale (sale_id, prod_id, product_quantity_per_sale) VALUES (4, 6, 6);

-- Venta 5
INSERT INTO product_in_sale (sale_id, prod_id, product_quantity_per_sale) VALUES (5, 1, 1);
INSERT INTO product_in_sale (sale_id, prod_id, product_quantity_per_sale) VALUES (5, 2, 1);
INSERT INTO product_in_sale (sale_id, prod_id, product_quantity_per_sale) VALUES (5, 4, 1);


-- 3. Borrados lógicos y físicos de ventas realizadas
-- Borrado lógico 1
UPDATE sale SET sale_deleted_at = now() WHERE (sale_id = 2);

-- Borrado lógico 2
UPDATE sale SET sale_deleted_at = now() WHERE (sale_id = 1);

-- Borrado físico 1
DELETE FROM sale WHERE (sale_id = 3);

-- Borrado físico 2
DELETE FROM sale WHERE (sale_id = 4);

-- 4. Modificación de tres productos en nombre u proveedor