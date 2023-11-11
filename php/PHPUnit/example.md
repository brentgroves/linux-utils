https://www.freecodecamp.org/news/test-php-code-with-phpunit/

PHPUnit Testing Example
To help understand this article, here's a sample User class with simple methods that will be tested:

<?php

namespace Zubair\TestProject;

use InvalidArgumentException;

class User
{
    public int $age;
    public array $favorite_movies = [];
    public string $name;

    /**
     * @param int $age
     * @param string $name
     */
    public function __construct(int $age, string $name)
    {
        $this->age = $age;
        $this->name = $name;
    }

    public function tellName(): string
    {
        return "My name is " . $this->name . ".";
    }

    public function tellAge(): string
    {
        return "I am " . $this->age . " years old.";
    }

    public function addFavoriteMovie(string $movie): bool
    {
        $this->favorite_movies[] = $movie;

        return true;
    }

    public function removeFavoriteMovie(string $movie): bool
    {
        if (!in_array($movie, $this->favorite_movies)) throw new InvalidArgumentException("Unknown movie: " . $movie);

        unset($this->favorite_movies[array_search($movie, $this->favorite_movies)]);

        return true;
    }
}


This user class could be the User class in your movie streaming application. The user has a name, age, and a list of favourite movies that can be updated. For the rest of the article we will test that all these features work as they're expected to.

Create a UserTest class in the tests folder. Paste this in to start:

<?php

namespace Zubair\TestProject;

use PHPUnit\Framework\TestCase;

final class UserTest extends TestCase
{
    // Tests will go here
}


Test Constructor
Normally, you wouldn't be testing the __construct method. However, since we're setting values in it, it only makes sense to be sure that the values are being set correctly.

This seems like a very small thing to test, but that's the whole point of unit tests – to ensure that the smallest parts of your application function as expected.

Create a testClassConstructor method to test the constructor:

public function testClassConstructor()
{
    $user = new User(18, 'John');

    $this->assertSame('John', $user->name);
    $this->assertSame(18, $user->age);
    $this->assertEmpty($user->favorite_movies);
}
Test for __construct method
Let's take a quick break now, to see how to run the tests.

How to Run Tests in PHPUnit
You can run all the tests in a directory using the PHPUnit binary installed in your vendor folder.

$ ./vendor/bin/phpunit --verbose tests
You can also run a single test by providing the path to the test file.

$ ./vendor/bin/phpunit --verbose tests/UserTest.php

The output shows that we ran 1 test, and made 3 assertions in it. We also see how long it took to run the test, as well as how much memory was used in running the test.

These assertions are what PHPUnit uses to compare values returned from the methods to their expected value.

This example uses assertSame to check if the name and age properties on the user object match the entered values. It also uses assertEmpty to check that the favorite_movies array is empty.

To see a list of all these assertions, you can check out PHPUnit's docs here.

Edit the code to check if the user age is the same as 21.

public function testClassConstructor()
{
    $user = new User(18, 'John');

    $this->assertSame('John', $user->name);
    $this->assertSame(21, $user->age);
    $this->assertEmpty($user->favorite_movies);
} 
Running the test again this time gives this output:

Screenshot-2022-03-08-at-13.24.20
Failed Assertion Output
The output now shows that we ran 1 test, with 2 successful assertions, and also a failed one. We can see some explanation of the failure, showing the expected value, the gotten value, and the line where the error is from.

Test testName and tellAge
Next, we can test the testName method. This method tells the name of a user as a sentence. So, we can write the test to check:

If the returned value is a string.
If the returned string has the user's name in it (with or without case sensitivity).
public function testTellName()
{
    $user = new User(18, 'John');

    $this->assertIsString($user->tellName());
    $this->assertStringContainsStringIgnoringCase('John', $user->tellName());
}
The test uses the assertions assertIsString  and assertStringContainsStringIgnoringCase to check that the return value is a string and that it contains the string John, respectively.

The testAge method is very similar to testName and uses the same logic. Its test will be similar to the previous one:

public function testTellAge()
{
    $user = new User(18, 'John');

    $this->assertIsString($user->tellAge());
    $this->assertStringContainsStringIgnoringCase('18', $user->tellAge());
}

Test addFavoriteMovie
We can test this method, too. This method adds a movie to the list of movies. To test it, we can check if the newly added movie is in the list, and that the number of items in the list actually increased.

The latter is for confirming that items are not being displaced. Also, since the function returns some value at the end, we can check that this value is correct too.

public function testAddFavoriteMovie()
{
    $user = new User(18, 'John');

    $this->assertTrue($user->addFavoriteMovie('Avengers'));
    $this->assertContains('Avengers', $user->favorite_movies);
    $this->assertCount(1, $user->favorite_movies);
}
Here, we use a few new assertions – assertTrue, assertContains, and assertCount – to check that the returned value is true, that it contains the newly added string, and that the array now has one item in it.

Test removeFavoriteMovie
Finally, we can test that the method to remove a movie works.

public function testRemoveFavoriteMovie()
{
    $user = new User(18, 'John');

    $this->assertTrue($user->addFavoriteMovie('Avengers'));
    $this->assertTrue($user->addFavoriteMovie('Justice League'));

    $this->assertTrue($user->removeFavoriteMovie('Avengers'));
    $this->assertNotContains('Avengers', $user->favorite_movies);
    $this->assertCount(1, $user->favorite_movies);
}
Here, we're adding some movies to the list. Then, we remove one of them, and confirm that the function returned true. Next, we confirm the removal by checking that the value is no longer in the list. Finally, we confirm that we have only one movie in the list, instead of two.

Conclusion
Now you know how to set up PHPUnit in your projects and how to test and ensure that you're building world class software. You can find all the code for this article here.

If you have any questions or relevant advice, please get in touch with me to share them.

To read more of my articles or follow my work, you can connect with me on LinkedIn, Twitter, and Github. It’s quick, it’s easy, and it’s free!