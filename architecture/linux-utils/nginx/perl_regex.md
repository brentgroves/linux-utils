https://perldoc.perl.org/perlre
https://www.geeksforgeeks.org/perl-regex-cheat-sheet/#
Regex or Regular Expressions are an important part of Perl Programming. It is used for searching the specified text pattern. In this, set of characters together form the search pattern. It is also known as regexp. When user learns regular expression then there might be a need for quick look of those concepts which he didn’t use often. So to provide that facility, a regex cheat sheet is created which contains the different classes, Characters, modifiers etc. which are used in regular expression.

Character Classes
Character classes are used to match the string of characters. These classes let the user match any range of characters, which user don’t know in advance.

[abc.]	It includes only one of specified characters i.e. ‘a’, ‘b’, ‘c’, or ‘.’
[a-j]	It includes all the characters from a to j.
[a-z]	It includes all lowercase characters from a to z.
[^az]	It includes all characters except a and z.
\w	It includes all characters like [a-z, A-Z, 0-9]
\d	It matches for the digits like [0-9]
[ab][^cde]	It matches that the characters a and b should not be followed by c, d and e.
\s	It matches for [\f\t\n\r] i.e form feed, tab, newline and carriage return.
\W	Complement of \w
\D	Complement of \d
\S	Complement of \s