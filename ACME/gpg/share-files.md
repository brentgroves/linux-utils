# encypt raven.txt file for moto
gpg --encrypt --sign --armor -r brent@moto raven.txt
less raven.txt.asc

# give encrypted file to moto
ssh brent@moto
lftp brent@reports-avi
get /home/brent/raven.txt.asc 
get /home/brent/Downloads/raven.txt.asc 
exit
gpg --decrypt raven.txt.asc > raven.txt
gpg2 --keyserver https://pgp.mit.edu/ --search-keys <sender_name_or_address>
gpg2 --keyserver moto --search-keys brent@reports51
Test passphrase:
Britney Jazzy1!
