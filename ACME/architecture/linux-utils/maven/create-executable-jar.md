# create the com.mobex.etl_lib jar
pushd ~/src/reports/volume/java/etl_lib
## remove everything in target directories
mvn clean
## run goal verify just past package and before install
mvn verify
## install jar and pom file into local .m2 repo
mvn install

# create the etl_lib test program
pushd ~/src/reports/volume/java/etl_test
<!-- https://stackoverflow.com/questions/574594/how-can-i-create-an-executable-runnable-jar-with-dependencies-using-maven -->
## create jar with dependancies
mvn clean compile assembly:single
## run the program
java -jar target/etl_test-1.0-SNAPSHOT-jar-with-dependencies.jar
