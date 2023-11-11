when running:python odbc-dsn-plextest.py from
/home/brent/src/linux-utils/odbc
would get a segmentation fault when using pyodbc installed with conda
to fix the issue i ran: conda remove pyodbc
then checked pip list:
if pyodbc was not installed then I ran: pip install pyodbc.
after this running:python odbc-dsn-plextest.py caused no errors.
