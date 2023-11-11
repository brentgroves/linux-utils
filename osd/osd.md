# Object based storage device

## Reference

<https://medium.com/@kamal.maiti/object-based-storage-architecture-b841e5842124>

## What is OSD

Overview
It is fascinating to observe how computing and storage have been separated in recent years to support massive scale at both levels. In terms of storage, the industry has relied on file and block-based storage for a long time. However, managing metadata such as inode or other attributes, or journal information, can be a burden for the compute node that manages the file system.

To alleviate this burden, a new way of storing files on disk has emerged rapidly in recent years: object-based storage. By using an “object ID,” specific files can be tracked, retrieved, and deleted. Essentially, some metadata has been reduced and is maintained by a separate compute node called a “metadata server.”
