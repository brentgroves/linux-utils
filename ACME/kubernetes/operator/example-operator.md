<https://sdk.operatorframework.io/docs/building-operators/golang/tutorial/>

Go Operator Tutorial
An in-depth walkthrough of building and running a Go-based operator.
NOTE: If your project was created with an operator-sdk version prior to v1.0.0 please migrate, or consult the legacy docs.

Prerequisites
Go through the installation guide.
Make sure your user is authorized with cluster-admin permissions.
An accessible image registry for various operator images (ex. hub.docker.com, quay.io) and be logged in to your command line environment.
example.com is used as the registry Docker Hub namespace in these examples. Replace it with another value if using a different registry or namespace.
Authentication and certificates if the registry is private or uses a custom CA.

Overview
We will create a sample project to let you know how it works and this sample will:

Create a Memcached Deployment if it doesn’t exist
Ensure that the Deployment size is the same as specified by the Memcached CR spec
Update the Memcached CR status using the status writer with the names of the CR’s pods
