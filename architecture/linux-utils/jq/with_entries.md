https://stedolan.github.io/jq/manual/#to_entries,from_entries,with_entries

Refactoring with with_entries
It turns out that the pattern:

to_entries -> map(...) -> from_entries
is common enough to have a function expression all of its own, and it's with_entries. As detailed in the entries section of the manual:

with_entries(foo) is shorthand for to_entries | map(foo) | from_entries

In fact, we can see how it's defined (which is exactly as described in the manual) in builtin.jq, along with to_entries and from_entries.


to_entries, from_entries, with_entries
These functions convert between an object and an array of key-value pairs. If to_entries is passed an object, then for each k: v entry in the input, the output array includes {"key": k, "value": v}.

from_entries does the opposite conversion, and with_entries(foo) is a shorthand for to_entries | map(foo) | from_entries, useful for doing some operation to all keys and values of an object. from_entries accepts key, Key, name, Name, value and Value as keys.


1. kubectl get secret example-mongodb-admin-my-user -n mongo \
-o json

  {
    "apiVersion": "v1",
    "data": {
        "connectionString.standard": "bW9uZ29kYjovL215LXVzZXI6SmVzdXNMaXZlczElMjFAZXhhbXBsZS1tb25nb2RiLTAuZXhhbXBsZS1tb25nb2RiLXN2Yy5tb25nby5zdmMuY2x1c3Rlci5sb2NhbDoyNzAxNyxleGFtcGxlLW1vbmdvZGItMS5leGFtcGxlLW1vbmdvZGItc3ZjLm1vbmdvLnN2Yy5jbHVzdGVyLmxvY2FsOjI3MDE3LGV4YW1wbGUtbW9uZ29kYi0yLmV4YW1wbGUtbW9uZ29kYi1zdmMubW9uZ28uc3ZjLmNsdXN0ZXIubG9jYWw6MjcwMTcvYWRtaW4/cmVwbGljYVNldD1leGFtcGxlLW1vbmdvZGImc3NsPWZhbHNl",
        "connectionString.standardSrv": "bW9uZ29kYitzcnY6Ly9teS11c2VyOkplc3VzTGl2ZXMxJTIxQGV4YW1wbGUtbW9uZ29kYi1zdmMubW9uZ28uc3ZjLmNsdXN0ZXIubG9jYWwvYWRtaW4/cmVwbGljYVNldD1leGFtcGxlLW1vbmdvZGImc3NsPWZhbHNl",
        "password": "SmVzdXNMaXZlczEh",
        "username": "bXktdXNlcg=="
    },
    "kind": "Secret",
    "metadata": {
        "creationTimestamp": "2023-02-17T23:53:08Z",
        "name": "example-mongodb-admin-my-user",
        "namespace": "mongo",
        "ownerReferences": [
            {
                "apiVersion": "mongodbcommunity.mongodb.com/v1",
                "blockOwnerDeletion": true,
                "controller": true,
                "kind": "MongoDBCommunity",
                "name": "example-mongodb",
                "uid": "7eaba8d0-6e77-4b99-a676-11675232e60e"
            }
        ],
        "resourceVersion": "2367945",
        "uid": "688346e0-ea7e-4087-8694-5eb759e43139"
    },
    "type": "Opaque"
}

2. kubectl get secret example-mongodb-admin-my-user -n mongo \
-o json | jq -r '.data | with_entries(.value |= @base64d)'