https://medium.com/the-godev-corner/go-generics-everything-you-need-to-know-52dd3796d8a1
https://go.dev/blog/intro-generics
What is generics in programming?
Generic programming, according to Wikipedia, is a style of computer programming in which algorithms are written in terms of types that can be specified later.

A simple explanation: a generic type is a type that can be used in conjunction with multiple types, and a generic function is one that can work with more than one type.

So… why Go generics?
Simply put, up to a 20% performance improvement.

According to The Go Blog, Go generics added three primary components to the language:

Type parameters for function and types.
Defining interface types as sets of types, including types that don’t have methods.
Type inference, which permits omitting type arguments in many cases when calling a function.
 The question: Given an integer(int or in32 or int64) array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.
 Now let’s solve this without using Go generics first.

Navigate to your development directory and create a new Go project directory with any name. I named mine leetcode1. Then change directory into the newly created project directory.

As is customary, let’s create a Go module for our project by runninggo mod init github.com/brentgroves/leetcode1 in the project root directory in the terminal.