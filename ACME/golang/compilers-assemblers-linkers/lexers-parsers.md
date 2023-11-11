https://dev.to/cad97/what-is-a-lexer-anyway-4kdo
Slightly more concretely, parsing is the task of turning a list of symbols into a data structure representing some higher level of structure. In the case of parsing, the set of input symbols are characters†.

Traditionally, parsing of programming languages is split up into two phases: the lexing stage and the parsing stage. In truth, both of these stages are parsers: they both take an input list of symbols and produce a higher level of structure. It's just that the lexer's output is used as the parser's input.

This separation is useful because the lexer's job is simpler than the parser's. The lexer just turns the meaningless string into a flat list of things like "number literal", "string literal", "identifier", or "operator", and can do things like recognizing reserved identifiers ("keywords") and discarding whitespace. Formally, a lexer recognizes some set of Regular languages. A "regular" language is one that can be parsed without any extra state in a single non-backtracking pass. This makes it very efficient: you only have to look at one byte at a time to make decisions, and all of the decisions can even be packed into a decision matrix called a Finite Automaton. If you've ever used a regular expression, you've written a recognizer for a regular language‡.

The parser has the much harder job of turning the stream of "tokens" produced by the lexer into a parse tree representing the structure of the parsed language. The separation of the lexer and the parser allows the lexer to do its job well and for the parser to work on a simpler, more meaningful input than the raw text.

