named captures
https://www.regular-expressions.info/named.html

Nearly all modern regular expression engines support numbered capturing groups and numbered backreferences. Long regular expressions with lots of groups and backreferences may be hard to read. They can be particularly difficult to maintain as adding or removing a capturing group in the middle of the regex upsets the numbers of all the groups that follow the added or removed group.

Python’s re module was the first to offer a solution: named capturing groups and named backreferences. (?P<name>group) captures the match of group into the backreference “name”. name must be an alphanumeric sequence starting with a letter. group can be any regular expression. You can reference the contents of the group with the named backreference (?P=name). The question mark, P, angle brackets, and equals signs are all part of the syntax. Though the syntax for the named backreference uses parentheses, it’s just a backreference that doesn’t do any capturing or grouping. The HTML tags example can be written as <(?P<tag>[A-Z][A-Z0-9]*)\b[^>]*>.*?</(?P=tag)>.

Perl 5.10 added support for both the Python and .NET syntax for named capture and backreferences. It also adds two more syntactic variants for named backreferences: \k{one} and \g{two}. There’s no difference between the five syntaxes for named backreferences in Perl. All can be used interchangeably. In the replacement text, you can interpolate the variable $+{name} to insert the text matched by a named capturing group.


Capture groups
The grouping construct ( ... ) creates capture groups (also referred to as capture buffers). To refer to the current contents of a group later on, within the same pattern, use \g1 (or \g{1}) for the first, \g2 (or \g{2}) for the second, and so on. This is called a backreference. There is no limit to the number of captured substrings that you may use. Groups are numbered with the leftmost open parenthesis being number 1, etc. If a group did not match, the associated backreference won't match either. (This can happen if the group is optional, or in a different branch of an alternation.) You can omit the "g", and write "\1", etc, but there are some issues with this form, described below.

You can also refer to capture groups relatively, by using a negative number, so that \g-1 and \g{-1} both refer to the immediately preceding capture group, and \g-2 and \g{-2} both refer to the group before it. For example:

/
 (Y)            # group 1
 (              # group 2
    (X)         # group 3
    \g{-1}      # backref to group 3
    \g{-3}      # backref to group 1
 )
/x
would match the same as /(Y) ( (X) \g3 \g1 )/x. This allows you to interpolate regexes into larger regexes and not have to worry about the capture groups being renumbered.

You can dispense with numbers altogether and create named capture groups. The notation is (?<name>...) to declare and \g{name} to reference. (To be compatible with .Net regular expressions, \g{name} may also be written as \k{name}, \k<name> or \k'name'.) name must not begin with a number, nor contain hyphens. When different groups within the same pattern have the same name, any reference to that name assumes the leftmost defined group. Named groups count in absolute and relative numbering, and so can also be referred to by those numbers. (It's possible to do things with named capture groups that would otherwise require (??{}).)

Capture group contents are dynamically scoped and available to you outside the pattern until the end of the enclosing block or until the next successful match, whichever comes first. (See "Compound Statements" in perlsyn.) You can refer to them by absolute number (using "$1" instead of "\g1", etc); or by name via the %+ hash, using "$+{name}".

Braces are required in referring to named capture groups, but are optional for absolute or relative numbered ones. Braces are safer when creating a regex by concatenating smaller strings. For example if you have qr/$a$b/, and $a contained "\g1", and $b contained "37", you would get /\g137/ which is probably not what you intended.

If you use braces, you may also optionally add any number of blank (space or tab) characters within but adjacent to the braces, like \g{ -1 }, or \k{ name }.

The \g and \k notations were introduced in Perl 5.10.0. Prior to that there were no named nor relative numbered capture groups. Absolute numbered groups were referred to using \1, \2, etc., and this notation is still accepted (and likely always will be). But it leads to some ambiguities if there are more than 9 capture groups, as \10 could mean either the tenth capture group, or the character whose ordinal in octal is 010 (a backspace in ASCII). Perl resolves this ambiguity by interpreting \10 as a backreference only if at least 10 left parentheses have opened before it. Likewise \11 is a backreference only if at least 11 left parentheses have opened before it. And so on. \1 through \9 are always interpreted as backreferences. There are several examples below that illustrate these perils. You can avoid the ambiguity by always using \g{} or \g if you mean capturing groups; and for octal constants always using \o{}, or for \077 and below, using 3 digits padded with leading zeros, since a leading zero implies an octal constant.

The \digit notation also works in certain circumstances outside the pattern. See "Warning on \1 Instead of $1" below for details.

Examples:

s/^([^ ]*) *([^ ]*)/$2 $1/;     # swap first two words

/(.)\g1/                        # find first doubled char
     and print "'$1' is the first doubled character\n";

/(?<char>.)\k<char>/            # ... a different way
     and print "'$+{char}' is the first doubled character\n";

/(?'char'.)\g1/                 # ... mix and match
     and print "'$1' is the first doubled character\n";

if (/Time: (..):(..):(..)/) {   # parse out values
    $hours = $1;
    $minutes = $2;
    $seconds = $3;
}

/(.)(.)(.)(.)(.)(.)(.)(.)(.)\g10/   # \g10 is a backreference
/(.)(.)(.)(.)(.)(.)(.)(.)(.)\10/    # \10 is octal
/((.)(.)(.)(.)(.)(.)(.)(.)(.))\10/  # \10 is a backreference
/((.)(.)(.)(.)(.)(.)(.)(.)(.))\010/ # \010 is octal

$a = '(.)\1';        # Creates problems when concatenated.
$b = '(.)\g{1}';     # Avoids the problems.
"aa" =~ /${a}/;      # True
"aa" =~ /${b}/;      # True
"aa0" =~ /${a}0/;    # False!
"aa0" =~ /${b}0/;    # True
"aa\x08" =~ /${a}0/;  # True!
"aa\x08" =~ /${b}0/;  # False
Several special variables also refer back to portions of the previous match. $+ returns whatever the last bracket match matched. $& returns the entire matched string. (At one point $0 did also, but now it returns the name of the program.) $` returns everything before the matched string. $' returns everything after the matched string. And $^N contains whatever was matched by the most-recently closed group (submatch). $^N can be used in extended patterns (see below), for example to assign a submatch to a variable.

These special variables, like the %+ hash and the numbered match variables ($1, $2, $3, etc.) are dynamically scoped until the end of the enclosing block or until the next successful match, whichever comes first. (See "Compound Statements" in perlsyn.)

The @{^CAPTURE} array may be used to access ALL of the capture buffers as an array without needing to know how many there are. For instance

$string=~/$pattern/ and @captured = @{^CAPTURE};
will place a copy of each capture variable, $1, $2 etc, into the @captured array.

Be aware that when interpolating a subscript of the @{^CAPTURE} array you must use demarcated curly brace notation:

print "@{^CAPTURE[0]}";
See "Demarcated variable names using braces" in perldata for more on this notation.

NOTE: Failed matches in Perl do not reset the match variables, which makes it easier to write code that tests for a series of more specific cases and remembers the best match.

WARNING: If your code is to run on Perl 5.16 or earlier, beware that once Perl sees that you need one of $&, $`, or $' anywhere in the program, it has to provide them for every pattern match. This may substantially slow your program.

Perl uses the same mechanism to produce $1, $2, etc, so you also pay a price for each pattern that contains capturing parentheses. (To avoid this cost while retaining the grouping behaviour, use the extended regular expression (?: ... ) instead.) But if you never use $&, $` or $', then patterns without capturing parentheses will not be penalized. So avoid $&, $', and $` if you can, but if you can't (and some algorithms really appreciate them), once you've used them once, use them at will, because you've already paid the price.

Perl 5.16 introduced a slightly more efficient mechanism that notes separately whether each of $`, $&, and $' have been seen, and thus may only need to copy part of the string. Perl 5.20 introduced a much more efficient copy-on-write mechanism which eliminates any slowdown.

As another workaround for this problem, Perl 5.10.0 introduced ${^PREMATCH}, ${^MATCH} and ${^POSTMATCH}, which are equivalent to $`, $& and $', except that they are only guaranteed to be defined after a successful match that was executed with the /p (preserve) modifier. The use of these variables incurs no global performance penalty, unlike their punctuation character equivalents, however at the trade-off that you have to tell perl when you want to use them. As of Perl 5.20, these three variables are equivalent to $`, $& and $', and /p is ignored.