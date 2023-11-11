https://www.xml.com/pub/a/2006/05/31/converting-between-xml-and-json.html
https://www.howtogeek.com/devops/how-to-convert-xml-to-json-on-the-command-line/
https://github.com/kislyuk/yq

Use the xq Utility
You’ll want to use a custom made utility for this, rather than trying to parse it with something like regex, which is a bad idea. There’s a utility called xq that is perfect for this task. It’s installed alongside yq, which works for YAML. You can install yq from pip:

curl -sSL https://bit.ly/install-xq | sudo bash
For Ubuntu 22.10 or higher via package manager:
sudo apt-get install xq

pip install yq
Under the hood, this utility uses jq to handle working with JSON, so you’ll need to download the binary, and move it to somewhere on your PATH (/usr/local/bin/ should work fine).

Usage
Format an XML file and highlight the syntax:

xq test/data/xml/unformatted.xml
xq also accepts input through stdin:

curl -s https://www.w3schools.com/xml/note.xml | xq
HTML content can be formatted and highlighted as well (using -m flag):

xq -m test/data/html/formatted.html
It is possible to extract the content using XPath query language. -x parameter accepts XPath expression.

Extract the text content of all nodes with city name:

cat note.xml | xq -x //note
Extract the value of attribute named status and belonging to user:
cat note.xml | xq -x /note/to
cat result.xml | xq -x /soap:Envelope/@xmlns:soap

cat result.xml | xq -x /soap:Envelope/soap:Body/ExecuteDataSourceResponse/ExecuteDataSourceResult/ResultSets/ResultSet/RowCount

cat result.xml | xq -x /soap:Envelope/soap:Body/ExecuteDataSourceResponse/ExecuteDataSourceResult/ResultSets/ResultSet/Rows/Row[0]

cat test/data/xml/unformatted.xml | xq -x /user/@status
See https://en.wikipedia.org/wiki/XPath for details.

It is possible to use CSS selector to extract the content as well:

cat test/data/html/unformatted.html | xq -q "body > p"