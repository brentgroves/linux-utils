# week42

Good morning dear ones,
My our hearts not be as gloomy as the weather of late! I hope you are doing well my friends :-) As always please feel free to contact me for anything at work or at home.

-Sincerely yours
Brent
260-564-4868

## Problems with the report system

Like Azure Automation the 1st report system ran the ETL pipeline to create the report result set at scheduled times.
But the customer wants to be able to run the TB right after he updates some accounts in Plex.
He wants to use the report to see his changes instantly.

To fix this we insert a record into a request database table using a web app.
Then the report runner makes sure these requests get processed right away.
We run the ETL pipeline for each request one at a time.
We store the result set in JSON compatible database and associate it with an id, requestor, report name, time or request, etc.
We also create an excel spreadsheet and send it to the costomer immediately.
We can access the report result set and run comparison reports from the JSON database.

## Web app problem

We need a way for the web app to request what it needs from an HTTP API server's micro-services.
Old Plex uses SOAP web services
SOAP web services are requested through HTTP by sending an XML document.
The XML document contains all the info the server needs to know what the user agent wants.
XML is not simple but you can make it declare anything you want.
XML was changed to JSON and a routing path such as busche-cnc.com/cats/1 and an HTTP verb such as GET or PUT.
This is called a REST API but soon there were so many functions in these web services it became hard to manage.
Now there is a query language that gets sent in the body of an HTTP request.
This query language is like a simple version of SQL.
So now the HTTP API or graph server can look at the query and route the request to the correct micro-service.

## Problem with REST API

**[Why Graph API](https://zapier.com/engineering/graph-apis/)**
"In a REST API the data was likely organized around resources, responses included ids to related objects, and HTTP verbs were used to communicate reading, writing, and updating

REST, however, has its problems. A client might get stuck in a pattern of data over-fetching, requesting an entire resource to just get one or two pieces of information. Or the client may regularly need several objects at once, but can’t fetch it all in one request, known as data under-fetching. In terms of maintenance, changes to a REST API can mean clients need to update their integrations to follow the new API structure or response schemas.

To attempt to solve these issues, a new design has gained ground the last few years: Graph APIs.

What is a Graph API?
A simplistic definition of a Graph API is an API that models the data in terms of nodes and edges (objects and relationships) and allows the client to interact with multiple nodes in a single request. For example, imagine a server holds data on authors, blog posts, and comments. In a REST API, to get the author and comments for a particular blog post, the client might make three HTTP requests like /posts/123, /authors/455, /posts/123/comments.

In a graph API, the client formulates the call so data from all three resources is pulled in at once. The client is also able to specify the fields it cares about, giving more control over the response schema.

A good example of a **[graph API](https://developers.facebook.com/docs/graph-api/overview/?utm_source=zapier.com&utm_medium=referral&utm_campaign=zapier)**

The Graph API is named after the idea of a "social graph" — a representation of the information on Facebook. It's composed of nodes, edges, and fields. Typically you use nodes to get data about a specific object, use edges to get collections of objects on a single object, and use fields to get data about a single object or each object in a collection. Throughout our documentation, we may refer to both a node and edge as an "endpoint". For example, "send a GET request to the User endpoint".

"

## Facebook Graph API

Nodes
A node is an individual object with a unique ID. For example, there are many User node objects, each with a unique ID representing a person on Facebook. Pages, Groups, Posts, Photos, and Comments are just some of the nodes of the Facebook Social Graph.

The following cURL example represents a call to the User node.

```bash
curl -i -X GET \
  "https://graph.facebook.com/USER-ID?access_token=ACCESS-TOKEN"
This request would return the following data by default, formatted using JSON:

{
  "name": "Your Name",
  "id": "YOUR-USER-ID"
}

Node Metadata
You can get a list of all fields, including the field name, description, and data type, of a node object, such as a User, Page, or Photo. Send a GET request to an object ID and include the metadata=1 parameter:

curl -i -X GET \
  "https://graph.facebook.com/USER-ID?
    metadata=1&access_token=ACCESS-TOKEN"
The resulting JSON response will include the metadata property that lists all the supported fields for the given node:

{
  "name": "Jane Smith",
  "metadata": {
    "fields": [
      {
        "name": "id",
        "description": "The app user's App-Scoped User ID. This ID is unique to the app and cannot be used by other apps.",
        "type": "numeric string"
      },
      {
        "name": "age_range",
        "description": "The age segment for this person expressed as a minimum and maximum age. For example, more than 18, less than 21.",
        "type": "agerange"
      },
      {
        "name": "birthday",
        "description": "The person's birthday.  This is a fixed format string, like `MM/DD/YYYY`.  However, people can control who can see the year they were born separately from the month and day so this string can be only the year (YYYY) or the month + day (MM/DD)",
        "type": "string"
      },
...

Edges
An edge is a connection between two nodes. For example, a User node can have photos connected to it, and a Photo node can have comments connected to it. The following cURL example will return a list of photos a person has published to Facebook.

curl -i -X GET \
  "https://graph.facebook.com/USER-ID/photos?access_token=ACCESS-TOKEN"
Each ID returned represents a Photo node and when it was uploaded to Facebook.

    {
  "data": [
    {
      "created_time": "2017-06-06T18:04:10+0000",
      "id": "1353272134728652"
    },
    {
      "created_time": "2017-06-06T18:01:13+0000",
      "id": "1353269908062208"
    }
  ],
}
Fields
Fields are node properties. When you query a node, or an edge, it returns a set of fields by default, as the examples above show. However, you can specify which fields you want returned by using the fields parameter and listing each field. This overrides the defaults and returns only the fields you specify, and the ID of the object, which is always returned.

The following cURL request includes the fields parameter and the User's name, email, and profile picture.

curl -i -X GET \
  "https://graph.facebook.com/USER-ID?fields=id,name,email,picture&access_token=ACCESS-TOKEN"
Data Returned
{
  "id": "USER-ID",
  "name": "EXAMPLE NAME",
  "email": "EXAMPLE@EMAIL.COM",
  "picture": {
    "data": {
      "height": 50,
      "is_silhouette": false,
      "url": "URL-FOR-USER-PROFILE-PICTURE",
      "width": 50
    }
  }
}
```


## GraphQL

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

## GraphQL IDE

We can use Curl, Postman, Insomnia, etc. to test our Graph API or we can use the official GraphQL IDE.
**[GrqphQL IDE](https://github.com/graphql/graphiql)**
**![GrqphQL IDE](https://github.com/graphql/graphiql/blob/main/packages/graphiql/resources/graphiql.png)**


**[Graph Theory](https://en.wikipedia.org/wiki/Graph_theory)**
**![Graph](https://en.wikipedia.org/wiki/File:GraphQL_Logo.svg)**

In mathematics, graph theory is the study of graphs, which are mathematical structures used to model pairwise relations between objects. A graph in this context is made up of vertices which are connected by edges.

**[Graphs in CS](http://web.cecs.pdx.edu/~sheard/course/Cs163/Doc/Graphs.html)**
Algorithms on Graphs
There are many, many algorithms on graphs. In this note we will look at a few of them. They include:

**[Graph Search Algorithms](https://neo4j.com/developer/graph-data-science/graph-search-algorithms/#overview-graph-search-algorithms)**
Searching Graphs
Detecting Cycles in Graphs
Shortest Path algorithms

Graph search (or graph traversal) algorithms explore a graph for general discovery or explicit search. They will try to visit as much of the graph as they can reach, but there is no expectation that the paths they explore are computationally optimal. Graph search algorithms are usually used as a core component of other algorithms.
"

- While setting up the report system's MySQL deployment I found out about K8s operators and a new concept to me Observability.
- So instead of just monitoring data and storing it into a metrics database for consumption by reporting software such as Grafina we can use K8s operators
to react to problem condition found in K8s monitoring instead of just reporting them in some graph.
- Researching observability I came across the Nest.js micro-service framework and saw it is the most active and widely used framework.
- In the researching of Nest.js I found it supports both the graph query language and observability.
- But like the Feathers REST server it's developers kept saying how great Typescript is.
- IMO this Typescript language is thought to be so great is that it solves the problems inherit with OOP just like Java, C##, etc.
- It was found that objects depend upon one other to do anything useful.
- But if one object instantiates another object that it depends on that leads to code that is hard to test and hard to change.
- So dependancy injection and inversion of control was made to resolve this issues.
- And guess what these features are not found in Javascript, ECMA script, so you use Typescript which compiles down into one of the ECMA script versions.

