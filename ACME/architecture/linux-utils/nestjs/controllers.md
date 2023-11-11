<https://docs.nestjs.com/controllers>

To create a controller using the CLI, simply execute the $ nest g controller [name] command.

nest g controller cats

Controllers
Controllers are responsible for handling incoming requests and returning responses to the client.

A controller's purpose is to receive specific requests for the application. The routing mechanism controls which controller receives which requests. Frequently, each controller has more than one route, and different routes can perform different actions.

In order to create a basic controller, we use classes and decorators. Decorators associate classes with required metadata and enable Nest to create a routing map (tie requests to the corresponding controllers).

HINT
For quickly creating a CRUD controller with the validation built-in, you may use the CLI's CRUD generator: nest g resource [name].

Routing#
In the following example we'll use the @Controller() decorator, which is required to define a basic controller. We'll specify an optional route path prefix of cats. Using a path prefix in a @Controller() decorator allows us to easily group a set of related routes, and minimize repetitive code. For example, we may choose to group a set of routes that manage interactions with a cat entity under the route /cats. In that case, we could specify the path prefix cats in the @Controller() decorator so that we don't have to repeat that portion of the path for each route in the file.

cats.controller.tsJS

import { Controller, Get } from '@nestjs/common';

@Controller('cats')
export class CatsController {
  @Get()
  findAll(): string {
    return 'This action returns all cats';
  }
}

HINT
To create a controller using the CLI, simply execute the $ nest g controller [name] command.
The @Get() HTTP request method decorator before the findAll() method tells Nest to create a handler for a specific endpoint for HTTP requests. The endpoint corresponds to the HTTP request method (GET in this case) and the route path. What is the route path? The route path for a handler is determined by concatenating the (optional) prefix declared for the controller, and any path specified in the method's decorator. Since we've declared a prefix for every route ( cats), and haven't added any path information in the decorator, Nest will map GET /cats requests to this handler. As mentioned, the path includes both the optional controller path prefix and any path string declared in the request method decorator. For example, a path prefix of cats combined with the decorator @Get('breed') would produce a route mapping for requests like GET /cats/breed.

In our example above, when a GET request is made to this endpoint, Nest routes the request to our user-defined findAll() method. Note that the method name we choose here is completely arbitrary. We obviously must declare a method to bind the route to, but Nest doesn't attach any significance to the method name chosen.

This method will return a 200 status code and the associated response, which in this case is just a string. Why does that happen? To explain, we'll first introduce the concept that Nest employs two different options for manipulating responses:

Standard (recommended) Using this built-in method, when a request handler returns a JavaScript object or array, it will automatically be serialized to JSON. When it returns a JavaScript primitive type (e.g., string, number, boolean), however, Nest will send just the value without attempting to serialize it. This makes response handling simple: just return the value, and Nest takes care of the rest.

Furthermore, the response's status code is always 200 by default, except for POST requests which use 201. We can easily change this behavior by adding the @HttpCode(...) decorator at a handler-level (see Status codes).

Request object#
Handlers often need access to the client request details. Nest provides access to the request object of the underlying platform (Express by default). We can access the request object by instructing Nest to inject it by adding the @Req() decorator to the handler's signature.

cats.controller.tsJS

import { Controller, Get, Req } from '@nestjs/common';
import { Request } from 'express';

@Controller('cats')
export class CatsController {
  @Get()
  findAll(@Req() request: Request): string {
    return 'This action returns all cats';
  }
}
HINT
In order to take advantage of express typings (as in the request: Request parameter example above), install @types/express package.

The request object represents the HTTP request and has properties for the request query string, parameters, HTTP headers, and body (read more here). In most cases, it's not necessary to grab these properties manually. We can use dedicated decorators instead, such as @Body() or @Query(), which are available out of the box. Below is a list of the provided decorators and the plain platform-specific objects they represent.

@Request(), @Req() req
@Response(), @Res()* res
@Next() next
@Session() req.session
@Param(key?: string) req.params / req.params[key]
@Body(key?: string) req.body / req.body[key]
@Query(key?: string) req.query / req.query[key]
@Headers(name?: string) req.headers / req.headers[name]
@Ip() req.ip
@HostParam() req.hosts

* For compatibility with typings across underlying HTTP platforms (e.g., Express and Fastify), Nest provides @Res() and @Response() decorators. @Res() is simply an alias for @Response(). Both directly expose the underlying native platform response object interface. When using them, you should also import the typings for the underlying library (e.g., @types/express) to take full advantage. Note that when you inject either @Res() or @Response() in a method handler, you put Nest into Library-specific mode for that handler, and you become responsible for managing the response. When doing so, you must issue some kind of response by making a call on the response object (e.g., res.json(...) or res.send(...)), or the HTTP server will hang.

HINT
To learn how to create your own custom decorators, visit this chapter.
Resources#
Earlier, we defined an endpoint to fetch the cats resource (GET route). We'll typically also want to provide an endpoint that creates new records. For this, let's create the POST handler:

cats.controller.tsJS

import { Controller, Get, Post } from '@nestjs/common';

@Controller('cats')
export class CatsController {
  @Post()
  create(): string {
    return 'This action adds a new cat';
  }

  @Get()
  findAll(): string {
    return 'This action returns all cats';
  }
}

It's that simple. Nest provides decorators for all of the standard HTTP methods: @Get(), @Post(), @Put(), @Delete(), @Patch(), @Options(), and @Head(). In addition, @All() defines an endpoint that handles all of them.

Route wildcards#
Pattern based routes are supported as well. For instance, the asterisk is used as a wildcard, and will match any combination of characters.

@Get('ab*cd')
findAll() {
  return 'This route uses a wildcard';
}
The 'ab*cd' route path will match abcd, ab_cd, abecd, and so on. The characters ?, +, *, and () may be used in a route path, and are subsets of their regular expression counterparts. The hyphen ( -) and the dot (.) are interpreted literally by string-based paths.

WARNING
A wildcard in the middle of the route is only supported by express.
Status code#
As mentioned, the response status code is always 200 by default, except for POST requests which are 201. We can easily change this behavior by adding the @HttpCode(...) decorator at a handler level.

@Post()
@HttpCode(204)
create() {
  return 'This action adds a new cat';
}

HINT
Import HttpCode from the @nestjs/common package.
Often, your status code isn't static but depends on various factors. In that case, you can use a library-specific response (inject using @Res()) object (or, in case of an error, throw an exception).

Headers#
To specify a custom response header, you can either use a @Header() decorator or a library-specific response object (and call res.header() directly).

@Post()
@Header('Cache-Control', 'none')
create() {
  return 'This action adds a new cat';
}
HINT
Import Header from the @nestjs/common package.

Redirection#
To redirect a response to a specific URL, you can either use a @Redirect() decorator or a library-specific response object (and call res.redirect() directly).

@Redirect() takes two arguments, url and statusCode, both are optional. The default value of statusCode is 302 (Found) if omitted.

@Get()
@Redirect('<https://nestjs.com>', 301)

HINT
Sometimes you may want to determine the HTTP status code or the redirect URL dynamically. Do this by returning an object following the HttpRedirectResponse interface (from @nestjs/common).
Returned values will override any arguments passed to the @Redirect() decorator. For example:

@Get('docs')
@Redirect('<https://docs.nestjs.com>', 302)
getDocs(@Query('version') version) {
  if (version && version === '5') {
    return { url: '<https://docs.nestjs.com/v5/>' };
  }
}
Route parameters#
Routes with static paths won't work when you need to accept dynamic data as part of the request (e.g., GET /cats/1 to get cat with id 1). In order to define routes with parameters, we can add route parameter tokens in the path of the route to capture the dynamic value at that position in the request URL. The route parameter token in the @Get() decorator example below demonstrates this usage. Route parameters declared in this way can be accessed using the @Param() decorator, which should be added to the method signature.

HINT
Routes with parameters should be declared after any static paths. This prevents the parameterized paths from intercepting traffic destined for the static paths.
JS

@Get(':id')
findOne(@Param() params: any): string {
  console.log(params.id);
  return `This action returns a #${params.id} cat`;
}
@Param() is used to decorate a method parameter (params in the example above), and makes the route parameters available as properties of that decorated method parameter inside the body of the method. As seen in the code above, we can access the id parameter by referencing params.id. You can also pass in a particular parameter token to the decorator, and then reference the route parameter directly by name in the method body.

HINT
Import Param from the @nestjs/common package.
JS

@Get(':id')
findOne(@Param('id') id: string): string {
  return `This action returns a #${id} cat`;
}
Sub-Domain Routing#
The @Controller decorator can take a host option to require that the HTTP host of the incoming requests matches some specific value.

@Controller({ host: 'admin.example.com' })
export class AdminController {
  @Get()
  index(): string {
    return 'Admin page';
  }
}
