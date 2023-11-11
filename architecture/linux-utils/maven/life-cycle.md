https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html

A Build Lifecycle is Made Up of Phases
Each of these build lifecycles is defined by a different list of build phases, wherein a build phase represents a stage in the lifecycle.

For example, the default lifecycle comprises of the following phases (for a complete list of the lifecycle phases, refer to the Lifecycle Reference):

validate - validate the project is correct and all necessary information is available
compile - compile the source code of the project
test - test the compiled source code using a suitable unit testing framework. These tests should not require the code be packaged or deployed
package - take the compiled code and package it in its distributable format, such as a JAR.
verify - run any checks on results of integration tests to ensure quality criteria are met
install - install the package into the local repository, for use as a dependency in other projects locally
deploy - done in the build environment, copies the final package to the remote repository for sharing with other developers and projects.
These lifecycle phases (plus the other lifecycle phases not shown here) are executed sequentially to complete the default lifecycle. Given the lifecycle phases above, this means that when the default lifecycle is used, Maven will first validate the project, then will try to compile the sources, run those against the tests, package the binaries (e.g. jar), run integration tests against that package, verify the integration tests, install the verified package to the local repository, then deploy the installed package to a remote repository.

[top].

Usual Command Line Calls
You should select the phase that matches your outcome. If you want your jar, run package. If you want to run the unit tests, run test.

If you are uncertain what you want, the preferred phase to call is

mvn verify
This command executes each default lifecycle phase in order (validate, compile, package, etc.), before executing verify. You only need to call the last build phase to be executed, in this case, verify. In most cases the effect is the same as package. However, in case there are integration-tests, these will be executed as well. And during the verify phase some additional checks can be done, e.g. if your code written according to the predefined checkstyle rules.

In a build environment, use the following call to cleanly build and deploy artifacts into the shared repository.

mvn clean deploy
The same command can be used in a multi-module scenario (i.e. a project with one or more subprojects). Maven traverses into every subproject and executes clean, then executes deploy (including all of the prior build phase steps).

