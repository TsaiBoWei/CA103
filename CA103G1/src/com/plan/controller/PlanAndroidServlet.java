package com.plan.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eve.model.EventVO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.plan.model.*;

@WebServlet("/PlanAndroidServlet")
public class PlanAndroidServlet extends HttpServlet {
	private String TAG = "PlanAndroidServlet";
	
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
		
		List<PlanVO> planList = new ArrayList<PlanVO>();
		List<EventVO> eventList = new ArrayList<EventVO>();
		
		String mem_id = req.getParameter("mem_id");
		
		PlanDAO plandao = new PlanDAO();
		planList = plandao.getPlansByMem(mem_id);
		
		
		super.doPost(req, res);
	}
	
	public class PlanAndroidVO {
		String plan_id;
		Timestamp plan_start_date;
		Timestamp plan_end_date;
		
		public PlanAndroidVO( String plan_id, Timestamp plan_start, Timestamp plan_end ) {
			this.plan_id = plan_id;
			this.plan_start_date = plan_start_date;
			this.plan_end_date = plan_end_date;
		}
	}
	
	public class EventAndroidVO {
		String eve_id;
		String eve_title;
		String eve_content;
		Timestamp eve_start_date;
		Timestamp eve_end_date;
		
		
		public EventAndroidVO( String eve_id, String eve_title, String event_content,
				Timestamp eve_start_date, Timestamp eve_end_date) {
			this.eve_id = eve_id;
			this.eve_title = eve_title;
			this.eve_content = event_content;
			this.eve_start_date = eve_start_date;
			this.eve_end_date = eve_end_date;
		}
		
	}	
	

}
