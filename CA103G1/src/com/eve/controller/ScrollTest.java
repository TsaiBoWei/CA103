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
 * �s�����ʭ��� ���U�Ԩ쩳�۰ʲ��ͤ��e Ajax�ǰe�ШD
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
	    	
	    	//�C�ШD�@��INDEX+1(�bJSP���[1)  Controller�HINDEX���XLIST����VO 
        	//�C���ШD��3��vo(�Hjson�榡)�^�h
        	//�s�����ʭ����w�]�O�e�{9�� �]���ǰe�Ӫ�INDEX�q3�}�l
	    
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
		        	//�Ylist����vo������ �N���A��     			        	
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