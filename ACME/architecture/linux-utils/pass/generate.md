https://www.passwordstore.org/
https://medium.com/@chasinglogic/the-definitive-guide-to-password-store-c337a8f023a1
https://github.com/docker/docker-credential-helpers

Now we can add our first password, let’s create a test password:

pass generate test 10
The way generate works is that pass takes first the name of the password (often the domain name such as google.com) and then the length of password you want it to generate. There are multiple flags you can give generate to make it conform to whatever password rules you would like, you can view possible options with pass generate --help

You’ll now be able to do a listing of your password store by just running pass with no arguments:

pass