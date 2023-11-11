Good morning my friends! 
I hope you all had a terific holiday or at least survived depending on if you enjoy this festive season or not.  First days back to work after a long break are difficult and here's to hoping each one of you adjust to work as easily as possible :-) The database story is included here after the status report.


- Sincerely yours
Brent

Database Story
The purpose of this story is to entertain and try to answer the question of why we need a PCN for different sites. Take this story with a grain of salt because I didn't spend any time on research! 
1. Cobol
In the 70's we used Cobol to create reports. What I remember is that you had to create 5 program divisions, the only one I remember is the procedure division. When I ran these reports some of the IT people would get anxious because they took a considerable amount of the Wang mini's resources.
Characteristics:
Data stored in flat files.
I don't remember how we linked data in different files but I believe we did.
Output reports on green and white paper.
2. Hiarchical databases
Our unisys, I think that was the name, mainframe had this software
Characteristics:
I believe the programmers decided it was a good idea to abstract files into tables and make a hiarchical way to store data.  
I imagine linking data from tables was easier than with Cobol but I never got a chance to create a report on this system since I worked in the Air Force Civil engineering squadran and not in the supply squadron. Colonol Abrams taught was the master of this database and he let us look at it in our database class but we didn't get to touch it.
3. SQL Server
There were some big improvements here.  The programmers decided that abstracting files into tables was still a good idea but this relating the data hiarchically did not fly so it was dropped in favor of a flat object based linking approach.  
Characteristics:
- Is now a full programming language with several popular dialects.
- relates tables using common fields.
- programming language very good at manipulating data sets to produce a final result set.
- A division for different geographical regions, in our case PCN, out of making more money and technical limitations.
4. Replicatable Database
With the advent of cloud computing and databases used by multiple geographical regions it became desirable to have a database the could have its data syncronized between multiple geographic regions. So when Harry updates the data in a table in Chicago Sally will see that update in her database in San Diego.
Characteristics:
- The programmers decided it was good to switch to objects, JSON, instead of storing data in tables linked by fields.
- Easier to add, remove, and update uniquely identified objects stored in multiple databases than replicating field linked tables.
- Some implementations use the JavaScript/ECMA scripting language to handle data set manipulations.
  

