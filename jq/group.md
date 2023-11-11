https://qmacro.org/blog/posts/2022/05/30/reshaping-data-values-using-jq's-with_entries/


Reshaping data values using jq's with_entries
[
  [
    "topic",
    "abap-connectivity"
  ],
  [
    "programming-tool",
    "abap-development"
  ],
  [
    "programming-tool",
    "abap-extensibility"
  ],
  [
    "operating-system",
    "android"
  ],
  [
    "topic",
    "artificial-intelligence"
  ],
  [
    "topic",
    "big-data"
]

Grouping by categories with group_by
The categories are the first values in each of the inner arrays, so next is to group the inner arrays by those categories:

.common
| map(.value | split(">"))
| group_by(.[0])
The .[0] supplied to group_by specifies that it's the first element of each inner array that should be the basis of grouping (i.e. the categories topic, programming-tool, programming-tool, etc).

This produces a differently shaped nesting of arrays, one for each of the categories:

[
  [
    [
      "operating-system",
      "android"
    ]
  ],
  [
    [
      "programming-tool",
      "abap-development"
    ],
    [
      "programming-tool",
      "abap-extensibility"
    ]
  ],
  [
    [
      "topic",
      "abap-connectivity"
    ],
    [
      "topic",
      "artificial-intelligence"
    ],
    [
      "topic",
      "big-data"
    ]
  ]
]

