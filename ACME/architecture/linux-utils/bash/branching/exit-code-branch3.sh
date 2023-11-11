#!/bin/bash
# echo "hello world" 
echo "hello world" | grep world
# echo "hello world" | grep not
status=$?

#!/bin/bash
if [[ "$(whoami)" != bgroves ]]; then
  echo "Not bgroves."
  exit 1
fi
echo "user=bgroves"
exit 0

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

# echo "hello world" | grep not
# status=$?
# [ $status -eq 0 ] && echo "command successful" || echo "command unsuccessful"
