https://www.azurecitadel.com/cli/jmespath/

az ad group list --output table --query "[?securityEnabled].{name:displayName, description:description, objectId:objectId}"

Note the [?securityEnabled]. (You can also convert booleans to strings, e.g. [? to_string(securityEnabled) == 'true'].)
