https://dzone.com/articles/how-to-create-a-java-library-from-scratch-to-maven

Creating the Project
Run the following command on your terminal:

mvn archetype:generate -DgroupId=com.thegreatapi.demolibrary -DartifactId=demolibrary -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false

Note
Use your own group ID on the command. If you use com.thegreat.api.demolibraryyou won’t be able to publish to Maven Central.

If you’re not sure about what group ID to use, look at this article.

That command will create a project with the following pom.xml:


https://stackoverflow.com/questions/4955635/how-to-add-local-jar-files-to-a-maven-project

