#!/usr/bin/env python
import os

# Set environment variables
os.environ['API_USER'] = 'username'
os.environ['API_PASSWORD'] = 'secret'

# Get environment variables
USER = os.getenv('API_USER')
PASSWORD = os.environ.get('API_PASSWORD')

# Getting non-existent keys
mysql_host = os.getenv('MYSQL_HOST') # None
mysql_port = os.environ.get('MYSQL_PORT') # None
