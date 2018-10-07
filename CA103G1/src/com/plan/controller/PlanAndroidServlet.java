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
import com.plan.model.*;

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
		
		System.out.println("input: " + jsonIn);
		
		List<PlanVO> planList = new ArrayList<PlanVO>();
		List<EventVO> eventList = new ArrayList<EventVO>();
		
		String action = req.getParameter("action");
		String mem_id = req.getParameter("mem_id");
		
		if ( "get_plan_by_mem_id".equals(action) ) {
			PlanDAO plandao = new PlanDAO();
			planList = plandao.getPlansByMem(mem_id);
			writeText(res, gson.toJson(planList));
		}
		
		if ("get_eve_by_mem_id".equals(action)) {
			EveService eveserv = new EveService();
			eventList = eveserv.getEvesByMem(mem_id);
			writeText(res, gson.toJson(eventList));
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