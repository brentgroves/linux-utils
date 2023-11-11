https://qmacro.org/blog/posts/2022/05/30/reshaping-data-values-using-jq's-with_entries/


Creating a neat structure with from_entries
According to the manual, the to_entries and from_entries "convert between an object and array of key-value pairs". In each case, the name for the key and value properties are key and value respectively. I had an inkling I would probably want to use from_entries at some stage, and this is the reason why I kept the names of the properties earlier.

[
  {
    "key": "operating-system",
    "value": [
      "android"
    ]
  },
  {
    "key": "programming-tool",
    "value": [
      "abap-development",
      "abap-extensibility"
    ]
  },
  {
    "key": "topic",
    "value": [
      "abap-connectivity",
      "artificial-intelligence",
      "big-data"
    ]
  }
]

Let's have a look what passing the above structure into from_entries produces:

Creating a neat structure with from_entries
According to the manual, the to_entries and from_entries "convert between an object and array of key-value pairs". In each case, the name for the key and value properties are key and value respectively. I had an inkling I would probably want to use from_entries at some stage, and this is the reason why I kept the names of the properties earlier.

Let's have a look what passing the above structure into from_entries produces:

.common
| map(.value | split(">"))
| group_by(.[0])
| to_entries
| map({key: .value[0][0], value: .value|map(.[1])})
| from_entries
It's this:

{
  "operating-system": [
    "android"
  ],
  "programming-tool": [
    "abap-development",
    "abap-extensibility"
  ],
  "topic": [
    "abap-connectivity",
    "artificial-intelligence",
    "big-data"
  ]
}

