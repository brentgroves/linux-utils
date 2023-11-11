## What is XHR?
**[XMLHttpRequest](https://www.quora.com/What-is-XHR-XMLHttpRequest-and-how-does-this-work)**
XHR (XMLHttpRequest) is an API in the web browser that allows communication between the client (i.e. the web browser) and the server without reloading the entire page. XHR enables the creation of dynamic, fast and efficient web applications, by allowing partial updates of the page, based on the data received from the server.

Here's how XHR works:

Creation: An XHR object is created using the XMLHttpRequest() constructor in JavaScript.
Configuration: The XHR object is configured with the desired HTTP method (such as GET or POST), the URL to send the request to, and the asynchronous status of the request.
Sending: The XHR object is then sent to the server using the send() method, along with any data to be sent in the request body.
Receiving: The XHR object listens for changes in its readyState property, which indicates the state of the request/response cycle. Once the readyState changes to 4 and the status is 200, the request is considered successful and the response is available in the responseText or responseXML property of the XHR object.
Processing: The response from the server is processed by the client-side JavaScript, which can update the page dynamically based on the data received.
This is a very basic overview of XHR, but it gives you an idea of how it operates. XHR has largely been replaced by more modern APIs like the Fetch API, which provides a more straightforward and efficient way to make network requests.