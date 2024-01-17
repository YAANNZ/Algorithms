import java.util.Objects;

public class Person {
    private int age;
    private float height;
    private String name;
    private String address;

    public Person(int age, float height, String name, String address) {
        this.age = age;
        this.height = height;
        this.name = name;
        this.address = address;
    }

    public int hashCode() {
        int hash = Integer.hashCode(age);
        hash = 31 * hash + Float.hashCode(height);
        hash = 31 * hash + (name != null ? name.hashCode() : 0);
        return hash;
    }

    public boolean equals(Object obj) {
        if (obj == this) return true;
        if (obj == null || obj.getClass() != getClass()) return false;
        Person person = (Person) obj;
        return person.age == age &&
                person.height == height &&
                Objects.equals(person.name, name);
    }

}
