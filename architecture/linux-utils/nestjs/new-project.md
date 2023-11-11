<https://docs.nestjs.com/>

# create new project

```bash
cd ~/src
$ npm i -g @nestjs/cli
$ nest new project-name

To create a new TypeScript project with stricter feature set, pass the --strict flag to the nest new command.

Alternatives#
Alternatively, to install the TypeScript starter project with Git:


$ git clone https://github.com/nestjs/typescript-starter.git project
$ cd project
$ npm install
$ npm run start

Open your browser and navigate to http://localhost:3000/.

To install the JavaScript flavor of the starter project, use javascript-starter.git in the command sequence above.

You can also manually create a new project from scratch by installing the core and supporting files with npm (or yarn). In this case, of course, you'll be responsible for creating the project boilerplate files yourself.


$ npm i --save @nestjs/core @nestjs/common rxjs reflect-metadata
```
