https://www.pcre.org/
The PCRE library supports named captures using the following syntax:

?<name>	Perl 5.10 compatible syntax, supported since PCRE-7.0
?'name'	Perl 5.10 compatible syntax, supported since PCRE-7.0
?P<name>	Python compatible syntax, supported since PCRE-4.0

Regular Expressions:
A PCRE regular expression library is used by Nginx to match URI so network traffic can be manipulated and routed as needed. In order to understand the regular expression protocol better I thought it was a good idea to take some time to study its usage. 
[Perl Compatible Regular Expressions](https://en.wikipedia.org/wiki/Perl_Compatible_Regular_Expressions#:~:text=Perl%20Compatible%20Regular%20Expressions%20(PCRE,writing%20PCRE%20in%20summer%201997.):
'''
Perl Compatible Regular Expressions (PCRE) is a library written in C, which implements a regular expression engine, inspired by the capabilities of the Perl programming language. Philip Hazel started writing PCRE in summer 1997.[3] PCRE's syntax is much more powerful and flexible than either of the POSIX regular expression flavors (BRE, ERE)[4] and than that of many other regular-expression libraries.

While PCRE originally aimed at feature-equivalence with Perl, the two implementations are not fully equivalent. During the PCRE 7.x and Perl 5.9.x phase, the two projects coordinated development, with features being ported between them in both directions.[5]
'''
[Creates nginx configuration files from a given URI](https://www.nginx.com/blog/regular-expression-tester-nginx/)
[docker image for nginx regular expression testor](https://github.com/nginxinc/NGINX-Demos/tree/master/nginx-regex-tester)
[nginx location testor](https://nginx.viraptor.info/)
[another regex site](https://regex101.com/)
[generic testor for specific use cases](https://www.regextester.com/94055)
[Regular expression syntax summary](http://www.greenend.org.uk/rjk/tech/regexp.html)
[Comparison of regular expression engines](https://en.wikipedia.org/wiki/Comparison_of_regular_expression_engines)
[Online tool to evaluate a regular expression by language](https://www.regexplanet.com/)
- Nginx uses PCRE.
