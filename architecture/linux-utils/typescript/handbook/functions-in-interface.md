<https://www.scaler.com/topics/typescript/function-interface-in-typescript/>

Applying the Keyword Type’

When using a type in an interface, it might be more easy and simple to define the type of the function first. The syntax is slightly different when a function is being declared as a type. Put the arrow operator to use.

type Fun = (name: string) => number;
interface sample {
    test: Fun;
    Properties: string;
}

The Definition of Optional Attributes in Interfaces
The implementation of the entities is much improved via interfaces. It might not always be required to have all of the attributes specified in the interface, though. These are referred to as optional properties and are shown in the interface as follows:

interface Toyotacars {
    length: number;
    Model: string;
    baseprice: number;
    seatingCapacity: number;
    getTyrePressure?: () => number;
    getmeasurement: () => number;
}

The ? in the getTyrePressure property should be noted. The question Mark denotes that entities do not have to implement the functionality of the property getTyrePressure in all models and that it is optional. Even if you don't include this property in the carObj argument, the compiler won't raise an error.

Additionally, the compiler looks for extra attributes that are not specified in the interface. Let's imagine that the carObj interface does not specify the extra property Color that is present in the carObj:

Toyotacars({
    Model: "Fortuner"
    length: 500,
    baseprice: 150,
    getTyrePressure: function () {
        let tyrePressure = 19
        return tyrePressure
    },
    getmesurement: function () {
        let measurement = 20
        return measurement
    },
    color: "White"
})

The following error is returned by the compiler:

Argument of type length: number; Model: string; baseprice: number; getTyrePressure: () => number; getmeasurment: () => number; colour: String; and baseprice: number is not a criterion of the Toyota automobiles type. Only known characteristics may be specified in object literals because the Toyotacars type does not have Color.

Interface Read-Only Properties
Once initialized, read-only attributes cannot be altered. For instance, after they have been initialized with a fixed value, the attributes length, model, wheelbase, and seatingCapacity should never be changed.

Our user interface will need to be updated to reflect this change:

interface Toyotacars {
    readonly length: number;
    readonly model: string;
    readonly baseprice: number;
    readonly seatingCapacity: number;
    getTyrePressure?: () => number;
    getmeasurement: () => number;
}

Take note of how the readonly keyword is used with the properties' names. It implies that once they are initialized with a value, these attributes cannot be changed.

Definition of Function Types in Interfaces
The structure of a function can also be defined via an interface. The getTyrePressure and getmeasurement methods are defined as properties on the Toyotacars interface, as we previously observed. For functions like these, we can specify an interface, though:

interface Ordered {
    (modelId: number, customerId: number): boolean
}

let order: Ordered = function (custId, modId) {
    // processing the order
    return true // processed successfully!
}

Type Ordered to use the order function. It requires two arguments of type number and outputs a boolean value.

As you can see from the code above, there is no need to describe the type of parameters once again when defining the order function. The arguments defined in the interface are simply mapped one-to-one with those defined in the function declaration by the compiler.

It implies that modId maps to modelId and custId translates to customerId, both of which have numbered as their type. Even the order function's return type may be deduced from its declaration in the interface.

Interfaces with Indexable Attributes
As the name implies, indexable attributes are used to define types that are indexed into a special number or string. One way to define the type Sample_Array is as follows:

interface Sample_Array {
    [index: number]: string
}

let cars: Sample_Array = ['Hatchback', 'Sedan', 'Land Rover', 'Fortuner']
console.log('Element at position 1', cars[2]) // 'Land Rover'

Output:

Land Rover

You cannot use array built-in operations like push, pop, filter, etc. on the vehicle's variable since it is not an ordinary array. You may contend that utilizing indexable types is preferable to defining regular arrays. When you need to create custom attributes and methods that should work on a variety of values belonging to the same data type, indexable types come in handy.

Rules and Regulations for Function Interface
When using TypeScript's function interface, there are a few guidelines that must be followed:

The method signature, not the implementation, should be the only thing in the function interface.
The interface keyword should be used before the interface name when creating an interface.
It should make reference to the implemented function when generating the object for the interface function.
The interface variable type and function return type should be appropriately indicated when creating the function inside the interface.
The method signature for the functional interface must match exactly when providing the implementation for it to operate properly.
