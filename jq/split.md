https://qmacro.org/blog/posts/2022/05/30/reshaping-data-values-using-jq's-with_entries/


Reshaping data values using jq's with_entries

{
  "level": [
    {
      "name": "Beginner",
      "value": " tutorial>beginner"
    },
    {
      "name": "Intermediate",
      "value": " tutorial>intermediate"
    },
    {
      "name": "Advanced",
      "value": " tutorial>advanced"
    }
  ],
  "common": [
    {
      "name": "ABAP Connectivity",
      "value": "topic>abap-connectivity"
    },
    {
      "name": "ABAP Development",
      "value": "programming-tool>abap-development"
    },
    {
      "name": "ABAP Extensibility",
      "value": "programming-tool>abap-extensibility"
    },
    {
      "name": "Android",
      "value": "operating-system>android"
    },
    {
      "name": "Artificial Intelligence",
      "value": "topic>artificial-intelligence"
    },
    {
      "name": "Big Data",
      "value": "topic>big-data"
    }
  ]
}

Separating tags from categories with split
First, I used split to separate out the categories and tags by splitting on the > symbol in each of the values.


.common
| map(.value | split(">"))

This produces an array of arrays. The outer array is the result of running map (which takes an array and produces an array) and the inner arrays are the result of running split on each category>tag pattern in the value properties:

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