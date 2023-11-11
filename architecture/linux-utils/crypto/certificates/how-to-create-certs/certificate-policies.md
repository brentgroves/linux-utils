Certificate Policies.
This is a raw extension. All the fields of this extension can be set by using the appropriate syntax.

If you follow the PKIX recommendations and just using one OID then you just include the value of that OID. Multiple OIDs can be set separated by commas, for example:

 certificatePolicies= 1.2.4.5, 1.1.3.4
If you wish to include qualifiers then the policy OID and qualifiers need to be specified in a separate section: this is done by using the @section syntax instead of a literal OID value.

The section referred to must include the policy OID using the name policyIdentifier, cPSuri qualifiers can be included using the syntax:

 CPS.nnn=value
userNotice qualifiers can be set using the syntax:

 userNotice.nnn=@notice
The value of the userNotice qualifier is specified in the relevant section. This section can include explicitText, organization and noticeNumbers options. explicitText and organization are text strings, noticeNumbers is a comma separated list of numbers. The organization and noticeNumbers options (if included) must BOTH be present. If you use the userNotice option with IE5 then you need the 'ia5org' option at the top level to modify the encoding: otherwise it will not be interpreted properly.

Example:
https://www.openssl.org/docs/man1.0.2/man5/x509v3_config.html
 certificatePolicies=ia5org,1.2.3.4,1.5.6.7.8,@polsect

 [polsect]

 policyIdentifier = 1.3.5.8
 CPS.1="http://my.host.name/"
 CPS.2="http://my.your.name/"
 userNotice.1=@notice

 [notice]

 explicitText="Explicit Text Here"
 organization="Organisation Name"
 noticeNumbers=1,2,3,4
The ia5org option changes the type of the organization field. In RFC2459 it can only be of type DisplayText. In RFC3280 IA5Strring is also permissible. Some software (for example some versions of MSIE) may require ia5org.

Policy Constraints
This is a multi-valued extension which consisting of the names requireExplicitPolicy or inhibitPolicyMapping and a non negative intger value. At least one component must be present.

Example:

 policyConstraints = requireExplicitPolicy:3
Inhibit Any Policy
This is a string extension whose value must be a non negative integer.

Example:

 inhibitAnyPolicy = 2
Name Constraints
The name constraints extension is a multi-valued extension. The name should begin with the word permitted or excluded followed by a ;. The rest of the name and the value follows the syntax of subjectAltName except email:copy is not supported and the IP form should consist of an IP addresses and subnet mask separated by a /.

Examples:

 nameConstraints=permitted;IP:192.168.0.0/255.255.0.0

 nameConstraints=permitted;email:.somedomain.com

 nameConstraints=excluded;email:.com