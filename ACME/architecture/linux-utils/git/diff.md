<https://refine.dev/blog/git-diff-command/#compare-using-commit-hashany-specific-commits>

# diff

## compare 2 commits

Let's assume we are going to compare these two commits [hashes above in 1 & 2]. We will execute the following command:

git diff 21d752987e7f507494439a599a02a105039b4125 60b1649d99710436fb56991b1120736d5e33c63e

git log --pretty=oneline

7bbf9b0c3efdac3e29e42fbfa49674f4fc4b65ac

2ce11604f96c11f64fc4d3188ef892d16617dbf4

## Compare Using Head (Last two commits)

If you want to find the differences between the two most recent commits, you will use the following command:

Syntax: git diff HEAD HEAD~1
