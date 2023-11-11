https://www.mongodb.com/docs/kubernetes-operator/master/tutorial/manage-database-users-scram/index.html
Salted Challenge Response Authentication Mechanism
Salted Challenge Response Authentication Mechanism (SCRAM) is a password-based mutual authentication protocol designed to make an eavesdropping attack (i.e. man-in-the-middle) more difficult. Using cryptographic hashing techniques, a client can prove to a server that the user knows a secret derived from the user’s password without sending the password itself. The server can prove to the client that it knows a secret derived from the user’s password also without having to send the actual password.

