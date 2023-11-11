https://graphql.org/

A query language for your API
GraphQL is a query language for APIs and a runtime for fulfilling those queries with your existing data. GraphQL provides a complete and understandable description of the data in your API, gives clients the power to ask for exactly what they need and nothing more, makes it easier to evolve APIs over time, and enables powerful developer tools.

Get many resources
in a single request
GraphQL queries access not just the properties of one resource but also smoothly follow references between them. While typical REST APIs require loading from multiple URLs, GraphQL APIs get all the data your app needs in a single request. Apps using GraphQL can be quick even on slow mobile network connections.

Describe what’s possible
with a type system
GraphQL APIs are organized in terms of types and fields, not endpoints. Access the full capabilities of your data from a single endpoint. GraphQL uses types to ensure Apps only ask for what’s possible and provide clear and helpful errors. Apps can use types to avoid writing manual parsing code.

Bring your own
data and code
GraphQL creates a uniform API across your entire application without being limited by a specific storage engine. Write GraphQL APIs that leverage your existing data and code with GraphQL engines available in many languages. You provide functions for each field in the type system, and GraphQL calls them with optimal concurrency.

https://graphql.org/learn/


GraphQL is a query language for your API, and a server-side runtime for executing queries using a type system you define for your data. GraphQL isn't tied to any specific database or storage engine and is instead backed by your existing code and data.

A GraphQL service is created by defining types and fields on those types, then providing functions for each field on each type. For example, a GraphQL service that tells you who the logged in user is (me) as well as that user's name might look like this:

type Query {
  me: User
}

type User {
  id: ID
  name: String
}
Along with functions for each field on each type:

function Query_me(request) {
  return request.auth.user
}

function User_name(user) {
  return user.getName()
}
After a GraphQL service is running (typically at a URL on a web service), it can receive GraphQL queries to validate and execute. The service first checks a query to ensure it only refers to the types and fields defined, and then runs the provided functions to produce a result.

For example, the query:

{
  me {
    name
  }
}
Could produce the following JSON result:

{
  "me": {
    "name": "Luke Skywalker"
  }
}

Arguments
If the only thing we could do was traverse objects and their fields, GraphQL would already be a very useful language for data fetching. But when you add the ability to pass arguments to fields, things get much more interesting.

{
  human(id: "1000") {
    name
    height
  }
}
{
  "data": {
    "human": {
      "name": "Luke Skywalker",
      "height": 1.72
    }
  }
}
In a system like REST, you can only pass a single set of arguments - the query parameters and URL segments in your request. But in GraphQL, every field and nested object can get its own set of arguments, making GraphQL a complete replacement for making multiple API fetches. You can even pass arguments into scalar fields, to implement data transformations once on the server, instead of on every client separately.

{
  human(id: "1000") {
    name
    height(unit: FOOT)
  }
}
{
  "data": {
    "human": {
      "name": "Luke Skywalker",
      "height": 5.6430448
    }
  }
}