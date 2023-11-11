DOM
https://stackoverflow.com/questions/4110081/difference-between-html-and-dom#:~:text=DOM%20is%20a%20model%20of,kind%20of%20DOM%20in%20text.

https://en.wikipedia.org/wiki/Document_Object_Model
Layout engines[edit]
Web browsers rely on layout engines to parse HTML into a DOM. Some layout engines, such as Trident/MSHTML, are associated primarily or exclusively with a particular browser, such as Internet Explorer. Others, including Blink, WebKit, and Gecko, are shared by a number of browsers, such as Google Chrome, Opera, Safari, and Firefox. The different layout engines implement the DOM standards to varying degrees of compliance.

DOM is a model of a document with an associated API for manipulating it.

HTML is a markup language that lets you represent a certain kind of DOM in text.

Other kinds of DOMs can be expressed in other markup languages, for example RSS and Atom can be converted to a DOM and manipulated with the same API as an HTML or XHTML document (more or less anyway; there are some HTML specific DOM extensions).

The Document Object Model (DOM) is a language-independent model made up of objects representing the structure of a document. HTML is one language for writing such documents.

DOM is the tree model to represent HTML.
Share
Improve this answer
Follow
answered Nov 5, 2010 at 21:06

Alan Haggai Alavi
71.5k19
19 gold badges
99
99 silver badges
126
126 bronze badges
DOM: en.wikipedia.org/wiki/Document_object_model HTML: en.wikipedia.org/wiki/HTML – zzzzBov Nov 5, 2010 at 21:07 
The HTML of a page is a string, and the DOM of the page is what happens when you take that string and construct an object in the object-oriented programming sense of the term "object". Creating that object is how JavaScript is able to interact with the page:
https://en.wikipedia.org/wiki/Document_Object_Model#JavaScript
When a web page is loaded, the browser creates a Document Object Model of the page, which is an object oriented representation of an HTML document, that acts as an interface between JavaScript and the document itself and allows the creation of dynamic web pages.


