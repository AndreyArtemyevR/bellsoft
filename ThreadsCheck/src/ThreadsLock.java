
public class ThreadsLock {
    public static void main(String[] args) {
        boolean avoidDeadlock = Boolean.parseBoolean(System.getenv("noLock"));
        System.out.println("Avoid deadlock setting: " + avoidDeadlock);
        Object objA = new Object();
        Object objB = new Object();
        Thread threadA = new Thread(new MyThread(objA, objB));
        Thread threadB = new Thread(avoidDeadlock?new MyThread(objA, objB):new MyThread(objB, objA));
        threadA.start();
        threadB.start();
    }
}