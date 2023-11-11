Overview

jTDS is an open source 100% pure Java (type 4) JDBC 3.0 driver for Microsoft SQL Server (6.5, 7, 2000, 2005, 2008 and 2012) and Sybase Adaptive Server Enterprise (10, 11, 12 and 15). jTDS is based on FreeTDS and is currently the fastest production-ready JDBC driver for SQL Server and Sybase ASE. jTDS is 100% JDBC 3.0 compatible, supporting forward-only and scrollable/updateable ResultSets, concurrent (completely independent) Statements and implementing all the DatabaseMetaData and ResultSetMetaData methods. Check out the feature matrix for more details.

Quite a few of the commercial JDBC drivers out there are based on jTDS (or FreeTDS), even if they no longer acknowledge this. jTDS has been tested with virtually all JDBC-based database management tools and is the driver of choice for most of these (recommended for DbVisualizer and SQuirreL SQL, distributed with Aqua Data Studio and DataDino). jTDS is also becoming a common choice for enterprise-level applications: it passes both the J2EE 1.3 certification and Hibernate test suites, and is recommended for JBoss, Hibernate, Atlassian JIRA and Confluence and Compiere.

Getting Started

Being a type 4 driver, jTDS does not need any special installation. Just drop the jar file into your application's classpath and you're done. All you need to know is the name of the Driver and DataSource implementations and the URL format and you're all set. You can get these and a lot more information from the Frequently Asked Questions page. For features needing native libraries such as XA support or Single-Sign-On consult the specific README files.

