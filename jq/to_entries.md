https://qmacro.org/blog/posts/2022/05/30/reshaping-data-values-using-jq's-with_entries/

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


Getting from an array-based to an object-based structure with to_entries
As I wanted an object, with the keys being categories, and the values being arrays of tag strings, it felt right to reach for the to_entries function:

.common
| map(.value | split(">"))
| group_by(.[0])
| to_entries


This produced the following:

[
  {
    "key": 0,
    "value": [
      [
        "operating-system",
        "android"
      ]
    ]
  },
  {
    "key": 1,
    "value": [
      [
        "programming-tool",
        "abap-development"
      ],
      [
        "programming-tool",
        "abap-extensibility"
      ]
    ]
  },
  {
    "key": 2,
    "value": [
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
  }
]