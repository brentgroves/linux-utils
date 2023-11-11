<https://docs.nestjs.com/first-steps>

Prerequisites#
Please make sure that Node.js (version >= 16) is installed on your operating system.

Setup#
Setting up a new project is quite simple with the Nest CLI. With npm installed, you can create a new Nest project with the following commands in your OS terminal:

$ npm i -g @nestjs/cli
$ nest new nestjs-metrics
cd nestjs-metrics
pnpm run start:dev

<https://github.com/willsoto/nestjs-prometheus>
pnpm install @willsoto/nestjs-prometheus prom-client

add   imports: [PrometheusModule.register()], to modules file
curl <http://localhost:3000/metrics>

<https://www.youtube.com/watch?v=x1W3FJ1RJlM>
