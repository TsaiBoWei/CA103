package com.mem.controller;

import java.io.*; 
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;


import com.mem.model.MemService;
import com.mem.model.MemVO;

public class MemServlet extends HttpServlet {

	public void doGet (HttpServletRequest req, HttpServletResponse res)
			throws IOException, ServletException {
		doPost(req,res);
	}
	
	public void doPost (HttpServletRequest req, HttpServletResponse res)
			throws IOException, ServletException { 

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		HttpSession session = req.getSession();
		MemVO loggedMember =(MemVO)session.getAttribute("memVO");
		
		
		if ("login".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				String str = req.getParameter("password");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("�п�J�K�X");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/mem/login/Mem_Login_Signup.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				

				/*****************************2.�n�J*****************************************/
				
				MemVO memVO = new MemVO();
				
				String email = req.getParameter("email");
				String psw = req.getParameter("password");
				
				memVO.setMem_account(email);
				memVO.setMem_password(psw);


				MemService memSvc = new MemService();
				loggedMember = memSvc.loginMem(memVO.getMem_account(), memVO.getMem_password());
				session.setAttribute("memVO", loggedMember);
				
				String url = "/front_end/mem/login/TestView.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� TestView.jsp
				successView.forward(req, res);
				
			}catch(NullPointerException npe) {
				errorMsgs.add("�b���K�X���~" + npe.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/mem/login/Mem_Login_Signup.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
		if ("mem_signUp".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				String str = req.getParameter("regPassword");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("�п�J�K�X");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					boolean openModal=true;
					req.setAttribute("openModal",openModal );
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/mem/login/Mem_Login_Signup.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************2.�}�l���U���*****************************************/
				
				MemVO memVO = new MemVO();
				
				String regaccount = req.getParameter("regEmail");
				String regName = req.getParameter("regName");
				String regPsw = req.getParameter("regPassword");
				memVO.setMem_account(regaccount);
				memVO.setMem_name(regName);
				memVO.setMem_password(regPsw);
				memVO.setMem_email(regaccount);
				memVO.setMem_status("MS0");
				
				MemService memSvc = new MemService();
				memVO = memSvc.addMem(regaccount, regName, regPsw);
				
				String url = "/front_end/mem/login/Mem_Login_Signup.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);
				
			}catch(Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/mem/login/Mem_Login_Signup.jsp");
				failureView.forward(req, res);
			}
			
		}
		
	}
}