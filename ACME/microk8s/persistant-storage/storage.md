k8s Storage
It is an exciting time for storage and OpenEBS which is the biggest feature contributer. Many of the features are not yet stable but are available to try. So I have been examining the ones put out by OpenEBS and using the MicroK8s forum to get educated and contribute the results I'm seeing.
My goal is to be able to still have working database servers if one crashes and to have a good backup/recovery scheme set up.
https://openebs.io/docs/user-guides/localpv-device#backup-and-restore

The storage I'm testing in the k8s reporting cluster is:
openebs-hostpath: This is pretty cool in that you can delete the pod that has claimed it and when the cluster recreates the pod the storage is reattached seamlessly.
openebs-jiva: better suited for storage that is replicated across nodes than local hostpath storage.  
openebs-cstor: the next step up from jiva.
openebs-mayastor: the latest and greatest feature-rich storage option from OpenEBS.

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