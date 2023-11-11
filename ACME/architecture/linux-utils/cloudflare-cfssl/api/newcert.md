curl -d '{ "request": {"hosts":["www.example.com"], "names":[{"C":"US", "ST":"California", "L":"San Francisco", "O":"example.com"}], "CN": "www.example.com"} }' \
          localhost:8080/api/v1/cfssl/newcert  \
          | python -m json.tool