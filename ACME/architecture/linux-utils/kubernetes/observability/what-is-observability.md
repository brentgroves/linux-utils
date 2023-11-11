# What is observability

**[What is observability](https://grafana.com/docs/grafana-cloud/introduction/what-is-observability/)

What is observability?
Observability is the process of making a system’s internal state more transparent. Systems are made observable by the data they produce, which in turn helps you to determine if your infrastructure or application is healthy and functioning normally.

Observability is made up of the following Three Pillars, and Grafana Cloud enables all of them:

Logs: timestamped records of events that happened over time; for example event or error log files
Metrics: numeric representations of data measured over time; such as the number of user logins, or the temperature of a device
Traces: a representation of a chain of related events moving through a system; such as (a) credit card payment made, (b) customer order recorded, and (c) shipping order created.
Observability is powerful because it enables system operators, DevOps practitioners, and Site Reliability Engineers to ask questions about that information. Ultimately we want transparent systems that are easier for operators to understand and maintain. This transparency helps resolve issues more quickly, and make bugs more shallow and easy to spot.

Observability is often talked about together with infrastructure monitoring or application performance monitoring (APM), and while the two are related, they are not the same. Monitoring involves collecting and analyzing data on a system’s performance and behavior, using this information to identify issues and diagnose problems, and then evaluating the data against established standards to determine if the system is functioning as expected. As an example, the more archaic IT Operations monitoring was focused on checks and statuses of a small number of things. In contrast, with the more modern cloud architecture, systems are so complex that the number of metrics increases dramatically and it becomes more of a data analytics challenge. Observability is a more holistic approach to understanding and managing these complex systems. It involves not only collecting data on the system’s behavior, but also creating a deep understanding of the system’s internal workings and how they interact with each other. This can involve instrumenting the system to collect data at various levels, and using techniques such as distributed tracing and log analysis to gain insight into the system’s behavior.

The key difference between monitoring and observability is that monitoring focuses on collecting data, while observability focuses on understanding and interpreting that data in order to gain a deeper understanding of the system’s behavior and performance. Observability is therefore a more proactive and holistic approach to managing complex systems, as it enables teams to identify and address issues before they become serious problems.
