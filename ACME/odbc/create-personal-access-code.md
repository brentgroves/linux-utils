What permission has to be set for an account to be able to connect to plex using odbc? Data Access Allow.

1. use iam login to login as mg.odbcalbion.
2. log in to https://accounts.plex.com
2. Click Access Codes.
3. On the Personal Access Codes screen, click Create.
4. On the Create A Personal Access Code screen, complete the following:
Description - Albion ODBC personal access code.
Expiration - Select an expiration time of never.
Click OK.
On the Code Created screen, your Personal Access Code is displayed.
5. Copy your Personal Access Code to a local file and save it immediately. This is the only time that this code will be displayed and you cannot retrieve it again. If you lose this code, you will have to create a new Access Code.

Plex Manufacturing Cloud, PMC, user name: mg.odbcalbion
BPG-IN
mg.odbcalbion
Mob3xalbion

Mob3xalbion
Mob3xalbion
Mob3xalbion


It seems like mg.odbcalbion was not migrated into IAM, because I can't login through IAM with company code BPG-IN although I can login using the regular login screen. invalid credentials
All permissions data access.

Can we migrate mg.odbcalbion?  
Sam created the account mg.odbcazure should all our ETL scripts use that one.
Or do you want more than user name made?

Make user for odbc:
bpg-in
first:etl
last:mcp
userid:mg.odbcetl

old odbc user:
last:Albion
First: ODBC

Albion	ODBC	I.T. Coordinator	Mobex Global Albion	 	mg.odbcalbion	Generic user for ODBC connector	bgroves@mobexglobal.com	
Albion	ODBC2	I.T. Coordinator	Mobex Global Albion	 	mg.odbcalbion2	Generic user for ODBC connector	dgerkin@mobexglobal.com	



