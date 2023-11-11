https://www.typescripttutorial.net/typescript-tutorial/setup-typescript/
Since any Feathers application is a Node application, we can create a default package.json using npm:
https://feathersjs.com/guides/basics/starting.html
sh
npm init --yes
# Install TypeScript and its NodeJS wrapper
npm i typescript ts-node @types/node --save-dev
# Also initialize a TS configuration file that uses modern JavaScript
npx tsc --init --target es2020

# We can run it with
npx ts-node app.ts

https://www.typescripttutorial.net/typescript-tutorial/setup-typescript/
TypeScript Setup
Summary: in this tutorial, you’ll learn how to set up a TypeScript development environment.

The following tools you need to set up to start with TypeScript:

Node.js – Node.js is the environment in which you will run the TypeScript compiler. Note that you don’t need to know node.js.
TypeScript compiler – a Node.js module that compiles TypeScript into JavaScript. If you use JavaScript for node.js, you can install the ts-node module. It is a TypeScript execution and REPL for node.js
Visual Studio Code or VS Code – is a code editor that supports TypeScript. VS Code is highly recommended. However, you can use your favorite editor.
If you use VS Code, you can install the following extension to speed up the development process:

Live Server – allows you to launch a development local Server with the hot reload feature.

To install the ts-node module globally, you run the following command from the Terminal on macOS and Linux or Command Prompt on Windows:

npm install -g ts-node
