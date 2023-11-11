<https://yourbasic.org/golang/errors-explained/>

Go has two different error-handling mechanisms:

most functions return errors;
only a truly unrecoverable condition, such as an out-of-range index, produces a run-time exception, known as a panic.
Go’s multivalued return makes it easy to return a detailed error message alongside the normal return value. By convention, such messages have type error, a simple built-in interface:

type error interface {
    Error() string
}

Error handling example
The os.Open function returns a non-nil error value when it fails to open a file.

func Open(name string) (file *File, err error)
The following code uses os.Open to open a file. If an error occurs it calls log.Fatal to print the error message and stop.

f, err := os.Open("filename.ext")
if err != nil {
    log.Fatal(err)
}

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
