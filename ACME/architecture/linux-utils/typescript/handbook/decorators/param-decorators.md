<https://hackernoon.com/using-decorators-in-typescript>

Parameter Decorators
A Parameter Decorator is is used to decorate a parameter of a class method or a class constructor.

The parameter decorator receives three arguments.

The prototype of the class for an instance member OR the constructor function of the class for a static member.
The name of the method that uses the parameter.
The index of the parameter in the function’s parameter list.

const parameterDecorator = (target: any, methodName: string, position: number) => {
  // do something with your parameter
  console.log('Parameter decorator!');
  console.log(target);
  console.log(methodName);
  console.log(position);
}

class Product {
  title: string;
  private _price: number;

  constructor(t: string, p: number) {
    this.title = t;
    this._price = p;
  }

  getPriceWithDiscount(@parameterDecorator discount: number) {
    return this._price - (this._price * discount) / 100;
  }
}
