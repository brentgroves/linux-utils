https://learn.microsoft.com/en-us/sql/connect/ado-net/sql/handle-null-values?view=sql-server-ver16

A null value in a relational database is used when the value in a column is unknown or missing. A null is neither an empty string (for character or datetime data types) nor a zero value (for numeric data types).

https://learn.microsoft.com/en-us/sql/connect/ado-net/sql/handle-null-values?view=sql-server-ver16#nulls-and-three-valued-logic

Nulls and three-valued logic
Allowing null values in column definitions introduces three-valued logic into your application. A comparison can evaluate to one of three conditions:
True
False
Unknown

Because null is considered to be unknown, two null values compared to each other are not considered to be equal. In expressions using arithmetic operators, if any of the operands is null, the result is null as well.

Why do we need NULL Functions?
Null functions are required to perform operations on the null values stored in our database. We can perform functions on NULL values, which explicitly recognize if a value is null or not.

Using this recognizing capacity, one can further perform operations on the null values like the aggregate functions in SQL. Some of the functions are as follows:

Sr.No	Function	Description
1	ISNULL()	Helps us to replace NULL values with the desired value. 
2	IFNULL()	Allows us to return the first value if the value is NULL, and otherwise returns the second value. 
3	COALESCE()	Helps us to return the first non-null values in the arguments. 
4	NVL()	Helps to replace the NULL value with the desired value given by the user. 


ISNULL(FPONO.[Replan Ref_ No_],(SELECT DISTINCT PO.[Replan Ref_ No_]
                                FROM NAV_Vermorel_Live.dbo.[SC Vermorel SRL$Production Order] AS PO
                                WHERE SH.[External Document No_] = PO.[Old Prod_ Order No_] AND PO.[Source No_] = SL.No_)),


