USE DB01;

-- Begin Transaction
BEGIN TRY
    BEGIN TRANSACTION;

    -- Create Products table if it doesn't exist
    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Products' AND schema_id = SCHEMA_ID('dbo'))
    BEGIN
        CREATE TABLE dbo.Products (
            ProductID INT IDENTITY(1,1) PRIMARY KEY,
            ProductName NVARCHAR(100),
            Price DECIMAL(10, 2),
            Description NVARCHAR(255),
            CategoryID INT
        );
        PRINT 'Products table created successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Products table already exists.';
    END;

    -- Insert data into the Products table
    INSERT INTO dbo.Products (ProductName, Price, Description, CategoryID)
    VALUES
        -- Fruits
        ('Organic Blueberries', 4.99, 'Sweet, antioxidant-rich organic blueberries.', 1),
        ('Bananas', 1.29, 'Organic bananas, naturally ripened.', 1),
        ('Organic Avocados', 2.99, 'Rich, creamy organic avocados.', 1),

        -- Vegetables
        ('Organic Broccoli', 3.49, 'Fresh, crisp organic broccoli.', 2),
        ('Organic Carrots', 2.49, 'Sweet and crunchy organic carrots.', 2),
        ('Organic Kale', 3.99, 'Dark, leafy green packed with nutrients.', 2),

        -- Dairy
        ('Organic Greek Yogurt', 6.99, 'Thick, creamy organic Greek yogurt.', 3),
        ('Organic Cheddar Cheese', 5.49, 'Sharp and rich organic cheddar cheese.', 3),
        ('Free-Range Eggs', 4.29, 'Fresh, free-range large brown eggs.', 3),

        -- Bakery
        ('Gluten-Free Bread', 6.99, 'Soft, gluten-free sandwich bread.', 4),
        ('Sourdough Loaf', 4.99, 'Freshly baked artisan sourdough bread.', 4),
        ('Vegan Chocolate Chip Cookies', 5.99, 'Delicious vegan chocolate chip cookies.', 4),

        -- Meat & Seafood
        ('Grass-Fed Ground Beef', 8.99, '100% grass-fed ground beef.', 5),
        ('Organic Chicken Breast', 9.99, 'Organic, free-range chicken breast.', 5),
        ('Wild-Caught Shrimp', 13.99, 'Fresh, wild-caught shrimp from the Gulf.', 5),

        -- Pantry Staples
        ('Organic Olive Oil', 10.99, 'Extra virgin olive oil from Italy.', 6),
        ('Brown Rice', 2.99, 'Nutty and wholesome organic brown rice.', 6),
        ('Organic Almond Butter', 9.99, 'Smooth organic almond butter with no added sugar.', 6),

        -- Additional entries
        ('Organic Gala Apples', 3.99, 'Crisp and sweet, perfect for snacking.', 1),
        ('Organic Baby Spinach', 4.99, 'Fresh organic spinach, ready to use.', 2),
        ('Almond Milk - Unsweetened', 2.99, 'Dairy-free milk alternative, unsweetened.', 3),
        ('Whole Wheat Bread', 5.49, 'Freshly baked whole wheat bread.', 4),
        ('Wild-Caught Salmon', 12.99, 'Fresh wild-caught Alaskan salmon.', 5),
        ('Organic Quinoa', 6.99, 'A versatile grain, rich in protein.', 6);

    -- Commit Transaction
    COMMIT TRANSACTION;
    PRINT 'Data inserted successfully into Products table.';

    -- Verify insertion
    DECLARE @InsertedRows INT;
    SELECT @InsertedRows = COUNT(*) FROM dbo.Products;
    PRINT 'Total rows in Products table: ' + CAST(@InsertedRows AS NVARCHAR(10));

END TRY
BEGIN CATCH
    -- Rollback if an error occurs
    ROLLBACK TRANSACTION;
    PRINT 'Error occurred. Transaction rolled back.';
    PRINT ERROR_MESSAGE();
END CATCH;
