<https://middleware.io/blog/golang-logging/>

As a developer that codes with Golang to benefit from its speed, flexibility, and CSP-style concurrency, you would still not fully leverage Go’s capabilities without Golang logging.

Logging helps you understand your software’s condition. Furthermore, logging allows you to track the step-by-step execution of your application, thereby easing debugging.

Asides from error tracking, logging also helps you record notable events in your application for future decision-making, especially during deployment and upgrading.

This article discusses Golang Logging, highlighting how you can collect and measure logs vis-a-vis the Golang logging best practices.

Golang logging is the process of recording information about the execution of an application. Golang is built with a logging package called `log,` which developers can use to record critical events and messages during the execution of their Golang applications.

The ‘log’ provides a simple interface to create and manage logs and specify the importance of each log message and the destination of the log output. Although the log outputs to the standard error (STDERR) by default, you can customize the destination of your logs. Logging is integral to Golang application performance monitoring.

Logging in Golang uses Golang’s in-built library package or a third-party logging tool. Both provide basic logging facilities that you can use to print messages based on different severity levels to the console or a file.

There are five printing functions—Print(), Printf(), PrintIn(), Fatal(), and Fatalf(), and four severity levels—INFO, WARN, ERROR, and FATAL.

The `Print` functions write log messages with a severity of `INFO,` while the `Fatal` functions write messages with a severity of `FATAL.` Accordingly, a developer can execute the “Printf” or the “Fatalf” functions to format log messages with variables and other data. The “PrintIn” function logs a message followed by a newline character to the console or standard output.

In addition, the log package also provides several other features that enable the customization of logging exercises. With these features, you can configure the prefix to be displayed with each log message, the output location, and the formatting of the log message. For example, you can add timestamps to each log entry and customize the output to meet their needs.

To use the logging package, you must first create a logged object with the function:

log.New().
This function produces the output destination of the log messages and the prefix that will be added.

For example, to create a logger that writes to standard output (STDOUT) with the prefix INFO, you can run this function:

logger := log.New(os.Stdout, "INFO: ", log.Ldate|log.Ltime)

You can then use the logger to write log messages using the Print, Printf, and Println functions. Consider this PrintIn log message:

logger.Println("This is an info message.")

It will produce this output:

INFO:2023/02/17 14:30:15 This is an info message.

Golang’s log package provides many other features. Check the Golang documentation for more information.

How to Collect Golang Logs
Whether you are using the log package or a third-party package, here is a step-by-step process to collect logs in Golang using the standard “log” package:

Step 1: Import the log package:

import "log"

Step 2: Create an output destination for your logs:

logfile, err  := os.Create("app.log")

if err != nil {
    log.Fatal(err)
}

defer logfile.Close()
log. SetOutput(logfile)

This creates a new file called “app.log“ and sets it as the output destination for logs. The “defer” statement ensures that the file is closed after the logs are written.

Step 3: Write logs:

log.Println("Starting the application...")

This code writes a log message to the file specified in step 2. The “Println” function adds a new line character at the end of the message.

Step 4: Use different levels of severity:

log.Println("Info message")
log.Println("Debug message: %s", debugInfo)
log.Println("Fatal error message")

The log package provides different severity levels for logs, such as Debug, Info, Warning, and Error.

Step 5: Format logs:

log.Println("Request from %s for %s", req.RemoteAddr, req.URL.Path)

The “Printf” function allows you to format logs with variables, similar to the standard.“fmt.Printf“ function.

Step 6: Set log flags:

log.SetFlags(log.Ldate | log.Ltime | log.Lmicroseconds | log.Llongfile)

This sets the log flags to include the date, time, microseconds, and the full file path. You can also customize the flags.

Step 7: Handle panics:

deferfunc() {
if := recover(); err != nil {
     log.Println("Panic:", err)
}
}()

If a panic occurs in the application, the `defer` function writes a log with the error message.

By implementing the steps above, you should be able to collect logs in your Golang application using the standard “log” package.

If a panic occurs in the application, the `defer` function writes a log with the error message.

By implementing the steps above, you should be able to collect logs in your Golang application using the standard “log” package.

How to measure Golang logs
Measuring Golang logs analyzes the log collection output to gain insights into its performance and behavior. After collecting your Golang logs, you can use the data to identify errors, optimize performance, and track usage metrics.

Follow these steps to measure your logs:

1. Determine the type of logs you need to measure
The first step is to decide what information you intend to capture in your logs. You can capture performance metrics like request and response times, error rates, and memory usage. The information can also be more application-specific, like user actions or API calls.

2. Decide on a logging package
While you can use the built-in log package, third-party logging packages offer more comprehensive options and opportunities for customization.

8. Set up alerts
You can also set up alerts based on specific events or metrics in your logs. For example, you might set up an alert to notify you if the error rate in your logs exceeds a certain threshold.

Golang logging best practices
Well-executed logging makes identifying and resolving issues easier, improving performance, and gaining insights into your application. Follow these best practices for well-executed Golang logging:

1. Use a logging framework
While Golang provides a built-in “log” package, the package has limited functionality. Consider using a third-party logging framework that is more feature-rich for more control over log output.

2. Use structured logging
Structured logging is a technique where log messages are formatted into machine-readable formats such as JSON. This makes it easier to search and analyze logs and extract valuable information. It is beneficial when dealing with large volumes of logs.

Custom errors
To create a simple string-only error you can use errors.New:

err := errors.New("Houston, we have a problem")
The error interface requires only an Error method, but specific error implementations often have additional methods, allowing callers to inspect the details of the error.
Panic
Panics are similar to C++ and Java exceptions, but are only intended for run-time errors, such as following a nil pointer or attempting to index an array out of bounds.

String-based errors
The standard library offers two out-of-the-box options.

// simple string-based error
err1 := errors.New("math: square root of negative number")

// with formatting
err2 := fmt.Errorf("math: square root of negative number %g", x)

Custom errors with data
To define a custom error type, you must satisfy the predeclared error interface.

type error interface {
 Error() string
}
Here are two examples.

type SyntaxError struct {
 Line int
 Col  int
}

func (e *SyntaxError) Error() string {
 return fmt.Sprintf("%d:%d: syntax error", e.Line, e.Col)
}

type InternalError struct {
 Path string
}

func (e *InternalError) Error() string {
 return fmt.Sprintf("parse %v: internal error", e.Path)
}
If Foo is a function that can return a SyntaxError or an InternalError, you may handle the two cases like this.

if err := Foo(); err != nil {
 switch e := err.(type) {
 case *SyntaxError:
  // Do something interesting with e.Line and e.Col.
case*InternalError:
  // Abort and file an issue.
 default:
  log.Println(e)
 }
}
