https://www.mongodb.com/docs/mongodb-shell/crud/delete/
# open collection
use sample_mflix
# insert a document into the collection
db.movies.insertOne(
  {
    title: "The Favourite",
    genres: [ "Drama", "History" ],
    runtime: 121,
    rated: "R",
    year: 2018,
    directors: [ "Yorgos Lanthimos" ],
    cast: [ "Olivia Colman", "Emma Stone", "Rachel Weisz" ],
    type: "movie"
  }
)
# retrieve the document
db.movies.find( { title: "The Favourite" } )

# insert multiple documents
db.movies.insertMany([
   {
      title: "Jurassic World: Fallen Kingdom",
      genres: [ "Action", "Sci-Fi" ],
      runtime: 130,
      rated: "PG-13",
      year: 2018,
      directors: [ "J. A. Bayona" ],
      cast: [ "Chris Pratt", "Bryce Dallas Howard", "Rafe Spall" ],
      type: "movie"
    },
    {
      title: "Tag",
      genres: [ "Comedy", "Action" ],
      runtime: 105,
      rated: "R",
      year: 2018,
      directors: [ "Jeff Tomsic" ],
      cast: [ "Annabelle Wallis", "Jeremy Renner", "Jon Hamm" ],
      type: "movie"
    }
])

# retrieve all the documents in the collection
db.movies.find( {} )

# query examples
db.movies.find( { rated: { $in: [ "PG", "PG-13" ] } } )
db.movies.find( { countries: "Mexico", "imdb.rating": { $gte: 7 } } )

db.movies.find( {
     year: 2010,
     $or: [ { "awards.wins": { $gte: 5 } }, { genres: "Drama" } ]
} )

# db.account_period_balance.find( {} )
# db.account_period_balance.countDocuments()
# db.account_period_balance.dataSize()
# db.account_period_balance.find({}).limit(10)
# db.account_period_balance.find({}).skip(db.account_period_balance.countDocuments() - 10)
# db.account_period_balance.find({}, $orderby: {$natural : -1}})

# update documents
db.movies.updateOne( { title: "Tag" },
{
  $set: {
    plot: "One month every year, five highly competitive friends
           hit the ground running for a no-holds-barred game of tag"
  }
  { $currentDate: { lastUpdated: true } }
})

The update operation:

Uses the 
$set
 operator to update the value of the plot field for the movie Tag.

Uses the 
$currentDate
 operator to update the value of the lastUpdated field to the current date. If lastUpdated field does not exist, 
$currentDate
 will create the field. See 
$currentDate
 for details.


 To update all documents in the sample_airbnb.listingsAndReviews collection to update where security_deposit is less than 100:

use sample_airbnb
db.listingsAndReviews.updateMany(
  { security_deposit: { $lt: 100 } },
  {
    $set: { security_deposit: 100, minimum_nights: 1 }
  }
)

The update operation uses the 
$set
 operator to update the value of the security_deposit field to 100 and the value of the minimum_nights field to 1.


 Replace a Document
To replace the entire content of a document except for the _id field, pass an entirely new document as the second argument to 
db.collection.replaceOne()

When replacing a document, the replacement document must contain only field/value pairs. Do not include 
update operators
 expressions.

The replacement document can have different fields from the original document. In the replacement document, you can omit the _id field since the _id field is immutable; however, if you do include the _id field, it must have the same value as the current value.

To replace the first document from the sample_analytics.accounts collection where account_id: 371138:

db.accounts.replaceOne(
  { account_id: 371138 },
  { account_id: 893421, limit: 5000, products: [ "Investment", "Brokerage" ] }
)

db.accounts.findOne( { account_id: 893421 } )

More advanced updates
https://www.mongodb.com/docs/manual/tutorial/update-documents-with-aggregation-pipeline/

To delete all documents from the sample_mflix.movies collection:

use sample_mflix
db.movies.deleteMany({})

The method returns a document with the status of the operation. For more information and examples, see 
deleteMany()

Delete All Documents that Match a Condition
You can specify criteria, or filters, that identify the documents to delete. The 
filters
 use the same syntax as read operations.

To specify equality conditions, use <field>:<value> expressions in the query filter document.

To delete all documents that match a deletion criteria, pass a filter parameter to the 
deleteMany()
 method.

 To delete all documents from the sample_mflix.movies collection where the title equals "Titanic":

use sample_mflix
db.movies.deleteMany( { title: "Titanic" } )

The method returns a document with the status of the operation. For more information and examples, see 
deleteMany()

Delete Only One Document that Matches a Condition
To delete at most a single document that matches a specified filter (even though multiple documents may match the specified filter) use the 
db.collection.deleteOne()
 method.

EXAMPLE
To delete the first document from the sample_mflix.movies collection where the cast array contains "Brad Pitt":

use sample_mflix
db.movies.deleteOne( { cast: "Brad Pitt" } )

MongoDB preserves a natural sort order for documents. This ordering is an internal implementation feature, and you should not rely on any particular structure within it. To learn more, see 
natural order.