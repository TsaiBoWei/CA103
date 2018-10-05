package com.eve.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import com.eve.model.EveService;
import com.eve.model.EventVO;

/**
 * 瀏覽活動頁面 往下拉到底自動產生內容 Ajax傳送請求
 */
@WebServlet("/ScrollTest")
public class ScrollTest extends HttpServlet {


	    protected void processRequest(HttpServletRequest req,
	            HttpServletResponse res) throws ServletException, IOException {
	    	res.setContentType("text/html; charset=utf-8");
	    	PrintWriter out = res.getWriter();
	    	String indexStr=req.getParameter("index");
	    	int index=new Integer(indexStr);
//	    	System.out.println("index="+index);
	    	
	    	//每請求一次INDEX+1(在JSP內加1)  Controller以INDEX取出LIST內的VO 
        	//每次請求傳3個vo(以json格式)回去
        	//瀏覽活動頁面預設是呈現9個 因此傳送來的INDEX從3開始
	    
	        HttpSession session=req.getSession();
//	        System.out.println(session.getAttribute("listEves_ByCompositeQuery"));	 
	        EveService eveSvc=new EveService();
	        List<EventVO> list=(List<EventVO>)session.getAttribute("listEves_ByCompositeQuery");
	        if(list==null) {
    		 	list = eveSvc.getEvesInViewPage();		
	  
	        }
	       
	    	   
	    	   System.out.println(list.size());
		        try {
		        	JSONArray jarray=new JSONArray();
		        	//若list內的vo都取完 就不再取     			        	
		        	if((3*index+3)>=list.size()) {
		        		if(3*index==list.size()) {
		        			 out.print(jarray);
		        		}else {
		        			for(int i=3*index;i<list.size();i++) {
		        				System.out.println(i);
					        	EventVO eveVO=list.get(i);
					 	        JSONObject jobj=new JSONObject(eveVO);
					 	        jarray.put(jobj);
		        			}
		        			 out.print(jarray);
		        		}
		        		
		        		
		        	}else {
		        			
			            for (int i = 3*index; i < (3*index+3); i++) {
			            	
			            	System.out.println("i="+i);
				        	EventVO eveVO=list.get(i);
				 	        JSONObject jobj=new JSONObject(eveVO);
				 	        jarray.put(jobj);
			            }
			            out.print(jarray);
		        		
		        	}
		        	
		        } finally {
		            out.close();
		        }
	    	   
	
	     
	    }

	    @Override
	    protected void doGet(HttpServletRequest request,
	            HttpServletResponse response) throws ServletException, IOException {
	        processRequest(request, response);
	    }

	    @Override
	    protected void doPost(HttpServletRequest request,
	            HttpServletResponse response) throws ServletException, IOException {
	        processRequest(request, response);
	    }
	}