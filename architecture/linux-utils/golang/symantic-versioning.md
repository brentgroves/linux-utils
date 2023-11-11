<https://www.digitalocean.com/community/tutorials/how-to-distribute-go-modules>

Using these rules allows Go to determine which version of a module to use when you run go get. As an example, suppose you have a project using version 1.4.3 of the module, github.com/your_github_username/pubmodule. If you depend on pubmodule being stable, you may only want to automatically upgrade the patch version (the .3). If you run the command go get -u=patch github.com/your_github_username/pubmodule, Go would see that you want to upgrade the patch version of the module and would only look for new versions with 1.4 as the major and minor part of the version.

When creating a new release of your module, it’s important to consider how the public API of your module has changed. Each part of a semantic version string conveys the scope of API change to both you and your users. These types of changes typically fall into three different categories, lining up with each component of the version. The smallest changes increase the patch version, medium-sized changes increase the minor version, and the largest changes increase the major version. Using these categories to determine which version number to increase will help you avoid breaking your own code and the code of anyone else who relies on your module.

Major Version Numbers
The first number in a SemVer version is the major version number (1.4.3). The major version number is the most important number to consider when releasing a new version of your module. A major version change is used to signal backward-incompatible changes to your public API. A backward-incompatible change would be any change in your module that would cause someone’s program to break if they upgraded without making any other changes. Breaking could mean anything from a failure to build because a function name has changed, or a change in how the library works that results in the same method returning "v1" instead of "1". This is only for your public API, though, meaning any exported types or methods someone else could use. If the version only includes improvements a user of your library would not notice, it doesn’t need a major version change. A way to remember which changes fit into this category might be that anything considered an “update” or a “delete” would be a major version increase.

Note: Unlike the other types of numbers in SemVer, the major version 0 has an additional special significance. The major version 0 is considered the “in development” version. Any SemVer with a major version 0 is not considered stable and anything can change in the API at any time. When you create a new module it’s best to start with major version 0 and only update minor and patch versions until you’ve finished initial development of your module. Once your module’s public API is done changing and considered stable for your users, it’s time to start with version 1.0.0.

Minor Version Numbers
The second number in a SemVer version is the minor version number (1.4.3). A minor version change is used to signal backward-compatible changes to your public API. A backward-compatible change would be any change that doesn’t affect code or projects currently using your module. Similar to the major version number, this only affects your public API. A way to remember which changes fit in this category might be anything considered an “addition”, but not an “update”.

Using the same example from the major version number, imagine you have a method named UserAddress that returns a string:

func UserAddress(username string) string {
 // return user address as a string
}
This time, though, instead of updating UserAddress to return *Address, you decide to add a completely new method named UserAddressDetail:

type Address struct {
 Address    string
 PostalCode string
}

func UserAddress(username string) string {
 // return user address as a string
}

func UserAddressDetail(username string) *Address {
 // return user address and postal code struct
}
Adding this new UserAddressDetail function doesn’t require changes by your users if they update to this version of your module, so it would be considered a minor version number increase. They can continue using UserAddress and would only need to update their code if they’d rather include the additional information from UserAddressDetail.

Public API changes likely aren’t the only time you’ll release a new version of your module, though. Bugs are an inevitable part of software development and the patch version number is there to cover up those holes.

Patch Version Numbers
The patch version number is the last number in a SemVer version (1.4.3). A patch version change is any change that doesn’t affect the module’s public API. Changes that don’t affect a module’s public API tend to be things like bug fixes or security fixes. Using the UserAddress function from the previous examples again, suppose a release of your module is missing part of an address in the string the function returns. If you release a new version of your module to fix that bug, it would only increase the patch version. The release wouldn’t include any changes to how a user uses the UserAddress public API, only the correctness of the data returned.

As you’ve seen in this section, carefully choosing a new version number is an important way to earn the trust of your users. Using semantic versioning shows users the amount of work required to update to a new version, and you won’t accidentally surprise them with an update that breaks their program. After considering the changes you’ve made to your module and determining the next version number to use, you can publish the new version and make it available to your users.

Publishing a New Module Version
Before you publish a new version of your module, you’ll need to update your module with the changes you’re planning to make. Without any changes, you won’t be able to determine which part of the semantic version to increase. For the module in this tutorial, you’ll add a new Goodbye method to complement the Hello method, and then you’ll publish that new version for users to use.

First, open the pubmodule.go file and add the new Goodbye method to your public API:

pubmodule/pubmodule.go
package pubmodule

func Hello() string {
  return "Hello, You!"
}

func Goodbye() string {
  return "Goodbye for now!"
}
Once you’ve saved your change, you’ll want to check which changes are expected to be committed by running git status:

git status
The output will look similar to this, showing that the only change in your module is the method you added to pubmodule.go:

Output
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
 modified:   pubmodule.go

no changes added to commit (use "git add" and/or "git commit -a")
Next, add the change to the staged files and commit the change to your local repository with git add and git commit:

git add .
git commit -m "Add Goodbye method"
The output will look similar to this:

Output
[main 3235010] Add Goodbye method
 1 file changed, 4 insertions(+)
After the changes are committed, you’ll need to push them to your GitHub repository. In a larger software project, or when working with other developers on a project, this step would commonly be slightly different. When doing development on a new feature, a developer would create a Git branch to put changes in until the new feature is stable and ready to be released. Once that happens, another developer would review the changes in the branch to add a second pair of eyes that might catch issues the first developer may have missed. Once the review is finished, the branch would then be merged into the default branch (such as master or main). Between releases, the default branch would accumulate these types of changes until it’s time to publish a new release.

Since your module here doesn’t go through this process, pushing the changes you’ve made to the repository will simulate the accumulation of changes instead:

git push
The output will look similar to this:

Output
numerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 369 bytes | 369.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To github.com:your_github_username/pubmodule.git
   931071d..3235010  main -> main
The output shows the new code is ready for users to use in the default branch.

Up to this point, everything you’ve done has been the same as initially publishing your module. However, now an important part of releasing a new version comes up: choosing a new version number.

If you look at the changes you’ve made to the module, the only change to the public API (or really any change) is adding the Goodbye method to your module. Since a user could update from the previous version, which only had the Hello function, without making changes on their part, this change would be a backward-compatible change. In semantic versioning, a backward-compatible change to the public API would mean an increase in the minor version number. This is the first version of your module being published, though, so there’s no previous version to increase. If you consider 0.0.0 to be “no version” then incrementing the minor version would lead you to version 0.1.0, the next version of your module.

Now that you have a version number to give to the release of your module, you can use it, paired with Git tags, to publish a new version. When developers use Git to keep track of their source code, even in languages other than Go, a common convention is to use Git’s tags to keep track of which code was released for a specific version. This way, if they ever need to make changes to an old version, they can use the tag. Since Go is already downloading modules from the source repositories, it takes advantage of this practice by using those same version tags.

To publish a new version of your own module using these tags, you will tag the code you’re releasing with the git tag command. As an argument to the git tag command, you’ll also need to provide the version tag. To create the version tag, start with the prefix v, for version, and add your SemVer immediately after it. In the case of your module, your final verison tag would be v0.1.0. Now, run git tag to tag your module with the version tag:

git tag v0.1.0

Once the version tag is added locally, you’ll still need to push the tag to your GitHub repository, which you can do using git push with origin:

git push origin v0.1.0
After the git push command succeeds, you’ll see that a new tag, v0.1.0, has been created:

Output
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
To github.com:your_github_username/pubmodule.git

* [new tag]         v0.1.0 -> v0.1.0
The output above shows that your tag has been pushed and your GitHub repository has a new v0.1.0 tag available for users of your module to reference.

Now that you’ve published a new version of your module with git tag, whenever a user runs go get to get the latest version of your module, it will no longer download a version based on the latest commit hash from the default branch. Once a module has a released version, the go tool will start using those versions to determine the best way to update the module. Paired with semantic versioning, this allows you to iterate and improve your modules while also providing your users with a consistent and stable experience.
