https://perldoc.perl.org/perlre
https://regex101.com/
^(.+\.php)(.*)$
^(.+\.php)(.*)$
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

You can dispense with numbers altogether and create named capture groups. The notation is (?<name>...) to declare and \g{name} to reference. 