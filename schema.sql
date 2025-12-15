DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS sellers;
DROP TABLE IF EXISTS customers;


CREATE TABLE customers (
    customer_id VARCHAR(200) PRIMARY KEY,
    customer_unique_id VARCHAR(200) NOT NULL,
    customer_city VARCHAR(200) NOT NULL,
    customer_state VARCHAR(200) NOT NULL
    
);

CREATE TABLE orders (
    order_id VARCHAR(200) PRIMARY KEY,
    customer_id VARCHAR(200) NOT NULL,
    order_status VARCHAR(50) NOT NULL,
    order_purchase_timestamp DATE NOT NULL,
    order_approved_at DATE,
	order_delivered_carrier_date DATE,
    order_delivered_customer_date DATE,
    order_estimated_delivery_date DATE,

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


CREATE TABLE products (
    product_id VARCHAR(200) PRIMARY KEY,
    product_category_name VARCHAR(200),
    product_weight_g DECIMAL(10,2),
    product_length_cm DECIMAL(10,2),
    product_height_cm DECIMAL(10,2),
    product_width_cm DECIMAL(10,2)
);


CREATE TABLE sellers (
    seller_id VARCHAR(200) PRIMARY KEY,
    seller_city VARCHAR(200) NOT NULL,
    seller_state VARCHAR(200) NOT NULL
);


CREATE TABLE order_items (
    order_id VARCHAR(200) NOT NULL,
    order_item_id INT NOT NULL,
    product_id VARCHAR(200) NOT NULL,
    seller_id VARCHAR(200) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    freight_value DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (order_id, order_item_id),

    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

CREATE TABLE payments (
    order_id VARCHAR(200) NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type VARCHAR(200) NOT NULL,
    payment_installments INT,
    payment_value DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (order_id, payment_sequential),

    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


CREATE TABLE reviews (
    review_id VARCHAR(200) PRIMARY KEY,
    order_id VARCHAR(200) NOT NULL,
    review_score INT NOT NULL CHECK (review_score BETWEEN 1 AND 5),
    review_comment_title TEXT,
    review_comment_message TEXT,

    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);



