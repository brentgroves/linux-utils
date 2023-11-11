https://pkg.go.dev/testing

Package testing provides support for automated testing of Go packages. It is intended to be used in concert with the "go test" command, which automates execution of any function of the form

func TestXxx(*testing.T)
where Xxx does not start with a lowercase letter. The function name serves to identify the test routine.

Within these functions, use the Error, Fail or related methods to signal failure.

To write a new test suite, create a file that contains the TestXxx functions as described here, and give that file a name ending in "_test.go". The file will be excluded from regular package builds but will be included when the "go test" command is run.

The test file can be in the same package as the one being tested, or in a corresponding package with the suffix "_test".

If the test file is in the same package, it may refer to unexported identifiers within the package, as in this example:

package abs

import "testing"

func TestAbs(t *testing.T) {
    got := Abs(-1)
    if got != 1 {
        t.Errorf("Abs(-1) = %d; want 1", got)
    }
}
If the file is in a separate "_test" package, the package being tested must be imported explicitly and only its exported identifiers may be used. This is known as "black box" testing.

package abs_test

import (
	"testing"

	"path_to_pkg/abs"
)

func TestAbs(t *testing.T) {
    got := abs.Abs(-1)
    if got != 1 {
        t.Errorf("Abs(-1) = %d; want 1", got)
    }
}
For more detail, run "go help test" and "go help testflag".

