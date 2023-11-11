
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