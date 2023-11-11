
https://catonmat.net/cookbooks/curl/make-post-request
Send a POST Request with Data from a File
curl -d '@data.txt' https://google.com/login
This recipe loads POST data from a file called data.txt. Notice the extra @ symbol before the filename. That's how you tell curl that data.txt is a file and not just a string that should go in the POST body.

POST a Binary File
curl -F 'file=@photo.png' https://google.com/profile
This recipe uses the -F argument that forces curl to make a multipart form data POST request. It's a more complicated content type that's more efficient at sending binary files. This recipe makes curl read an image photo.png and upload it to https://google.com/profile with a name file. The -F argument also sets the Content-Type header to multipart/form-data.

POST a Binary File and Set Its MIME Type
curl -F 'file=@photo.png;type=image/png' https://google.com/profile
Similar to the previous recipe, this recipe uses the -F argument to upload a binary file (a photo with the filename photo.png) via a multipart POST request. It also specifies the MIME type of this file and sets it to image/png. If no type is specified, then curl sets it to application/octet-stream.

POST a Binary File and Change Its Filename
curl -F 'file=@photo.png;filename=me.png' https://google.com/profile
Similar to the previous two recipes, this recipe uses the -F argument to upload a photo.png via a POST request. Additionally, in this recipe, the filename that is sent to the web server is changed from photo.png to me.png. The web server only sees the filename me.png and doesn't know the original filename was photo.png.

