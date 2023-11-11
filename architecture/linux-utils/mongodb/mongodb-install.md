The Real Goal:
Trust and believe that doing good is what I want of you!
Also trust and believe that I love you and am with you always!
Goal:
https://stackoverflow.com/questions/68366456/mongodb-community-kubernetes-operator-and-custom-persistent-volumes
Try to get 6 to work by modifying conf.orig and attempting to make sure mongo uses it.
https://www.mongodb.com/docs/manual/reference/configuration-options/

The story:
Created a k8s deployment and mounted a local drive c:\data\mongo with no files in it and the deployment succeeded and I was able to access it from a nodeport: git@github.com:brentgroves/mongodb-k8s.git
The catch is that only works for mongo:4.0.8
In order to get access via a nodeport with later versions of mongo I first ran a docker image which created the database files and then copied those files to /mnt/mongodb. Only then was I able to get a stateful set to work from a nodeport.
Thanks Father!
https://wiki.crowncloud.net/?How_to_Install_Latest_MongoDB_on_Ubuntu_22_04
https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/
sudo apt install dirmngr gnupg apt-transport-https ca-certificates software-properties-common
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt-get update
https://askubuntu.com/questions/1403619/mongodb-install-fails-on-ubuntu-22-04-depends-on-libssl1-1-but-it-is-not-insta
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb
sudo dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb
rm -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb
sudo apt-get install -y mongodb-org


mongosh --host 10.1.59.171 --port 27017 -u adminuser -p password123


https://phoenixnap.com/kb/kubernetes-mongodb
This one is simple to follow.
https://devopscube.com/deploy-mongodb-kubernetes/
This one uses replicasets and should be used with this stateful application I think?


https://hub.docker.com/_/mongo
1. create a data directory
sudo mkdir -p /mnt/mongodb
sudo chmod 777 /mnt/mongodb
sudo chown nobody:nogroup /srv/mysql

Start your mongo container like this:

$ docker run --name some-mongo -v /mnt/mongodb:/data/db -d mongo

https://phoenixnap.com/kb/kubernetes-mongodb
This one is simple to follow.
https://devopscube.com/deploy-mongodb-kubernetes/
This one uses replicasets and should be used with this stateful application I think?

After mongodb is setup use the following to move mysql data to mongodb:

https://hevodata.com/learn/mysql-to-mongodb/


Use kubectl to label the node with a key-value pair.
kubectl label nodes reports31 mongodb=reports31

Step 2: Create a StorageClass
StorageClass helps pods provision persistent volume claims on the node. To create a StorageClass:
code StorageClass.yaml

Step 3: Create Persistent Storage
Provision storage for the MongoDB deployment by creating a persistent volume and a persistent volume claim:

code PersistentVolume.yaml
2. In the file, allocate storage that belongs to the storage class defined in the previous step. Specify the node that will be used in pod deployment in the nodeAffinity section. The node is identified using the label created in Step 1.