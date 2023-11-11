# Install Mongo Shell

## References

<https://www.mongodb.com/docs/mongodb-shell/install/>
<https://www.mongodb.com/docs/mongodb-shell/connect/>

## Mongo Shell installation

```bash
# Import the public key used by the package management system.
wget -qO- https://www.mongodb.org/static/pgp/server-7.0.asc | sudo tee /etc/apt/trusted.gpg.d/server-7.0.asc

# Create the /etc/apt/sources.list.d/mongodb-org-7.0.list file for Ubuntu 22.04 (Jammy):
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

sudo apt-get update
# noticed there are different openssl library version options
# If we want to use our PKI we might want to install the version that uses our system openssl.

# mongosh supports OpenSSL. You can also configure mongosh to use your system's OpenSSL installation.

# To install the latest stable version of mongosh with the included OpenSSL libraries:

sudo apt-get install -y mongodb-mongosh
mongosh --version

```

## Test MongoDB Shell

- open a command prompt and type:

```bash
mongosh "mongodb+srv://brentgroves:LXchhTpBJxffVaDf@cluster0.qe7ba1f.mongodb.net/"

```

- For a free cloud-hosted deployment, you can use MongoDB Atlas
and setup a free account

myaccount: brentgroves

## Connecting with MongoDB for VS Code

1. Install MongoDB for VS Code
2. In VS Code, open "Extensions" in the left navigation and search for "MongoDB for VS Code." Select the extension and click install
3. In VS Code, open the Command Palette
4. Search "MongoDB: Connect" on the Command Palette and click on "Connect with Connection String."
5. Connect to your MongoDB deployment
6. Paste your connection string into the Command Palette.

```connectionstring
mongodb+srv://brentgroves:LXchhTpBJxffVaDf@cluster0.qe7ba1f.mongodb.net/
```
