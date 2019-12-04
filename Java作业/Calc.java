package ������;
import java.awt.event.*;
import java.awt.*;
import javax.swing.*;

public class Calc extends JPanel implements ActionListener{
	//�������еİ�ť ��ʾ���� ��־����
	private JButton number[] = new JButton[10],operater[] = new JButton[10];
    private JTextField text;
    private JPanel temp[] = new JPanel[4];
    private String op[] = {"+","---","*","/","..","C","<--","ƽ��","����","="};
    private String num="",num2 = "";
    private int flag = 0;//���ڱ�ʶ��ǰ���ڽ��еĲ���
    public Calc()
    {
    	//���ò����Լ����ð�ť����������
        this.setLayout(new GridLayout(5, 1));
        text = new JTextField();
        this.add(text);
        text.setEditable(false);
        for(int i = 0;i < 4;i++)
        	temp[i] = new JPanel(new GridLayout(1,5));
		for(int j = 0;j <5;j++) {
			number[j] = new JButton(""+j);
			temp[0].add(number[j]);
			number[j].addActionListener(this);
			operater[j] = new JButton(op[j]);
			operater[j].addActionListener(this);
			temp[2].add(operater[j]);
		}
		for(int j = 5;j <10;j++) {
			number[j] = new JButton(""+j);
			number[j].addActionListener(this);
			temp[1].add(number[j]);
			operater[j] = new JButton(op[j]);
			operater[j].addActionListener(this);
			temp[3].add(operater[j]);
		}
        for(int i = 0;i < 4;i++)
        	this.add(temp[i]);
        this.setVisible(true);
    }
    //������ְ�ť����ʾ������ص��¼�
    public void actionPerformed(ActionEvent ev)
    {
    	for(int i = 0;i < 10;i++)
    	{
    		//����������ʱ
    		if(ev.getSource()==number[i])
    		{
    			if(flag==0) {
    				num = num +(""+i);
    				text.setText(num);
    			}
    			else if(flag==-1)
    			{
    				flag = 0;
    				num = ""+i;
    				text.setText(num);
    			}
    			else
    			{
    				num2 = num2+""+i;
    				text.setText(num2);
    			}
    		}
    	}
    	for(int i = 0;i < 4;i++) //�����˼Ӽ��˳����� �ñ�־�������б�ʶ
    		if(ev.getSource()==operater[i])
    			flag = i+1;
    	if(ev.getSource()==operater[4])//������С���� ��������ʱֻ����һ��
    	{
    		if(flag==0 ||flag==-1) {
    			if(num.indexOf('.')==-1) {
    				flag = 0;
					num = num +".";
					text.setText(num);
    			}
			}
			else
			{
				if(num2.indexOf('.')==-1) {
					num2 = num2 +".";
					text.setText(num2);
    			}
			}
    	}
    	if(ev.getSource()==operater[5]) //��յ�ǰ�����ַ�
    	{
    		if(flag==0 || flag == -1) {
	    		num = "0";
	    		flag = -1;
	    		text.setText(num);
    		}
    		else
    		{
    			num2 = "0";
	    		text.setText(num2);
    		}
    	}
    	if(ev.getSource()==operater[6])//���ݱ�ǵĲ�ͬÿ�η�������һ���ַ�
    	{
    		if((flag==0 || flag==-1)&&num.length()>0) {
    			flag = 0;
    			num = num.substring(0, num.length()-1);
    			if(num=="")
    				num = "0";
    			text.setText(num);
    		}
    		if(flag!=0 &&flag!=-1&&num2.length()>0) {
    			num2 = num2.substring(0, num2.length()-1);
    			if(num2=="")
    				num2 = "0";
    			text.setText(num2);
    		}
    	}
    	
    	if(ev.getSource()==operater[7]) //ƽ������
    	{
    		double rlt;
    		if(flag == 0 ||flag == -1)
    		{
    			if(flag==-1)	flag = 0;
    			rlt = Double.parseDouble(num);
    			num = String.format("%.4f", rlt*rlt);
    		}
    		else
    			rlt = Double.parseDouble(num2);
    		rlt = rlt*rlt;
			text.setText(String.format("%.4f", rlt));
    	}
    	if(ev.getSource()==operater[8])//��������
    	{
    		double rlt=0;
    		if(flag == 0 ||flag == -1)
    		{
    			if(flag==-1)	flag = 0;
    			rlt = Math.sqrt(Double.parseDouble(num));
    			num = String.format("%.4f", rlt);
    		}
    		else
    		{
    			rlt = Math.sqrt(Double.parseDouble(num2));
    			num2 = String.format("%.4f", rlt);
    		}
    		text.setText(String.format("%.4f", rlt));
    	}
    	int mark = 0;
    	if(ev.getSource()==operater[9]) //�����˵Ⱥ� ������ֵ����
    	{
    		if(flag!=-1 && flag!=0) {
	    		double n1 = Double.parseDouble(num);
	    		double n2 = Double.parseDouble(num2);
	    		double result = 0;
	    		if(flag==1)
	    			result = n1+n2;
	    		else if(flag==2)
	    			result = n1-n2;
	    		else if(flag==3)
	    			result = n1*n2;
	    		else if(flag==4) {
	    			try {//�������Ϊ0�Ĳ���
	    				if(n2==0)
	    					throw new Exception();
	    				else
	    					result = n1/n2;
	    			}
	    			catch (Exception e) {
						text.setText("0����������");
						mark = 1;
					}
	    		}
	    		//������Ϊ0�����߽��е�����������ʱ���еĲ���
	    		flag = -1;
	    		num2 = "";
	    		if(mark!=1) {//������Ϊ0
	    			num = String.format("%.4f", result);
	    			text.setText(num);
	    		}
	    		else//����Ϊ0
	    		{
	    			flag = 0;
	    			num = "0";
	    		}
    		} 		
    	}
    }
}