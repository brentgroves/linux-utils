https://coderpad.io/blog/development/intro-to-web-components-vanilla-js/

Many modern web apps today are built using components. While frameworks like React exist to add an implementation, web components seek to make those practices standardized and part of your browser.

In this article, we’ll touch on what web components are, how we can build them without a framework, and some limitations to keep in mind during development. Later, in a follow-up article, we’ll show how a lightweight framework (such as Lit) can provide quality-of-life improvements for those looking to build larger scale applications.

What are Web Components?
There are a lot of misconceptions about what web components even are. While some might assume that it’s simply the ability to make custom elements with dedicated UI, style, and logic in one consolidated place (more on that later), there’s definitely more to it

Web components are a mix of 3 different web standards that, when utilized together, can offer a viable alternative to using a framework like React which offers similar functionality. These web standards consist of:

Custom elements – the ability to create new elements that will provide unique UI and app logic when the related HTML tag is added
Shadow DOM – the ability to keep specific elements segmented off from your main document DOM, allowing you to avoid document collision issues
HTML templates – elements that allow you to write HTML that is not drawn to the page, but can be used as a template for markup to reuse elsewhere
While the Shadow DOM and HTML templates are undoubtedly useful in applications, we’ll be focusing on custom elements today, as we feel they’re the easiest place to start in introducing web components as a whole.

While these are the only official specifications part of Web Components, they’re often utilized with other JavaScript and browser features to create a cohesive development experience.

One of these features often used is JavaScript Modules. While the concept of breaking your app into multiple files has been commonplace with bundlers like Webpack for a while, being built into the browser has been game changing.

What are Custom Elements?
At their core, custom elements essentially allow you to create new HTML tags. These tags are then used to implement custom UI and logic that can be used throughout your application. 

<!-- page.html -->

<!-- These are custom elements, combined to make a page -->
<page-header></page-header>
<page-contents></page-contents>
<page-footer></page-footer>
Code language: HTML, XML (xml)
These components can be as simple as a styled button or as complex as an entire page of your application, complete with your business logic.

While we tend to think of HTML tags as directly mapping to a single DOM element, that’s not always the case with custom elements. For example, the “page-header” tag in the example above might contain “nav” and “a” elements as a list of their children.


Because of this, we’re able to improve an app’s organization by reducing the amount of tags visible in a single file to read with better flow. 

But custom elements aren’t just made up of HTML – you’re able to associate JavaScript logic with these tags as well! This enables you to keep your logic alongside it’s associated UI. Say your header is a dropdown that’s powered by JavaScript. Now you can keep that JavaScript inside of your “page-header” component, keeping your logic consolidated.

Finally, a significant improvement that components provide is composability. You’re able to use these components on different pages, allowing you to keep your header code in sync between pages. This reduces the potential for having variations in standard components – like having multiple differently sized buttons in a page – that might confuse your users. As long as you’re vigilant about utilizing your existing components, you’re able to make your app more consistent this way.

History
But web components didn’t come from nowhere. While web components enjoy large-scale usage now, that wasn’t always the case. Let’s walk through a short history of web components and the related ecosystem.

2010:
Angular.js made open-source
2011:
Web components are announced at a conference by Alex Russell (then Sr Staff Engineer at Google, working on web platform team)
2013:
Polymer (Google’s web component framework) public development began
React open-sourced
2016:
YouTube rewritten in Polymer
2018:
Polymer announces start of migration to “LitElement”
Firefox enables web components (Polyfills no longer needed)
While JavaScript frameworks with similar concepts have been around since at least 2010, web components have found a way to standardize those concepts in the browser. 

it’s clear that the core concepts at play in web components have allowed for dramatic adoption since then. For example React, which has a lot of the same ideas at play, now has a major market share of websites and applications written in JavaScript. 

Now that we’ve seen a short history of web components, let’s take a look at how to build custom elements without using a framework.

Lifecycle Methods
While many implementations of components have differences, one concept that is fairly universal is “lifecycle methods”. At their core, lifecycle methods enable you to run code when events occur on an element. Even frameworks like React, which haved moved away from classes, still have similar concepts of doing actions when a component is changed in some way.


Let’s take a look at some of the lifecycle methods that are baked into the browser’s implementation.

Custom elements have 4 lifecycle methods that can be attached to a component.

connectedCallback	Ran when attached to the DOM
disconnectedCallback	Ran when unattached to the DOM
attributeChangedCallback	Ran when one of the web component’s attributes is changed. Must explicitly track
adoptedCallback	Ran when moved from one HTML document to another
While each of them has their uses, we’ll primarily be focusing on the first 3. adoptedCallback is primarily useful in niche circumstances and is therefore difficult to make a straightforward demo of.

Now that we know what the lifecycle methods are, let’s see an example of them in action.

Connection Lifecycles
The first two lifecycle methods we’ll be talking about are typically used as a pair together: connectedCallback and disconnectedCallback

connectedCallback is ran when a component is mounted onto the DOM. This means that when you want the element to be shown, you can change your innerHTML, add event listeners to elements, or do any other kind of code logic meant to setup your component.

Meanwhile, disconnectedCallback is run when the element is being removed from the DOM. This is often used to remove event listeners added during the connectedCallback, or do other forms of cleanup required for the element.

Here’s a simple web component that renders a header with the text “Hello world”.

class MyComponent extends HTMLElement {
  connectedCallback() {
      console.log("I am connecting");
      this.innerHTML = `<h1>Hello world</h1>`;
  }

  disconnectedCallback() {
      console.log("I am leaving");
  }
}

customElements.define('my-component', MyComponent);