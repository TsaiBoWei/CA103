package com.plan.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.mem.model.MemVO;
import com.plan.model.PlanService;
import com.plan.model.PlanVO;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)

public class PlanServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public PlanServlet() {
		super();
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	@SuppressWarnings("unchecked")
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
				MemVO memVO = (MemVO) session.getAttribute("memVO");
				if (memVO.getMem_id() == null || memVO.getMem_id().trim().length() == 0) {
					errorMsgs.add("未登入");
				}
				String mem_id = memVO.getMem_id();
				// plan_name
				String plan_name = req.getParameter("plan_name");
				String plan_name_Reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_?\\-)]{2,20}$";
				if (plan_name == null || plan_name.trim().length() == 0) {
					errorMsgs.add("Plan Name Can't Be Blank");
				} else if (!plan_name.trim().matches(plan_name_Reg)) {
					errorMsgs.add("Plan Name: 只能是中、英文字母、數字、?和_ , 且長度必需在2到20之間");
				}

				// plan_cover
				Part part = req.getPart("plan_cover");
				byte[] plan_cover = null;
				if (part.getSubmittedFileName() != null && part.getContentType() != null) {
					InputStream in = part.getInputStream();
					plan_cover = new byte[in.available()];
					in.read(plan_cover);
					in.close();
				}

				// plan_start_date
				java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
				java.util.Date du = null;
				Timestamp plan_start_date = null;
				try {
					du = df.parse(req.getParameter("plan_start_date"));
					plan_start_date = (new Timestamp(du.getTime()));
				} catch (ParseException e) {
					errorMsgs.add("Enter The Start Date");
//					e.printStackTrace();
				}

				// plan_end_date
				java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
				java.util.Date du2 = null;
				Timestamp plan_end_date = null;
				try {
					du2 = df2.parse(req.getParameter("plan_end_date"));
					plan_end_date = (new Timestamp(du2.getTime()));
				} catch (ParseException e) {
					errorMsgs.add("Enter The End Date");
					e.printStackTrace();
				}

				// sptype_id
				String sptype_id = req.getParameter("sptype_id");


				// plan_privacy
				String plan_privacy = req.getParameter("plan_privacy");

				// plan_vo
				String plan_vo = req.getParameter("plan_vo"); 
				System.out.println("planServlet line114，印出plan_vo" + plan_vo);
				if (plan_vo == null || plan_vo.trim().length() == 0) {
					errorMsgs.add("Plan Content Can't Be Blank6666");
				}

				// plan_view
				Integer plan_view = null;
				try {
					plan_view = Integer.parseInt(req.getParameter("plan_view"));
					System.out.println(plan_view);
				} catch (Exception s) {
					errorMsgs.add("plan_view" + plan_view);
				}

				PlanVO planVO = new PlanVO();
				planVO.setMem_id(mem_id);
				planVO.setPlan_name(plan_name);
				planVO.setPlan_cover(plan_cover);
				planVO.setPlan_start_date(plan_start_date);
				planVO.setPlan_end_date(plan_end_date);
				planVO.setSptype_id(sptype_id);
				planVO.setPlan_privacy(plan_privacy);
				planVO.setPlan_vo(plan_vo);
				planVO.setPlan_view(plan_view);

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
						plan_privacy, plan_vo, plan_view);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front_end/plan/My_Plan_myself.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage() + "test");
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/plan/Create_Plan.jsp");
				failureView.forward(req, res);
			}
		}

		
		if ("getOne_For_Update".equals(action)) { // 來自My_Plan_myself.jsp/My_Plan.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String plan_id =req.getParameter("plan_id");

				/*************************** 2.開始查詢資料 ****************************************/
				PlanService planSvc = new PlanService();
				PlanVO planVO = planSvc.getOnePlan(plan_id);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.getSession().setAttribute("planVO", planVO); // 資料庫取出的planVO物件,存入req
				String url = "/front_end/plan/plan_update.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 plan_update.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage() + "testing20180929");
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/plan/plan_wrong.jsp");
				failureView.forward(req, res);
			}
		}
	
		
		
		
		if ("update".equals(action)) { // 來自plan_update.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】 或 【 /emp/listEmps_ByCompositeQuery.jsp】

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				
				HttpSession session = req.getSession();
				PlanVO planVO = (PlanVO) session.getAttribute("planVO");
				
				//plan_id
				String plan_id = new String(req.getParameter("plan_id").trim());
				
				//plan_name
				String plan_name = req.getParameter("plan_name");
				String plan_name_Reg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_?)]{2,20}$";
				if (plan_name == null || plan_name.trim().length() == 0) {
					errorMsgs.add("Plan Name Can't Be Blank");
				} else if (!plan_name.trim().matches(plan_name_Reg)) {
					errorMsgs.add("Plan Name: 只能是中、英文字母、數字和_ , 且長度必需在2到20之間");
				}
				
				//plan_cover
				Part part = req.getPart("plan_cover");
				byte[] plan_cover = planVO.getPlan_cover();
				if(part.getSize() !=0) {
					InputStream is = part.getInputStream();
					plan_cover = new byte[is.available()];
					is.read(plan_cover);
					is.close();
					System.out.println("success");
				}
				
				
				// plan_vo
				String plan_vo = req.getParameter("plan_vo");
				if (plan_vo == null || plan_vo.trim().length() == 0) {
					errorMsgs.add("Plan Content Can't Be Blank");
				}

				// plan_start_date
				java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
				java.util.Date du = null;
				Timestamp plan_start_date = null;
				try {
					du = df.parse(req.getParameter("plan_start_date"));
					plan_start_date = (new Timestamp(du.getTime()));
				} catch (ParseException e) {
					errorMsgs.add("Enter The Start Date");
//					e.printStackTrace();
				}
				
				// plan_end_date
				java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
				java.util.Date du2 = null;
				Timestamp plan_end_date = null;
				try {
					du2 = df2.parse(req.getParameter("plan_end_date"));
					plan_end_date = (new Timestamp(du2.getTime()));
				} catch (ParseException e) {
					errorMsgs.add("Enter The End Date");
					e.printStackTrace();
				}

				// sptype_id
				String sptype_id = req.getParameter("sptype_id");


				// plan_privacy
				String plan_privacy = req.getParameter("plan_privacy");
				
				//plan_status
				String plan_status = req.getParameter("plan_status");
				
				
				planVO.setPlan_cover(plan_cover);
				planVO.setPlan_name(plan_name);
				planVO.setPlan_vo(plan_vo);
				planVO.setPlan_start_date(plan_start_date);
				planVO.setPlan_end_date(plan_end_date);
				planVO.setSptype_id(sptype_id);
				planVO.setPlan_status(plan_status);
				planVO.setPlan_privacy(plan_privacy);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("planVO", planVO); // 含有輸入格式錯誤的planVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/plan/plan_update.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				 
				/***************************2.開始修改資料*****************************************/
				PlanService planSvc = new PlanService();
				planVO = planSvc.updatePlan(plan_name, plan_vo, plan_cover, plan_start_date, plan_end_date,sptype_id, plan_privacy,plan_status ,plan_id);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/				
				if(requestURL.equals("/front_end/plan/list_compositeQuery.jsp")){
//					HttpSession session = req.getSession();
					Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
					List<PlanVO> list  = planSvc.getAll(map);
					req.setAttribute("listPlans_ByCompositeQuery",list); //  複合查詢, 資料庫取出的list物件,存入request
				}
				String url = requestURL;
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage()+"更新失敗");
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/plan/plan_wrong.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
		

		if ("delete".equals(action)) { // 來自My_Plan.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				String plan_id = req.getParameter("plan_id");

				/*************************** 2.開始刪除資料 ***************************************/
				PlanService planSvc = new PlanService();
				planSvc.deletePlan(plan_id);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/front_end/plan/My_plan_blank.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage() + "test20180929-2");
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/plan/plan_wrong.jsp");
				failureView.forward(req, res);
			}
		}

		if ("listPlans_ByCompositeQuery".equals(action)) { // 來自compositeQuery.jsp的複合查詢請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {

				/*************************** 1.將輸入資料轉為Map **********************************/
				// 採用Map<String,String[]> getParameterMap()的方法
				// 注意:an immutable java.util.Map
				// Map<String, String[]> map = req.getParameterMap();
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String, String[]>) session.getAttribute("map");
				if (req.getParameter("whichPage") == null) {
					HashMap<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
					session.setAttribute("map", map1);
					map = map1;
				}

				/*************************** 2.開始複合查詢 ***************************************/
				PlanService planSvc = new PlanService();
				List<PlanVO> list = planSvc.getAll(map);
				System.out.println("line371");

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.getSession().setAttribute("listPlans_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/front_end/plan/list_compositeQuery.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				System.out.println("line376");
				successView.forward(req, res);
				System.out.println("已成功轉交");

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				System.out.println("test20181007");
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/plan/plan_wrong.jsp");
				failureView.forward(req, res);
			}

		}
		
		
		if ("listAllPlans_ForVisitor_ByCompositeQuery".equals(action)) { // 來自ListAllPlans_ForVisitor.jsp的複合查詢請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			System.out.println("line353");
			try {
				
				/*************************** 1.將輸入資料轉為Map **********************************/
				// 採用Map<String,String[]> getParameterMap()的方法
				// 注意:an immutable java.util.Map
				// Map<String, String[]> map = req.getParameterMap();
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String, String[]>) session.getAttribute("map");
				if (req.getParameter("whichPage") == null) {
					HashMap<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
					session.setAttribute("map", map1);
					map = map1;
				}
				
				/*************************** 2.開始複合查詢 ***************************************/
				PlanService planSvc = new PlanService();
				List<PlanVO> list = planSvc.getAllforVisitor(map);
				System.out.println("line413");
				
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.getSession().setAttribute("listAllPlans_ForVisitor_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				RequestDispatcher successView = req.getRequestDispatcher("/front_end/plan/list_compositeQuery_ForVisitor.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				successView.forward(req, res);
				System.out.println("已成功轉交");
				
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				System.out.println("test20181007");
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/plan/plan_wrong.jsp");
				failureView.forward(req, res);
			}
			
		}
	
	}
}
