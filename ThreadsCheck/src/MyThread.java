import java.time.LocalDateTime;
import java.util.Date;

import static java.lang.Thread.sleep;

public class MyThread implements Runnable {
    private final int ttwMS = 10000;
    private final long stopAtMS = java.lang.System.currentTimeMillis() + ttwMS;
    private final Object sharedA;
    private final Object sharedB;
    private static final Date date;

    static {
        date = new Date();
    }

    public MyThread(Object sharedA, Object sharedB) {
        this.sharedA = sharedA;
        this.sharedB = sharedB;
    }

    private boolean continueToWork() {
        return (java.lang.System.currentTimeMillis() < stopAtMS);
    }

    private void printData() {
        System.out.println(LocalDateTime.now() + " " + this.toString());
    }

    @Override
    public void run() {
        while (continueToWork()) {
            synchronized (sharedA) {
                try {
                    sleep(100);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
                synchronized (sharedB) {
                    printData();
                }
            }
            try {
                sleep(1000);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }
    }

}
