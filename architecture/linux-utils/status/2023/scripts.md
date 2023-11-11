ETL scripts generate the report result-set which is stored in MongoDB with a unique id.  
Since we are using OpenEBS jiva storage every result-set is inserted into 3 identical database files automatically.  
The MongoDB software engine inserts report result-sets and OpenEBS takes care of updating the 3 database files automatically.
If the node, VM, where the MongoDB software engine crashes it's the k8s job to start a pod on another node.
Since we still have 2 duplicate copies of the MongoDB files the MongoDB software engine still works great.
The MongoDB engine is also available to the network that the k8s is deployed on by a Nodeport service by connecting to one of the other 2 working nodes.  
The nodeport maps MongoDB tcp port connections to the MongoDB software engine no matter which node k8s runs it on.
K8s has it's own internal network with a DNS.