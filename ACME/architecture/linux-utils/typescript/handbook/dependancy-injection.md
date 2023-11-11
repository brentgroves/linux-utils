# definition

 The dependency injection principle tells us that a class should receive its dependencies rather than instantiating them.

<https://angular.io/guide/dependency-injection>

Inversion of Control is inverting the whole program flow so that a container manages all program dependencies. You create a container, and this container becomes responsible for constructing every object. When a class needs an object to instantiate, the IoC container serves required dependencies.

IoC only expresses a methodology, not a concrete implementation. For applying the dependency injection principle, you need a DI framework. A couple of examples are:

Spring and Dagger for Java
Hilt for Kotlin
Unity for C#
Inversify, Nest.js, and TypeDI for TypeScript

<https://masoudx.medium.com/dependency-injection-in-typescript-7bb8fdd2863c>

There are a few different ways to implement DI in TypeScript. One common approach is to use constructor injection, where dependencies are passed to a class via its constructor function. For example:

class ServiceA {
  doSomething() {
    console.log('Doing something');
  }
}

class ServiceB {
  constructor(private serviceA: ServiceA) {}

  doSomethingElse() {
    this.serviceA.doSomething();
    console.log('Doing something else');
  }
}

const serviceA = new ServiceA();
const serviceB = new ServiceB(serviceA);
serviceB.doSomethingElse();
In this example, ServiceB depends on ServiceA, and it receives an instance of ServiceA via its constructor. This allows ServiceB to use the doSomething() method of ServiceA without having to know how to create an instance of ServiceA itself.

<https://levelup.gitconnected.com/dependency-injection-in-typescript-2f66912d143c>
Another way to implement DI in TypeScript is to use an inversion of control (IoC) container. An IoC container is a tool that manages the creation and injection of dependencies for you. There are several IoC containers available for TypeScript, such as inversify, awilix, and typeDI.

Before we proceed to the examples, we have to understand a few concepts about dependency injection. The dependency injection principle tells us that a class should receive its dependencies rather than instantiating them. Delegating object initializations can reduce the stress of designing classes by taking care of complex operations. You carry away the complicated part from the code, and you re-introduce dependencies through other ways. How you do this “carrying away” and “re-introducing them” is the problem of managing dependencies. You can manually handle all of the initializations and injections, but this leads to intricate systems, which we try to avoid. Instead of this, you can transfer your construction responsibilities to an IoC container.
