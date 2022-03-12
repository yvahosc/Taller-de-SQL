-- 1. Consulta productos vendidos digitando tipo de documento y número de documento.
-- Consulta productos por cliente 1
SELECT prod_name FROM product WHERE prod_id = 
    ANY (SELECT prod_id FROM product_in_sale 
    WHERE sale_id = ANY (SELECT sale_id FROM sale 
    WHERE cust_id = (SELECT cust_id FROM customer 
    WHERE cust_type_id = 'CC' AND cust_id_number = '0000000001')));

-- Consulta productos por cliente 2
SELECT prod_name FROM product WHERE prod_id = 
    ANY (SELECT prod_id FROM product_in_sale 
    WHERE sale_id = ANY (SELECT sale_id FROM sale 
    WHERE cust_id = (SELECT cust_id FROM customer 
    WHERE cust_type_id = 'CC' AND cust_id_number = '0000000002')));

-- Consulta productos por cliente 3
SELECT prod_name FROM product WHERE prod_id = 
    ANY (SELECT prod_id FROM product_in_sale 
    WHERE sale_id = ANY (SELECT sale_id FROM sale 
    WHERE cust_id = (SELECT cust_id FROM customer 
    WHERE cust_type_id = 'CE' AND cust_id_number = '0000000003')));

-- 2. Consulta de productos por nombre y mostrar proveedor 


-- 3. Consulta de productos más vendidos y las cantidades ordenados de mayor a menor.