package com.Mgr.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.Mgr.model.MgrService;
import com.Mgr.model.MgrVO;

public class MgrLoginServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String actionMgrLogin = req.getParameter("actionMgrLogin");
		
		
		if("Mgr_try_login".equals(actionMgrLogin)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			
			try {
		
//				**********接受帳號密碼，進行輸入格式錯誤處裡**************************
				String mgr_account = req.getParameter("mgr_account");
				String mgr_password = req.getParameter("mgr_password");
				
				String accountchk = "^[(a-zA-Z0-9_)]{3,10}$"; //驗證帳號正規表示法
				if (mgr_account == null || (mgr_account.trim()).length() == 0) {
					errorMsgs.add("帳號不得空白");
				}else if(!mgr_account.trim().matches(accountchk)) {
				errorMsgs.add("帳號格式錯誤，只能填入英文字母、數字及_符號，且長度必需在3到10之間");
				}
					

				
				if (mgr_password == null || (mgr_password.trim()).length() == 0) {
					errorMsgs.add("密碼不得空白");
				}
				
				
				if(!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/mgr/mgrlogin.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
/***************************2.開始查詢資料庫比對帳密*****************************************/
				MgrService mgrSvc = new MgrService();
				MgrVO mgrVO = mgrSvc.getMgrLogin(mgr_account,mgr_password);
				
				
				if (mgrVO == null) {
					errorMsgs.add("查無資料，請輸入正確帳號或密碼");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back_end/mgr/mgrlogin.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				HttpSession session =req.getSession(); //丟到session準備轉交給Filter
				session.setAttribute("islogin",mgrVO);
				
				try {
					String location = (String) session.getAttribute("location");
					System.out.println(location);
					if(location != null) {
						session.removeAttribute("location");
						res.sendRedirect(location);
						
//						RequestDispatcher successView = req.getRequestDispatcher("/back_end/mgrview.jsp");
//						successView.forward(req, res);
						return;
					}
					
				}catch(Exception ignore) {}		
//				res.sendRedirect(req.getContextPath()+"back_end/mgr/mgrlogin");

				res.sendRedirect(req.getContextPath()+"/back_end/mgrview.jsp"); 
			
				}catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/mgr/mgrlogin.jsp");
				failureView.forward(req, res);
				
			}
		}
	
	}
}
