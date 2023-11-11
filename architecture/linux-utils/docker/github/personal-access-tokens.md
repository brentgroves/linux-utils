https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token-classic

https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens

Managing your personal access tokens
In this article
About personal access tokens
Creating a fine-grained personal access token
Creating a personal access token (classic)
Deleting a personal access token
Using a personal access token on the command line
Further reading
You can use a personal access token in place of a password when authenticating to GitHub in the command line or with the API.

Personal access tokens are an alternative to using passwords for authentication to GitHub when using the GitHub API or the command line.

Personal access tokens are intended to access GitHub resources on behalf of yourself. To access resources on behalf of an organization, or for long-lived integrations, you should use a GitHub App. For more information, see "About creating GitHub Apps."

Types of personal access tokens
GitHub currently supports two types of personal access tokens: fine-grained personal access tokens and personal access tokens (classic). GitHub recommends that you use fine-grained personal access tokens instead of personal access tokens (classic) whenever possible.

Organization owners can set a policy to restrict the access of personal access tokens (classic) to their organization. For more information, see "Setting a personal access token policy for your organization."

Fine-grained personal access tokens
Fine-grained personal access tokens have several security advantages over personal access tokens (classic):

Each token can only access resources owned by a single user or organization.
Each token can only access specific repositories.
Each token is granted specific permissions, which offer more control than the scopes granted to personal access tokens (classic).
Each token must have an expiration date.
Organization owners can require approval for any fine-grained personal access tokens that can access resources in the organization.
Personal access tokens (classic)
Personal access tokens (classic) are less secure. However, some features currently will only work with personal access tokens (classic):

Only personal access tokens (classic) have write access for public repositories that are not owned by you or an organization that you are not a member of.
Outside collaborators can only use personal access tokens (classic) to access organization repositories that they are a collaborator on.
Some REST API operations are not available to fine-grained personal access tokens. For a list of REST API operations that are supported for fine-grained personal access tokens, see "Endpoints available for fine-grained personal access tokens".
If you choose to use a personal access token (classic), keep in mind that it will grant access to all repositories within the organizations that you have access to, as well as all personal repositories in your personal account.

As a security precaution, GitHub automatically removes personal access tokens that haven't been used in a year. To provide additional security, we highly recommend adding an expiration to your personal access tokens.

Keeping your personal access tokens secure
Personal access tokens are like passwords, and they share the same inherent security risks. Before creating a new personal access token, consider if there is a more secure method of authentication available to you:

To access GitHub from the command line, you can use GitHub CLI or Git Credential Manager instead of creating a personal access token.
When using a personal access token in a GitHub Actions workflow, consider whether you can use the built-in GITHUB_TOKEN instead. For more information, see "Automatic token authentication."

https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens