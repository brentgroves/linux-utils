#!/bin/bash
# echo "hello world" 
echo "hello world" | grep not
status=$?
[ $status -eq 0 ] && echo "command successful" || echo "command unsuccessful"


# if [[ $status -eq 0 ]]
# then # if/then branch
#   echo 'success'
# else # else branch
#   echo 'fail'
# fi

# if [[ some condition ]]; then
#   do_something
# fi


# if [[ some condition ]]; then
#   do_this
# elif [[ another condition ]]; then
#   do_that_a
# elif [[ yet another condition]]; then
#   do_that_b
# else
#   do_that_default_thing
# fi