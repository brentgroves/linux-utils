https://www.mongodb.com/docs/mongodb-shell/run-agg-pipelines/

You can run 
aggregation pipelines
 on your collections using the MongoDB Shell. Aggregation pipelines transform your documents into aggregated results based on selected 
pipeline stages.

Common uses for aggregation include:

Grouping data by a given expression.

Calculating results based on multiple fields and storing those results in a new field.

Filtering data to return a subset that matches a given criteria.

Sorting data.

When you run an aggregation, MongoDB Shell outputs the results directly to the terminal.

Understand the Aggregation Syntax
The MongoDB aggregation pipeline consists of 
stages
. Each stage transforms the documents as they pass through the pipeline. Pipeline stages do not need to produce one output document for every input document; e.g., some stages may generate new documents or filter out documents.

To create an aggregation pipeline, use the following syntax in the MongoDB Shell:

db.<collection>.aggregate([
  {
    <$stage1>
  },
  {
    <$stage2>
  }
  ...
])

Example
The examples on this page reference the Atlas 
sample dataset
. You can create a free Atlas cluster and populate that cluster with sample data to follow along with these examples. To learn more, see 
Get Started with Atlas.

The example below uses the movies collection in the Atlas 
sample_mflix
 sample dataset.

Example Document
Each document in the movies collection describes a movie: