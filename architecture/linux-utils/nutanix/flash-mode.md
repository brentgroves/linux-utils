https://portal.nutanix.com/page/documents/details?targetId=Web-Console-Guide-Prism-v6_5:wc-vm-flash-mode-c.html

Flash mode for VM allows you to set the storage tier preference to SSD for a virtual machine or volume group. Flash mode is not enabled by default for all database deployments. But, flash mode allows latency sensitive workloads to remain on the SSD tier and avoid any potential performance impact of down migration of data.

By default, you can use up to 25% of the cluster-wide SSD tier as flash mode space for VMs or VGs. If the data size for flash mode enabled VMs or VGs exceeds 25% of the SSD capacity, the system may down migrate the data. Before performing down-migration, the flash mode feature tries to preserve the excess data on the SSD tier for some reasonable amount of time so that you can take corrective actions on the cluster and bring back to stable state. To reduce flash mode usage, you can disable flash mode on some VMs or VGs or add SSDs.
