<https://basarat.gitbook.io/typescript/type-system/index-signatures#declaring-an-index-signature>

let foo:{ [index:string] : {message: string} } = {};

/**

* Must store stuff that conforms to the structure
 */
/**Ok */
foo['a'] = { message: 'some message' };
/** Error: must contain a `message` of type string. You have a typo in `message` */
foo['a'] = { messages: 'some message' };

/**

* Stuff that is read is also type checked
 */
/**Ok */
foo['a'].message;
/** Error: messages does not exist. You have a typo in `message` */
foo['a'].messages;
