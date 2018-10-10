package com.mem.controller;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import com.mailservice.MailService;
import com.mem.model.MemService;
import com.mem.model.MemVO;
import com.memsplike.model.MemSpLikeService;
import com.memsplike.model.MemSpLikeVO;

import redis.clients.jedis.Jedis;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class MemServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		doPost(req,res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("login".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("loginErrorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/
				String str = req.getParameter("password");
				String account = req.getParameter("email");
				if(account==null || (account.trim()).length()==0) {
					errorMsgs.add("�п�J�b��");
				}
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("�п�J�K�X");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/Mem_Login_Signup.jsp");
					failureView.forward(req, res);
					return;// �{�����_
				}

				/******************************
				 * 2.�n�J-�b��Ʈw�d�߷|�����b���K�X
				 *****************************************/
				MemVO loggedMember = new MemVO();
				String email = req.getParameter("email");
				String psw = req.getParameter("password");
				loggedMember.setMem_account(email);
				loggedMember.setMem_password(psw);
				MemService memSvc = new MemService();
				loggedMember = memSvc.loginMem(loggedMember.getMem_account(), loggedMember.getMem_password());
				

				/*************************** 3.�n�J����,�ǳ����(Send the Success view) *************/
				if ("MS0".equals(loggedMember.getMem_status())) {
					HttpSession session = req.getSession();
					session.setAttribute("memVO", loggedMember);
					String url = "/front_end/mem/login/Verify.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // ���ҥ��q�L ��� Verify.jsp
					successView.forward(req, res);
				} else {
					MemSpLikeService memsplikeSvc = new MemSpLikeService();
					List<MemSpLikeVO> memSpLikeVOList = new ArrayList<MemSpLikeVO>();
					memSpLikeVOList = memsplikeSvc.findByMemId(loggedMember.getMem_id());
					HttpSession session = req.getSession();
					session.setAttribute("memSpLikeVOList",memSpLikeVOList);
					session.setAttribute("memVO", loggedMember);
					String url = "/front_end/mem/login/TestView.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� TestView.jsp
					successView.forward(req, res);

				}

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (NullPointerException npe) {
				errorMsgs.add("�b���K�X���~,�Э��s��J");
				RequestDispatcher failureView = req.getRequestDispatcher("/Mem_Login_Signup.jsp");
				failureView.forward(req, res);
			}
		}

		if ("loggedout".equals(action)) {
			System.out.println("I am here");
			System.out.println(req.getContextPath());
			System.out.println(req.getAttribute(action));
			System.out.println(req.getServletPath());
			System.out.println(req.getPathTranslated());
			System.out.println(req.getRequestURL());
			System.out.println(req.getRequestURI());
			System.out.println(req.getQueryString());

			HttpSession session = req.getSession();
			session.invalidate();

			String url = "/Mem_Login_Signup.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� TestView.jsp
			successView.forward(req, res);
		}

		if ("mem_signUp".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/
				String str = req.getParameter("regPassword");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("�п�J�K�X");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					boolean openModal = true;
					req.setAttribute("openModal", openModal);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/Mem_Login_Signup.jsp");
					failureView.forward(req, res);
					return;// �{�����_
				}

				/*************************** 2.�}�l���U��� *****************************************/

				MemVO memVO = new MemVO();
				String regaccount = req.getParameter("regEmail");
				String regName = req.getParameter("regName");
				String regPsw = req.getParameter("regPassword");
				MemService memSvc = new MemService();
				memVO = memSvc.addMem(regaccount, regName, regPsw);
				memVO.setMem_account(regaccount);
				memVO.setMem_name(regName);
				memVO.setMem_password(regPsw);
				memVO.setMem_email(regaccount);
				memVO.setMem_status("MS0");

				MailService verifyEMail = new MailService();
				Jedis jedis = new Jedis("localhost", 6379);
				jedis.auth("123456");

				String verifyCode = returnAuthCode();
				jedis.set(regaccount, verifyCode);
				jedis.expire(regaccount, 100);

				System.out.println("Auth code is: " + verifyCode);
				String subject = "[Work It Out] �|���{�ҫH";
				String messageText = "Hello! " + regName + " �п�J�����ҽX:" + verifyCode + "\n";
				verifyEMail.sendMail(regaccount, subject, messageText);
				System.out.println("email has been sent");

				jedis.close();

				MemVO loggedMember = memSvc.loginMem(regaccount, regPsw);
				HttpSession session = req.getSession();
				session.setAttribute("memVO", loggedMember); // ��b�����s�_�� ���F����hredis�����ҽX

				String url = "/front_end/mem/login/Verify.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

			} catch (Exception e) {
				errorMsgs.add("���~�T��: " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/mem/login/FailPage.jsp");
				failureView.forward(req, res);
			}

		}

		if ("verifyCode".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/
				String str = req.getParameter("verifyCode");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("�п�J���ҽX");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/mem/login/Verify.jsp");
					failureView.forward(req, res);
					return;// �{�����_
				}

				/***************************
				 * 2.�Predis��Ʈw������ҽX�O�_���T
				 *****************************************/

				MemVO memVO = new MemVO();

				String verifyCode = req.getParameter("verifyCode");

				// �}��redis���o���ҽX
				Jedis jedis = new Jedis("localhost", 6379);
				jedis.auth("123456");
				HttpSession session = req.getSession();
				memVO = (MemVO) session.getAttribute("memVO");
				String tempAuth = jedis.get(memVO.getMem_account());

				if (tempAuth == null) {
					System.out.println("�s���H�w�O�ɡA�Э��s�ӽ�");
				} else if (verifyCode.equals(tempAuth)) {
					memVO.setMem_status("MS1");
					MemService memSev = new MemService();
					memSev.updateStatus(memVO.getMem_account(), memVO.getMem_status());
					System.out.println("���Ҧ��\!");
				} else {
					System.out.println("���Ҧ��~�A�Э��s�ӽ�");
				}
				jedis.close();

				String url = "/front_end/mem/login/TestView.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/mem/login/Mem_Login_Signup.jsp");
				failureView.forward(req, res);
			}

		}

		if ("mem_update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/
//				String str = req.getParameter("password");
//				if (str == null || (str.trim()).length() == 0) {
//					errorMsgs.add("�п�J�K�X");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front_end/mem/login/TestView.jsp");
//					failureView.forward(req, res);
//					return;//�{�����_
//				}

				/******************************* 2-1.����|����ƭק�*****************************************/
				HttpSession session = req.getSession();
				MemVO loggedMember = (MemVO) session.getAttribute("memVO");
				MemService memSvc = new MemService();
				MemVO updatedMem = memSvc.getOneMem(loggedMember.getMem_id());
				
				Part part = req.getPart("memPhoto");
				byte[] memPhoto=loggedMember.getMem_photo();
				System.out.println(memPhoto);
				if(part.getSize() !=0) {
					InputStream is = part.getInputStream();
					memPhoto = new byte[is.available()];
					is.read(memPhoto);
					is.close();
					System.out.println("success");
				}

				java.sql.Date membirth = null;
				if(req.getParameter("memBirth")!=null) {
					membirth = java.sql.Date.valueOf(req.getParameter("memBirth"));					
				}
				System.out.println(membirth);
				String memName = req.getParameter("memName");
				String memEmail = req.getParameter("memEmail");
				String memIntro = req.getParameter("memIntro");

				updatedMem = memSvc.updateMem(updatedMem.getMem_id(), memName, updatedMem.getMem_account(),
						updatedMem.getMem_password(), membirth, memPhoto, memEmail, memIntro);
				System.out.println("here");

				MemSpLikeVO memSpLikeVO = new MemSpLikeVO();
				MemSpLikeService memsplikeSvc = new MemSpLikeService();
				
				String[] memSpLike = req.getParameterValues("memSpLike");
				/*******************************2-2.����|���B�ʳߦn�ק�************************************/
				if(memSpLike != null) {
					//�|�����Ŀ�B�ʳߦn
					for(int i=1;i<9;i++) {
						memsplikeSvc.delete(updatedMem.getMem_id(), "SP00000"+i);		
					}
					for(int i=0;i<memSpLike.length;i++) {
						memSpLikeVO.setMem_id(loggedMember.getMem_id());
						memSpLikeVO.setSptype_id(memSpLike[i]);
						memSpLikeVO.setLike_status("LS1");
						memsplikeSvc.insert(memSpLikeVO);
					}		
				}else {
					//�|���L�Ŀ�B�ʳߦn
					for(int i=1;i<9;i++) {
						memsplikeSvc.delete(updatedMem.getMem_id(), "SP00000"+i);		
					}
				}
				
				List<MemSpLikeVO> memSpLikeVOList = new ArrayList<MemSpLikeVO>();
				memSpLikeVOList = memsplikeSvc.findByMemId(loggedMember.getMem_id());
				session.setAttribute("memSpLikeVOList",memSpLikeVOList);
				session.setAttribute("memVO", updatedMem);
//				memSvc.getMemberPhoto(updatedMem.getMem_id());
				String url = "/front_end/mem/login/TestView.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� TestView.jsp
				successView.forward(req, res);

			} catch (NullPointerException npe) {
				errorMsgs.add("���~�T��: " + npe.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/mem/login/FailPage.jsp");
				failureView.forward(req, res);
			} catch (IllegalArgumentException pe) {
				pe.printStackTrace();
				errorMsgs.add("���~�T��: " + pe.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/mem/login/FailPage.jsp");
				failureView.forward(req, res);
			}
		}

	}


	private static String returnAuthCode() {
		StringBuilder sb = new StringBuilder();
		for (int i = 1; i <= 8; i++) {
			int condition = (int) (Math.random() * 3) + 1;
			switch (condition) {
			case 1:
				char c1 = (char) ((int) (Math.random() * 26) + 65);
				sb.append(c1);
				break;
			case 2:
				char c2 = (char) ((int) (Math.random() * 26) + 97);
				sb.append(c2);
				break;
			case 3:
				sb.append((int) (Math.random() * 10));
			}
		}
		return sb.toString();
	}

}