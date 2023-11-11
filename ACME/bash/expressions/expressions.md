https://www.gnu.org/software/bash/manual/bash.html#Pipelines
((…))
(( expression ))
The arithmetic expression is evaluated according to the rules described below (see Shell Arithmetic). If the value of the expression is non-zero, the return status is 0; otherwise the return status is 1. This is exactly equivalent to

let "expression"
See Bash Builtins, for a full description of the let builtin.
[[…]]
[[ expression ]]
Return a status of 0 or 1 depending on the evaluation of the conditional expression expression. Expressions are composed of the primaries described below in Bash Conditional Expressions. Word splitting and filename expansion are not performed on the words between the [[ and ]]; tilde expansion, parameter and variable expansion, arithmetic expansion, command substitution, process substitution, and quote removal are performed. Conditional operators such as ‘-f’ must be unquoted to be recognized as primaries.

When used with [[, the ‘<’ and ‘>’ operators sort lexicographically using the current locale.

When the ‘==’ and ‘!=’ operators are used, the string to the right of the operator is considered a pattern and matched according to the rules described below in Pattern Matching, as if the extglob shell option were enabled. The ‘=’ operator is identical to ‘==’. If the nocasematch shell option (see the description of shopt in The Shopt Builtin) is enabled, the match is performed without regard to the case of alphabetic characters. The return value is 0 if the string matches (‘==’) or does not match (‘!=’) the pattern, and 1 otherwise. Any part of the pattern may be quoted to force the quoted portion to be matched as a string.

An additional binary operator, ‘=~’, is available, with the same precedence as ‘==’ and ‘!=’. When it is used, the string to the right of the operator is considered a POSIX extended regular expression and matched accordingly (using the POSIX regcomp and regexec interfaces usually described in regex(3)). The return value is 0 if the string matches the pattern, and 1 otherwise. If the regular expression is syntactically incorrect, the conditional expression’s return value is 2. If the nocasematch shell option (see the description of shopt in The Shopt Builtin) is enabled, the match is performed without regard to the case of alphabetic characters. Any part of the pattern may be quoted to force the quoted portion to be matched as a string. Bracket expressions in regular expressions must be treated carefully, since normal quoting characters lose their meanings between brackets. If the pattern is stored in a shell variable, quoting the variable expansion forces the entire pattern to be matched as a string.

