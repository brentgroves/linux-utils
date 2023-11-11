https://github.com/apache/maven/blob/trunk/maven-model-builder/src/main/resources/org/apache/maven/model/pom-4.0.0.xml#L53
mvn help:effective-pom
https://stackoverflow.com/questions/13354531/maven-project-build-directory

  <build>
    <directory>${project.basedir}/target</directory>
    <outputDirectory>${project.build.directory}/classes</outputDirectory>
    <finalName>${project.artifactId}-${project.version}</finalName>
    <testOutputDirectory>${project.build.directory}/test-classes</testOutputDirectory>
    <sourceDirectory>${project.basedir}/src/main/java</sourceDirectory>
    <scriptSourceDirectory>src/main/scripts</scriptSourceDirectory>
    <testSourceDirectory>${project.basedir}/src/test/java</testSourceDirectory>
