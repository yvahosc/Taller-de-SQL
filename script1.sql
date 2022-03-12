-- 1. Creación de tablas

-- Creación del esquema store
CREATE SCHEMA IF NOT EXISTS store DEFAULT CHARACTER SET utf8;
USE store;

-- Creación tabla supplier
CREATE TABLE IF NOT EXISTS supplier (
    sup_id INT NOT NULL AUTO_INCREMENT,
    sup_name VARCHAR(80) NOT NULL,
    PRIMARY KEY (sup_id))
ENGINE = InnoDB;

-- Creación tabla product
CREATE TABLE IF NOT EXISTS product (
    prod_id INT NOT NULL AUTO_INCREMENT,
    sup_id INT NOT NULL,
    prod_name VARCHAR(80) NOT NULL,
    PRIMARY KEY (prod_id),
    UNIQUE INDEX fk_product_supplier_idx (sup_id ASC) VISIBLE,
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
    sale_elimination_status BOOLEAN NULL DEFAULT 0,
    PRIMARY KEY (sale_id),
    UNIQUE INDEX fk_sale_customer1_idx (cust_id ASC) VISIBLE,
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
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_sale_has_product_product1
        FOREIGN KEY (prod_id)
        REFERENCES product (prod_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE)
ENGINE = InnoDB;


-- 2. Creación de información para las tablas


-- 3. Borrados lógicos y físicos de ventas realizadas


-- 4. Modificación de tres productos en nombre u proveedor