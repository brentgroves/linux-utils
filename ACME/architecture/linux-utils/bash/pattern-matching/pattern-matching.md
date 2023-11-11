https://www.gnu.org/software/bash/manual/bash.html#Pipelines

For example, the following will match a line (stored in the shell variable line) if there is a sequence of characters anywhere in the value consisting of any number, including zero, of characters in the space character class, zero or one instances of ‘a’, then a ‘b’:

[[ $line =~ [[:space:]]*(a)?b ]]
That means values like ‘aab’ and ‘ aaaaaab’ will match, as will a line containing a ‘b’ anywhere in its value.

Storing the regular expression in a shell variable is often a useful way to avoid problems with quoting characters that are special to the shell. It is sometimes difficult to specify a regular expression literally without using quotes, or to keep track of the quoting used by regular expressions while paying attention to the shell’s quote removal. Using a shell variable to store the pattern decreases these problems. For example, the following is equivalent to the above:

pattern='[[:space:]]*(a)?b'
[[ $line =~ $pattern ]]
If you want to match a character that’s special to the regular expression grammar, it has to be quoted to remove its special meaning. This means that in the pattern ‘xxx.txt’, the ‘.’ matches any character in the string (its usual regular expression meaning), but in the pattern ‘"xxx.txt"’ it can only match a literal ‘.’. Shell programmers should take special care with backslashes, since backslashes are used both by the shell and regular expressions to remove the special meaning from the following character. The following two sets of commands are not equivalent:

pattern='\.'

[[ . =~ $pattern ]]
[[ . =~ \. ]]

[[ . =~ "$pattern" ]]
[[ . =~ '\.' ]]
he first two matches will succeed, but the second two will not, because in the second two the backslash will be part of the pattern to be matched. In the first two examples, the backslash removes the special meaning from ‘.’, so the literal ‘.’ matches. If the string in the first examples were anything other than ‘.’, say ‘a’, the pattern would not match, because the quoted ‘.’ in the pattern loses its special meaning of matching any single character.

Expressions may be combined using the following operators, listed in decreasing order of precedence:

( expression )
Returns the value of expression. This may be used to override the normal precedence of operators.

! expression
True if expression is false.

expression1 && expression2
True if both expression1 and expression2 are true.

expression1 || expression2
True if either expression1 or expression2 is true.

The && and || operators do not evaluate expression2 if the value of expression1 is sufficient to determine the return value of the entire conditional expression.




[[…]]
[[ expression ]]
Return a status of 0 or 1 depending on the evaluation of the conditional expression expression. Expressions are composed of the primaries described below in Bash Conditional Expressions. Word splitting and filename expansion are not performed on the words between the [[ and ]]; tilde expansion, parameter and variable expansion, arithmetic expansion, command substitution, process substitution, and quote removal are performed. Conditional operators such as ‘-f’ must be unquoted to be recognized as primaries.

When used with [[, the ‘<’ and ‘>’ operators sort lexicographically using the current locale.

When the ‘==’ and ‘!=’ operators are used, the string to the right of the operator is considered a pattern and matched according to the rules described below in Pattern Matching, as if the extglob shell option were enabled. The ‘=’ operator is identical to ‘==’. If the nocasematch shell option (see the description of shopt in The Shopt Builtin) is enabled, the match is performed without regard to the case of alphabetic characters. The return value is 0 if the string matches (‘==’) or does not match (‘!=’) the pattern, and 1 otherwise. Any part of the pattern may be quoted to force the quoted portion to be matched as a string.

An additional binary operator, ‘=~’, is available, with the same precedence as ‘==’ and ‘!=’. When it is used, the string to the right of the operator is considered a POSIX extended regular expression and matched accordingly (using the POSIX regcomp and regexec interfaces usually described in regex(3)). The return value is 0 if the string matches the pattern, and 1 otherwise. If the regular expression is syntactically incorrect, the conditional expression’s return value is 2. If the nocasematch shell option (see the description of shopt in The Shopt Builtin) is enabled, the match is performed without regard to the case of alphabetic characters. Any part of the pattern may be quoted to force the quoted portion to be matched as a string. Bracket expressions in regular expressions must be treated carefully, since normal quoting characters lose their meanings between brackets. If the pattern is stored in a shell variable, quoting the variable expansion forces the entire pattern to be matched as a string.

The pattern will match if it matches any part of the string. Anchor the pattern using the ‘^’ and ‘$’ regular expression operators to force it to match the entire string. The array variable BASH_REMATCH records which parts of the string matched the pattern. The element of BASH_REMATCH with index 0 contains the portion of the string matching the entire regular expression. Substrings matched by parenthesized subexpressions within the regular expression are saved in the remaining BASH_REMATCH indices. The element of BASH_REMATCH with index n is the portion of the string matching the nth parenthesized subexpression.

For example, the following will match a line (stored in the shell variable line) if there is a sequence of characters anywhere in the value consisting of any number, including zero, of characters in the space character class, zero or one instances of ‘a’, then a ‘b’:

[[ $line =~ [[:space:]]*(a)?b ]]

