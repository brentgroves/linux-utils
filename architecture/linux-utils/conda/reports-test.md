# tested reports2 on dev system
## test odbc
pushd /home/brent/src/linux-utils/odbc
OpenSSL 3.1.2 1 Aug 2023 (Library: OpenSSL 3.1.2 1 Aug 2023)
pip install pyodbc
Successfully installed pyodbc-4.0.39
python odbc-dsn-plextest.py
## test soap
pushd /home/brent/src/linux-utils/soap
python ws_to_dw_test.py

