https://mayastor.gitbook.io/introduction/
What is Mayastor?
Mayastor is a performance optimised "Container Attached Storage" (CAS) solution of the CNCF project . The goal of OpenEBS is to extend Kubernetes with a declarative data plane, providing flexible persistent storage for stateful applications.
Design goals for Mayastor include:
Highly available, durable persistence of data
To be readily deployable and easily managed by autonomous SRE or development teams
To be a low-overhead abstraction for NVMe-based storage devices

NVMe-based storage devices:
https://www.kingston.com/en/community/articledetail/articleid/57715

What is NVMe Storage? NVMe Storage Explained
Non-Volatile Memory Express (NVMe) is a new transfer protocol designed for solid-state memory. While SATA (Serial Advanced Technology Attachment) remains the industry standard for storage protocols, it wasn't built specifically for Flash storage like SSDs and can't offer the same advantages of NVMe. Eventually, SSDs with NVMe will replace SATA SSDs as the new industry standard.

One easy way of comparing NVMe and SATA is to think of them as race tracks since they are the path used to get data from the SSD to the CPU. A SSD is the Formula One race car of storage while spinning drives are more like an old family sedan. The SSD can only go as fast as the road it's riding on. If you put a Formula One car on a race track (NVMe) it's going to travel at it's full potential, but if you drive it on an old dirt road full of rocks (SATA) it needs to slow down.

Kingston NVMe SSDs
Kingston offers multiple SSDs that utilize the NVMe protocols. To see the latest offerings we have, check out the related productions section below. While NVMe SSDs are significantly faster than SATA SSDs, there are still differences between them. Some might support entry-level NVMe speeds while others might support the latest PCIe Gen4 standards for incredible performance available on the latest CPUs.

START HERE
https://mayastor.gitbook.io/introduction/quickstart/preparing-the-cluster