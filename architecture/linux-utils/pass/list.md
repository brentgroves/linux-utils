https://www.passwordstore.org/
https://medium.com/@chasinglogic/the-definitive-guide-to-password-store-c337a8f023a1
https://github.com/docker/docker-credential-helpers

Using the password store
We can list all the existing passwords in the store:

zx2c4@laptop ~ $ pass

And we can show passwords too:

zx2c4@laptop ~ $ pass Email/zx2c4.com
pass api://reports
Or copy them to the clipboard:

zx2c4@laptop ~ $ pass -c Email/zx2c4.com

There will be a nice password input dialog using the standard gpg-agent (which can be configured to stay authenticated for several minutes), since all passwords are encrypted.
