https://en.wikipedia.org/wiki/Here_document

In computing, a here document (here-document, here-text, heredoc, hereis, here-string or here-script) is a file literal or input stream literal: it is a section of a source code file that is treated as if it were a separate file. The term is also used for a form of multiline string literals that use similar syntax, preserving line breaks and other whitespace (including indentation) in the text.

Here documents originate in the Unix shell,[1] and are found in the Bourne shell (sh), C shell (csh),[2] tcsh (tcsh),[3] KornShell (ksh), Bourne Again Shell (bash), and Z shell (zsh), among others. Here document-style string literals are found in various high-level languages, notably the Perl programming language (syntax inspired by Unix shell) and languages influenced by Perl, such as PHP and Ruby. JavaScript also supports this functionality via template literals, a feature added in its 6th revision (ES6). Other high-level languages such as Python, Julia and Tcl have other facilities for multiline strings.

Here documents can be treated either as files or strings. Some shells treat them as a format string literal, allowing variable substitution and command substitution inside the literal.

The most common syntax for here documents, originating in Unix shells, is << followed by a delimiting identifier (often the word EOF or END[4]), followed, starting on the next line, by the text to be quoted, and then closed by the same delimiting identifier on its own line. This syntax is because here documents are formally stream literals, and the content of the document is redirected to stdin (standard input) of the preceding command; the here document syntax is by analogy with the syntax for input redirection, which is < “take input from the following file”.

Other languages often use substantially similar syntax, but details of syntax and actual functionality can vary significantly. When used simply for string literals, the << does not indicate indirection, but is simply a starting delimiter convention. In some languages, such as Ruby, << is also used for input redirection, thus resulting in << being used twice if one wishes to redirect from a here document string literal.

