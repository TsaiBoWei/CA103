package com.purchcour.model;

import java.sql.Date;



public class PurchCourTest {
	public static void main(String[] args){
		// add
//		   PurchCourVO purchcourVo=new PurchCourVO();
//		   purchcourVo.setCrorder_time(new Date(System.currentTimeMillis()));
//		   purchcourVo.setCour_id("COUR000002");
//		   purchcourVo.setMem_id("M000003");
//		   PurchCourDAO purchcourDao = new PurchCourDAO();
//		   purchcourDao.add(purchcourVo);

		//updateScore
//		   PurchCourDAO purchcourDao1 = new PurchCourDAO();
//		   purchcourDao1.updateScore(5,"CO000004");
//		   
		//updateScore
		   PurchCourDAO purchcourDao2 = new PurchCourDAO();
		   purchcourDao2.updateRefund("CO2","CO000003");
	}	
}
