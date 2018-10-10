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
				String eve_id = req.getParameter("eve_idTochange"); //�q��ƾ䱵�L�Ӫ�eve_id
				String eve_chargeStr = req.getParameter("eve_chargeToback"); //�q��ƾ䱵�L�Ӫ�eve_charge �ΨӤ��몬�A�A�j��0�N�OEL3��L�OEL0
//				String mem_id = memVO.getMem_id();
				String mem_id = "M000001"; //���ΰ����
				String evelist_status=null;
				
				
//				EventListVO eventListVO =(EventListVO) eveListSvc.getOneEveList(mem_id, eve_id);
				Integer eve_charge=Integer.parseInt(eve_chargeStr);
				if(eve_charge>0){
					evelist_status = "EL4";
					
				}else {
					evelist_status = "EL9";
				};
			
				EventlistService eveListSvc = new EventlistService();
				/***************************2.�}�l�h�X����***************************************/	
				eveListSvc.changeEveListStatus(mem_id, eve_id, evelist_status);
				/***************************3.�h�X����,�ǳ����(Send the Success view)�^��ƾ䭶��*************/	
				String url = "/front_end/calendar/page/Calendar.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);
				
				
			}catch(Exception e) {
				String url = "/front_end/calendar/page/Calendar.jsp";
				errorMsgs.add("�h�X���ʥ���:" +e.getMessage());
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
				errorMsgs.add("�p�e�W��: �ФŪť�");
			} 
			
			Timestamp plan_start_date = null;
			try {
				String str= req.getParameter("plan_start_date").trim();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
				Date parsedDate = dateFormat.parse(str);
			 plan_start_date =  new Timestamp(parsedDate.getTime());
			}catch(IllegalArgumentException e) {
				errorMsgs.add("�п�J�p�e�}�l���!");
				};
				
			
				Timestamp plan_end_date = null;
			try {
				String str= req.getParameter("plan_end_date").trim();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
			    Date parsedDate = dateFormat.parse(str);
			    plan_end_date = new Timestamp(parsedDate.getTime());
				
				
			}catch(IllegalArgumentException e) {
				errorMsgs.add("�п�J�p�e�������!");
				
				};
			
	
			
			String plan_vo = req.getParameter("plan_vo").trim();
//			System.out.println("--------"+plan_vo+"-------");
			if (plan_vo == null || plan_vo.trim().length() == 0) {
				errorMsgs.add("�p�e���e�ФŪť�");
			}
			
			PlanVO planVO = new PlanVO();
			
			
			planVO.setPlan_name(plan_name);
			planVO.setPlan_vo(plan_vo);
			planVO.setPlan_start_date(plan_start_date);
			planVO.setPlan_end_date(plan_end_date);
			planVO.setPlan_id(plan_id);

			if (!errorMsgs.isEmpty()) {
				req.setAttribute("planVO", planVO); // �t����J�榡���~��empVO����,�]�s�Jreq
				String URL = "/front_end/calendar/page/Calendar.jsp";
				RequestDispatcher failureView = req
						.getRequestDispatcher(URL);
				failureView.forward(req, res);
				return; //�{�����_
			}
			
			/***************************2.�}�l�ק�p�e***************************************/
			
			PlanService planSvc = new PlanService();
			planVO=planSvc.updateInCal(plan_name, plan_vo, plan_start_date, plan_end_date, plan_id);
			
			String URL = "/front_end/calendar/page/Calendar.jsp";
			
			RequestDispatcher successView = req.getRequestDispatcher(URL); 
			successView.forward(req, res);		
				
				
			}catch(Exception e) {
				
				
				errorMsgs.add("�ק��ƥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/calendar/page/Calendar.jsp");
				failureView.forward(req, res);
			}
			
			
			
		}
		
		
	/**************************************�R���p�e********************************/
		String outPlan =  req.getParameter("outPlan");

		if("out_Plan".equals(outPlan)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs );
			
			try {
				String plan_id = req.getParameter("plan_idToDelete");
				String plan_status="PLANST2";
	

			
				
				
				PlanService planSvc = new PlanService();
	/***************************2.�}�l�R���p�e***************************************/	
				planSvc.changePlanStatusCal(plan_id,plan_status);

				
				
				String url = "/front_end/calendar/page/Calendar.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);
			}catch(Exception e) {
				
				String url = "/front_end/calendar/page/Calendar.jsp";
				
				errorMsgs.add("�R���p�e����:" +e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(url);
				failureView.forward(req, res);
				e.printStackTrace();
				
				return;
			};
		}
		
	}
}
