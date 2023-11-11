

https://www.tutorialspoint.com/How-to-run-Java-package-program
pushd ~/src/linux-utils/java/animals
/* File name : Animal.java */
package animals;
interface Animal {
   public void eat();
   public void travel();
}

package animals;
/* File name : MammalInt.java */
public class MammalInt implements Animal {
   public void eat() {
      System.out.println("Mammal eats");
   }
   public void travel() {
      System.out.println("Mammal travels");
   }
   public int noOfLegs() {
      return 0;
   }
   public static void main(String args[]) {
      MammalInt m = new MammalInt();
      m.eat();
      m.travel();
   }
}

Now compile the java files as shown below −

javac -d . Animal.java -cp ~/src/linux-utils/animals
javac -d . MammalInt.java -cp ~/src/linux-utils/animals

8. Run B.java
java -cp ~/src/linux-utils/animals animals/MammalInt
Mammal eats
Mammal travels