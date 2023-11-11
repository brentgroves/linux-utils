https://www.knowledgehut.com/blog/web-development/commonjs-vs-es-modules
The ECMAScript modules (in short ES modules) is a JavaScript modules format which is the official standard format to package JavaScript code for reuse. The ES modules format generally offers an easier route to writing isomorphic JavaScript, which can run in the browser or on a server.
When Node.js came into existence, the ES modules support didn't exist, and so Node.js decided to use CommonJS Modules. While CommonJS as an organization is no longer an active concern, Node.js and npm have evolved the specification to create a very large JavaScript ecosystem. Due to this the ES module got its first support starting from version v8.5.0. At this time we needed to use it with an experimental flag ‘--experimental-modules’. 

But starting from version v13.2.0, the support has been stabilized, so this tag is not required anymore. As a result, the Node/npm ecosystem is extended to both server and client, and is growing rapidly. ES Modules are defined using a variety of import and export statements, but Node.js uses ES modules format if: 

The file extension for the module is ‘.mjs’ or the module's nearest parent folder has { "type": "module" } in its package.json :
An easy way to tell Node.js to treat the modules in ECMAScript format is to use the .mjs file extension. 

Let us take the following ES module example weekday-from-date.mjs exports a function weekdayFromDate(), which is used to determine the day of the week of an arbitrary date: 

// weekday-from-date.mjs (ES Module) 
const WEEKDAY = ['Monday', 'Tuesday', ‘Wednesday', 'Thursday', 
'Friday', 'Saturday', 'Sunday']; 
export function weekDayFromDate(date) { 
if (!(date instanceof Date)) { 
date = new Date(date); 
} 
return WEEKDAY[date.getWeekday()]; 
} 
// weekday.mjs (ES Module) 
import { weekDayFromDate } from './weekday-from-date.mjs'; 
const dateString = process.argv[2] ?? null; 
console.log(weekDayFromDate(dateString)); 
Copy Code
Now if we run weekday.mjs module in command line: 

node ./weekday.mjs "2022-06-08" 

Wednesday is printed in the terminal. 

The argument --input-type=module is present in the config, and the module's code is passed as a string using --eval="<module-code>" argument or from STDIN. By default .js files in Node.js are considered CommonJS modules. To make .js files as ES modules, we need to set the "type" field as "module" in the package.json. Following presents an example for the same :
{ 
"name": "my-app", 
"version": "1.0.0", 
"type": "module", 
// ... 
} 

Now all ‘.js’ files inside the folder containing such package.json execute as ECMAScript modules, and we don’t need to alter the filenames. Let’s take the example of the weekday-from-date module’s example here as well :

Let's rename weekday-from-date.mjs to weekday-from-date.js and weekday.mjs to weekday.js and keep the import and export syntax the same. Then we set "type" field as "module" in the package.json, and we can see Node.js executes these modules as ECMAScript ones. 

node ./weekday.js "2022-06-07" 
Copy Code
Tuesday is printed in the terminal. 

Above was an example for local imports, but we can use the same to import other ES modules. The specifier is the string literal representing the path from where to import the module. Like in the example below, 'path' is a specifier: 

// 'path' is the specifier 
import module from 'path' 
Copy Code
There are 3 kinds of specifiers in Node.js :

1. Relative: Importing a module using a relative specifier would resolve the path of the imported module relative to the current (importing) module location. Relative specifiers usually start with '.', '..', or './':

// Relative specifiers: 
import module1 from './module1.js'; 
import module2 from '../folder/module2.mjs'; 
Copy Code
When using relative specifiers, indicating the file extension (.js, '.mjs', etc.) is obligatory. 

2. Bare: A bare specifier starts with a module name and imports modules from node_modules or the built-in Node.js modules. For instance, if we have installed the lodash-es package in node_modules, then we can access that module using a bare specifier:

// Bare specifiers: 
import lodash from 'lodash-es'; 
import intersection from 'lodash-es/intersection'; 
Copy Code
Using bare specifiers we can also import the Node.js built-in modules: 

import fs from 'fs' 

3. Absolute: An absolute specifier imports modules using an absolute path:

// Absolute specifier: 
import module from 'file:///usr/opt/module.js'; 
Copy Code
Also you can check out the full stack online course to work and experience everything in action. 
What's the Difference Between CommonJS and ES?
Under the default scenario Node.js treats all JavaScript code as CommonJS modules. Because of this, CommonJS modules are characterized by the require() statement for module imports and module.exports for module exports. 

Since by default, all the code is considered CommonJS, we need to explicitly mention the type specifying it by either the file extension(.mjs) in which case it then overrides the default standard of CommonJS and makes ES as default, or by using type:”module” in the package.json, which results in the same behavior.

Since both types are different, it is only feasible to use one at a time. In contrast, conditional exports allow us to build libraries that are both backward-compatible with CommonJS modules and newer ES modules. Consider the following example 

example-node-library 

├── lib/ 
│ ├── module-exampleA.js (commonjs format) 
│ ├── module-exampleA.mjs (es6 module format) 
│ └── private/ 
│ ├── module-exampleB.js (commonjs format) 
│ └── module-exampleB.mjs (es6 module format) 
├── package.json 
└── … 

Inside package.json, we can use the exports field to export the public module (module-exampleA) in two different module formats while restricting access to the private module (module-exampleB): 

// package.json 
{ 
"name": "example-node-library",
"exports": { 
".": { 
"... 
}, 
"module-exampleA": { 
"import": "./lib/module-exampleA.mjs" 
"require": "./lib/module-exampleA.js" 
} 
} 
} 

Now that we have provided the following information about our example-node-library package, we can use it anywhere it is supported. 

// For CommonJS 
const module-exampleA = require('example-node-library/module-exampleA') 
// For ES6 Module 
import module-exampleA from 'example-node-library/module-exampleA' 
Copy Code
Our public modules can be imported and required without specifying absolute paths because of the paths in different exports. Thus, by including '.js' and '.mjs', we are able to resolve the compatibility issue. Package modules can be mapped to different environments, such as a browser and Node.js, while private modules can be restricted. 

We will be looking at the pros and cons of each in the next section. ES modules are the current standard for JavaScript, while CommonJS is the default standard in Node.js 

Merits and Demerits of CommonJS and ES 
CommonJS
1. Support for Older Versions 

In case of legacy code or older version of node, CommonJS has full and stable support, since it is the default standard. Versions preceding v8.5.0 have to be using this only. Also, upto very recently until v13.2.0, ES was marked experimental, there also CommonJS has a great support. 

2. Flexibility with Module Imports 

Import statements are allowed only at the beginning of the file if we call them elsewhere. The control moves the expression to the beginning of the file or throws an error. As a result, require() can be called anywhere in the code since it is parsed at runtime. As well as loading modules conditionally or dynamically, it can also load modules from if statements, conditional loops, or functions, e.g :

if(str.length > 0) { 
const StringMeta = require(‘./stringMeta.js’); 
… 
} 
Copy Code
Here, we load the module stringMeta only if the string is non-empty. 

3. Module Load is Synchronous

One of the drawbacks of using require() is that modules are loaded and processed sequentially one by one since it does the loading synchronously. This can pose rigorous performance issues for large-scale applications that can load hundreds of modules. It might not be a problem for a small-scale application using a limited number of modules. 

ES Module 
1. Allows Import of CommonJS from ES

NodeJS allows us to import CommonJS modules from ES Modules, since in this case, module. exports simply become the default export which we might import as such. 

2. Can be Executed at Both Parse Time and Runtime 

It is for this reason that imports are "hoisted", as they are implicitly moved to the top. The import syntax cannot be used anywhere in the code, therefore. The benefits of this are that errors can be caught upfront and we get better support from developer tools for writing valid code. However, using the import() function can give us the same benefit of dynamic loading. 

3. Load from URL Support 

ECMAScript 6 also provides support that modules can be loaded from a URL. This new improvement not only makes loading more complicated but also slow.

4. Requires File Extension 

A file extension must be provided when using the import keyword. Directory indexes (e.g., './directory/index.js') must be fully specified. 

5. Is Asynchronous 

Since the load is asynchronous, it makes more sense to use it to load many modules. 

Which One is Better, CommonJS or ES? 
Both CommonJS and ES are valid options; as we have just seen, it has evolved a lot in the past decade, and we have options for a good amount of versatility. But mostly, we can classify the decision-making into broadly two clauses :

Since ES Modules have been standardized for many years, it is often better to use them when starting a new project. Since the release of version 14, released in April 2020, NodeJS has had stable support for this. There is a lot of documentation and examples, and it is also interoperable with CommonJs. ES Modules support has already been added to many libraries by new package maintainers. 
If we are maintaining an existing NodeJS project using CommonJS, or if we are using an older version of Node.js, things may be different. It is good news that no existing code needs to be migrated at the moment. NodeJS still uses CommonJS as its default module system and it is unlikely to change any time soon. A conversion to the ES modules would also make the application incompatible with earlier versions of Node.js because of the sketchy support. 
Conclusion
It is better to migrate to ES Modules while still using CommonJS. This can be accomplished by tools like Babel or Typescript, allowing us to decide more easily to switch to ES Modules later. 
