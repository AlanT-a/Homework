package ������;
import javax.swing.JFrame;

public class Display extends JFrame {
    public Display(Calc c)
    {
        super("����������");
        this.setBounds(300,500,400,400);
        this.getContentPane().add(c);
        this.setVisible(true);
    }
    public static void main(String[] args) {
        new Display(new Calc());
    }
}