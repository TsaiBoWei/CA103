package com.plan.controller_undone;

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

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1021, maxRequestSize = 5 * 5 * 1024 * 1024)

public class PlanServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("insert".equals(action)) {
			System.out.println("test");
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

//			try {
			/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
//				String plan_name = req.getParameter("plan_name");
//				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
//				if (plan_name == null || plan_name.trim().length() == 0) {
//					errorMsgs.add("計畫名稱: 請勿空白");
//				}
//
//				java.sql.Date plan_create_date = null;
//				try {
//					plan_create_date = java.sql.Date.valueOf(req.getParameter("plan_create_date").trim());
//				} catch (IllegalArgumentException e) {
//					plan_create_date = new java.sql.Date(System.currentTimeMillis());
//					errorMsgs.add("請輸入日期!");
//				}

			PlanVO planVO = new PlanVO();
//				planVO.setMem_id(mem_id);
//				planVO.setPlan_name();
//				planVO.setPlan_vo(plan_vo);
//				planVO.setPlan_cover(plan_cover);
//				planVO.setPlan_start_date(plan_start_date);
//				planVO.setPlan_end_date(plan_end_date);
//				planVO.setSptype_id(sptype_id);
//				planVO.setPlan_view(plan_view);
//				planVO.setPlan_create_date(plan_create_date);
//				planVO.setPlan_privacy(plan_privacy);
//				planVO.setPlan_status(plan_status);
			System.out.println(req.getParameter("plan_name"));
			System.out.println(req.getParameter("plan_vo"));
//			System.out.println(req.getParameter("plan_cover").getBytes());
			System.out.println(req.getParameter("sptype_id"));
			System.out.println(req.getParameter("plan_privacy"));
			System.out.println(req.getParameter("plan_start_date"));
			System.out.println(req.getParameter("plan_end_date"));
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

			Part part = req.getPart("plan_cover");
			InputStream is = part.getInputStream();
			byte[] picture = new byte[is.available()];
			is.read(picture);

			Part plan_cover = req.getPart("plan_cover");
			plan_cover.getInputStream();
			System.out.println(plan_cover);
			PlanService planSvc = new PlanService();
//			planVO = planSvc.addPlan(req.getParameter("plan_name"), req.getParameter("plan_vo"), picture,
//					plan_start_date, plan_end_date, req.getParameter("sptype_id"), req.getParameter("plan_privacy"));

//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("empVO", empVO); // 含有輸入格式錯誤的empVO物件,也存入req
//					RequestDispatcher failureView = req.getRequestDispatcher("/emp/addEmp.jsp");
//					failureView.forward(req, res);
//					return;
//				}
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
//			}
		}

	}

}
