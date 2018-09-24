package com.plan.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.plan.model.PlanService;
import com.plan.model.PlanVO;

import oracle.net.aso.e;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)

public class PlanServlet extends HttpServlet {

	public PlanServlet() {
		super();
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("insert".equals(action)) { // 來自Create_Plan.jsp的請求
			System.out.println("test");
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String plan_name = req.getParameter("plan_name");
				String plan_name_Reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (plan_name == null || plan_name.trim().length() == 0) {
					errorMsgs.add("Plan Name: Do Not Blank ");
				} else if (!plan_name.trim().matches(plan_name_Reg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("Plan Name: 只能是中、英文字母、數字和_ , 且長度必需在1到10之間");
				}

				java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
				java.util.Date du = null;
				try {
					du = df.parse(req.getParameter("plan_start_date"));
				} catch (ParseException e) {
					e.printStackTrace();
				}
				Timestamp plan_start_date = (new Timestamp(du.getTime()));
	
				java.util.Date du2 = null;
				try {
					du2 = df.parse(req.getParameter("plan_end_date"));
				} catch (ParseException e) {
					e.printStackTrace();
				}
				Timestamp plan_end_date = (new Timestamp(du2.getTime()));
				
				
				
				PlanVO planVO = new PlanVO();
				planVO.setPlan_name(plan_name);
//				planVO.setPlan_cover(plan_cover);
				planVO.setPlan_start_date(plan_start_date);
				planVO.setPlan_end_date(plan_end_date);
//				planVO.setSptype_id(sptype_id);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("planVO", planVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/plan/Create_Plan.jsp");
					failureView.forward(req, res);
					return;
				}

				PlanService planSvc = new PlanService();
//				planVO = planSvc.addPlan(mem_id, plan_name_Reg, plan_vo, plan_cover, plan_start_date, plan_end_date, sptype_id, plan_view, plan_privacy, plan_status) 
				
////				planVO.setPlan_vo(plan_vo);
////				planVO.setPlan_privacy(plan_privacy);
//			
//
//			Part part = req.getPart("plan_cover");
//			InputStream is = part.getInputStream();
//			byte[] picture = new byte[is.available()];
//			is.read(picture);
//
//			Part plan_cover = req.getPart("plan_cover");
//			plan_cover.getInputStream();
//			System.out.println(plan_cover);
//			PlanService planSvc = new PlanService();
//			planVO = planSvc.addPlan(plan_name, req.getParameter("plan_vo"), picture,
//					plan_start_date, plan_end_date, req.getParameter("sptype_id"), req.getParameter("plan_privacy"));

//				
//
//				/*************************** 2.開始新增資料 ***************************************/
//				PlanService planSvc = new PlanService();
//				planVO = planSvc.addPlan(mem_id, plan_name, plan_vo, plan_cover, plan_start_date, plan_end_date,
//						sptype_id, plan_view, plan_privacy, plan_status);
//
//				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
//				String url = "/emp/listAllEmp.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
//				successView.forward(req, res);
//
//				/*************************** 其他可能的錯誤處理 **********************************/
//			} catch (Exception e) {
//				errorMsgs.add(e.getMessage());
//				RequestDispatcher failureView = req.getRequestDispatcher("/emp/addEmp.jsp");
//				failureView.forward(req, res);

			} catch (Throwable s) {
			}
		}

	}

}
