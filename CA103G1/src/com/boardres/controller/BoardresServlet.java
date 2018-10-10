package com.boardres.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.boardres.model.BoardresService;
import com.boardres.model.BoardresVO;
import com.courboar.model.CourBoarService;
import com.courboar.model.CourBoarVO;

public class BoardresServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("insert".equals(action)) { // �Ӧ� ���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z *************************/
				String crres_text = req.getParameter("crres_text");

				if (crres_text == null || crres_text.trim().length() == 0) {
					errorMsgs.add("�d���ФŪť�");
				}


				Timestamp crres_time = new Timestamp(System.currentTimeMillis());
				String crpost_id = req.getParameter("crpost_id");
				String mem_id = req.getParameter("mem_id");

System.out.println(crres_text);
System.out.println(crpost_id);
System.out.println(mem_id);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					boolean openreplyform=true; // �A�����}openreplyform�O�c
					req.setAttribute("openreplyform",openreplyform);
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.�}�l�s�W��� ***************************************/
				BoardresService boardresSVC = new BoardresService();
				String crres_id=boardresSVC.addBoardres(crres_time, crpost_id, mem_id, crres_text);
               
				/*************************** 3.�s�W����,�ǳ����(Send the Success view) ***********/
				String whichPage=req.getParameter("whichPage");
				
				String url = "/front_end/course/courboar/page/maincourboar.jsp?whichPage="+whichPage+"&showCrres_id="+crres_id;
System.out.println("insertUrl"+url);
				req.setAttribute("localhref",url );
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����maincourbaor.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				boolean openreplyform=true; // �A�����}openreplyform�O�c
				req.setAttribute("openreplyform",openreplyform);
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // �Ӧ�maincourboar.jsp ���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			BoardresVO boardresVO=new BoardresVO();
			try {
				/*********************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z *************************/
				String crres_text = req.getParameter("crres_text");

				if (crres_text == null || crres_text.trim().length() == 0) {
					errorMsgs.add("content�ФŪť�");
				}

				String crres_id = req.getParameter("crres_id");
				
				
				boardresVO.setCrres_text(crres_text);
				boardresVO.setCrres_id(crres_id);

System.out.println(crres_text);
System.out.println(crres_id);
				
												

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					boolean openupdatereplyform=true; // �A�����}openupdatereplyform�O�c
					req.setAttribute("openupdatereplyform",openupdatereplyform);
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.�}�l��s��� ***************************************/
				BoardresService boardresSVC = new BoardresService();
				boardresSVC.updateBoardres(crres_id, crres_text);

				/*************************** 3.��s����,�ǳ����(Send the Success view) ***********/
				String whichPage=req.getParameter("whichPage");
				String url = "/front_end/course/courboar/page/maincourboar.jsp?whichPage="+whichPage+"&showCrres_id="+crres_id;
System.out.println("insertUrl"+url);
				req.setAttribute("localhref",url );

				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllEmp.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				boolean openupdatereplyform=true; // �A�����}openupdatereplyform�O�c
				req.setAttribute("openupdatereplyform",openupdatereplyform);
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
				failureView.forward(req, res);
			}
		}

		if ("hide".equals(action)) { // �Ӧ� ���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z *************************/
				
				String crres_id = req.getParameter("crres_id");
System.out.println(crres_id);

				/*************************** 2.�}�l�ק��� ***************************************/
				BoardresService boardresSVC = new BoardresService();
				boardresSVC.hideBoardres("CPR2",crres_id);

				/*************************** 3.�ק粒��,�ǳ����(Send the Success view) ***********/
				String whichPage=req.getParameter("whichPage");
				String url = "/front_end/course/courboar/page/maincourboar.jsp?whichPage="+whichPage;
System.out.println("insertUrl"+url);
				req.setAttribute("localhref",url );
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����maincourboar.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne".equals(action)) { // �Ӧ� ���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z *************************/
				
				String crres_id = req.getParameter("crres_id");

				/*************************** 2.�}�l�d�߸�� ***************************************/
				BoardresService boardresSVC = new BoardresService();
				BoardresVO boardresVO= boardresSVC.getOneBoardres(crres_id);
				

				/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) ***********/
				req.setAttribute("boardresVO", boardresVO); 
				String url = "/front_end/course/courboar/page/maincourboar.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
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
