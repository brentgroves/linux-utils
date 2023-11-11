https://www.freecodecamp.org/news/test-php-code-with-phpunit/

How to Write Tests in PHPUnit
Writing tests in PHPUnit is quite simple. Here are a few conventions to get you started:

To test a class in PHP, you'll create a test class named after that class. For example, if I had some sort of User class, the test class would be named UserTest.
The test class, UserTest, will usually inherit the PHPUnit\Framework\TestCase class.
Individual tests on the class are public methods named with test as a prefix. For example, to test a sayHello method on the User class, the method will be named testSayHello.
Inside the test method, say testSayHello, you use PHPUnit's method like assertSame to see that some method returns some expected value.
A popular convention is to have all tests in a tests directory, and all source code in the src directory.