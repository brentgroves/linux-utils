https://www.xml.com/pub/a/2006/05/31/converting-between-xml-and-json.html
More and more web service providers seem to be interested in offering JSON APIs beneath their XML APIs. One considerable advantage of using a JSON API is its ability to provide cross-domain requests while bypassing the restrictive same domain policy of the XmlHttpRequest object. On the client-side, JSON comes with a native language-compliant data structure, with which it performs much better than corresponding DOM calls required for XML processing. Finally, transforming JSON structures to presentational data can be easily achieved with tools such as JSONT.

So if you're working in this space, you probably need to convert an existing XML document to a JSON structure while preserving the following:

structure
order
information
In an ideal world, the resulting JSON structure can be converted back to its original XML document easily. Thus it seems worthwhile to discuss some common patterns as the foundation of a potentially bidirectional conversion process between XML and JSON. A similar discussion can be found at BadgerFish and Yahoo-- without the reversibility aspect though.

A Pragmatic Approach
A single structured XML element might come in seven flavors:

an empty element
an element with pure text content
an empty element with attributes
an element with pure text content and attributes
an element containing elements with different names
an element containing elements with identical names
an element containing elements and contiguous text
The following table shows the corresponding conversion patterns between XML and JSON.

Pattern	XML	JSON	Access
1	<e/>	"e": null	o.e
2	<e>text</e>	"e": "text"	o.e
3	<e name="value" />	"e":{"@name": "value"}	o.e["@name"]
4	<e name="value">text</e>	"e": { "@name": "value", "#text": "text" }	o.e["@name"] o.e["#text"]
5	<e> <a>text</a> <b>text</b> </e>	"e": { "a": "text", "b": "text" }	o.e.a o.e.b
6	<e> <a>text</a> <a>text</a> </e>	"e": { "a": ["text", "text"] }	o.e.a[0] o.e.a[1]
7	<e> text <a>text</a> </e>	"e": { "#text": "text", "a": "text" }	o.e["#text"] o.e.a
Please note that all patterns are considered to describe structured elements, despite the fact that the element of pattern 7 is commonly understood as a semistructured element. A pragmatic approach to convert an XML document to a JSON structure and vice versa can be based on the seven patterns above. It always assumes a normalized XML document for input and doesn't take into consideration the following:

XML declaration
processing instructions
explicit handling of namespace declarations
XML comments
Preserving order
JSON is built on two internal structures:

A collection of name/value pairs with unique names (associative array)
An ordered list of values (array)
An attempt to map a structured XML element...

<e>

  <a>some</a>

  <b>textual</b>

  <a>content</a>

</e>
