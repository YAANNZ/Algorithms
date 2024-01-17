// Press Shift twice to open the Search Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class Main {
    public static void main(String[] args) {


        String string = "jack";
        System.out.println(string.hashCode());

        Person p1 = new Person(12,1.6f,"jack","beijing");
        Person p2 = new Person(12,1.6f,"jack","shanghai");
        System.out.println(p1.hashCode());
        System.out.println(p2.hashCode());
        System.out.println(p1.equals(p2));
    }
}