<https://stackoverflow.com/questions/2893954/how-to-pass-in-password-to-pg-dump>

<https://www.postgresql.org/docs/8.4/app-pgdump.html>

Or you can set up crontab to run a script. Inside that script you can set an environment variable like this: export PGPASSWORD="$put_here_the_password"

This way if you have multiple commands that would require password you can put them all in the script. If the password changes you only have to change it in one place (the script).

And I agree with Joshua, using pg_dump -Fc generates the most flexible export format and is already compressed. For more info see: pg_dump documentation

E.g.

```bash
## dump the database in custom-format archive

pg_dump -Fc mydb > db.dump

##  restore the database

pg_restore -d newdb db.dump

PGPASSWORD="mypass" pg_dump mydb > mydb.dump

```
