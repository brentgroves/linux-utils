https://www.howtogeek.com/devops/how-to-convert-xml-to-json-on-the-command-line/
For Linux using custom installer:

curl -sSL https://bit.ly/install-xq | sudo bash
For Ubuntu 22.10 or higher via package manager:
apt-get install xq

Use the xq Utility
You’ll want to use a custom made utility for this, rather than trying to parse it with something like regex, which is a bad idea. There’s a utility called xq that is perfect for this task. It’s installed alongside yq, which works for YAML. You can install yq from pip:

sudo snap install yq
Under the hood, this utility uses jq to handle working with JSON, so you’ll need to download the binary, and move it to somewhere on your PATH (/usr/local/bin/ should work fine).

Now, you’ll be able to parse XML input by piping it into xq:

cat result.xml | xq .
https://blog.lazy-evaluation.net/posts/linux/jq-xq-yq.html