https://docs.oracle.com/javase/tutorial/deployment/jar/appman.html
https://www.dummies.com/article/technology/programming-web-design/java/how-to-use-the-javac-command-172116/
https://docs.oracle.com/javase/tutorial/deployment/jar/manifestindex.html
https://docs.oracle.com/javase/tutorial/deployment/jar/modman.html
https://www.tutorialspoint.com/How-to-run-Java-package-program
The basic command has this format:
jar cfm jar-file manifest-addition input-file(s)
Let's look at the options and arguments used in this command:
The c option indicates that you want to create a JAR file.
The m option indicates that you want to merge information from an existing file into the manifest file of the JAR file you're creating.
The f option indicates that you want the output to go to a file (the JAR file you're creating) rather than to standard output.
manifest-addition is the name (or path and name) of the existing text file whose contents you want to add to the contents of JAR file's manifest.
jar-file is the name that you want the resulting JAR file to have.
The input-file(s) argument is a space-separated list of one or more files that you want to be placed in your JAR file.
The m and f options must be in the same order as the corresponding arguments.


https://xperti.io/blogs/top-java-build-tools-and-continuous-integration-tools/
pushd ~/src/linux-utils/java/mobex/jdbc
# compile Cribmaster test
javac -d . JdbcCribmaster.java -cp ~/src/linux-utils/java/mobex/jdbc
# compile Toolboss test
javac -d . JdbcToolBoss.java -cp ~/src/linux-utils/java/mobex/jdbc
# compile Jtds test
javac -d . JdbcJtds.java -cp ~/src/linux-utils/java/mobex/jdbc
# compile MySqlDW test
javac -d . JdbcMySqlDW.java -cp ~/src/linux-utils/java/mobex/jdbc
# compile AzureDW test
javac -d . JdbcAzureDW.java -cp ~/src/linux-utils/java/mobex/jdbc
# compile ETL test
javac -d . JdbcRestrictionsToDW.java -cp ~/src/linux-utils/java/mobex/jdbc
# compile ToolList test
javac -d . JdbcToolListJtds.java -cp ~/src/linux-utils/java/mobex/jdbc

# compile Main 
http://www.henrikfrank.dk/abaptips/javaforsap/javabasics/calling_class_i_another_file.htm
javac -d . JdbcMain.java -cp ~/src/linux-utils/java/mobex/jdbc
# we can just run it
java -cp ./mssql-jdbc-11.2.0.jre11.jar:./jtds-1.3.1.jar:./mysql-connector-j-8.0.31.jar:. mobex.jdbc/JdbcMain
# or we can create a jar file to run
https://docs.oracle.com/javase/tutorial/deployment/jar/build.html
https://docs.oracle.com/javase/tutorial/deployment/jar/downman.html
jar cvfm JdbcMain.jar server-connection-manifest.txt mobex/jdbc/*.class
# run app from jar file
java -jar JdbcMain.jar

