https://www.typescripttutorial.net/typescript-tutorial/why-typescript/

Suppose you have a function that returns a product object based on an id:

function getProduct(id){
  return {
    id: id,
    name: `Awesome Gadget ${id}`,
    price: 99.5
  }
}
Code language: TypeScript (typescript)
The following uses the getProduct() function to retrieve the product with id 1 and shows its data:

const product = getProduct(1);
console.log(`The product ${product.Name} costs $${product.price}`);
Code language: TypeScript (typescript)
Output:

The product undefined costs $99.5 
Code language: Shell Session (shell)
It isn’t what we expected.

The issue with this code is that the product object doesn’t have the Name property. It has the name property with the first letter n in lowercase.

However, you can only know it until you run the script.

Referencing a property that doesn’t exist on the object is a common issue when working in JavaScript.

The following example defines a new function that outputs the product information to the Console:

const showProduct = (name, price)  => {
  console.log(`The product ${name} costs ${price}$.`);
};
Code language: JavaScript (javascript)
And the following uses the getProduct() and showProduct() functions:

const product = getProduct(1);
showProduct(product.price, product.name);
Code language: JavaScript (javascript)
Output:

The product 99.5 costs $Awesome Gadget 1 
Code language: PHP (php)
This time we pass the arguments in the wrong order to the showProduct() function. This is another common problem that you often have when working with JavaScript.

This is why TypeScript comes into play.

How Typescript solves the problems of dynamic types
To fix the problem of referencing a property that doesn’t exist on an object, you do the following steps:

First, define the “shape” of the product object using an interface. Note that you’ll learn about the interface in a later tutorial.

interface Product{
    id: number,
    name: string,
    price: number
};
Code language: CSS (css)
Second, explicitly use the Product type as the return type of the getProduct() function:

function getProduct(id) : Product{
  return {
    id: id,
    name: `Awesome Gadget ${id}`,
    price: 99.5
  }
}
Code language: JavaScript (javascript)
When you reference a property that doesn’t exist, the code editor will inform you immediately:

const product = getProduct(1);
console.log(`The product ${product.Name} costs $${product.price}`);
Code language: JavaScript (javascript)
The code editor highlighted the following error on the Name property:


And when you hover the mouse cursor over the error, you’ll see a hint that helps you to solve the issue:


To solve the problem of passing the arguments in the wrong order, you explicitly assign types to function parameters:

const showProduct = (name: string, price:number)  => {
  console.log(`The product ${name} costs ${price}$.`);
};
Code language: JavaScript (javascript)
And when you pass the arguments of the wrong types to the showProduct() function, you’ll receive an error:

const product = getProduct(1);
showProduct(product.price, product.name);
Code language: JavaScript (javascript)

Summary
JavaScript is dynamically typed. It offers flexibility but also creates many problems.
TypeScript adds an optional type system to JavaScript to solve these problems.
