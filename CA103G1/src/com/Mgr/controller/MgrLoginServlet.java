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
		
//				**********�����b���K�X�A�i���J�榡���~�B��**************************
				String mgr_account = req.getParameter("mgr_account");
				String mgr_password = req.getParameter("mgr_password");
				
				String accountchk = "^[(a-zA-Z0-9_)]{3,10}$"; //���ұb�����W��ܪk
				if (mgr_account == null || (mgr_account.trim()).length() == 0) {
					errorMsgs.add("�b�����o�ť�");
				}else if(!mgr_account.trim().matches(accountchk)) {
				errorMsgs.add("�b���榡���~�A�u���J�^��r���B�Ʀr��_�Ÿ��A�B���ץ��ݦb3��10����");
				}
					

				
				if (mgr_password == null || (mgr_password.trim()).length() == 0) {
					errorMsgs.add("�K�X���o�ť�");
				}
				
				
				if(!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/mgr/mgrlogin.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
/***************************2.�}�l�d�߸�Ʈw���b�K*****************************************/
				MgrService mgrSvc = new MgrService();
				MgrVO mgrVO = mgrSvc.getMgrLogin(mgr_account,mgr_password);
				
				
				if (mgrVO == null) {
					errorMsgs.add("�d�L��ơA�п�J���T�b���αK�X");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back_end/mgr/mgrlogin.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
/***************************3.�d�ߧ���,�ǳ����(Send the Success view)*************/
				HttpSession session =req.getSession(); //���session�ǳ���浹Filter
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
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/mgr/mgrlogin.jsp");
				failureView.forward(req, res);
				
			}
		}
	
	}
}
