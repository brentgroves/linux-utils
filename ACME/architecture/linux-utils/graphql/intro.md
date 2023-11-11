## Graph API

**[GraphQL](https://en.wikipedia.org/wiki/GraphQL)**
"
GraphQL is an open-source data query and manipulation language for APIs and a query runtime engine. GraphQL enables declarative data fetching where a client can specify exactly what data it needs from an API.
History
Facebook started GraphQL development in 2012 and released it as open source in 2015.[3] In 2018, GraphQL was moved to the newly established GraphQL Foundation, hosted by the non-profit Linux Foundation.[4][5]

On 9 February 2018, the GraphQL Schema Definition Language (SDL) became part of the specification.[6]

Many popular public APIs adopted GraphQL as the default way to access them. These include public APIs of Facebook, Github, Yelp, Shopify and Google Directions API.[7]

Design
GraphQL supports reading, writing (mutating), and subscribing to changes to data (realtime updates – commonly implemented using WebSockets).[8] A GraphQL service is created by defining types with fields, then providing functions to resolve the data for each field. The types and fields make up what is known as the schema definition. The functions that retrieve and map the data are called resolvers.[9]

After being validated against the schema, a GraphQL query is executed by the server. The server returns a result that mirrors the shape of the original query, typically as JSON.[10]
