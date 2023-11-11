https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html

How to build your inventory
Ansible automates tasks on managed nodes or “hosts” in your infrastructure, using a list or group of lists known as inventory. You can pass host names at the command line, but most Ansible users create inventory files. Your inventory defines the managed nodes you automate, with groups so you can run automation tasks on multiple hosts at the same time. Once your inventory is defined, you use patterns to select the hosts or groups you want Ansible to run against.

The simplest inventory is a single file with a list of hosts and groups. The default location for this file is /etc/ansible/hosts. You can specify a different inventory file at the command line using the -i <path> option or in configuration using inventory.

Ansible Inventory plugins support a range of formats and sources to make your inventory flexible and customizable. As your inventory expands, you may need more than a single file to organize your hosts and groups. Here are three options beyond the /etc/ansible/hosts file: - You can create a directory with multiple inventory files. See Organizing inventory in a directory. These can use different formats (YAML, ini, and so on). - You can pull inventory dynamically. For example, you can use a dynamic inventory plugin to list resources in one or more cloud providers. See Working with dynamic inventory. - You can use multiple sources for inventory, including both dynamic inventory and static files. See Passing multiple inventory sources.

Inventory basics: formats, hosts, and groups
You can create your inventory file in one of many formats, depending on the inventory plugins you have. The most common formats are INI and YAML. A basic INI /etc/ansible/hosts might look like this:

mail.example.com

[webservers]
foo.example.com
bar.example.com

[dbservers]
one.example.com
two.example.com
three.example.com

The headings in brackets are group names, which are used in classifying hosts and deciding what hosts you are controlling at what times and for what purpose. Group names should follow the same guidelines as Creating valid variable names.

Here’s that same basic inventory file in YAML format:

all:
  hosts:
    mail.example.com:
  children:
    webservers:
      hosts:
        foo.example.com:
        bar.example.com:
    dbservers:
      hosts:
        one.example.com:
        two.example.com:
        three.example.com:

Default groups
Even if you do not define any groups in your inventory file, Ansible creates two default groups: all and ungrouped. The all group contains every host. The ungrouped group contains all hosts that don’t have another group aside from all. Every host will always belong to at least 2 groups (all and ungrouped or all and some other group). For example, in the basic inventory above, the host mail.example.com belongs to the all group and the ungrouped group; the host two.example.com belongs to the all group and the dbservers group. Though all and ungrouped are always present, they can be implicit and not appear in group listings like group_names.

Hosts in multiple groups
You can (and probably will) put each host in more than one group. For example a production webserver in a datacenter in Atlanta might be included in groups called [prod] and [atlanta] and [webservers]. You can create groups that track:

What - An application, stack or microservice (for example, database servers, web servers, and so on).

Where - A datacenter or region, to talk to local DNS, storage, and so on (for example, east, west).

When - The development stage, to avoid testing on production resources (for example, prod, test).

Extending the previous YAML inventory to include what, when, and where would look like this:

all:
  hosts:
    mail.example.com:
  children:
    webservers:
      hosts:
        foo.example.com:
        bar.example.com:
    dbservers:
      hosts:
        one.example.com:
        two.example.com:
        three.example.com:
    east:
      hosts:
        foo.example.com:
        one.example.com:
        two.example.com:
    west:
      hosts:
        bar.example.com:
        three.example.com:
    prod:
      hosts:
        foo.example.com:
        one.example.com:
        two.example.com:
    test:
      hosts:
        bar.example.com:
        three.example.com:

You can see that one.example.com exists in the dbservers, east, and prod groups.

Grouping groups: parent/child group relationships
You can create parent/child relationships among groups. Parent groups are also known as nested groups or groups of groups. For example, if all your production hosts are already in groups such as atlanta_prod and denver_prod, you can create a production group that includes those smaller groups. This approach reduces maintenance because you can add or remove hosts from the parent group by editing the child groups.

To create parent/child relationships for groups:

in INI format, use the :children suffix

in YAML format, use the children: entry

Here is the same inventory as shown above, simplified with parent groups for the prod and test groups. The two inventory files give you the same results:

all:
  hosts:
    mail.example.com:
  children:
    webservers:
      hosts:
        foo.example.com:
        bar.example.com:
    dbservers:
      hosts:
        one.example.com:
        two.example.com:
        three.example.com:
    east:
      hosts:
        foo.example.com:
        one.example.com:
        two.example.com:
    west:
      hosts:
        bar.example.com:
        three.example.com:
    prod:
      children:
        east:
    test:
      children:
        west:
Child groups have a couple of properties to note:

Any host that is member of a child group is automatically a member of the parent group.

Groups can have multiple parents and children, but not circular relationships.

Hosts can also be in multiple groups, but there will only be one instance of a host at runtime. Ansible merges the data from the multiple groups.

Adding ranges of hosts
If you have a lot of hosts with a similar pattern, you can add them as a range rather than listing each hostname separately:

In INI:

[webservers]
www[01:50].example.com
In YAML:

...
  webservers:
    hosts:
      www[01:50].example.com:
You can specify a stride (increments between sequence numbers) when defining a numeric range of hosts:

In INI:

[webservers]
www[01:50:2].example.com
In YAML:

...
  webservers:
    hosts:
      www[01:50:2].example.com:
The example above would make the subdomains www01, www03, www05, …, www49 match, but not www00, www02, www50 and so on, because the stride (increment) is 2 units each step.

For numeric patterns, leading zeros can be included or removed, as desired. Ranges are inclusive. You can also define alphabetic ranges:

[databases]
db-[a:f].example.com

