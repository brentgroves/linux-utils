# Instio

## Traffic Management

Istio’s traffic routing rules let you easily control the flow of traffic and API calls between services. Istio simplifies configuration of service-level properties like circuit breakers, timeouts, and retries, and makes it easy to set up important tasks like A/B testing, canary rollouts, and staged rollouts with percentage-based traffic splits. It also provides out-of-box failure recovery features that help make your application more robust against failures of dependent services or the network.

Istio’s traffic management model relies on the Envoy proxies that are deployed along with your services. All traffic that your mesh services send and receive (data plane traffic) is proxied through Envoy, making it easy to direct and control traffic around your mesh without making any changes to your services.

Architecture
 3 MINUTE READ  

An Istio service mesh is logically split into a data plane and a control plane.

The data plane is composed of a set of intelligent proxies (Envoy) deployed as sidecars. These proxies mediate and control all network communication between microservices. They also collect and report telemetry on all mesh traffic.

The control plane manages and configures the proxies to route traffic.

The following diagram shows the different components that make up each plane:

**![istio](https://istio.io/v1.7/docs/ops/deployment/architecture/arch.svg)**

Envoy
Istio uses an extended version of the Envoy proxy. Envoy is a high-performance proxy developed in C++ to mediate all inbound and outbound traffic for all services in the service mesh. Envoy proxies are the only Istio components that interact with data plane traffic.

Envoy proxies are deployed as sidecars to services, logically augmenting the services with Envoy’s many built-in features, for example:

Dynamic service discovery
Load balancing
TLS termination
HTTP/2 and gRPC proxies
Circuit breakers
Health checks
Staged rollouts with %-based traffic split
Fault injection
Rich metrics

## Kubernetes Native Sidecars in Istio

Demoing the new SidecarContainers feature with Istio.
**[Native Sidecars](https://istio.io/latest/blog/2023/native-sidecars/)**

A formal proposal for adding sidecar support in Kubernetes was raised in 2019. With many stops and starts along the way, and after a reboot of the project last year, formal support for sidecars is being released to Alpha in Kubernetes 1.28. Istio has implemented support for this feature, and in this post you can learn how to take advantage of it.

