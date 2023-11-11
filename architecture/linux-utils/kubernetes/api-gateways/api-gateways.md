API gateways
https://benbrougher.tech/posts/microk8s-ingress/
You might ask, however: “What about service load balancers and API gateways?” Historically, API gateways are used (such as Ocelot, or Kong) to consolidate individual APIs into a single interface that our frontend can talk to. Ingress’ provide a way to define in a semi-vendor neutral way, how traffic should flow. You can specify host names, and within those hosts you can specify sub routes and have the Ingress route traffic to different services via the same host name. For example, you may have:

