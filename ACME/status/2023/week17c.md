Good morning dear ones,
Father please help me to serve those people you have given me to serve!  Thank you for your favor and blessing of life and the plan that you have for each of us!
I hope you are of good spirits and have the strength to endure whatever hardships come our way this week!  I truely appreciate being part of this team and look forward to spending time with each of you doing what we love :-)  May we grow to care and support one another as we face whatever challenges come our way.

As always please feel free to contact me at home or at work for anything.
- Sincerely yours
Brent 
260-564-4868 

Big Picture:
1. Attempting to create a simple user interface for customers to manage longer running reports such as the Trial Balance using Microsoft Teams tabs. This effort requires that our AKS ingress endpoints have certificates signed by a public CA, "Let's Encrypt" in our case.
2. Give the option to our report customers to encrypt reports containing sensitive data. This requires key pairs for ciphers algorithms such as RSA or ECDSA. In our case we have a nonsycronizing private hockeypuck OpenPGP key server to manage these keys.

Report Ecnryption:
1. Install [GPG](https://www.gpg4win.org/) and decryption scripts on customers laptop.
2. Run genkeypair script from customer's laptop.
3. Send customer's public key certificate to the OpenPGP key server.
4. Customer runs report and checks the "encrypted" box.
5. Customer downloads the encrypted report to their Downloads folder.
6. Customer starts the decryption script from a desktop icon.


OpenPGP key server:
Why did the author of OpenGPG key server switch from MongoDB to PostGreSQL?
This database only has 2 tables but it currently contains over 8 million public keys, 40 GB, that endeavor to ramain syncronized throughout the world. One of it's purposes is to search a JSON column containing a list of email addresses and other DN so the author started with MongoDB which focuses heavily on the JSON data type but was disatisfied with it for some reeson which I believe was the speed of searching this particular column. Many database can do full text searches using the "like" operator which can do searches a few symbols such as "* and ?", but if you have ever used the perl regular expression syntax you may have been disatified with it's ability to search text'.  The Berkley PostgreSQL database on the other hand has the tsvector data type that takes as input a string and converts it to an array of name value pairs that can more quickly searched at the expense of adding another column that would not normally be included in the table.     
[Full Text Searching](https://medium.com/geekculture/comprehend-tsvector-and-tsquery-in-postgres-for-full-text-search-1fd4323409fc)
We now have a [PostGreSQL database server](https://www.postgresql.org/) to manage our RSA cipher keys.  This database is used by our Hockeypuck key server. This database is a Berkeley University project that takes claim to being the most advanced open source database. I don't know about the truthfulness of that claim but it does have many cool features such as:
- database clustering,
- TCP and Unix Socker connections
- support for many driver types including a JSONB driver
Besides having all those features it does a good job in handling the huge, 40 GB, key store available to any private installation of Hockeypuck.


Report Decryption:
- On Ubuntu server running Hockeypuck with a PostgreSQL database that contains all customer key pairs.
- Is a service that monitors each customer cipher directory.
Process:
Customer copies encrypted report that was emailed to them to their decryption folder located on the decryption server.
The decryption service associates the decryption folder with a customer's private key and copies the decrypted file to a designated folder on the customers personal computer. 

