# remove old 
kubectl delete ingress,svc reporting-service 
kubectl delete deployment reporting
kubectl get pods -o wide

# build image
docker build --tag brentgroves/reporting:1 .
docker build --tag brentgroves/reporting:1 --build-arg CACHEBUST=$(date +%s) .

https://10.1.0.9
administrator@vsphere.local
Bu$ch3@dm!n


# start a container in the background
docker run -p 5000:5000 --name reporting -d brentgroves/reporting:1
docker container ls -a

# Next, execute a command on the container.
docker exec -it reporting pwd
docker exec -it reporting pgrep cron

# Next, execute an interactive bash shell on the container.
docker exec -it reporting bash


# test hotel api
docker run --name reporting -d -p 5000:5000 brentgroves/reporting:1
curl -X POST http://localhost:5000/hotel -H 'Content-Type: application/json' -d '{"id":"1","name":"name1","state":"state1","rooms":"1"}'
{"1": {"rooms": 1, "id": 1, "name": "name1", "state": "state1"}}
curl http://localhost:5000/hotel 
# https://everything.curl.dev/usingcurl/verbose/writeout
curl -w "Type: %{content_type}\nCode: %{response_code}\n" http://localhost:5000/report/trial_balance

# test report api
curl http://localhost:5000/report/trial_balance
curl -X POST http://localhost:5000/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","email":"bgroves@buschegroup.com","start_period":202201,"end_period":202207}'

# test parameter validation
curl -X POST http://localhost:5000/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","start_period":202201,"end_period":202207}'

# Next, execute an interactive bash shell on the container.
docker exec -it reporting bash

# is python installed
ls /miniconda/bin
python

# check path
echo $PATH
/miniconda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/mssql-tools/bin:/opt/mssql-tools18/bin

# can we see the mobex mail server? 
dig mobexglobal-com.mail.protection.outlook.com
# can we send an email?
echo "Testing msmtp from ${HOSTNAME} with mail command" | mail -s "test mail from cron-test pod" bgroves@buschegroup.com

# Deploy 
# Thank you Abba for the work that you have given us all to do!
kubectl apply -f tooling.yaml  
kubectl apply -f reports.yaml
kubectl apply -f reports-dev.yaml    

kubectl describe deployment reporting
kubectl get pods -o wide

These apps are now available at their internal pod IP address.
kubectl get pods -o wide
or 
# test api using internal ip of primary pod
export primaryPodIP=$(kubectl get pods -l app=reporting -o=jsonpath="{.items[0].status.podIPs[0].ip}")

curl http://${primaryPodIP}:5000/report_list
curl -X POST http://${primaryPodIP}:5000/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","email":"bgroves@buschegroup.com","start_period":202201,"end_period":202207}'

curl http://${primaryPodIP}:5000/hotel -H 'Content-Type: application/json' -d '{"id":"1","name":"name1","state":"state1","rooms":"1"}'

curl http://${primaryPodIP}:5000/hotel -H 'Content-Type: application/json' -d '{"id":"2","name":"name2","state":"state2","rooms":"2"}'

curl http://${primaryPodIP}:5000/hotel -H 'Content-Type: application/json' -d '{"id":"3","name":"name3","state":"state3","rooms":"3"}'

curl http://${primaryPodIP}:5000/hotel

# test report api
curl http://${primaryPodIP}:5000/report/trial_balance

# test parameter validation
curl -X POST http://${primaryPodIP}:5000/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","start_period":202201,"end_period":202207}'

kubectl get services
# IP of primary service
export primaryServiceIP=$(kubectl get service/reporting-service -o=jsonpath="{.spec.clusterIP}")
# check primary service
curl http://${primaryServiceIP}:5000/report_list

curl -X POST http://${primaryServiceIP}:5000/hotel -H 'Content-Type: application/json' -d '{"id":"4","name":"name4","state":"state4","rooms":"4"}'
curl http://${primaryServiceIP}:5000/hotel

curl http://${primaryServiceIP}:5000/report/trial_balance

# test parameter validation
curl -X POST http://${primaryServiceIP}:5000/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","start_period":202201,"end_period":202207}'

# test trial balance pipe line
curl -X POST http://${primaryServiceIP}:5000/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","email":"bgroves@buschegroup.com","start_period":202108,"end_period":202208}'

These validations proved out the pod and service independent of the NGINX ingress controller.  Notice all these were using insecure HTTP on port 8080, because the Ingress controller step in the following step is where TLS is layered on.

# verify /etc/hosts has an entry for the host in the ingress yaml is pointing to the ingress service IP used by the load balancer
kubectl get service --namespace ingress
load balancer -> primary or secondary ingress -> ingress object -> reporting API

# create secured ingress
kubectl apply -f report-ingress.yaml

# show Ingress objects
kubectl get ingress --namespace default
kubectl describe ingress reporting-service

# these host names have to be in the hosts file or in the DNS
# check primary service
curl -k https://avi-ubu/report_list
curl -k https://reports01/report_list
curl -k https://reports11/report_list

curl -k -X POST https://avi-ubu/hotel -H 'Content-Type: application/json' -d '{"id":"5","name":"name5","state":"state5","rooms":"5"}'
curl -k -X POST https://reports01/hotel -H 'Content-Type: application/json' -d '{"id":"5","name":"name5","state":"state5","rooms":"5"}'
curl -k -X POST https://reports11/hotel -H 'Content-Type: application/json' -d '{"id":"5","name":"name5","state":"state5","rooms":"5"}'

curl -k https://avi-ubu/hotel
curl -k https://reports01/hotel
curl -k https://reports11/hotel

curl -k https://avi-ubu/report/trial_balance
curl -k https://reports01/report/trial_balance
curl -k https://reports11/report/trial_balance

# test parameter validation
curl -k -X POST https://avi-ubu/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","start_period":202201,"end_period":202207}'
curl -k -X POST https://reports01/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","start_period":202201,"end_period":202207}'
curl -k -X POST https://reports11/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","start_period":202201,"end_period":202207}'

# test trial balance pipe line
curl -k -X POST https://avi-ubu/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","email":"bgroves@buschegroup.com","start_period":202108,"end_period":202208}'
curl -k -X POST https://reports01/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","email":"bgroves@buschegroup.com","start_period":202108,"end_period":202208}'
curl -k -X POST https://reports11/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","email":"bgroves@buschegroup.com","start_period":202108,"end_period":202208}'


from chrome: 
see the certificate_authority.md for the detail of adding our root certificate to Windows or Ubuntu.
https://avi-ubu/report/trial_balance
https://reports01/report/trial_balance
https://reports11/report/trial_balance

ubuntu test:
curl -X POST http://localhost:5000/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","email":"bgroves@buschegroup.com","start_period":202201,"end_period":202207}'
curl -k -X POST https://avi-ubu/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","email":"bgroves@buschegroup.com","start_period":202108,"end_period":202208}'
curl -k -X POST https://reports11/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","email":"bgroves@buschegroup.com","start_period":202108,"end_period":202208}'
curl -k -X POST https://reports01/report -H 'Content-Type: application/json' -d '{"report_name":"trial_balance","email":"bgroves@buschegroup.com","start_period":202108,"end_period":202208}'

windows test: Must use double-quotes on Windows
curl -k -X POST https://avi-ubu/report -H "Content-Type: application/json" -d "{\"report_name\":\"trial_balance\",\"email\":\"bgroves@buschegroup.com\",\"start_period\":202108,\"end_period\":202208}"

curl -k -X POST https://reports01/report -H "Content-Type: application/json" -d "{\"report_name\":\"trial_balance\",\"email\":\"bgroves@buschegroup.com\",\"start_period\":202108,\"end_period\":202208}"

curl -k -X POST https://reports11/report -H "Content-Type: application/json" -d "{\"report_name\":\"trial_balance\",\"email\":\"bgroves@buschegroup.com\",\"start_period\":202108,\"end_period\":202208}"


