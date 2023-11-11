#!/bin/bash

get_remaining_days () {
    export PYCMD=$(cat <<EOF
from datetime import datetime

first_day_of_new_year = datetime(2023, 1, 1)

days_remaining = (first_day_of_new_year - datetime.now()).days
print('{} days remaining in this year'.format(days_remaining))
EOF
    )

    python3 -c "$PYCMD"
}

get_remaining_days
