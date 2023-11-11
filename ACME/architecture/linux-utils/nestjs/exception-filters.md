<https://docs.nestjs.com/exception-filters>

Exception filters#
While the base (built-in) exception filter can automatically handle many cases for you, you may want full control over the exceptions layer. For example, you may want to add logging or use a different JSON schema based on some dynamic factors. Exception filters are designed for exactly this purpose. They let you control the exact flow of control and the content of the response sent back to the client.

Let's create an exception filter that is responsible for catching exceptions which are an instance of the HttpException class, and implementing custom response logic for them. To do this, we'll need to access the underlying platform Request and Response objects. We'll access the Request object so we can pull out the original url and include that in the logging information. We'll use the Response object to take direct control of the response that is sent, using the response.json() method.

import { ExceptionFilter, Catch, ArgumentsHost, HttpException } from '@nestjs/common';
import { Request, Response } from 'express';

@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
  catch(exception: HttpException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();
    const status = exception.getStatus();

    response
      .status(status)
      .json({
        statusCode: status,
        timestamp: new Date().toISOString(),
        path: request.url,
      });
  }
}

All exception filters should implement the generic ExceptionFilter<T> interface. This requires you to provide the catch(exception: T, host: ArgumentsHost) method with its indicated signature. T indicates the type of the exception.

The @Catch(HttpException) decorator binds the required metadata to the exception filter, telling Nest that this particular filter is looking for exceptions of type HttpException and nothing else. The @Catch() decorator may take a single parameter, or a comma-separated list. This lets you set up the filter for several types of exceptions at once.

Arguments host#
Let's look at the parameters of the catch() method. The exception parameter is the exception object currently being processed. The host parameter is an ArgumentsHost object. ArgumentsHost is a powerful utility object that we'll examine further in the execution context chapter*. In this code sample, we use it to obtain a reference to the Request and Response objects that are being passed to the original request handler (in the controller where the exception originates). In this code sample, we've used some helper methods on ArgumentsHost to get the desired Request and Response objects. Learn more about ArgumentsHosthere.

*The reason for this level of abstraction is that ArgumentsHost functions in all contexts (e.g., the HTTP server context we're working with now, but also Microservices and WebSockets). In the execution context chapter we'll see how we can access the appropriate underlying arguments for any execution context with the power of ArgumentsHost and its helper functions. This will allow us to write generic exception filters that operate across all contexts.

Binding filters#
Let's tie our new HttpExceptionFilter to the CatsController's create() method.

cats.controller.tsJS

@Post()
@UseFilters(new HttpExceptionFilter())
async create(@Body() createCatDto: CreateCatDto) {
  throw new ForbiddenException();
}

@UseFilters(new HttpExceptionFilter())
export class CatsController {}
This construction sets up the HttpExceptionFilter for every route handler defined inside the CatsController.

To create a global-scoped filter, you would do the following:

main.tsJS

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalFilters(new HttpExceptionFilter());
  await app.listen(3000);
}
bootstrap();

Global-scoped filters are used across the whole application, for every controller and every route handler. In terms of dependency injection, global filters registered from outside of any module (with useGlobalFilters() as in the example above) cannot inject dependencies since this is done outside the context of any module. In order to solve this issue, you can register a global-scoped filter directly from any module using the following construction:

app.module.tsJS

import { Module } from '@nestjs/common';
import { APP_FILTER } from '@nestjs/core';

@Module({
  providers: [
    {
      provide: APP_FILTER,
      useClass: HttpExceptionFilter,
    },
  ],
})
export class AppModule {}

Catch everything#
In order to catch every unhandled exception (regardless of the exception type), leave the @Catch() decorator's parameter list empty, e.g., @Catch().

In the example below we have a code that is platform-agnostic because it uses the HTTP adapter to deliver the response, and doesn't use any of the platform-specific objects (Request and Response) directly:

import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { HttpAdapterHost } from '@nestjs/core';

@Catch()
export class AllExceptionsFilter implements ExceptionFilter {
  constructor(private readonly httpAdapterHost: HttpAdapterHost) {}

  catch(exception: unknown, host: ArgumentsHost): void {
    // In certain situations `httpAdapter` might not be available in the
    // constructor method, thus we should resolve it here.
    const { httpAdapter } = this.httpAdapterHost;

    const ctx = host.switchToHttp();

    const httpStatus =
      exception instanceof HttpException
        ? exception.getStatus()
        : HttpStatus.INTERNAL_SERVER_ERROR;

    const responseBody = {
      statusCode: httpStatus,
      timestamp: new Date().toISOString(),
      path: httpAdapter.getRequestUrl(ctx.getRequest()),
    };

    httpAdapter.reply(ctx.getResponse(), responseBody, httpStatus);
  }
}

Exception filters
Nest comes with a built-in exceptions layer which is responsible for processing all unhandled exceptions across an application. When an exception is not handled by your application code, it is caught by this layer, which then automatically sends an appropriate user-friendly response.

Out of the box, this action is performed by a built-in global exception filter, which handles exceptions of type HttpException (and subclasses of it). When an exception is unrecognized (is neither HttpException nor a class that inherits from HttpException), the built-in exception filter generates the following default JSON response:

{
  "statusCode": 500,
  "message": "Internal server error"
}

The global exception filter partially supports the http-errors library. Basically, any thrown exception containing the statusCode and message properties will be properly populated and sent back as a response (instead of the default InternalServerErrorException for unrecognized exceptions).

Throwing standard exceptions#
Nest provides a built-in HttpException class, exposed from the @nestjs/common package. For typical HTTP REST/GraphQL API based applications, it's best practice to send standard HTTP response objects when certain error conditions occur.

For example, in the CatsController, we have a findAll() method (a GET route handler). Let's assume that this route handler throws an exception for some reason. To demonstrate this, we'll hard-code it as follows:

cats.controller.tsJS

@Get()
async findAll() {
  throw new HttpException('Forbidden', HttpStatus.FORBIDDEN);
}

HINT
We used the HttpStatus here. This is a helper enum imported from the @nestjs/common package.
When the client calls this endpoint, the response looks like this:

{
  "statusCode": 403,
  "message": "Forbidden"
}

The HttpException constructor takes two required arguments which determine the response:

The response argument defines the JSON response body. It can be a string or an object as described below.
The status argument defines the HTTP status code.
By default, the JSON response body contains two properties:

statusCode: defaults to the HTTP status code provided in the status argument
message: a short description of the HTTP error based on the status
To override just the message portion of the JSON response body, supply a string in the response argument. To override the entire JSON response body, pass an object in the response argument. Nest will serialize the object and return it as the JSON response body.

The second constructor argument - status - should be a valid HTTP status code. Best practice is to use the HttpStatus enum imported from @nestjs/common.

There is a third constructor argument (optional) - options - that can be used to provide an error cause. This cause object is not serialized into the response object, but it can be useful for logging purposes, providing valuable information about the inner error that caused the HttpException to be thrown.

Here's an example overriding the entire response body and providing an error cause:

cats.controller.tsJS

@Get()
async findAll() {
  try {
    await this.service.findAll()
  } catch (error) {
    throw new HttpException({
      status: HttpStatus.FORBIDDEN,
      error: 'This is a custom message',
    }, HttpStatus.FORBIDDEN, {
      cause: error
    });
  }
}

Using the above, this is how the response would look:

{
  "status": 403,
  "error": "This is a custom message"
}
Custom exceptions#
In many cases, you will not need to write custom exceptions, and can use the built-in Nest HTTP exception, as described in the next section. If you do need to create customized exceptions, it's good practice to create your own exceptions hierarchy, where your custom exceptions inherit from the base HttpException class. With this approach, Nest will recognize your exceptions, and automatically take care of the error responses. Let's implement such a custom exception:

forbidden.exception.tsJS

export class ForbiddenException extends HttpException {
  constructor() {
    super('Forbidden', HttpStatus.FORBIDDEN);
  }
}

Since ForbiddenException extends the base HttpException, it will work seamlessly with the built-in exception handler, and therefore we can use it inside the findAll() method.

cats.controller.tsJS

@Get()
async findAll() {
  throw new ForbiddenException();
}

Built-in HTTP exceptions#
Nest provides a set of standard exceptions that inherit from the base HttpException. These are exposed from the @nestjs/common package, and represent many of the most common HTTP exceptions:

BadRequestException
UnauthorizedException
NotFoundException
ForbiddenException
NotAcceptableException
RequestTimeoutException
ConflictException
GoneException
HttpVersionNotSupportedException
PayloadTooLargeException
UnsupportedMediaTypeException
UnprocessableEntityException
InternalServerErrorException
NotImplementedException
ImATeapotException
MethodNotAllowedException
BadGatewayException
ServiceUnavailableException
GatewayTimeoutException
PreconditionFailedException
All the built-in exceptions can also provide both an error cause and an error description using the options parameter:

throw new BadRequestException('Something bad happened', { cause: new Error(), description: 'Some error description' })
Using the above, this is how the response would look:

{
  "message": "Something bad happened",
  "error": "Some error description",
  "statusCode": 400,
}
