https://studio3t.com/whats-new/i-need-some-sample-datasets-for-mongodb-studio3t_ama/
https://www.mongodb.com/docs/atlas/sample-data/sample-mflix/

pushd ~/src/linux-utils/mongodb
wget https://raw.githubusercontent.com/mongodb/docsassets/primer-dataset/dataset.json

mongodump --archive
