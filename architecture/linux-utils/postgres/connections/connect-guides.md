# enter password options

<https://dba.stackexchange.com/questions/14740/how-to-use-psql-with-no-password-prompt>
<https://www.calhoun.io/connecting-to-a-postgresql-database-with-gos-database-sql-package/>
String url = "jdbc:postgresql://localhost/test?user=fred&password=secret&ssl=false";

You have four choices regarding the password prompt:

set the PGPASSWORD environment variable. For details see the manual:
<http://www.postgresql.org/docs/current/static/libpq-envars.html>
use a .pgpass file to store the password. For details see the manual:
<http://www.postgresql.org/docs/current/static/libpq-pgpass.html>
use "trust authentication" for that specific user:
<http://www.postgresql.org/docs/current/static/auth-methods.html#AUTH-TRUST>
use a connection URI that contains everything:
<http://www.postgresql.org/docs/current/static/libpq-connect.html#AEN42532>

<https://dba.stackexchange.com/questions/14740/how-to-use-psql-with-no-password-prompt>

<https://github.com/zalando/postgres-operator/blob/master/docs/user.md>
<https://github.com/zalando/postgres-operator>
