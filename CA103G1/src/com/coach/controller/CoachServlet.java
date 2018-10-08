package com.coach.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.coach.model.*;

@MultipartConfig
public class CoachServlet extends HttpServlet {

		public void doGet(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {
			doPost(req, res);
		}
		
		public String getFileNameFromPart(Part part) {
			  String header = part.getHeader("content-disposition");
			  String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();
			  if (filename.length() == 0) {
			   return null;
			  }
			  return filename;
			 }
		
		public void doPost(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {

			req.setCharacterEncoding("UTF-8");
			String action = req.getParameter("action");
		 
	
			if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllCourlist.jsp���ШD

				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/***************************1.�����ШD�Ѽ�****************************************/
					String coa_id = new String(req.getParameter("coa_id"));
					
					/***************************2.�}�l�d�߸��****************************************/
					CoachService coachSvc = new CoachService();
					CoachVO coachVO = coachSvc.getOneCoach(coa_id);
									
					/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
					req.setAttribute("coachVO", coachVO);         // ��Ʈw���X��coachVO����,�s�Jreq
					String url = "/front_end/course/coach/update_CoachText.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_CoachText.jsp
					successView.forward(req, res);

					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/coach/update_CoachText.jsp");
					failureView.forward(req, res);
				}
			}
			
			
			if ("update".equals(action)) { // �Ӧ�update_CoachText.jsp���ШD
				
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
			
//				try {
					/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
					String coa_id = new String (req.getParameter("coa_id").trim());

					String mem_id = new String (req.getParameter("mem_id").trim());

		            String coa_text = req.getParameter("coa_text");
					
					String coa_status = req.getParameter("coa_status").trim();
					String coa_statusReg = "^[(CS)(0-9)]{4}$";
					if (coa_status == null || coa_status.trim().length() == 0) {
						errorMsgs.add("�b�����A: �ФŪť�");
					} else if(!coa_status.trim().matches(coa_statusReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
						errorMsgs.add("�b�����A: �u��OCS+���Ʀr");
		            }
							
					CoachVO coachVO = new CoachVO();
					coachVO.setCoa_id(coa_id);
					coachVO.setMem_id(mem_id);
					coachVO.setCoa_text(coa_text);
					coachVO.setCoa_status(coa_status);


					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("coachVO", coachVO); // �t����J�榡���~��coachVO����,�]�s�Jreq
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front_end/course/coach/update_CoachText.jsp");
						failureView.forward(req, res);
						return; //�{�����_
					}
				
					/***************************2.�}�l�ק���*****************************************/
					CoachService coachSvc = new CoachService();
					coachVO = coachSvc.updateCoach(coa_id, mem_id, coa_text, coa_status);
							
					/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/
					req.setAttribute("coachVO", coachVO); // ��Ʈwupdate���\��,���T����coachVO����,�s�Jreq
					String url = "/front_end/course/coach/update_CoachText.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // �ק令�\��,���listOneCoach.jsp
					successView.forward(req, res);

					/***************************��L�i�઺���~�B�z*************************************/
//				} catch (Exception e) {
//					errorMsgs.add("�ק��ƥ���:"+e.getMessage());
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front_end/course/coach/update_CoachText.jsp");
//					failureView.forward(req, res);
//				}
			}

	        if ("insert".equals(action)) { // �Ӧ�addCoachText.jsp���ШD  
				
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);

//				try {
					/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
					String mem_id = new String (req.getParameter("mem_id").trim());

		            String coa_text = req.getParameter("coa_text");
					
					String coa_status = req.getParameter("coa_status").trim();



					CoachVO coachVO = new CoachVO();
					coachVO.setMem_id(mem_id);
					coachVO.setCoa_text(coa_text);
					coachVO.setCoa_status(coa_status);

					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("coachVO", coachVO); // �t����J�榡���~��coachVO����,�]�s�Jreq
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front_end/course/coach/addCoachText.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.�}�l�s�W���***************************************/
					CoachService coachSvc = new CoachService();
					coachVO = coachSvc.addCoach(mem_id, coa_text, coa_status);
					
					/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
					String url = "/front_end/course/coach/addCoachText.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllCourlist.jsp
					successView.forward(req, res);				
					
					/***************************��L�i�઺���~�B�z**********************************/
//				} catch (Exception e) {
//					errorMsgs.add("�s�W��ƥ���:"+e.getMessage());
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front_end/course/courlist/addCoachText.jsp");
//					failureView.forward(req, res);
//				}
			}
			

		}
}
