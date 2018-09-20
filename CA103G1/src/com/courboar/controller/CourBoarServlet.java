package com.courboar.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.boardres.model.BoardresService;
import com.courboar.model.CourBoarService;
import com.courboar.model.CourBoarVO;

public class CourBoarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("insert".equals(action)) { // �Ӧ�maincourboar.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z *************************/
				String crpos_tit = req.getParameter("crpos_tit");
				String crpos_text = req.getParameter("crpos_text");
				

				if (crpos_tit == null || crpos_tit.trim().length() == 0) {
					errorMsgs.add("title�ФŪť�");
				}
				if (crpos_text == null || crpos_text.trim().length() == 0) {
					errorMsgs.add("content�ФŪť�");
	
				}

				Timestamp crpos_time = new Timestamp(System.currentTimeMillis());
//				String cour_id = req.getParameter("cour_id");
//				String mem_id = req.getParameter("mem_id");
				String cour_id = req.getParameter("cour_id");
				String mem_id = (String)req.getSession().getAttribute("mem_id");
                
				System.out.println(cour_id);
                System.out.println(mem_id);
                System.out.println(crpos_tit);
                System.out.println(crpos_text);
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					boolean opencourboarform=true; // �A�����}courboarform�O�c
					req.setAttribute("opencourboarform",opencourboarform);
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.�}�l�s�W��� ***************************************/
				CourBoarService courBoarSVC = new CourBoarService();
				courBoarSVC.addCourboar(crpos_tit, crpos_time, cour_id, mem_id, crpos_text);

				/*************************** 3.�s�W����,�ǳ����(Send the Success view) ***********/
				String url = "/front_end/course/courboar/page/maincourboar.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����
				successView.forward(req, res);
				

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				boolean opencourboarform=true;
				req.setAttribute("opencourboarform",opencourboarform);
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // �Ӧ�maincourboar.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z *************************/
				String crpos_tit = req.getParameter("crpos_tit");
				String crpos_text = req.getParameter("crpos_text");
				
				CourBoarVO courBoarVO=new CourBoarVO();
			
           
				if (crpos_tit == null || crpos_tit.trim().length() == 0) {
					errorMsgs.add("title�ФŪť�");
				}
				if (crpos_text == null || crpos_text.trim().length() == 0) {
					errorMsgs.add("content�ФŪť�");
				}

				String crpost_id = req.getParameter("crpost_id");
				courBoarVO.setCrpos_tit(crpos_tit);
				courBoarVO.setCrpos_text(crpos_text);
				courBoarVO.setCrpost_id(crpost_id);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					
					boolean openModal=true;
					req.setAttribute("openModal",openModal );	// �A�����}update�O�c
					req.setAttribute("courBoarVO",courBoarVO );
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.�}�l�ק��� ***************************************/
				CourBoarService courBoarSVC = new CourBoarService();
				courBoarSVC.updateCourboar(crpost_id, crpos_tit, crpos_text);

				/*************************** 3.�ק粒��,�ǳ����(Send the Success view) ***********/
				String url = "/front_end/course/courboar/page/maincourboar.jsp";
				boolean localhref=true;
				req.setAttribute("localhref",localhref );
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����maincourboar.jsp
				successView.forward(req, res);
				

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("hide".equals(action)) { // �Ӧ�maincourboar.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z *************************/
				
				String crpost_id = req.getParameter("crpost_id");

				/*************************** 2.�}�l�ק��� ***************************************/
				CourBoarService courBoarSVC = new CourBoarService();
				courBoarSVC.hideCourboar(crpost_id);
System.out.println(crpost_id);

				/*************************** 3.�ק粒��,�ǳ����(Send the Success view) ***********/
				
                String url = "/front_end/course/courboar/page/maincourboar.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 
				successView.forward(req, res);
                

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne".equals(action)) { // �Ӧ�maincourboar���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z *************************/
				
				String crpost_id = req.getParameter("crpost_id");
System.out.println("check"+crpost_id);
System.out.println(action);

				/*************************** 2.�}�l�d�߸�� ***************************************/
				CourBoarService courBoarSVC = new CourBoarService();
				CourBoarVO courBoarVO= courBoarSVC.getOneCourboar(crpost_id);
System.out.println(courBoarVO);
				
				/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) ***********/
				//Bootstrap_modal
				boolean openModal=true;
				req.setAttribute("openModal",openModal );				

				req.setAttribute("courBoarVO", courBoarVO);
				String url = "/front_end/course/courboar/page/maincourboar.jsp"; 
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����getOneCourboar.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
				failureView.forward(req, res);
			}
		}


	}
}
