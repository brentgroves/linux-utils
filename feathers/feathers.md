feathersjs.org
nvm install --lts
nvm use 18.12.1
npm install @feathersjs/feathers --save
git clone git@github.com:brentgroves/feathers-basics.git
pushd ~/src/feathers-basics

npm install @feathersjs/socketio @feathersjs/express --save

learn feathers-basics:
In this chapter we created our first Feathers application and a service that allows to create new messages, store them in-memory and return all messages. We then hosted that service as a REST and real-time API server and used Feathers in the browser to connect to that server and create a website that can send new messages, show all existing messages and update with new messages in real-time.

Even though we are using just NodeJS and Feathers from scratch without any additional tools, it was not a lot of code for what we are getting. In the next chapter we will look at the Feathers CLI which can create a similar Feathers application with a recommended file structure and things like authentication and database connections set up for us automatically.

pushd ~/src/feathers-basics
node app

npm i @jsreport/browser-client