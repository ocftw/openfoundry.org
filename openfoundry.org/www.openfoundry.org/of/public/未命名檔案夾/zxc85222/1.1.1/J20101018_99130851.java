package test.test;
/**
 * @(#)J20101018_99130851.java
 *
 *
 * @author
 * @version 1.00 2010/10/18
 */

public class J20101018_99130851 {

    /**
     * Creates a new instance of <code>J20101018_99130851</code>.
     */
    public J20101018_99130851() {
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        int i,sum=0;
        for(i=1;i<=10;i++)
        {
        sum+=i;
        }
        System.out.println("1+2+...+10="+sum);




        do
        {
        sum+=i;
        i++;
        }



        while(i<=10);
        {
        sum+=i;
        i++;
        }
        System.out.println("1+2+3+4+5+6+7+8+9+10="+sum);
        System.out.println("1+2++3+4+5+...+9+10="+sum);




    }
}
