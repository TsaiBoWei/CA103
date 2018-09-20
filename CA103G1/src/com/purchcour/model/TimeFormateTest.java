package com.purchcour.model;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Locale;

public class TimeFormateTest {
	public static void main(String[] args){
		// add
		   PurchCourVO purchcourVO=new PurchCourVO();
		   Calendar calendar = Calendar.getInstance();
		
		   
		   System.out.println(new Date(System.currentTimeMillis()));
		   
		   SimpleDateFormat sdf = new SimpleDateFormat("EEE, MMM d, ''yy", Locale.US); 
		                                             //"EEE, MMM d, ''yy"
	       System.out.println(sdf.format(new Date(System.currentTimeMillis())));
	                                              //public static long currentTimeMillis()
	       
///////////////
	       
//	       Timestamp ts= tsVO.getCol_timestamp();
//	       cal.setTime(ts);

	       Calendar myCal = new GregorianCalendar();
	       
	       myCal.setTimeInMillis(System.currentTimeMillis());
           
	      
	       
	       System.out.println("Day: " + myCal.get(Calendar.DAY_OF_MONTH));
	       System.out.println("Month: "+myCal.get(Calendar.MONTH)+1);
	       System.out.println("Year: " + myCal.get(Calendar.YEAR));

	}

}
