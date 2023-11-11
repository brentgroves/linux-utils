<https://khalilstemmler.com/articles/tutorials/dependency-injection-inversion-explained/>

Dependency Injection is a technique that can improve the testability of our code.

It works by passing in (usually via constructor) the dependencies that your module needs to operate.

Dependency Inversion
Dependency Inversion is a technique that allows us to decouple components from one another. Check this out.

What direction does the flow of dependencies go in right now?

From left to right. The UserController relies on the UserRepo.

OK. Ready?

Watch what happens when we slap an interface in between the two components make UserRepo implement an IUserRepo interface, and then point the UserController to refer to that instead of the UserRepo concrete class.

**![dependancy inversion](https://d33wubrfki0l68.cloudfront.net/d075438bf5892c2e11841170ea30ce1da450ccb9/60155/img/blog/di-container/after-dependency-inversion.svg)**
