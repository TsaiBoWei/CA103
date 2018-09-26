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
import javax.servlet.http.HttpSession;
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
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/

				// mem_id
				HttpSession session = req.getSession();
				String mem_id = (String) session.getAttribute("mem_id");

				// plan_name
				String plan_name = req.getParameter("plan_name");
				String plan_name_Reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (plan_name == null || plan_name.trim().length() == 0) {
					errorMsgs.add("Plan Name: Do Not Blank ");
				} else if (!plan_name.trim().matches(plan_name_Reg)) {
					errorMsgs.add("Plan Name: 只能是中、英文字母、數字和_ , 且長度必需在1到10之間");
				}

				// plan_cover
				Part part = req.getPart("plan_cover");
				InputStream is = part.getInputStream();
				byte[] plan_cover = new byte[is.available()];
				is.read(plan_cover);
				

				// plan_start_date
				java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
				java.util.Date du = null;
				try {
					du = df.parse(req.getParameter("plan_start_date"));
				} catch (ParseException e) {
					errorMsgs.add("是不會輸入日期?");
					e.printStackTrace();
				}
				Timestamp plan_start_date = (new Timestamp(du.getTime()));

				// plan_end_date
				java.util.Date du2 = null;
				try {
					du2 = df.parse(req.getParameter("plan_end_date"));
				} catch (ParseException e) {
					e.printStackTrace();
				}
				Timestamp plan_end_date = (new Timestamp(du2.getTime()));

				// sptype_id
				String sptype_id = req.getParameter("sptype_id");
				// plan_privacy
				String plan_privacy = req.getParameter("plan_privacy");
				// plan_vo
				String plan_vo = req.getParameter("plan_vo");

				PlanVO planVO = new PlanVO();
				planVO.setMem_id(mem_id);
				planVO.setPlan_name(plan_name);
				planVO.setPlan_cover(plan_cover);
				planVO.setPlan_start_date(plan_start_date);
				planVO.setPlan_end_date(plan_end_date);
				planVO.setSptype_id(sptype_id);
				planVO.setPlan_privacy(plan_privacy);
				planVO.setPlan_vo(plan_vo);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("planVO", planVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/plan/Create_Plan.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				PlanService planSvc = new PlanService();
				planVO = planSvc.addPlan(mem_id, plan_name, plan_cover, plan_start_date, plan_end_date, sptype_id,
						plan_privacy, plan_vo);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front_end/plan/plan_view.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage()+"test");
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/plan/Create_Plan.jsp");
				failureView.forward(req, res);
			}
		}

	}

}
