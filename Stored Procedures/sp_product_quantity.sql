-- Description: This stored procedure allows the purchase of products by customers. It checks if there is sufficient
-- quantity of the product in stock and, if so, records the sale and updates product inventory.

DELIMITER $$

-- Delete the procedure if it already exists.
DROP PROCEDURE IF EXISTS pr_buy_products;

-- Create the stored procedure named pr_buy_products.
CREATE PROCEDURE pr_buy_products(p_product_name VARCHAR(50), p_quantity INT)
BEGIN 
    -- Declare local variables to store product details and quantities.
    DECLARE v_product_code VARCHAR(50);
    DECLARE v_price FLOAT;
    DECLARE v_cnt INT;

    -- Check if there is enough quantity of the specified product in stock.
    SELECT COUNT(1)
    INTO v_cnt
    FROM products
    WHERE product_name = p_product_name
    AND quantity_remaining >= p_quantity;

    -- If there is enough quantity, proceed with the sale.
    IF v_cnt > 0 THEN
        -- Retrieve the product code and price for the product.
        SELECT product_code, price
        INTO v_product_code, v_price
        FROM products
        WHERE product_name = p_product_name;

        -- Insert a new sales record into the 'sales' table.
        INSERT INTO sales (order_date, product_code, quantity_ordered, sale_price)
        VALUES (CAST(NOW() AS DATE), v_product_code, p_quantity, (v_price * p_quantity));

        -- Update the product inventory by reducing the remaining quantity and increasing the quantity sold.
        UPDATE products
        SET quantity_remaining = (quantity_remaining - p_quantity), 
            quantity_sold = (quantity_sold + p_quantity)
        WHERE product_code = v_product_code;

        -- Provide a success message indicating that the product has been sold.
        SELECT 'Product sold' AS Result;
    ELSE
        -- Provide an error message indicating insufficient product quantity in stock.
        SELECT 'Insufficient quantity' AS Result;
    END IF;
    
END$$
DELIMITER ;



