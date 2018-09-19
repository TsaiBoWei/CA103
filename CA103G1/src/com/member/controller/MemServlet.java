package com.member.controller;

import java.io.*; 
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

import com.member.model.MemJDBCDAO;
import com.member.model.MemService;
import com.member.model.MemVO;

public class MemServlet extends HttpServlet {

	public void doGet (HttpServletRequest req, HttpServletResponse res)
			throws IOException, ServletException {
		doPost(req,res);
	}
	
	public void doPost (HttpServletRequest req, HttpServletResponse res)
			throws IOException, ServletException { 

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("mem_signUp".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				String str = req.getParameter("psw");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("�п�J�K�X");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/Front-end/Mem_Login_Signup/Mem_Login_Signup.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
//				Integer empno = null;
//				try {
//					empno = new Integer(str);
//				} catch (Exception e) {
//					errorMsgs.add("���u�s���榡�����T");
//				}
				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/emp/select_page.jsp");
//					failureView.forward(req, res);
//					return;//�{�����_
//				}

				/***************************2.�}�l���U���*****************************************/
				
				MemVO memVO = new MemVO();
				
				String email = req.getParameter("email");
				String memName = req.getParameter("memName");
				String psw = req.getParameter("psw");
				memVO.setMemAcccount(email);
				memVO.setMemName(memName);
				memVO.setMemPsw(psw);
				memVO.setMemMail(email);
				memVO.setMemStatus("MS0");
				
				MemService memSvc = new MemService();
				memVO = memSvc.addMem(email, memName, psw);
				
				String url = "/Front-end/Mem_Login_Signup/Mem_Login_Signup.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneEmp.jsp
				successView.forward(req, res);
				
			}catch(Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/Front-end/Mem_Login_Signup/Mem_Login_Signup.jsp");
				failureView.forward(req, res);
			}
			
		}
		
	}
}