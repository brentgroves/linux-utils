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

Complex Parameters
Most parameter types are straightforward primitives such as bool, string and int, but there are also list and object types that can be specified in the request.

The list type is specified in JSON syntax, for example: ["firstitem", "seconditem", "thirditem"]

The object type is also specified in JSON syntax, for example: {"firstkey": "firstvalue", "secondKey": 123}

Publishing, Updating, and Deleting
Visit our Facebook Sharing guide to learn how to publish to a User's Facebook or our Pages API documentation to publish to a Page's Facebook feed.

Some nodes allow you to update fields with POST operations. For example, you could update your email field like this:

curl -i -X POST \
  "https://graph.facebook.com/USER-ID?email=YOURNEW@EMAILADDRESS.COM&access_token=ACCESS-TOKEN"
Read-After-Write
For create and update endpoints, the Graph API can immediately read a successfully published or updated object and return any fields supported by the corresponding read endpoint.

By default, an ID of the object created or updated will be returned. To include more information in the response, include the fields parameter in your request and list the fields you want returned. For example, to publish the message “Hello” to a Page's feed, you could make the following request:

curl -i - X POST "https://graph.facebook.com/PAGE-ID/feed?message=Hello&
  fields=created_time,from,id,message&access_token=ACCESS-TOKEN"
The above code example is formatted for readability.
This would return the specified fields as a JSON-formatted response, like this:

{
  "created_time": "2017-04-06T22:04:21+0000",
  "from": {
    "name": "My Facebook Page",
    "id": "PAGE-ID"
  },
  "id": "POST_ID",
  "message": "Hello",
}
Refer to each endpoint's reference documentation to see if it supports read-after-write and what fields are available.

Webhooks
You can be notified of changes to nodes or interactions with nodes by subscribing to webhooks. See Webhooks.

Versions
The Graph API has multiple versions with quarterly releases. You can specify the version in your calls by adding "v" and the version number to the start of the request path. For example, here's a call to version 4.0:

curl -i -X GET \
  "https://graph.facebook.com/v4.0/USER-ID/photos
    ?access_token=ACCESS-TOKEN"
If you do not include a version number we will default to the oldest available version, so it's recommended to include the version number in your requests.

You can read more about versions in our Versioning guide and learn about all available versions in the Graph API Changelog.

Facebook APIs, SDKs, and Platforms
Connect interfaces and develop across platforms using Facebook's various APIs, SDKs, and platforms.
```
