<https://openebs.io/docs/concepts/ndm>
<https://www.tecmint.com/exploring-proc-file-system-in-linux/>

Node Disk Manager(NDM) is an important component in the OpenEBS architecture. NDM treats block devices as resources that need to be monitored and managed just like other resources such as CPU, Memory and Network. It is a daemonset which runs on each node, detects attached block devices based on the filters and loads them as block devices custom resource into Kubernetes. These custom resources are aimed towards helping hyper-converged Storage Operators by providing abilities like:

Easy to access inventory of Block Devices available across the Kubernetes Cluster.
Predict failures on the Disks to help with taking preventive actions.
Allow dynamically attaching/detaching disks to a storage pod, without restarting the corresponding NDM pod running on the Node where the disk is attached/detached.

NDM is deployed as a daemonset during installation of OpenEBS. NDM daemonset discovers the disks on each node and creates a custom resource called Block Device or BD.

NDM daemon runs in containers and has to access the underlying storage devices and run in Privileged mode. NDM requires privileged mode because it requires access to /dev, /proc and /sys directories for monitoring the attached devices and also to fetch the details of the attached device using various probes. NDM is responsible for the discovery of block devices and filtering out devices that should not be used by OpenEBS; for example, detecting the disk that has OS filesystem. NDM pod by default mounts the /proc directory of the host inside the container and then load the /proc/1/mounts file to find the disk used by OS.

To allow OpenEBS to run in privileged mode in selinux=on nodes, the cluster should be configured to grant privileged access to OpenEBS service account.
