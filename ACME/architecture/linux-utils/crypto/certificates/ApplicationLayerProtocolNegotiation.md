https://httpwg.org/wg-materials/ietf88/ALPN.pdf

Application-Layer Protocol Negotiation is a Transport Layer Security extension that allows the application layer to negotiate which protocol should be performed over a secure connection in a manner that avoids additional round trips and which is independent of the application-layer protocols.

HTTPBis WG requested TLS support for
negotiating application layer protocols such as
HTTP 1.1 and HTTP 2.0.
Design goals:
• Negotiate application layer protocol for the
connection.
• Minimize connection latency.
• Align with existing TLS extensions.