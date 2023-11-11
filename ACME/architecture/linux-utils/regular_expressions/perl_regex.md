https://www.geeksforgeeks.org/perl-regex-cheat-sheet/#

Character classes are used to match the string of characters. These classes let the user match any range of characters, which user don’t know in advance.

Classes	Explanation
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


Anchors
Anchors do not match any character at all. Instead, they match a particular position as before, after, or between the characters.

Anchors	Explanation
^	It matches at the beginning of the string.
$	It matches at the end of the string.
\b	It matches at the word boundary of the string from \w to \W.
\A	It matches at the beginning of the string.
\Z	It matches at the ending of the string or before the newline.
\z	It matches only at the end of the string.
\G	It matches at the specified position pos().
\p{….}	Unicode character class like IsLower, IsAlpha etc.
\P{….}	Complement of Unicode character class
[:class:]	POSIX Character Classes like digit, lower, ascii etc.

Meta Characters
Metacharacters are used to match patterns in Perl regular expressions. All the metacharacters must be escaped.

Characters	Explanation
^	To check the beginning of the string.
$	To check the ending of the string.
.	Any character except newline.
*	Matches 0 or more times.
+	Matches 1 or more times.
?	Matches 0 or more times.
()	Used for grouping.
\	Use for quote or special characters.
[]	Used for set of characters.
{}	Used as repetition modifier.

Quantifiers
These are used to check for the special characters. There are three types of quantifiers

‘?’ It matches for 0 or 1 occurrence of character.
‘+’ It matches for 1 or more occurrence of character.
‘*’ It matches for 0 or more occurrence of character.
Using Quantifiers	Explanation
a?	It checks if ‘a’ occurs 0 or 1 time.
a+	It checks if ‘a’ occurs 1 or more time
a*	It checks if ‘a’ occurs 0 or more time
a{2, 6}	It checks if ‘a’ occurs 2 to 6 times
a{2, }	It checks if ‘a’ occurs 2 to infinite times
a{2}	It checks if ‘a’ occurs 2 time.

Modifiers
Modifiers	Explanation
\g	It is used to replace all the occurrence of string.
\gc	It allows continued search after \g match fails.
\s	It treats string as a single line.
i	It turns off the case sensitivity.
\x	It disregard all the white spaces.
(?#text)	It is used to add comment in the code.
(?:pattern)	It is used to match pattern of the non capturing group.
(?|pattern)	It is used to match pattern of the branch test.
(?=pattern)	It is used for positive look ahead assertion.
(?!pattern)	It is used for negative look ahead assertion.
(<=pattern)	It is used for positive look behind assertion.
(<!pattern)	It is used for negative look behind assertion.

White Space Modifiers
Modifiers	Explanation
\t	Used for inserting tab space
\r	Carriage return character
\n	Used for inserting new line.
\h	Used for inserting horizontal white space.
\v	Used for inserting vertical white space.
\L	Used for lowercase characters.
\U	Used for upper case characters.
Quantifiers – Modifiers
Maximal	Minimal	Explanation
?	??	It can occur 0 or 1 time
+	+?	It can occur 1 or more times.
*	*?	It can occur 0 or more times.
{3}	{3}?	Must match exactly 3 times.
{3, }	{3, }?	Must match at least 3 times.
{3, 7}	{3, 7}?	Must match at least 3 times but not more than 7 times.
Grouping and Capturing
Inside regex, these groups are referred by ‘\1’ and outside regex these groups are referred by ‘$1’. These groups can be fetched by variable assignment in list context is known as capture. The grouping construct (…) creates capture groups known as capture buffers.

Grouping and Capturing
Inside regex, these groups are referred by ‘\1’ and outside regex these groups are referred by ‘$1’. These groups can be fetched by variable assignment in list context is known as capture. The grouping construct (…) creates capture groups known as capture buffers.

(…)	These are used for grouping and capturing.
\1, \2, \3	During regex matching, these are used to capture buffers.
$1, $2, $3	During successful matching, these are used to capture variables.
(?:…)	These are used to group without capturing.(these neither set this $1 nor \1)