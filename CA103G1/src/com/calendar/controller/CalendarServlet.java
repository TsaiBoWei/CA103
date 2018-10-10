package com.calendar.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;

import com.eve.model.*;
import com.eventlist.model.*;

import com.plan.model.*;
//import com.mem.model.*;


public class CalendarServlet extends HttpServlet{

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
//		HttpSession session = req.getSession();
//		MemVO memVO = (MemVO) session.getAttribute("memVO"); 
		String CaloutEvent = req.getParameter("CaloutEvent");
		
		if("Cal_out_event".equals(CaloutEvent)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs );
			
			
			try {
				String eve_id = req.getParameter("eve_idTochange"); //從行事曆接過來的eve_id
				String eve_chargeStr = req.getParameter("eve_chargeToback"); //從行事曆接過來的eve_charge 用來分辨狀態，大於0就是EL3其他是EL0
//				String mem_id = memVO.getMem_id();
				String mem_id = "M000001"; //先用假資料
				String evelist_status=null;
				
				
//				EventListVO eventListVO =(EventListVO) eveListSvc.getOneEveList(mem_id, eve_id);
				Integer eve_charge=Integer.parseInt(eve_chargeStr);
				if(eve_charge>0){
					evelist_status = "EL4";
					
				}else {
					evelist_status = "EL9";
				};
			
				EventlistService eveListSvc = new EventlistService();
				/***************************2.開始退出活動***************************************/	
				eveListSvc.changeEveListStatus(mem_id, eve_id, evelist_status);
				/***************************3.退出完成,準備轉交(Send the Success view)回行事曆頁面*************/	
				String url = "/front_end/calendar/page/Calendar.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);
				
				
			}catch(Exception e) {
				String url = "/front_end/calendar/page/Calendar.jsp";
				errorMsgs.add("退出活動失敗:" +e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(url);
				failureView.forward(req, res);
				e.printStackTrace();
				return;
			};
			
			
		}
		
		
		
		String CalChangePlan =  req.getParameter("CalChangePlan");
		if("Cal_Change_Plan".equals(CalChangePlan)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {	
			
			String plan_id = req.getParameter("plan_id").trim();
	
			String plan_name = req.getParameter("plan_name");
	
			if (plan_name == null || plan_name.trim().length() == 0) {
				errorMsgs.add("計畫名稱: 請勿空白");
			} 
			
			Timestamp plan_start_date = null;
			try {
				String str= req.getParameter("plan_start_date").trim();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
				Date parsedDate = dateFormat.parse(str);
			 plan_start_date =  new Timestamp(parsedDate.getTime());
			}catch(IllegalArgumentException e) {
				errorMsgs.add("請輸入計畫開始日期!");
				};
				
			
				Timestamp plan_end_date = null;
			try {
				String str= req.getParameter("plan_end_date").trim();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
			    Date parsedDate = dateFormat.parse(str);
			    plan_end_date = new Timestamp(parsedDate.getTime());
				
				
			}catch(IllegalArgumentException e) {
				errorMsgs.add("請輸入計畫結束日期!");
				
				};
			
	
			
			String plan_vo = req.getParameter("plan_vo").trim();
//			System.out.println("--------"+plan_vo+"-------");
			if (plan_vo == null || plan_vo.trim().length() == 0) {
				errorMsgs.add("計畫內容請勿空白");
			}
			
			PlanVO planVO = new PlanVO();
			
			
			planVO.setPlan_name(plan_name);
			planVO.setPlan_vo(plan_vo);
			planVO.setPlan_start_date(plan_start_date);
			planVO.setPlan_end_date(plan_end_date);
			planVO.setPlan_id(plan_id);

			if (!errorMsgs.isEmpty()) {
				req.setAttribute("planVO", planVO); // 含有輸入格式錯誤的empVO物件,也存入req
				String URL = "/front_end/calendar/page/Calendar.jsp";
				RequestDispatcher failureView = req
						.getRequestDispatcher(URL);
				failureView.forward(req, res);
				return; //程式中斷
			}
			
			/***************************2.開始修改計畫***************************************/
			
			PlanService planSvc = new PlanService();
			planVO=planSvc.updateInCal(plan_name, plan_vo, plan_start_date, plan_end_date, plan_id);
			
			String URL = "/front_end/calendar/page/Calendar.jsp";
			
			RequestDispatcher successView = req.getRequestDispatcher(URL); 
			successView.forward(req, res);		
				
				
			}catch(Exception e) {
				
				
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/calendar/page/Calendar.jsp");
				failureView.forward(req, res);
			}
			
			
			
		}
		
		
	/**************************************刪除計畫********************************/
		String outPlan =  req.getParameter("outPlan");

		if("out_Plan".equals(outPlan)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs );
			
			try {
				String plan_id = req.getParameter("plan_idToDelete");
				String plan_status="PLANST2";
	

			
				
				
				PlanService planSvc = new PlanService();
	/***************************2.開始刪除計畫***************************************/	
				planSvc.changePlanStatusCal(plan_id,plan_status);

				
				
				String url = "/front_end/calendar/page/Calendar.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);
			}catch(Exception e) {
				
				String url = "/front_end/calendar/page/Calendar.jsp";
				
				errorMsgs.add("刪除計畫失敗:" +e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(url);
				failureView.forward(req, res);
				e.printStackTrace();
				
				return;
			};
		}
		
	}
}
