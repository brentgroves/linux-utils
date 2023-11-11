interface Person {
  age: number;
  name: string;
}

type PersonKeys = keyof Person; // "age" | "name"

function getProperty<T, K extends keyof T>(obj: T, key: K): T[K] {
  return obj[key];
}

const person: Person = {
  age: 22,
  name: "Tobias",
};

// name is a property of person
// --> no error
// const name1 = getProperty(person, "name");

// gender is not a property of person
// --> error
const age = getProperty(person, "age");
console.log(age)

type Optional<T> = {
  [K in keyof T]?: T[K]
};

const person2: Optional<Person> = {
  name: "Tobias"
  // notice how I do not have to specify an age,
  // since age's type is now mapped from 'number' to 'number?'
  // and therefore becomes optional
};
