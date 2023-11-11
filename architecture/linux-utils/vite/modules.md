https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules
A background on modules
JavaScript programs started off pretty small — most of its usage in the early days was to do isolated scripting tasks, providing a bit of interactivity to your web pages where needed, so large scripts were generally not needed. Fast forward a few years and we now have complete applications being run in browsers with a lot of JavaScript, as well as JavaScript being used in other contexts (Node.js, for example).

It has therefore made sense in recent years to start thinking about providing mechanisms for splitting JavaScript programs up into separate modules that can be imported when needed. Node.js has had this ability for a long time, and there are a number of JavaScript libraries and frameworks that enable module usage (for example, other CommonJS and AMD-based module systems like RequireJS, and more recently Webpack and Babel).

The good news is that modern browsers have started to support module functionality natively, and this is what this article is all about. This can only be a good thing — browsers can optimize loading of modules, making it more efficient than having to use a library and do all of that extra client-side processing and extra round trips.

Use of native JavaScript modules is dependent on the import and export statements; these are supported in browsers as shown in the compatibility table below.

Introducing an example
To demonstrate usage of modules, we've created a simple set of examples that you can find on GitHub. These examples demonstrate a simple set of modules that create a <canvas> element on a webpage, and then draw (and report information about) different shapes on the canvas.

These are fairly trivial, but have been kept deliberately simple to demonstrate modules clearly.

Note: If you want to download the examples and run them locally, you'll need to run them through a local web server.

Basic example structure
In our first example (see basic-modules) we have a file structure as follows:

index.html
main.js
modules/
    canvas.js
    square.js

The modules directory's two modules are described below:

canvas.js — contains functions related to setting up the canvas:
create() — creates a canvas with a specified width and height inside a wrapper <div> with a specified ID, which is itself appended inside a specified parent element. Returns an object containing the canvas's 2D context and the wrapper's ID.
createReportList() — creates an unordered list appended inside a specified wrapper element, which can be used to output report data into. Returns the list's ID.
square.js — contains:
name — a constant containing the string 'square'.
draw() — draws a square on a specified canvas, with a specified size, position, and color. Returns an object containing the square's size, position, and color.
reportArea() — writes a square's area to a specific report list, given its length.
reportPerimeter() — writes a square's perimeter to a specific report list, given its length.

Aside — .mjs versus .js
Throughout this article, we've used .js extensions for our module files, but in other resources you may see the .mjs extension used instead. V8's documentation recommends this, for example. The reasons given are:

It is good for clarity, i.e. it makes it clear which files are modules, and which are regular JavaScript.
It ensures that your module files are parsed as a module by runtimes such as Node.js, and build tools such as Babel.
However, we decided to keep using .js, at least for the moment. To get modules to work correctly in a browser, you need to make sure that your server is serving them with a Content-Type header that contains a JavaScript MIME type such as text/javascript. If you don't, you'll get a strict MIME type checking error along the lines of "The server responded with a non-JavaScript MIME type" and the browser won't run your JavaScript. Most servers already set the correct type for .js files, but not yet for .mjs files. Servers that already serve .mjs files correctly include GitHub Pages and http-server for Node.js.

This is OK if you are using such an environment already, or if you aren't but you know what you are doing and have access (i.e. you can configure your server to set the correct Content-Type for .mjs files). It could however cause confusion if you don't control the server you are serving files from, or are publishing files for public use, as we are here.

For learning and portability purposes, we decided to keep to .js.

If you really value the clarity of using .mjs for modules versus using .js for "normal" JavaScript files, but don't want to run into the problem described above, you could always use .mjs during development and convert them to .js during your build step.

It is also worth noting that:

Some tools may never support .mjs.
The <script type="module"> attribute is used to denote when a module is being pointed to, as you'll see below.

Exporting module features
The first thing you do to get access to module features is export them. This is done using the export statement.

The easiest way to use it is to place it in front of any items you want exported out of the module, for example:

export const name = "square";

export function draw(ctx, length, x, y, color) {
  ctx.fillStyle = color;
  ctx.fillRect(x, y, length, length);

  return { length, x, y, color };
}
Copy to ClipboardCopy to Clipboard
You can export functions, var, let, const, and — as we'll see later — classes. They need to be top-level items; you can't use export inside a function, for example.

A more convenient way of exporting all the items you want to export is to use a single export statement at the end of your module file, followed by a comma-separated list of the features you want to export wrapped in curly braces. For example:

export { name, draw, reportArea, reportPerimeter };

Importing features into your script
Once you've exported some features out of your module, you need to import them into your script to be able to use them. The simplest way to do this is as follows:

import { name, draw, reportArea, reportPerimeter } from "./modules/square.js";
Copy to ClipboardCopy to ClipboardCopy to Clipboard
You use the import statement, followed by a comma-separated list of the features you want to import wrapped in curly braces, followed by the keyword from, followed by the module specifier.

The module specifier provides a string that the JavaScript environment can resolve to a path to the module file. In a browser, this could be a path relative to the site root, which for our basic-modules example would be /js-examples/module-examples/basic-modules. However, here we are instead using the dot (.) syntax to mean "the current location", followed by the relative path to the file we are trying to find. This is much better than writing out the entire absolute path each time, as relative paths are shorter and make the URL portable — the example will still work if you move it to a different location in the site hierarchy.

So for example:

/js-examples/module-examples/basic-modules/modules/square.js
Copy to ClipboardCopy to ClipboardCopy to Clipboard
becomes

./modules/square.js
Copy to ClipboardCopy to ClipboardCopy to Clipboard
You can see such lines in action in main.js.

Note: In some module systems, you can use a module specifier like modules/square that isn't a relative or absolute path, and that doesn't have a file extension. This kind of specifier can be used in a browser environment if you first define an import map.

Once you've imported the features into your script, you can use them just like they were defined inside the same file. The following is found in main.js, below the import lines:

const myCanvas = create("myCanvas", document.body, 480, 320);
const reportList = createReportList(myCanvas.id);

const square1 = draw(myCanvas.ctx, 50, 50, 100, "blue");
reportArea(square1.length, reportList);
reportPerimeter(square1.length, reportList);
Copy to ClipboardCopy to ClipboardCopy to Clipboard
Note: The imported values are read-only views of the features that were exported. Similar to const variables, you cannot re-assign the variable that was imported, but you can still modify properties of object values. The value can only be re-assigned by the module exporting it. See the import reference for an example.

Importing modules using import maps
Above we saw how a browser can import a module using a module specifier that is either an absolute URL, or a relative URL that is resolved using the base URL of the document:

import { name as squareName, draw } from "./shapes/square.js";
import { name as circleName } from "https://example.com/shapes/circle.js";
Copy to ClipboardCopy to ClipboardCopy to Clipboard
Import maps allow developers to instead specify almost any text they want in the module specifier when importing a module; the map provides a corresponding value that will replace the text when the module URL is resolved.

For example, the imports key in the import map below defines a "module specifier map" JSON object where the property names can be used as module specifiers, and the corresponding values will be substituted when the browser resolves the module URL. The values must be absolute or relative URLs. Relative URLs are resolved to absolute URL addresses using the base URL of the document containing the import map.

<script type="importmap">
  {
    "imports": {
      "shapes": "./shapes/square.js",
      "shapes/square": "./modules/shapes/square.js",
      "https://example.com/shapes/": "/shapes/square/",
      "https://example.com/shapes/square.js": "./shapes/square.js",
      "../shapes/square": "./shapes/square.js"
    }
  }
</script>

The import map is defined using a JSON object inside a <script> element with the type attribute set to importmap. There can only be one import map in the document, and because it is used to resolve which modules are loaded in both static and dynamic imports, it must be declared before any <script> elements that import modules.

With this map you can now use the property names above as module specifiers. If there is no trailing forward slash on the module specifier key then the whole module specifier key is matched and substituted. For example, below we match bare module names, and remap a URL to another path.

// Bare module names as module specifiers
import { name as squareNameOne } from "shapes";
import { name as squareNameTwo } from "shapes/square";

// Remap a URL to another URL
import { name as squareNameThree } from "https://example.com/shapes/moduleshapes/square.js";
Copy to ClipboardCopy to ClipboardCopy to Clipboard
If the module specifier has a trailing forward slash then the value must have one as well, and the key is matched as a "path prefix". This allows remapping of whole classes of URLs.

// Remap a URL as a prefix ( https://example.com/shapes/)
import { name as squareNameFour } from "https://example.com/shapes/square.js";
Copy to ClipboardCopy to ClipboardCopy to Clipboard
It is possible for multiple keys in an import map to be valid matches for a module specifier. For example, a module specifier of shapes/circle/ could match the module specifier keys shapes/ and shapes/circle/. In this case the browser will select the most specific (longest) matching module specifier key.

Import maps allow modules to be imported using bare module names (as in Node.js), and can also simulate importing modules from packages, both with and without file extensions. While not shown above, they also allow particular versions of a library to be imported, based on the path of the script that is importing the module. Generally they let developers write more ergonomic import code, and make it easier to manage the different versions and dependencies of modules used by a site. This can reduce the effort required to use the same JavaScript libraries in both browser and server.

