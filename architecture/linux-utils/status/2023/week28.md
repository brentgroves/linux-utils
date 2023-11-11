I love you my son and have a great plan for your life so please stay close to me and continue to ask me for directions all the time.
My son I am with you always please practice helping others and doing what is good. Remember I want you to give everything away that you have whether it is money, time, jobs, or abilities so try your best to server and help others with all that I give you.
# continue
https://rakyll.org/scheduler/
https://medium.com/the-godev-corner/how-to-create-a-go-private-module-with-docker-b705e4d195c4
https://phpforever.com/postgresql/crud-example-using-php-object-oriented-and-postgresql/
https://divrhino.com/articles/crud-go-fiber-docker-postgres/
git@github.com:brentgroves/go-trivia.git

Good morning dear ones,
I hope you all had a nice weekend and you and your families are doing well my friends.  As always, if I can be of help to you in any way please feel free to contact me day or night.

-Sincerely yours,
Bren 260-564-4868

# Big Picture
1. Coordinate a team effort to create reports and answer business questions using our k8s, reporting software, and databases. This includes validating our result sets to ensure they match what Plex shows on its reports and screens.  
2. Attempting to create a simple user interface for customers to manage longer-running reports such as the Trial Balance using Microsoft Teams tabs. This effort requires that our AKS ingress endpoints have certificates signed by a public CA, "Let's Encrypt" in our case.
3. Give the option to our report customers to encrypt reports containing sensitive data. To do this run a non-synchronizing OpenPGP key server using a Postgres SQL server to provide storage for customers' RSA public key.

# Slight reports system change
Customer requests report from Teams hosted PHP app which inserts request in queue and gets a report serial id.
Report runner pulls next request from queue
Runner needed because all ETL scripts need to be run before next report is ran
Runner calls Go Rest API to run ETL script set for report.
(Change) Go Rest API runs ETL script set and produces report set with given id.
MQTT used to notify web app status screen of completed reports.

# Java ETL 
I have created an com.mobex.etl library.  This library has a class factory for each ETL class which can be called from any main class. It uses the maven project management tool and is integrated into the reports dev container. The reason I have for setting up a ETL environment for Java is because there are a lot of Java programmers and this language has great database support.

# Go
**[Think in Go by Language Authors](https://go.dev/blog/io2010)**
In OOP your class inherits from another class or implements multiple interfaces and if a new interface is to be implemented you must always have control of that class.  In Go you can add an implementation of small interfaces to classes you do not control as often as you want. But in Go you can not add to the data type using inheritance.  If you want to add a new variable x to your data type then you need to add it to its structure you can't inherit it from a base class. Multiple inheritance can lead to deadlocks and is not allowed in some OOP languages so inheriting needed variables from just one base class was decided an unnecessary complication by the Go Authors.  After seeing all the examples that were given of how easy it was to refactor/change existing code to add more functionality after first release I was sold on leaving out class inheritance and focusing on adding small interfaces to existing data types instead.

Add simple interfaces to data types as needed without refactoring old code.
Created a private Go module using generics with a simple test that can be imported only by us from our private repository. 
## GoLang Notes
- Post OOP: GoLang does not support classes but achieves mostly the same results using functions with type constraints. For example, when you define a function you can specify what type it works with and if a type works with all the functions in an interface's method set we say that the type implements that interface. 
- Pointers with garbage collections. A routine check for C++ validators was to run programs to detect memory leaks.  With Go memory leaks are still possible but the languages built in garbage collection routines helps matters considerablly. 
# Dev Container
Whether the programmer knows Python, Java, or Go they will have an example with which to create report ETL scripts in our dev container.  They only need to install docker on there Windos, Mac, or Linux system and be given access to our Azure Dev Ops repository and Microsoft Teams to get started.
## status
- added vscode build tool extensions for Python, Java, Go, PHP, and docker.
- Test python debugging
- Test Java maven build and debugging
- Tested Go debugging
- Added PHP 8.2 

# Research Activity
## When to use NULL or an empty string in a SQL Server table
They both mean the same thing for example if the field is a customer company code and we don't have one we could insert a NULL or empty string.  There is differences when writing a report or creating a UI in what you test for so it is best to know the data that is in the table.  Does it have empty string? Does it have NULLs?  Once you know this info you can decide what kind of checks to put in your SQL for example:
1st look at all the distinct phone # and check for an empty string '' or the word NULL.
select distinct phone from employee order by phone
If your table only has NULL values: 
select * from employee 
where phone is null
If your table only has empty strings:
select * from employee 
where phone = ''
If your table has both NULLs and empty strings:
select * from employee 
where phone = '' or phone is NULL

**[NULL vs empty string](https://www.alibabacloud.com/blog/when-to-use-null-and-when-to-use-empty-string_598579#:~:text=The%20difference%20is%20that%20NULL,unique%20string%20with%20zero%20length.)**
"The difference is that NULL is used to refer to nothing. However, an empty string is used to point to a unique string with zero length

NULL works well when a UNIQUE field is set. For example, in this case, a phone number is optional. Since the phone number is a unique field, the user with no phone number will get added. However, it will throw an error of unique constraint if you use an empty string here. So, NULL is better."

## What are generics?
**[Generics programming](https://en.wikipedia.org/wiki/Generic_programming)**
"Generic programming is a style of computer programming in which algorithms are written in terms of data types to-be-specified-later that are then instantiated when needed for specific types provided as parameters."

### example of generics written in Go
type AllowedTypes interface {
	constraints.Ordered
}

func Filter[T AllowedTypes](slice1, slice2 []T) []T {
	combinedSlice := append(slice1, slice2...)
	temp := make(map[T]bool)
	var filtered []T
	for _, v := range combinedSlice {
		_, ok := temp[v]
		if !ok {
			temp[v] = true
			filtered = append(filtered, v)
		}
	}
	return filtered
}

# How to keep CNC operators
This is a list of reasons that CNC operators may choose to seek other employment.
1. Not having any control as to when you work.
+ A CNC operator who is forced to work 7 days or 12 hours a day is more apt to look for another job. Suggest limiting there work hours to 52 max and 1 day a week off unless they want to work more.
2. Broken air conditioner
+ If a person has to work in a hot section of the building he/she might not want to stay long.  Suggest that if the air conditioner is not working well tell them we are working on it and keep them supplied with pop sickles until it is fixed. 
3. No means of advancement or not desirable.
+ An operator could become a tool setter but the tool setter has less off time so not desireable.  Suggest more tool setters from operater promotions and rotating tool setter responsibility among a larger pool of tool setters.
