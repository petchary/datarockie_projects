-- create keyTable
CREATE TABLE keyTable (
  order_id INT,
  amount REAL,
  order_date DATE,
PRIMARY KEY (order_id),
FOREIGN KEY  (amount) REFERENCES keyTable(amount),
FOREIGN KEY (order_date) REFERENCES customerHistory(order_date)
);

INSERT INTO keyTable VALUES
(1, 1500, '2023-01-01'),
(2, 1000, '2023-01-02'),
(3, 500, '2023-01-03'),
(4, 1500, '2023-01-04'),
(5, 1000, '2023-01-05'),
(6, 1000, '2023-01-05'),
(7,  500, '2023-01-06'),
(8, 1500, '2023-01-06'),
(9, 1500, '2023-01-07'),
(10, 1500, '2023-01-07');

-- create member information
CREATE TABLE memberInfo (
  membership_id INT,
  fullname CHAR,
  membership_lv CHAR,
  birthday DATE,
PRIMARY KEY (membership_id),
FOREIGN KEY (fullname) REFERENCES memberInfo(fullname),
FOREIGN KEY (membership_lv) REFERENCES memberInfo(membership_lv),
FOREIGN KEY (birthday) REFERENCES memberInfo(birthday)
);
  
INSERT INTO memberInfo VALUES
(1, 'Anderson Aron', 'Bronze', '2000-01-01'),
(2, 'Brewer Britte', 'Silver', '2000-01-02'),
(3, 'Centry Cathe', 'Gold', '2000-01-03'),
(4, 'Dean Dorothy', 'Silver', '2000-01-04'),
(5, 'Elle Elena', 'Bronze', '2000-01-05');

-- create transactions
CREATE TABLE orderedTransaction (
  table_no INT,
  set_menu CHAR,
  amount INT,
  order_date DATE,
PRIMARY KEY (table_no),
FOREIGN KEY (set_menu) REFERENCES orderedTransaction(set_menu),
FOREIGN KEY (amount) REFERENCES orderedTransaction(amount),
FOREIGN KEY (order_date) REFERENCES customerHistory(order_date)
);

INSERT or IGNORE INTO orderedTransaction VALUES
(6, 'The Biggest', 1500, '2023-01-01'),
(2, 'The Middle', 1000, '2023-01-02'),
(4, 'The Smallest', 500, '2023-01-03'),
(1, 'The Biggest', 1500, '2023-01-04'),
(3, 'The Middle', 1000, '2023-01-05'),
(2, 'The Middle', 1000, '2023-01-05'),
(1, 'The Smallest', 500, '2023-01-06'),
(4, 'The Biggest', 1500, '2023-01-06'),
(3, 'The Biggest', 1500, '2023-01-07'),
(1, 'The Biggest', 1500, '2023-01-07');

-- create reviews
CREATE TABLE review (
  review_id INT,
  rating_food REAL,
  rating_service REAL,
  complaint CHAR,
PRIMARY KEY (review_id),
FOREIGN KEY (rating_food) REFERENCES review(rating_food),
FOREIGN KEY (rating_service) REFERENCES review(rating_service),
FOREIGN KEY (complaint) REFERENCES review(complaint)
);
  
INSERT INTO review VALUES
(1, 4.8, 4.0, 'None'),
(2, 2.9, 3.5, 'Unsatisfied of taste'),
(3, 4.2, 4.8, 'None'),
(4, 3.9, 2.5, 'Waiting time'),
(5, 4.5, 4.6, 'None'),
(6, 4.1, 3.6, 'Waiting time'),
(7, 4.8, 4.2, 'None'),
(8, 3.1, 4.5, 'Overcooked shrimp'),
(9, 2.8, 3.9, 'Too spicy'),
(10, 4.5, 4.2, 'None');

-- create history
CREATE TABLE customerHistory (
  order_date DATE,
  membership_id INT,
PRIMARY KEY (order_date),
FOREIGN KEY (membership_id) REFERENCES memberInfo(membership_id)
);

INSERT or IGNORE INTO customerHistory VALUES
('2023-01-01',1),
('2023-01-02',2),
('2023-01-03',3),
('2023-01-04',4),
('2023-01-05',5),
('2023-01-05',3),
('2023-01-06',4),
('2023-01-06',1),
('2023-01-07',2),
('2023-01-07',5);

-- sub query to find complaints
SELECT complaint from 
(select * from review
where rating_food < 4);

-- queries

-- to sum total sales per day
SELECT
	order_date,
  sum(amount) total_sales
FROM keyTable
group by order_date;

-- to group hungry level of customer with menu size
SELECT set_menu,
CASE 
  WHEN set_menu IS 'The Biggest' THEN 'Hungry Customer' 
  ELSE 'Chill Customer'
END customer_types
FROM orderedTransaction;

-- to find repeating customers
SELECT
	membership_id,
	count(membership_id) repeating_customer
from customerHistory
GROUP BY membership_id
HAVING repeating_customer > 1;
