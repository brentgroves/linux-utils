https://learnxinyminutes.com/docs/yaml/

# |+ and >+ keeps trailing blank lines (also called literal/block "keep")
literal_keep: |+
  This entire block of text will be the value of the 'literal_block' key,
  with trailing blank line being kept.
literal_strip: |-
  This entire block of text will be the value of the 'literal_block' key,
  with trailing blank line being stripped.

https://stackoverflow.com/questions/46641224/what-is-and-in-yaml-mean
Well, those are elements of the YAML file format, which is used here to provide a configuration file for configtxgen. The "&" sign mean anchor and "*" reference to the anchor, this is basically used to avoid duplication, for example:

person: &person
    name: "John Doe"

employee: &employee
    << : *person
    salary : 5000
will reuse fields of person and has similar meaning as:

employee: &employee
    name   : "John Doe"
    salary : 5000
another example is simply reusing value:

key1: &key some very common value

key2: *key
equivalent to:

key1: some very common value

key2: some very common value