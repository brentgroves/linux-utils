https://qmacro.org/blog/posts/2022/05/30/reshaping-data-values-using-jq's-with_entries/

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

.common
| map(.value | split(">"))
| group_by(.[0])
| to_entries
| map({key: .value[0][0], value: .value|map(.[1])})

The expression passed to map is the object construction ({...}), creating objects each with two properties, key and value. The reason for staying with these property names will become clear shortly.

The value for key is expressed as .value[0][0], i.e. the first (zeroth) element of the inner array that is the first (zeroth) element of the array that is the value of the value property.


In other words, given the last object in the above most recent intermediate results:

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

Then .value[0][0] will return "topic" (specifically, the first instance of that string in the above JSON).

Similarly, to build the value for the new value property in the object being constructed, I used this expression: .value|map(.[1]). The current value of the value property is an array, so using map on that will produce another array. Of what? Well, of these values: .[1].

In other words, the second (index 1) value in each of the sub arrays. Given this same last object example above, .value|map(.[1]) produces ["abap-connectivity", "artificial-intelligence", "big-data"].

Running this latest iteration with the map function produces this:

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
Almost there!

