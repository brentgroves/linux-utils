https://jmespath.org/proposals/functions.html#join

string join(string $glue, array[string] $stringsarray)
Returns all of the elements from the provided $stringsarray array joined together using the $glue argument as a separator between each.

string join(string $glue, array[string] $stringsarray)

az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$STATIC_IP')].{ID:join('c',['a','b']),IP:ipAddress}" --output tsv 


Examples
Given,Expression,Result

["a", "b"]

join(`, `, @)

“a, b”

["a", "b"]

az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$STATIC_IP')].{ID:join(',',['a','b'])}" --output tsv 

az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$STATIC_IP')].{ID:join(',',[id])}" --output tsv 

az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$STATIC_IP')].{ID:join(',',[id,ipAddress])}" --output tsv 
az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$STATIC_IP')].{ID:join(',',[id,ipAddress,'ccc'])}" --output tsv 
az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$STATIC_IP')].{ID:join(',',keys(@))}" --output tsv

az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$STATIC_IP')].{ID:join(',',values(@))}" --output tsv

az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$STATIC_IP')].{ID:keys(@)}"

join(, @)``

“ab”

["a", false, "b"]

join(`, `, @)

<error: invalid-type>

[false]

join(`, `, @)

<error: invalid-type>

