package com.plan.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eve.model.*;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.plan.model.*;
import com.eventlist.model.*;

@WebServlet("/PlanAndroidServlet")
public class PlanAndroidServlet extends HttpServlet {
	private String TAG = "PlanAndroidServlet";
	private final static String CONTENT_TYPE = "text/html; charset=UTF-8";

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, res);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		BufferedReader br = req.getReader();
		StringBuilder jsonIn = new StringBuilder();
		String line = null;
		
		while ( (line = br.readLine()) != null)
			jsonIn.append(line);
		
		System.out.println("task" + TAG +"input: " + jsonIn);
						
		List<PlanVO> planList = new ArrayList<PlanVO>();
		List<EventVO> eventList = new ArrayList<EventVO>();
		
		
		// 將得到的JSON input從 string 轉為JAVA 類別的JSON OBJECT
		JsonObject jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);
		
		String action = jsonObject.get("action").getAsString();
		String mem_id = jsonObject.get("mem_id").getAsString();

		
		if ( "get_plan_by_mem_id".equals(action) ) {
			PlanDAO plandao = new PlanDAO();
			planList = plandao.getPlansByMem(mem_id);
			for ( PlanVO vo : planList ) {
				vo.setPlan_cover(null);
			}
			writeText(res, gson.toJson(planList));
		}
		
		// 會員已加入的活動, 只需要取得其標題及日期即可
		if ("get_eve_by_mem_id".equals(action)) {
			EventlistService evelistser = new EventlistService();
			EveService eventService = new EveService();
			
			List<EventListVO> eventlistVOs = evelistser.getEveListsByMem(mem_id);
			List<EventVO> eventVOs = new ArrayList<EventVO>();
			
			for ( EventListVO vo : eventlistVOs ) {
				EventVO run = eventService.getOneEve(vo.getEve_id());
				if ( run != null ) {
					run.setEve_content("");
					run.setEve_photo(null);
					eventVOs.add(run);
				}
			}			
			writeText(res, gson.toJson(eventVOs));
		}
		
		if ("getImage".equals(action) ) {
			
		}
	}
		
	private void writeText(HttpServletResponse res, String outText) throws IOException {
		res.setContentType(CONTENT_TYPE);
		PrintWriter out = res.getWriter();
		out.print(outText);
		out.close();
		System.out.println("outText: " + outText);
	}

}
