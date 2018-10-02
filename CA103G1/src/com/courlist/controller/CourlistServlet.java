package com.courlist.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.courlist.model.*;

@MultipartConfig
public class CourlistServlet extends HttpServlet {

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
					
		
			if ("getOne_For_Display".equals(action)) { // �Ӧ�select_page.jsp���ШD

				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
					String str = req.getParameter("cour_id");
					if (str == null || (str.trim()).length() == 0) {
						errorMsgs.add("�п�J�ҵ{�s��");
					}
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front_end/course/courlist/select_page.jsp");
						failureView.forward(req, res);
						return;//�{�����_
					}
					
					String cour_id = null;
					try {
						cour_id = new String(str);
					} catch (Exception e) {
						errorMsgs.add("�ҵ{�s���榡�����T");
					}
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front_end/course/courlist/select_page.jsp");
						failureView.forward(req, res);
						return;//�{�����_
					}
					
					/***************************2.�}�l�d�߸��*****************************************/
					CourlistService courlistSvc = new CourlistService();
					CourlistVO courlistVO = courlistSvc.getOneCourlist(cour_id);
					if (courlistVO == null) {
						errorMsgs.add("�d�L���");
					}
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front_end/course/courlist/select_page.jsp");
						failureView.forward(req, res);
						return;//�{�����_
					}
					
					/***************************3.�d�ߧ���,�ǳ����(Send the Success view)*************/
					req.setAttribute("courlistVO", courlistVO); // ��Ʈw���X��courlistVO����,�s�Jreq
					String url = "/front_end/course/courlist/oneCourlist.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneCourlist.jsp
					successView.forward(req, res);

					/***************************��L�i�઺���~�B�z*************************************/
				} catch (Exception e) {
					errorMsgs.add("�L�k���o���:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/courlist/select_page.jsp");
					failureView.forward(req, res);
				}
			}
			
			
			if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllCourlist.jsp���ШD

				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/***************************1.�����ШD�Ѽ�****************************************/
					String cour_id = new String(req.getParameter("cour_id"));
					
					/***************************2.�}�l�d�߸��****************************************/
					CourlistService courlistSvc = new CourlistService();
					CourlistVO courlistVO = courlistSvc.getOneCourlist(cour_id);
									
					/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
					req.setAttribute("courlistVO", courlistVO);         // ��Ʈw���X��courlistVO����,�s�Jreq
					String url = "/front_end/course/courlist/update_courlist.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_courlist_input.jsp
					successView.forward(req, res);

					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/courlist/listAllCourlist.jsp");
					failureView.forward(req, res);
				}
			}
			
			
			if ("update".equals(action)) { // �Ӧ�update_courlist_input.jsp���ШD
				
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
			
				try {
					/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
					String cour_id = new String (req.getParameter("cour_id").trim());
System.out.println("cour_id="+cour_id);

					String sptype_id = req.getParameter("sptype_id");
					String sptype_idReg = "^[(SP)(0-9)]{8}$";
					if (sptype_id == null || sptype_id.trim().length() == 0) {
						errorMsgs.add("�B�����O�s��: �ФŪť�");
					} else if(!sptype_id.trim().matches(sptype_idReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
						errorMsgs.add("�B�����O�s��: �u��OSP+����Ʀr");
		            }
System.out.println(sptype_id);

		            String coa_id = req.getParameter("coa_id");
					String coa_idReg = "^[(C)(0-9)]{7}$";
					if (coa_id == null || coa_id.trim().length() == 0) {
						errorMsgs.add("�нm�s��: �ФŪť�");
					} else if(!coa_id.trim().matches(coa_idReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
						errorMsgs.add("�нm�s��: �u��OC+����Ʀr");
		            }
System.out.println(coa_id);


					String cname = req.getParameter("cname").trim();
					if (cname == null || cname.trim().length() == 0) {
						errorMsgs.add("�ҵ{�W�ٽФŪť�");
					}
System.out.println(cname);
					
					String cour_text = req.getParameter("cour_text");
System.out.println(cour_text);

					Integer cour_cost = null;
					try {
						cour_cost = new Integer(req.getParameter("cour_cost").trim());
					} catch (NumberFormatException e) {
						cour_cost = 0;
						errorMsgs.add("�ҵ{�O�νж�Ʀr.");
					}
System.out.println(cour_cost);
					
                    byte[] cour_pho=null;
					//�W�ǹϤ�
					Part part = req.getPart("cour_pho");
					if (getFileNameFromPart(part) != null && part.getContentType() != null) {
						InputStream in = part.getInputStream();
						cour_pho = new byte[in.available()]; // buffer
						in.read(cour_pho);
					}else {
						CourlistService courlistService = new CourlistService();
						CourlistVO courlistVO = courlistService.getOneCourlist(cour_id);
						cour_pho = courlistVO.getCour_pho();
					}
//					String string = null;
//					if (getFileNameFromPart(part) == null || part.getContentType() == null) {
//						CourlistService courlistSvc = new CourlistService();
//						CourlistVO courlistVO = courlistSvc.getOneCourlist(cour_id);
//						cour_pho = courlistVO.getCour_pho();
//						System.out.println("cour_pho.length="+cour_pho.length);
//					}else {
//						InputStream in = part.getInputStream();
//						cour_pho = new byte[in.available()]; // buffer
//						in.read(cour_pho);
//						in.close();
//						string = "in";
//					}				

System.out.println(cour_pho);
//System.out.println(string);

					String cour_lau = req.getParameter("cour_lau");
					String cour_lauReg = "^[(CL)(0-9)]{4}$";
					if (cour_lau == null || cour_lau.trim().length() == 0) {
						errorMsgs.add("�ҵ{���A: �ФŪť�");
					} else if(!cour_lau.trim().matches(cour_lauReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
						errorMsgs.add("�ҵ{���A: �u��OCL+���Ʀr");
		            }
System.out.println(cour_lau);
					
					String cour_ann = req.getParameter("cour_ann");	
System.out.println(cour_ann);
			
					CourlistVO courlistVO = new CourlistVO();
					courlistVO.setCour_id(cour_id);
					courlistVO.setSptype_id(sptype_id);
					courlistVO.setCoa_id(coa_id);
					courlistVO.setCname(cname);
					courlistVO.setCour_text(cour_text);
					courlistVO.setCour_cost(cour_cost);
					courlistVO.setCour_pho(cour_pho);
System.out.println(cour_pho);
					courlistVO.setCour_lau(cour_lau);
					courlistVO.setCour_ann(cour_ann);
System.out.println("111111");

					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("courlistVO", courlistVO); // �t����J�榡���~��courlistVO����,�]�s�Jreq
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front_end/course/courlist/update_courlist.jsp");
						failureView.forward(req, res);
						return; //�{�����_
					}
System.out.println("22222222222");					
					/***************************2.�}�l�ק���*****************************************/
					CourlistService courlistSvc = new CourlistService();
System.out.println(courlistSvc);	
					courlistVO = courlistSvc.updateCourlist(cour_id, sptype_id, coa_id, cname, cour_text, cour_cost, 
							cour_pho, cour_lau, cour_ann);
System.out.println(courlistVO);							
					/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/
					req.setAttribute("courlistVO", courlistVO); // ��Ʈwupdate���\��,���T����courlistVO����,�s�Jreq
					String url = "/front_end/course/courlist/oneCourlist.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // �ק令�\��,���listOneCourlist.jsp
					successView.forward(req, res);

					/***************************��L�i�઺���~�B�z*************************************/
				} catch (Exception e) {
					errorMsgs.add("�ק��ƥ���:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/courlist/update_courlist.jsp");
					failureView.forward(req, res);
				}
			}

	        if ("insert".equals(action)) { // �Ӧ�addCourlist.jsp���ШD  
				
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);

//				try {
					/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
					String sptype_id = req.getParameter("sptype_id");
					String sptype_idReg = "^[(SP)(0-9)]{8}$";
					if (sptype_id == null || sptype_id.trim().length() == 0) {
						errorMsgs.add("�B�����O�s��: �ФŪť�");
					} else if(!sptype_id.trim().matches(sptype_idReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
						errorMsgs.add("�B�����O�s��: �u��OSP+����Ʀr");
		            }

					String coa_id = req.getParameter("coa_id");
					String coa_idReg = "^[(C)(0-9)]{7}$";
					if (coa_id == null || coa_id.trim().length() == 0) {
						errorMsgs.add("�нm�s��: �ФŪť�");
					} else if(!coa_id.trim().matches(coa_idReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
						errorMsgs.add("�нm�s��: �u��OC+����Ʀr");
		            }


					String cname = req.getParameter("cname").trim();
					if (cname == null || cname.trim().length() == 0) {
						errorMsgs.add("�ҵ{�W�ٽФŪť�");
					}
					
					String cour_text = req.getParameter("cour_text");

					Integer cour_cost = null;
					try {
						cour_cost = new Integer(req.getParameter("cour_cost").trim());
					} catch (NumberFormatException e) {
						cour_cost = 0;
						errorMsgs.add("�ҵ{�O�νж�Ʀr.");
					}
					
					//�W�ǹϤ�
					Part part = req.getPart("cour_pho");
					InputStream in = part.getInputStream();
					byte[] cour_pho = new byte[in.available()]; // buffer
					in.read(cour_pho);

					String cour_lau = req.getParameter("cour_lau");
					String cour_lauReg = "^[(CL)(0-9)]{4}$";
					if (cour_lau == null || cour_lau.trim().length() == 0) {
						errorMsgs.add("�ҵ{���A: �ФŪť�");
					} else if(!cour_lau.trim().matches(cour_lauReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
						errorMsgs.add("�ҵ{���A: �u��OCL+���Ʀr");
		            }
					
					String cour_ann = req.getParameter("cour_ann");

					CourlistVO courlistVO = new CourlistVO();
					courlistVO.setSptype_id(sptype_id);
					courlistVO.setCoa_id(coa_id);
					courlistVO.setCname(cname);
					courlistVO.setCour_text(cour_text);
					courlistVO.setCour_cost(cour_cost);
					courlistVO.setCour_pho(cour_pho);
					courlistVO.setCour_lau(cour_lau);
					courlistVO.setCour_ann(cour_ann);

					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("courlistVO", courlistVO); // �t����J�榡���~��courlistVO����,�]�s�Jreq
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front_end/course/courlist/addCourlist.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.�}�l�s�W���***************************************/
					CourlistService courlistSvc = new CourlistService();
					courlistVO = courlistSvc.addCourlist(sptype_id, coa_id, cname, cour_text, cour_cost, 
							cour_pho, cour_lau, cour_ann);
					
					/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
					String url = "/front_end/course/courlist/listAllCourlist.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllCourlist.jsp
					successView.forward(req, res);				
					
					/***************************��L�i�઺���~�B�z**********************************/
//				} catch (Exception e) {
//					errorMsgs.add(e.getMessage());
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front_end/course/courlist/addCourlist.jsp");
//					failureView.forward(req, res);
//				}
			}
			
			
			if ("delete".equals(action)) { // �Ӧ�listAllCourlist.jsp

				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
		
				try {
					/***************************1.�����ШD�Ѽ�***************************************/
					String cour_id = new String(req.getParameter("cour_id"));
					
					/***************************2.�}�l�R�����***************************************/
					CourlistService courlistSvc = new CourlistService();
					courlistSvc.deleteCourlist(cour_id);
					
					/***************************3.�R������,�ǳ����(Send the Success view)***********/								
					String url = "/front_end/course/courlist/listAllCourlist.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
					successView.forward(req, res);
					
					/***************************��L�i�઺���~�B�z**********************************/
				} catch (Exception e) {
					errorMsgs.add("�R����ƥ���:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/courlist/listAllCourlist.jsp");
					failureView.forward(req, res);
				}
			}
		}
}
