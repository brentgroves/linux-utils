pushd ~/src/linux-utils/java-tutorial

1. Use notepad to create A class - Save the file as A.java

package util;

public class A {
public int add(int x, int y){
return (x + y);
}
}



2. Use notepad to create B class - Save file as B.java

import util.A;

public class B {
public static void main(String args[]){
A a = new A();
System.out.println("Result: " + a.add(3, 5));
}
}



3. Place the A.java and B.java in a directory on yout classpath (In this example c:\jar)

4. Compile A.java package

javac A.java -classpath c:\jar
javac A.java -classpath ~/src/linux-utils/java-tutorial
javac -d . A.java -classpath ~/src/linux-utils/java-tutorial


5. Create a new subdirectoy under the current directory named util

Note that it is important to give the subdirectory exactly the same name as the utillity package (See A.java)

6. Move A.class to the util subdirectory

7. Compile B.java
javac B.java -classpath ~/src/linux-utils/java-tutorial


8. Run B.java

java -cp c:\jar B
java -cp ~/src/linux-utils/java-tutorial B
- Result: 8