https://www.toptal.com/go/golang-oop-tutorial
Is Go object-oriented? Can it be? Go (or “Golang”) is a post-OOP programming language that borrows its structure (packages, types, functions) from the Algol/Pascal/Modula language family. Nevertheless, in Go, object-oriented patterns are still useful for structuring a program in a clear and understandable way. This Golang tutorial will take a simple example and demonstrate how to apply the concepts of binding functions to types (aka classes), constructors, subtyping, polymorphism, dependency injection, and testing with mocks.

Go OOP: Binding Functions to a Type

OOP in Golang: Using Constructors
To avoid the panic when handling an invalid VIN, it’s possible to add validity checks to the Manufacturer() function itself. The disadvantages are that the checks would be done on every call to the Manufacturer() function, and that an error return value would have to be introduced, which would make it impossible to use the return value directly without an intermediate variable (e.g., as a map key).

A more elegant way is to put the validity checks in a constructor for the VIN type, so that the Manufacturer() function is called for valid VINs only and does not need checks and error handling:

package vin

import "fmt"

type VIN string

// it is debatable if this func should be named New or NewVIN
// but NewVIN is better for greping and leaves room for other
// NewXY funcs in the same package
func NewVIN(code string)(VIN, error) {

  if len(code) != 17 {
    return "", fmt.Errorf("invalid VIN %s: more or less than 17 characters", code)
  }

  // ... check for disallowed characters ...

  return VIN(code), nil
}

func (v VIN) Manufacturer() string {

  manufacturer := v[: 3]
  if manufacturer[2] == '9' {
    manufacturer += v[11: 14]
  }

  return string(manufacturer)
}
Of course, we add a test for the NewVIN function. Invalid VINs are now rejected by the constructor:

package vin_test

import (
  "vin-stages/3"
  "testing"
)

const (
  validVIN = "W0L000051T2123456"
  invalidVIN = "W0"
)

func TestVIN_New(t *testing.T) {

  _, err := vin.NewVIN(validVIN)
  if err != nil {
    t.Errorf("creating valid VIN returned an error: %s", err.Error())
  }

  _, err = vin.NewVIN(invalidVIN)
  if err == nil {
    t.Error("creating invalid VIN did not return an error")
  }
}

func TestVIN_Manufacturer(t *testing.T) {

  testVIN, _ := vin.NewVIN(validVIN)
  manufacturer := testVIN.Manufacturer()
  if manufacturer != "W0L" {
    t.Errorf("unexpected manufacturer %s for VIN %s", manufacturer, testVIN)
  }
}
