--I was trying to write a code that has 50 randome numbers in the second column of the #test table to start. 
--And then whenever it runs through the loop it adds one to the first column and does the corresponding math to the second column. 
--If the second column is odd then add one to the first column and multiply the second column by 3 and add one to it. 
--If the second column is even then add one to the first column and divide the second column by 2. 
--Repeat this until all values in the second column are 1.
CREATE TABLE #test(  
   ID INT IDENTITY NOT NULL PRIMARY KEY,   
   count int,
   value int,
--   Name VARCHAR(40) NOT NULL  
);  

CREATE TABLE #result(  
   ID INT,   
   count int,
   value int,
--   Name VARCHAR(40) NOT NULL  
);  

-- Inserting values into products table.  
DECLARE @Counter INT 
SET @Counter=1
WHILE ( @Counter <= 50)
BEGIN
  INSERT INTO #test(count,value)   
  VALUES (1,FLOOR(RAND()*(100)+1));  
--  VALUES (1,FLOOR(RAND()*(100)+1),'Screwdriver');  
--          , ('Hammer')  
--          , ('Saw')  
--          , ('Shovel');  
--    insert into #test(id,count,value) values( ROW_NUMBER() OVER (ORDER BY newId()), 1,FLOOR(RAND()*(100)+1))
    SET @Counter  = @Counter  + 1
END
--  DECLARE @mv int;
--  DECLARE @id int;
--  DECLARE @count int;
--  DECLARE @md DECIMAL(5,1);
--  select @mv=max(value) from #test
--  select @md=max(value)/2.0 from #test
--  select top 1 @id=id,@count=count from #test where value = @mv
--   select @mv mv,@md md, @count count,@id id
--  update #test
--  set value = @mv /2
--  where id = @id
--  select * from #test where id = @id  

DECLARE @mv int;
DECLARE @id int;
DECLARE @count int;
DECLARE @md DECIMAL(5,1);
SET @Counter=1
WHILE ( @Counter <= 50)
BEGIN
  select @mv=max(value) from #test
  select top 1 @id=id,@count=count from #test where value = @mv
  select @md=max(value)/2.0 from #test
  select top 1 value from #test where value = @mv
  select @md maxdiv2 

  if (@md like '%.0')
  begin
--    INSERT INTO #result(id, count,value)   
--    VALUES (@id,@count,@mv/2);  
    update #test
    set value = @mv /2
    where id = @id
    select @mv / 2 update_value
  end
  else
  begin
--    INSERT INTO #result(id, count,value)   
--    VALUES (@id,@count,@mv * 3 + 1);  
    update #test
    set value = @mv * 3 + 1
    where id = @id
    select @mv * 3 + 1 update_value
  end
  SET @Counter  = @Counter  + 1
END