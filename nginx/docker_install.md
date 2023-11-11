https://hub.docker.com/_/nginx
x=1; while  [ $x -le 5 ]; do echo "Welcome $x times" $(( ++x )); done 

x=1; while  [ $x -le 5 ]; do echo "Welcome $x times next " $(( ++x )); sleep 2;  done 

x=1; while  [ $x -le 5 ]; do echo "Welcome $x times next " $(( ++x )); sleep 2 &;  done 

x=1; while  [ $x -le 5 ]; do echo "Welcome $x times next " $(( ++x )); sleep 2 & wait $!;  done 

