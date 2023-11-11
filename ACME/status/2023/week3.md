Please help us Father to follow you and your plan for us today.
Thank you Father for taking such good care of your children!


**Enhanced Reporting System (ERS)**  
Why so much time on the ERS?  In my opinion this can differentiate Mobex Global from other companies that use Plex and Intelliplex for reporting.

- Giving us the ability to make advanced long running reports compared to Intelliplex which times out when asked to run time consuming procedures.
- Data analysis becomes possible since we have our own data warehouse to store intermediate results.
- Allows us to work with live data which can be easily compared to data shown on Plex screens giving our customers more confidence in our reporting.  

Why so much time on storage?  Speed and reliability.  
- Using newer k8s storage technologies we can take advantage of hardware advances such as NVMe (nonvolatile memory express).
- Redundant databases in case of a node failure
- Take advantage k8s backup/restore and disaster recovery software such as Velero.   

k8s Storage
- ver 1: to use manually created local or nfs storage mounted on each node. It works can use mysqldump or mongodump utils.
- ver 2: to use openebs-hostpath which gives us a few more benefits such as dynamic volume claims. It works but not ready for prod.
- ver 3: to use openebs-jiva which gives us more benefits still in a multi-node k8s cluster. I have questions concerning getting this to work on our VMWare vSphere posted to the following forums: https://github.com/openebs/openebs/discussions/3603
https://discuss.kubernetes.io/t/how-can-i-get-openebs-jiva-working-in-a-multi-node-microk8s-cluster-using-the-openebs-community-add-on/22696
https://stackoverflow.com/questions/75121047/how-can-i-get-openebs-jiva-working-in-a-multi-node-microk8s-cluster-using-the-op

Report Request Process:
- The web app to have 1 component for one time report requests and another component for cron scheduled requests.
- No matter which request type is used the first step of the process is to generate a report id, email, and output format, ie pdf or excel, in mongo.
- When the report request is submitted to the report queue it will contain the report id as the needed parameters.
- When the report runner initiates the report pipeline it will pass the report id and other parameters to the report pipeline script.
- The pipeline will insert the report result set in the mongo report object associated with the report id generated at the start of the process.
- If the user is logged into the web app they will be notified of the report completion.
- The mongo report object is never deleted so the customer can view their report history and submit a request to resend the report pdf and/or excel.

Misc k8s storage:
Allows applications to dynamically claim various classes of persistent storage specifying protocol, size, and replication.
csi driver: container storage interface
allows any storage system to be used by containers.
mayastor: ambitious open source container storage that runs inside of k8s cluster. 
https://openebs.io/docs/concepts/cstor
https://mayastor.gitbook.io/introduction/quickstart/faqs
syncronous replication of data over every node in k8s cluster.
TCP congestion:
Why is file transfers slow sometimes?  Can we speed it up? 
Does Mayastor suffer from TCP congestion when using NVME-TCP?
Mayastor, as any other solution leveraging TCP for network transport, may suffer from network congestion as TCP will try to slow down transfer speeds. It is important to keep an eye on networking and fine-tune TCP/IP stack as appropriate. This tuning can include (but is not limited to) send and receive buffers, MSS, congestion control algorithms (e.g. you may try DCTCP) etc.

linstor: block storage management for containers
https://linbit.com/linstor/
like an nfs server the software is running outside of the k8s cluster in a cluster of it's own.
nvme: NVMe is a high-speed access protocol that delivers low latency and high throughput for SSD storage devices by connecting them to the processor.
https://blog.mayadata.io/why-use-localpv-with-nvme-for-your-workload

SMB3: windows file sharing protocol
https://learn.microsoft.com/en-us/windows-server/storage/file-server/file-server-smb-overview
The Server Message Block (SMB) protocol is a network file sharing protocol that allows applications on a computer to read and write to files and to request services from server programs in a computer network. The SMB protocol can be used on top of its TCP/IP protocol or other network protocols. Using the SMB protocol, an application (or the user of an application) can access files or other resources at a remote server. This allows applications to read, create, and update files on the remote server. SMB can also communicate with any server program that is set up to receive an SMB client request. SMB is a fabric protocol that is used by Software-defined Data Center (SDDC) computing technologies, such as Storage Spaces Direct, Storage Replica. 