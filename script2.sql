-- 1. Consulta productos vendidos digitando tipo de documento y número de documento.
-- Consulta productos por cliente 1
SELECT prod_name FROM product WHERE prod_id = 
    ANY (SELECT prod_id FROM product_in_sale 
    WHERE sale_id = ANY (SELECT sale_id FROM sale 
    WHERE cust_id = (SELECT cust_id FROM customer 
    WHERE cust_type_id = 'CC' AND cust_id_number = '0000000001') 
    AND sale_deleted_at IS NULL));

-- Consulta productos por cliente 2
SELECT prod_name FROM product WHERE prod_id = 
    ANY (SELECT prod_id FROM product_in_sale 
    WHERE sale_id = ANY (SELECT sale_id FROM sale 
    WHERE cust_id = (SELECT cust_id FROM customer 
    WHERE cust_type_id = 'CC' AND cust_id_number = '0000000002')
    AND sale_deleted_at IS NULL));

-- Consulta productos por cliente 3
SELECT prod_name FROM product WHERE prod_id = 
    ANY (SELECT prod_id FROM product_in_sale 
    WHERE sale_id = ANY (SELECT sale_id FROM sale 
    WHERE cust_id = (SELECT cust_id FROM customer 
    WHERE cust_type_id = 'CE' AND cust_id_number = '0000000003')
    AND sale_deleted_at IS NULL));

-- 2. Consulta de productos por nombre y mostrar proveedor o quienes han sido sus proveedores
-- Consulta producto 1
SELECT product.prod_name, supplier.sup_name, product.prod_previous_sup FROM supplier 
    INNER JOIN product ON supplier.sup_id = product.sup_id 
    WHERE prod_id = (SELECT prod_id FROM product 
    WHERE prod_name = 'Aire acondicionado portatil');

-- Consulta producto 2
SELECT product.prod_name, supplier.sup_name, product.prod_previous_sup FROM supplier 
    INNER JOIN product ON supplier.sup_id = product.sup_id 
    WHERE prod_id = (SELECT prod_id FROM product 
    WHERE prod_name = 'Lavadora y secadora');

-- Consulta producto 3
SELECT product.prod_name, supplier.sup_name, product.prod_previous_sup FROM supplier 
    INNER JOIN product ON supplier.sup_id = product.sup_id 
    WHERE prod_id = (SELECT prod_id FROM product 
    WHERE prod_name = 'Computador');

-- Consulta producto 4
SELECT product.prod_name, supplier.sup_name, product.prod_previous_sup FROM supplier 
    INNER JOIN product ON supplier.sup_id = product.sup_id 
    WHERE prod_id = (SELECT prod_id FROM product 
    WHERE prod_name = 'Equipo de sonido');

-- Consulta producto 5
SELECT product.prod_name, supplier.sup_name, product.prod_previous_sup FROM supplier 
    INNER JOIN product ON supplier.sup_id = product.sup_id 
    WHERE prod_id = (SELECT prod_id FROM product 
    WHERE prod_name = 'Play Station');

-- Consulta producto 6
SELECT product.prod_name, supplier.sup_name, product.prod_previous_sup FROM supplier 
    INNER JOIN product ON supplier.sup_id = product.sup_id 
    WHERE prod_id = (SELECT prod_id FROM product 
    WHERE prod_name = 'Celular SmartPhone');

-- Consulta producto 7
SELECT product.prod_name, supplier.sup_name, product.prod_previous_sup FROM supplier 
    INNER JOIN product ON supplier.sup_id = product.sup_id 
    WHERE prod_id = (SELECT prod_id FROM product 
    WHERE prod_name = 'Televisor');

-- 3. Consulta de productos más vendidos y las cantidades ordenados de mayor a menor.
SELECT product.prod_name, SUM(product_quantity_per_sale) 
	FROM product_in_sale INNER JOIN product ON product.prod_id = product_in_sale.prod_id
    GROUP BY product.prod_id 
    ORDER BY SUM(product_quantity_per_sale) DESC;