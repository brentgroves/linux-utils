https://docs.oracle.com/javase/tutorial/jdbc/basics/storedprocedures.html
db_conn = pyodbc.connect(connection_string)
sql = """\
DECLARE @RC int;
SET ANSI_WARNINGS OFF;
SET NOCOUNT ON;
{Call [dev_1].[sp_testing] (?, ?, ?)};
SELECT @RC AS rc;
"""
values = (parm1, parm2, parm3)
cursor = db_conn.cursor()
cursor.execute(query_string, value)
rows = cursor.fetchall()