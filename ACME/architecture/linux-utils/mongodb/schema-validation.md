https://www.mongodb.com/docs/manual/core/schema-validation/specify-json-schema/#std-label-schema-validation-json

db.createCollection("students", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         title: "Student Object Validation",
         required: [ "address", "major", "name", "year" ],
         properties: {
            name: {
               bsonType: "string",
               description: "'name' must be a string and is required"
            },
            year: {
               bsonType: "int",
               minimum: 2017,
               maximum: 3017,
               description: "'year' must be an integer in [ 2017, 3017 ] and is required"
            },
            gpa: {
               bsonType: [ "double" ],
               description: "'gpa' must be a double if the field exists"
            }
         }
      }
   }
} )

Confirm that the validation prevents invalid documents.
The following insert operation fails because gpa is an integer when the validator requires a double.

db.students.insertOne( {
   name: "Alice",
   year: Int32( 2019 ),
   major: "History",
   gpa: Int32(3),
   address: {
      city: "NYC",
      street: "33rd Street"
   }
} )

Insert a valid document.
The insert succeeds after you change the gpa field to a double:

db.students.insertOne( {
   name: "Alice",
   year: NumberInt(2019),
   major: "History",
   gpa: Double(3.0),
   address: {
      city: "NYC",
      street: "33rd Street"
   }
} )

4
Query for the valid document.
To confirm that the document was successfully inserted, query the students collection:

db.students.find()

Additional Information
You can combine JSON Schema validation with query operator validation.

For example, consider a sales collection with this schema validation:

db.createCollection{ "sales", {
  validator: {
    "$and": [
      // Validation with query operators
      {
        "$expr": {
          "$lt": ["$lineItems.discountedPrice", "$lineItems.price"]
        }
      },
      // Validation with JSON Schema
      {
        "$jsonSchema": {
          "properties": {
            "items": { "bsonType": "array" }
          }
        }
      }
    ]
  }
}