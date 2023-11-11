<https://isitobservable.io/observability/kubernetes/how-to-collect-kubernetes-events>

we can retrieve metrics and logs for observability. One angle that we haven’t discussed yet is Kubernetes events, so that’s what we will get into in this blog post.

Intro to Kubernetes events
Kubernetes generates a lot of events related to the deployments of our workload, the scheduling, and more. This is a rich source of information to understand what is happening in our cluster - i.e., answering questions such as “Why did this particular pod get killed or restarted?”

There are two ways to see the events in your K8s:

kubectl describe pod <podname>
kubectl get events
When something isn’t working in your application, you should first look at its events and infrastructure operations. It’s also useful to keep events for a longer period because they can be useful for post-mortem analysis or to understand if a failure resulted from earlier events.

There are several types of events in Kubernetes because every Kubernetes object goes through several states until it reaches the desired one.

As we explained in the first episode on Kubernetes metrics, the master node and worker node have several core components that allow K8s to orchestrate the workload on our “servers”. The scheduler schedules pods on the node, the control manager detects state changes to reschedule a pod in case of a crash, etcd will store the status of the various K8s resources ( but only for the last hour).

All of those core components can orchestrate our workload based on events. That means that events are important to understanding a given situation.

Let’s look at a quick example:

When you deploy a pod, the scheduler tries to identify the correct node to start the pod. In the meantime, the pod will be in a pending state. Once the scheduler has identified the right node, the pod will be in a creating state.

To start this pod, we will first need to pull the container's image. The node will pull the image from the external docker registry. The scheduler prefers scheduling pods on the node when it already has the image.

Once the image has been pulled, the pod will be in a running state.

If, for some reason, your pod crashes, the control manager will reschedule the pod.

But if the pod has been restarted several times with the same error, the pod will go into the state CrashLoopBackOff.

If your nodes are stuck on pending, it could mean that no resources are available on them, or it’s impossible to find the right node.

Pods usually have health probes or readiness probes to help K8s to determine the state or the health of your pod, i.e., /health or /ready. Kubelet will be the one reaching out to those endpoints.

You can also define an init container with a specific image so that K8s will start and run the other containers.

If you are giving a wrong image in your deployment file or there is a connectivity issue to the docker registry, then the node cannot pull the image, so your Pod will never reach the running state. If you describe you'll see ImagePullBackOff event

Events in the Kubernetes API
All events can be retrieved with the help of the Kubernetes API (with kubectl as well).

We often use “kubectl describe” to collect the status, the reason, and more.

When interacting with the API, you'll collect:

The message

The reason

The type

The object involved in the event

The number of occurence of the event

The source of the event (kubelet or other)

It’s exactly what you can see using kubectl to get events.

What are the various types of Kubernetes events?
Informational events

Pods scheduled, images pulled, node healthy, deployment is updated, replica set is called, the container is killed

Warnings

Pod has errors, persistent volumes are not bound yet

Errors

Node is down, persistent volume is not found, can't create a load balancer in the cloud provider...etc.

You can publish your events directly using the rest API, the API client, or the event recorder.

The most important Kubernetes events
Kubernetes has a very wide range of events, and here are some of the most important ones to consider:

CrashLoopBackOff, which happens when a pod starts, crashes, starts again, and then crashes again

ImagePullBackOff, which happens when the node is unable to retrieve the image

Evicted events, which can happen when a node determines that a pod needs to be evicted or terminated to free up some resources (CPU, memory...etc). When this happens, K8s is supposed to reschedule the pod on another node.

FailedMount / FailedAttachVolume, when pods require a persistent volume or storage, this event prevents them from starting if the storage is not accessible.

FailedSchedulingEvents, when the scheduler is not able to find a node to run your pods.

NodeNotReady, when a node cannot be used to run a pod because of an underlying issue.

Rebooted

HostPort conflict

What solutions are available to retrieve Kubernetes events?
Various solutions can be used to retrieve Kubernetes events. I'll focus on Kspan and Event exporter in this blog post because we will use them in the tutorial. But let’s first mention some of the other available projects before we get into more details.

Eventrouter
As described on the Eventrouter project’s GitHub page: “The event router serves as an active watcher of event resources in the Kubernetes system, which takes those events and pushes them to a user-specified sink. This is useful for several different purposes, but most notably long-term behavioral analysis of your workloads running on your Kubernetes cluster.”

GitHub page: <https://github.com/heptiolabs/>...

Kubewatch
Kubewatch is a K8s event-watching tool that tracks every resource change in a Kubewatch. It supports notifications, and it will be able to publish notifications in Slack, Hipchat, Webhook, Flock, SMTP, etc.

GitHub page: <https://github.com/bitnami-lab>...

Sloop
Sloop monitors Kubernetes, recording histories of events and resource state changes and providing visualizations to aid in debugging past events.

GitHub page: <https://github.com/salesforce/>...

Kubernetes event exporter
The event exporter allows exporting the often missed Kubernetes events to various outputs for observability or alerting purposes.

The event exporter is simple to implement but very powerful.

We deploy a service/pod that will interact with the Kubernetes event API. Once the event has been collected, it utilizes one of the Prometheus clients to count and report the events in a Prometheus format.

In the tutorial, we will utilize the event-exporter together with Dynatrace, although it could also be used with Prometheus and Grafana.

GitHub page: <https://github.com/opsgenie/ku>...

Kspan
Kspan is a project created by Weaveworks, and it turns Kubernetes events into OpenTelemetry Spans, joining them up by causality and grouping them into traces.

Kspan will interact with the Kubernetes API to collect the various events and forward the generated traces to the open telemetry collector.

GitHub page: <https://github.com/weaveworks->...
