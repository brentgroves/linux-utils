<https://docs.oracle.com/cd/E19253-01/816-4557/rbac-1/index.html#:~:text=Role%2Dbased%20access%20control%20(RBAC,superuser%20capabilities%20among%20several%20administrators>.

**![Solaris RBAC](https://docs.oracle.com/cd/E19253-01/816-4557/images/rbac.elems.gif)**

In RBAC, roles are assigned to users. When a user assumes a role, the capabilities of the role are available. Roles get their capabilities from rights profiles. Rights profiles can contain authorizations, privileged commands, and other supplementary rights profiles. Privileged commands are commands that execute with security attributes.

The following figure uses the Operator role, the Operator rights profile, and the Printer Management rights profile to demonstrate RBAC relationships.

**![RBAC example](https://docs.oracle.com/cd/E19253-01/816-4557/images/rbac.ex.gif)**

The Operator role is used to maintain printers and to perform media backup. The role is assigned to the user jdoe. jdoe can assume the role by switching to the role, and then supplying the role password.

The Operator rights profile has been assigned to the Operator role. The Operator rights profile contains two supplementary profiles, Printer Management and Media Backup. The supplementary profiles reflect the role's primary tasks.

The Printer Management rights profile is for managing printers, print daemons, and spoolers. Three authorizations are included in the Printer Management rights profile: solaris.admin.printer.read, solaris.admin.printer.delete, and solaris.admin.printer.modify. These authorizations enable roles and users to manipulate information in the printer queue. The Printer Management rights profile also includes a number of commands with security attributes, such as /usr/sbin/lpshut with euid=lp and /usr/ucb/lpq with euid=0.

## RBAC Authorizations

An authorization is a discrete right that can be granted to a role or to a user. Authorizations enforce policy at the user application level. Authorizations can be assigned directly to a role or to a user. Typically, authorizations are included in a rights profile. The rights profile is then included in a role, and the role is assigned to a user. For an example, see Figure 8–2.

RBAC-compliant applications can check a user's authorizations prior to granting access to the application or specific operations within the application. This check replaces the check in conventional UNIX applications for UID=0. For more information on authorizations, see the following sections:

## Authorization Naming and Delegation

An RBAC authorization is a discrete right that can be granted to a role or a user. Authorizations are checked by RBAC-compliant applications before a user gets access to the application or specific operations within the application. This check replaces the tests in conventional UNIX applications for UID=0.

What is UID=0
The user ID (UID) '0' is reserved for default root account. Root is the superuser account in Linux. It is a user account for administrative purposes, and typically has the highest access rights on the system. Configuring UID as '0' for other user account grants them root-level privileges.

Authorization Naming Conventions
An authorization has a name that is used internally and in files. For example, solaris.admin.usermgr.pswd is the name of an authorization. An authorization has a short description, which appears in the graphical user interfaces (GUIs). For example, Change Passwords is the description of the solaris.admin.usermgr.pswd authorization.

By convention, authorization names consist of the reverse order of the Internet name of the supplier, the subject area, any subareas, and the function. The parts of the authorization name are separated by dots. An example would be com.xyzcorp.device.access. Exceptions to this convention are the authorizations from Sun Microsystems, Inc., which use the prefix solaris instead of an Internet name. The naming convention enables administrators to apply authorizations in a hierarchical fashion. A wildcard (*) can represent any strings to the right of a dot.

Example of Authorization Granularity
As an example of how authorizations are used, consider the following: A user in the Operator role might be limited to the solaris.admin.usermgr.read authorization, which provides read but not write access to user configuration files. The System Administrator role naturally has the solaris.admin.usermgr.read and the solaris.admin.usermgr.write authorizations for making changes to user files. However, without the solaris.admin.usermgr.pswd authorization, the System Administrator cannot change passwords. The Primary Administrator has all three of these authorizations.

The solaris.admin.usermgr.pswd authorization is required to make password changes in the Solaris Management Console User tool. This authorization is also required for using the password modification options in the smuser, smmultiuser, and smrole commands.

Delegation Authority in Authorizations
An authorization that ends with the suffix grant enables a user or a role to delegate to other users any assigned authorizations that begin with the same prefix.

For example, a role with the authorizations solaris.admin.usermgr.grant and solaris.admin.usermgr.read can delegate the solaris.admin.usermgr.read authorization to another user. A role with the solaris.admin.usermgr.grant and solaris.admin.usermgr.* authorizations can delegate any of the authorizations with the solaris.admin.usermgr prefix to other users.

## auth_attr Database

All authorizations are stored in the auth_attr database. Authorizations can be assigned to users, to roles, or to rights profiles. The preferred method is to place authorizations in a rights profile, to include the profile in a role's list of profiles, and then to assign the role to a user.
The fields in the auth_attr database are separated by colons, as follows:
authname:res1:res2:short_desc:long_desc:attr

The fields have the following meanings:

authname
A unique character string that is used to identify the authorization in the format prefix.[suffix]. Authorizations for the Solaris OS use solaris as a prefix. All other authorizations should use a prefix that begins with the reverse-order Internet domain name of the organization that creates the authorization (for example, com.xyzcompany). The suffix indicates what is being authorized, which is typically the functional area and operation.

When the authname consists of a prefix and functional area and ends with a period, the authname serves as a heading to be used by applications in their GUIs. A two-part authname is not an actual authorization. The authname of solaris.printmgr. is an example of a heading.

When authname ends with the word “grant,” the authname serves as a grant authorization. A grant authorization enables the user to delegate to other users authorizations with the same prefix and functional area. The authname of solaris.printmgr.grant is an example of a grant authorization. solaris.printmgr.grant gives the user the right to delegate to other users such authorizations as solaris.printmgr.admin and solaris.printmgr.nobanner.

es1:res2
Reserved for future use.

short_desc
A short name for the authorization. This short name is suitable for display in user interfaces, such as in a scrolling list in a GUI.

long_desc
A long description. This field identifies the purpose of the authorization, the applications in which the authorization is used, and the type of user who might use the authorization. The long description can be displayed in the help text of an application.

attr
An optional list of semicolon-separated (;) key-value pairs that describe the attributes of an authorization. Zero or more keys can be specified.

The keyword help identifies a help file in HTML. Help files can be accessed from the index.html file in the /usr/lib/help/auths/locale/C directory.

The following example shows an auth_attr database with some typical values:

% grep printer /etc/security/auth_attr
solaris.admin.printer.:::Printer Information::help=AuthPrinterHeader.html
solaris.admin.printer.delete:::Delete Printer Information::help=AuthPrinterDelete.html
solaris.admin.printer.modify:::Update Printer Information::help=AuthPrinterModify.html
solaris.admin.printer.read:::View Printer Information::help=AuthPrinterRead.html

Note that solaris.admin.printer. is defined as a heading, because the authorization name ends in a dot (.). Headings are used by the GUIs to organize families of authorizations.

Commands That Require Authorizations
The following table provides examples of how authorizations are used to limit command options on a Solaris system. For more discussion of authorizations, see Authorization Naming and Delegation.

Man Page for Command - Authorization Requirements

at(1) - solaris.jobs.user required for all options (when neither at.allow nor at.deny files exist)
sendmail(1M) - solaris.mail required to access mail subsystem functions; solaris.mail.mailq required to view mail queue

Role-Based Access Control (Overview)
Role-based access control (RBAC) is a security feature for controlling user access to tasks that would normally be restricted to superuser. By applying security attributes to processes and to users, RBAC can divide up superuser capabilities among several administrators. Process rights management is implemented through privileges. User rights management is implemented through RBAC.

For a discussion of process rights management, see Privileges (Overview).

For information on RBAC tasks, see Chapter 9, Using Role-Based Access Control (Tasks).

For reference information, see Chapter 10, Role-Based Access Control (Reference).

RBAC: An Alternative to the Superuser Model
In conventional UNIX systems, the root user, also referred to as superuser, is all-powerful. Programs that run as root, or setuid programs, are all-powerful. The root user has the ability to read and write to any file, run all programs, and send kill signals to any process. Effectively, anyone who can become superuser can modify a site's firewall, alter the audit trail, read confidential records, and shut down the entire network. A setuid program that is hijacked can do anything on the system.

Role-based access control (RBAC) provides a more secure alternative to the all-or-nothing superuser model. With RBAC, you can enforce security policy at a more fine-grained level. RBAC uses the security principle of least privilege. Least privilege means that a user has precisely the amount of privilege that is necessary to perform a job. Ordinary users have enough privilege to use their applications, check the status of their jobs, print files, create new files, and so on. Capabilities beyond ordinary user capabilities are grouped into rights profiles. Users who are expected to do jobs that require some of the capabilities of superuser assume a role that includes the appropriate rights profile.

RBAC collects superuser capabilities into rights profiles. These rights profiles are assigned to special user accounts that are called roles. A user can then assume a role to do a job that requires some of superuser's capabilities. Predefined rights profiles are supplied with Solaris software. You create the roles and assign the profiles.

Rights profiles can provide broad capabilities. For example, the Primary Administrator rights profile is equivalent to superuser. Rights profiles can also be narrowly defined. For example, the Cron Management rights profile manages at and cron jobs. When you create roles, you can decide to create roles with broad capabilities, or roles with narrow capabilities, or both.

In the RBAC model, superuser creates one or more roles. The roles are based on rights profiles. Superuser then assigns the roles to users who are trusted to perform the tasks of the role. Users log in with their user name. After login, users assume roles that can run restricted administrative commands and graphical user interface (GUI) tools.

The flexibility in setting up roles enables a variety of security policies. Although no roles are shipped with the Solaris Operating System (Solaris OS), three recommended roles can easily be configured. The roles are based on rights profiles of the same name:

Primary Administrator – A powerful role that is equivalent to the root user, or superuser.

System Administrator – A less powerful role for administration that is not related to security. This role can manage file systems, mail, and software installation. However, this role cannot set passwords.

Operator – A junior administrator role for operations such as backups and printer management.

These three roles do not have to be implemented. Roles are a function of an organization's security needs. Roles can be set up for special-purpose administrators in areas such as security, networking, or firewall administration. Another strategy is to create a single powerful administrator role along with an advanced user role. The advanced user role would be for users who are permitted to fix portions of their own systems.

The superuser model and the RBAC model can co-exist. The following table summarizes the gradations from superuser to restricted ordinary user that are possible in the RBAC model. The table includes the administrative actions that can be tracked in both models. For a summary of the effect of privileges alone on a system, see Table 8–2.

Solaris RBAC Elements and Basic Concepts
The RBAC model in the Solaris OS introduces the following elements:

Authorization – A permission that enables a user or role to perform a class of actions that could affect security. For example, security policy at installation gives ordinary users the solaris.device.cdrw authorization. This authorization enables users to read and write to a CD-ROM device. For a list of authorizations, see the /etc/security/auth_attr file.

Privilege – A discrete right that can be granted to a command, a user, a role, or a system. Privileges enable a process to succeed. For example, the proc_exec privilege allows a process to call execve(). Ordinary users have basic privileges. To see your basic privileges, run the ppriv -vl basic command.

Security attributes – An attribute that enables a process to perform an operation. In a typical UNIX environment, a security attribute enables a process to perform an operation that is otherwise forbidden to ordinary users. For example, setuid and setgid programs have security attributes. In the RBAC model, operations that ordinary users perform might require security attributes. In addition to setuid and setgid programs, authorizations and privileges are also security attributes in the RBAC model. For example, a user with the solaris.device.allocate authorization can allocate a device for exclusive use. A process with the sys_time privilege can manipulate system time.

Privileged application – An application or command that can override system controls by checking for security attributes. In a typical UNIX environment and in the RBAC model, programs that use setuid and setgid are privileged applications. In the RBAC model, programs that require privileges or authorizations to succeed are also privileged applications. For more information, see Privileged Applications and RBAC.

Rights profile – A collection of administrative capabilities that can be assigned to a role or to a user. A rights profile can consist of authorizations, of commands with security attributes, and of other rights profiles. Rights profiles offer a convenient way to group security attributes.

Role – A special identity for running privileged applications. The special identity can be assumed by assigned users only. In a system that is run by roles, superuser is unnecessary. Superuser capabilities are distributed to different roles. For example, in a two-role system, security tasks would be handled by a security role. The second role would handle system administration tasks that are not security-related. Roles can be more fine-grained. For example, a system could include separate administrative roles for handling the cryptographic framework, printers, system time, file systems, and auditing.

The following figure shows how the RBAC elements work together.
