#!/bin/bash

export PYCMD=$(cat <<EOF
from datetime import datetime

first_day_of_new_year = datetime(2022, 1, 1)

days_remaining = (first_day_of_new_year - datetime.now()).days
print('{} days remaining in this year'.format(days_remaining))
EOF
)

python3 -c "$PYCMD"