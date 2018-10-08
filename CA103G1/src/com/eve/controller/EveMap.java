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
import org.json.JSONException;
import org.json.JSONObject;

import com.eve.model.EveService;
import com.eve.model.EventVO;

/**
 * Servlet implementation class EveMap
 */
@WebServlet("/EveMap")
public class EveMap extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) 
													throws ServletException, IOException {
		res.setContentType("text/html; charset=utf-8");
    	PrintWriter out = res.getWriter();
    	 HttpSession session=req.getSession();
	        System.out.println(session.getAttribute("listEves_ByCompositeQuery"));	 
	        EveService eveSvc=new EveService();
	        List<EventVO> list=(List<EventVO>)session.getAttribute("listEves_ByCompositeQuery");
	        if(list==null) {
 		 	list = eveSvc.getEvesInViewPage();		
	  
	        }
	        
	        JSONArray jarray=new JSONArray();
	        for (int i = 0; i < list.size(); i++) {
	        	EventVO eveVO=list.get(i);
	 	        JSONObject jobj=new JSONObject();
	 	        try {
	 	        	jobj.put("eve_id", eveVO.getEve_id());
					jobj.put("eve_title", eveVO.getEve_title());
					jobj.put("eve_long", eveVO.getEve_long());
					jobj.put("eve_lat", eveVO.getEve_lat());
					jobj.put("sptype_id", eveVO.getSptype_id());
					jobj.put("city_id", eveVO.getCity_id());				
					jarray.put(jobj);
				} catch (JSONException e) {
					e.printStackTrace();
				}
   
            }
            out.print(jarray);
    		

	}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
													throws ServletException, IOException {
		doGet(req, res);
	}

}
