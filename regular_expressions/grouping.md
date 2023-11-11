Grouping and Capturing
Inside regex, these groups are referred by ‘\1’ and outside regex these groups are referred by ‘$1’. These groups can be fetched by variable assignment in list context is known as capture. The grouping construct (…) creates capture groups known as capture buffers.

(…)	These are used for grouping and capturing.
\1, \2, \3	During regex matching, these are used to capture buffers.
$1, $2, $3	During successful matching, these are used to capture variables.
(?:…)	These are used to group without capturing.(these neither set this $1 nor \1)