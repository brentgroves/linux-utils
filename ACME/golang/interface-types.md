https://www.alexedwards.net/blog/interfaces-explained

What is an interface in Go?
An interface type in Go is kind of like a definition. It defines and describes the exact methods that some other type must have.

One example of an interface type from the standard library is the fmt.Stringer interface, which looks like this:

type Stringer interface {
    String() string
}
We say that something satisfies this interface (or implements this interface) if it has a method with the exact signature String() string.

For example, the following Book type satisfies the interface because it has a String() string method:

type Book struct {
    Title  string
    Author string
}

func (b Book) String() string {
    return fmt.Sprintf("Book: %s - %s", b.Title, b.Author)
}
It's not really important what this Book type is or does. The only thing that matters is that is has a method called String() which returns a string value.

Or, as another example, the following Count type also satisfies the fmt.Stringer interface — again because it has a method with the exact signature String() string.

type Count int

func (c Count) String() string {
    return strconv.Itoa(int(c))
}
The important thing to grasp is that we have two different types, Book and Count, which do different things. But the thing they have in common is that they both satisfy the fmt.Stringer interface.

You can think of this the other way around too. If you know that an object satisfies the fmt.Stringer interface, you can rely on it having a method with the exact signature String() string that you can call.

Now for the important part.

Wherever you see declaration in Go (such as a variable, function parameter or struct field) which has an interface type, you can use an object of any type so long as it satisfies the interface.

For example, let's say that you have the following function:

func WriteLog(s fmt.Stringer) {
    log.Print(s.String())
}
Because this WriteLog() function uses the fmt.Stringer interface type in its parameter declaration, we can pass in any object that satisfies the fmt.Stringer interface. For example, we could pass either of the Book and Count types that we made earlier to the WriteLog() method, and the code would work OK.

Additionally, because the object being passed in satisfies the fmt.Stringer interface, we know that it has a String() string method that the WriteLog() function can safely call.

Let's put this together in an example, which gives us a peek into the power of interfaces.

package main

import (
    "fmt"
    "strconv"
    "log"
)

// Declare a Book type which satisfies the fmt.Stringer interface.
type Book struct {
    Title  string
    Author string
}

func (b Book) String() string {
    return fmt.Sprintf("Book: %s - %s", b.Title, b.Author)
}

// Declare a Count type which satisfies the fmt.Stringer interface.
type Count int

func (c Count) String() string {
    return strconv.Itoa(int(c))
}

// Declare a WriteLog() function which takes any object that satisfies
// the fmt.Stringer interface as a parameter.
func WriteLog(s fmt.Stringer) {
    log.Print(s.String())
}

func main() {
    // Initialize a Count object and pass it to WriteLog().
    book := Book{"Alice in Wonderland", "Lewis Carrol"}
    WriteLog(book)

    // Initialize a Count object and pass it to WriteLog().
    count := Count(3)
    WriteLog(count)
}
This is pretty cool. In the main function we've created different Book and Count types, but passed both of them to the same WriteLog() function. In turn, that calls their relevant String() functions and logs the result.

If you run the code, you should get some output which looks like this:

2009/11/10 23:00:00 Book: Alice in Wonderland - Lewis Carrol
2009/11/10 23:00:00 3
I don't want to labor the point here too much. But the key thing to take away is that by using a interface type in our WriteLog() function declaration, we have made the function agnostic (or flexible) about the exact type of object it receives. All that matters is what methods it has.

Why are they useful?
There are all sorts of reasons that you might end up using a interface in Go, but in my experience the three most common are:

To help reduce duplication or boilerplate code.
To make it easier to use mocks instead of real objects in unit tests.
As an architectural tool, to help enforce decoupling between parts of your codebase.
Let's step through these three use-cases and explore them in a bit more detail.

Reducing boilerplate code
OK, imagine that we have a Customer struct containing some data about a customer. In one part of our codebase we want to write the customer information to a bytes.Buffer, and in another part of our codebase we want to write the customer information to an os.File on disk. But in both cases, we want to serialize the customer struct to JSON first.

This is a scenario where we can use Go's interfaces to help reduce boilerplate code.

The first thing you need to know is that Go has an io.Writer interface type which looks like this:

type Writer interface {
        Write(p []byte) (n int, err error)
}

And we can leverage the fact that both bytes.Buffer and the os.File type satisfy this interface, due to them having the bytes.Buffer.Write() and os.File.Write() methods respectively.

Let's take a look at a simple implementation:

package main

import (
    "bytes"
    "encoding/json"
    "io"
    "log"
    "os"
)

// Create a Customer type
type Customer struct {
    Name string
    Age  int
}

// Implement a WriteJSON method that takes an io.Writer as the parameter.
// It marshals the customer struct to JSON, and if the marshal worked
// successfully, then calls the relevant io.Writer's Write() method.
func (c *Customer) WriteJSON(w io.Writer) error {
    js, err := json.Marshal(c)
    if err != nil {
        return err
    }

    _, err = w.Write(js)
    return err
}

func main() {
    // Initialize a customer struct.
    c := &Customer{Name: "Alice", Age: 21}

    // We can then call the WriteJSON method using a buffer...
    var buf bytes.Buffer
    err := c.WriteJSON(&buf)
    if err != nil {
        log.Fatal(err)
    }

    // Or using a file.
    f, err := os.Create("/tmp/customer")
    if err != nil {
        log.Fatal(err)
    }
    defer f.Close()


    err = c.WriteJSON(f)
    if err != nil {
        log.Fatal(err)
    }
}
Of course, this is just a toy example (and there are other ways we could structure the code to achieve the same end result). But it nicely illustrates the benefit of using an interface — we can create the Customer.WriteJSON() method once, and we can call that method any time that we want to write to something that satisfies the io.Writer interface.

But if you're new to Go, this still begs a couple of questions: How do you know that the io.Writer interface even exists? And how do you know in advance that bytes.Buffer and os.File both satisfy it?

There's no easy shortcut here I'm afraid — you simply need to build up experience and familiarity with the interfaces and different types in the standard library. Spending time thoroughly reading the standard library documentation, and looking at other people's code will help here. But as a quick-start I've included a list of some of the most useful interface types at the end of this post.

But even if you don't use the interfaces from the standard library, there's nothing to stop you from creating and using your own interface types. We'll cover how to do that next.

Unit testing and mocking
To help illustrate how interfaces can be used to assist in unit testing, let's take a look at a slightly more complex example.

Let's say you run a shop, and you store information about the number of customers and sales in a PostgreSQL database. You want to write some code that calculates the sales rate (i.e. sales per customer) for the past 24 hours, rounded to 2 decimal places.

A minimal implementation of the code for that could look something like this:

A minimal implementation of the code for that could look something like this:

File: main.go
package main

import (
    "fmt"
    "log"
    "time"
    "database/sql"
    _ "github.com/lib/pq"
)

type ShopDB struct {
    *sql.DB
}

func (sdb *ShopDB) CountCustomers(since time.Time) (int, error) {
    var count int
    err := sdb.QueryRow("SELECT count(*) FROM customers WHERE timestamp > $1", since).Scan(&count)
    return count, err
}

func (sdb *ShopDB) CountSales(since time.Time) (int, error) {
    var count int
    err := sdb.QueryRow("SELECT count(*) FROM sales WHERE timestamp > $1", since).Scan(&count)
    return count, err
}

func main() {
    db, err := sql.Open("postgres", "postgres://user:pass@localhost/db")
    if err != nil {
        log.Fatal(err)
    }
    defer db.Close()

    shopDB := &ShopDB{db}
    sr, err := calculateSalesRate(shopDB)
    if err != nil {
        log.Fatal(err)
    }
    fmt.Printf(sr)
}

func calculateSalesRate(sdb *ShopDB) (string, error) {
    since := time.Now().Add(-24 * time.Hour)

    sales, err := sdb.CountSales(since)
    if err != nil {
        return "", err
    }

    customers, err := sdb.CountCustomers(since)
    if err != nil {
        return "", err
    }

    rate := float64(sales) / float64(customers)
    return fmt.Sprintf("%.2f", rate), nil
}

Now, what if we want to create a unit test for the calculateSalesRate() function to make sure that the math logic in it is working correctly?

Currently this is a bit of a pain. We would need to set up a test instance of our PostgreSQL database, along with setup and teardown scripts to scaffold the database with dummy data. That's quite lot of work when all we really want to do is test our math logic.

So what can we do? You guessed it — interfaces to the rescue!

A solution here is to create our own interface type which describes the CountSales() and CountCustomers() methods that the calculateSalesRate() function relies on. Then we can update the signature of calculateSalesRate() to use this custom interface type as a parameter, instead of the concrete *ShopDB type.

Like so:

File: main.go
package main

import (
	"database/sql"
	"fmt"
	"log"
	"time"

	_ "github.com/lib/pq"
)

// Create our own custom ShopModel interface. Notice that it is perfectly
// fine for an interface to describe multiple methods, and that it should
// describe input parameter types as well as return value types.
type ShopModel interface {
	CountCustomers(time.Time) (int, error)
	CountSales(time.Time) (int, error)
}

// The ShopDB type satisfies our new custom ShopModel interface, because it
// has the two necessary methods -- CountCustomers() and CountSales().
type ShopDB struct {
	*sql.DB
}

func (sdb *ShopDB) CountCustomers(since time.Time) (int, error) {
	var count int
	err := sdb.QueryRow("SELECT count(*) FROM customers WHERE timestamp > $1", since).Scan(&count)
	return count, err
}

func (sdb *ShopDB) CountSales(since time.Time) (int, error) {
	var count int
	err := sdb.QueryRow("SELECT count(*) FROM sales WHERE timestamp > $1", since).Scan(&count)
	return count, err
}

func main() {
	db, err := sql.Open("postgres", "postgres://user:pass@localhost/db")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	shopDB := &ShopDB{db}
	sr, err := calculateSalesRate(shopDB)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf(sr)
}

// Swap this to use the ShopModel interface type as the parameter, instead of the
// concrete *ShopDB type.
func calculateSalesRate(sm ShopModel) (string, error) {
	since := time.Now().Add(-24 * time.Hour)

	sales, err := sm.CountSales(since)
	if err != nil {
		return "", err
	}

	customers, err := sm.CountCustomers(since)
	if err != nil {
		return "", err
	}

	rate := float64(sales) / float64(customers)
	return fmt.Sprintf("%.2f", rate), nil
}
With that done, it's straightforward for us to create a mock which satisfies our ShopModel interface. We can then use that mock during unit tests to test that the math logic in our calculateSalesRate() function works correctly. Like so:

