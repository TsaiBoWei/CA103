package com.coach.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import redis.clients.jedis.Jedis;



public class DiscountSave extends HttpServlet {
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String finaldiscount=req.getParameter("finaldiscount");
		String discountcour_id=req.getParameter("discountcour_id");
		String wholeworld=req.getParameter("wholeworld");
		String expiredateval=req.getParameter("expiredateval");
		
System.out.println("finaldiscount"+finaldiscount);
System.out.println("discountcour_id"+discountcour_id);
System.out.println("wholeworld"+wholeworld);
System.out.println("expiredateval"+expiredateval);
		
        Jedis jedis = new Jedis("localhost", 6379);
		jedis.auth("123456");
		
		String courdiscout="courdiscout:"+discountcour_id;
		jedis.hset(courdiscout, "finaldiscount", finaldiscount);
		jedis.hset(courdiscout, "discountcour_id",  discountcour_id);
		jedis.hset(courdiscout, "wholeworld",  wholeworld);
		jedis.hset(courdiscout, "expiredateval", expiredateval);
//		
        int expiretime = (Integer.parseInt(wholeworld))/1000;
//		
		jedis.expire(courdiscout, expiretime);
System.out.println("OKOK");
		jedis.close();
		
	}

}
