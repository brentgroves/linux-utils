To create a new object within generic code, you need to refer to the type by its constructor function. So instead of writing this:

function activatorNotWorking<T extends IActivatable>(type: T): T {
    return new T(); // compile error could not find symbol T
}
You need to write this:

function activator<T extends IActivatable>(type: { new(): T ;} ): T {
    return new type();
}

var classA: ClassA = activator(ClassA);

When creating factories in TypeScript using generics, it is necessary to refer to class types by their constructor functions. For example,

function create<Type>(c: { new (): Type }): Type {
  return new c();
}
Try

A more advanced example uses the prototype property to infer and constrain relationships between the constructor function and the instance side of class types.

class BeeKeeper {
  hasMask: boolean = true;
}

class ZooKeeper {
  nametag: string = "Mikle";
}

class Animal {
  numLegs: number = 4;
}

class Bee extends Animal {
  numLegs = 6;
  keeper: BeeKeeper = new BeeKeeper();
}

class Lion extends Animal {
  keeper: ZooKeeper = new ZooKeeper();
}

function createInstance<A extends Animal>(c: new () => A): A {
  return new c();
}

createInstance(Lion).keeper.nametag;
createInstance(Bee).keeper.hasMask;
