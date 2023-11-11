Snaps are a secure and scalable way to embed applications on Linux devices. A snap is an application containerised with all its dependencies. A snap can be installed using a single command on any device running Linux. With snaps, software updates are automatic and resilient. Applications run fully isolated in their own sandbox, thus minimising security risks.

Snaps are hosted in the global Snap Store, an application repository hosted and managed by Canonical, and are free for anyone to download. Snaps can be created by anyone - existing software can be packaged as a snap or new software can be built from scratch using snap packaging. There is also an active, vibrant community of developers and users, with a forum where anyone can ask questions.

https://ubuntu.com/core/services/guide/snaps-intro


149

You might find Mark Shuttleworth's talk "Why we need a different container purely for apps" at Container Camp relevant to your question. He talks generally about VMs, containers and Docker at the start, continuing on to snaps and how they fit in about nine minutes in. Here's my summary:

    Different types of containers look the same but are used for different purposes.
    Containers don't really exist at the kernel level. Different sorts of illusions are possible. Independently we can create illusions about what users, network, disk and processes a container sees.
    Different types of containers are really about different classes of the illusions that are created.
    Snaps are:
        Immutable, but still part of the base system.
        Integrated in terms of network, so share the system IP address, unlike Docker, where each container gets its own IP address.
        In other words, Docker gives us a thing there. Snaps gives us a thing here. For example, on a desktop, a snap provides an app right on it.
        A snap can't pollute the rest of the system. It's in its own box. But it can still see (read-only) the rest of the system, which allows it to talk and integrate with the system.

You asked about different use cases compared to Docker. Here's one that snaps can do, but Docker cannot: desktop apps. Third parties can ship desktop apps using snaps, and users can easily install and update them. A Docker container can't (easily) interact with the user graphically on the screen, load documents from the user's home directory, or provide video conferencing via the user's webcam. Snaps can (once given permission).

You might ask how this is better than using PPAs. But in comparison to Docker, that's like asking how Docker is better than installing dependencies on a system by hand. It's better, but exactly how would probably be best answered in a separate, non-Docker-specific question.
