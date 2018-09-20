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

		if ("insert".equals(action)) { // 來自maincourboar.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String crpos_tit = req.getParameter("crpos_tit");
				String crpos_text = req.getParameter("crpos_text");
				

				if (crpos_tit == null || crpos_tit.trim().length() == 0) {
					errorMsgs.add("title請勿空白");
				}
				if (crpos_text == null || crpos_text.trim().length() == 0) {
					errorMsgs.add("content請勿空白");
	
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
					boolean opencourboarform=true; // 再次打開courboarform燈箱
					req.setAttribute("opencourboarform",opencourboarform);
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				CourBoarService courBoarSVC = new CourBoarService();
				courBoarSVC.addCourboar(crpos_tit, crpos_time, cour_id, mem_id, crpos_text);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front_end/course/courboar/page/maincourboar.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交
				successView.forward(req, res);
				

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				boolean opencourboarform=true;
				req.setAttribute("opencourboarform",opencourboarform);
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // 來自maincourboar.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String crpos_tit = req.getParameter("crpos_tit");
				String crpos_text = req.getParameter("crpos_text");
				
				CourBoarVO courBoarVO=new CourBoarVO();
			
           
				if (crpos_tit == null || crpos_tit.trim().length() == 0) {
					errorMsgs.add("title請勿空白");
				}
				if (crpos_text == null || crpos_text.trim().length() == 0) {
					errorMsgs.add("content請勿空白");
				}

				String crpost_id = req.getParameter("crpost_id");
				courBoarVO.setCrpos_tit(crpos_tit);
				courBoarVO.setCrpos_text(crpos_text);
				courBoarVO.setCrpost_id(crpost_id);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					
					boolean openModal=true;
					req.setAttribute("openModal",openModal );	// 再次打開update燈箱
					req.setAttribute("courBoarVO",courBoarVO );
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始修改資料 ***************************************/
				CourBoarService courBoarSVC = new CourBoarService();
				courBoarSVC.updateCourboar(crpost_id, crpos_tit, crpos_text);

				/*************************** 3.修改完成,準備轉交(Send the Success view) ***********/
				String url = "/front_end/course/courboar/page/maincourboar.jsp";
				boolean localhref=true;
				req.setAttribute("localhref",localhref );
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交maincourboar.jsp
				successView.forward(req, res);
				

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("hide".equals(action)) { // 來自maincourboar.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				
				String crpost_id = req.getParameter("crpost_id");

				/*************************** 2.開始修改資料 ***************************************/
				CourBoarService courBoarSVC = new CourBoarService();
				courBoarSVC.hideCourboar(crpost_id);
System.out.println(crpost_id);

				/*************************** 3.修改完成,準備轉交(Send the Success view) ***********/
				
                String url = "/front_end/course/courboar/page/maincourboar.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 
				successView.forward(req, res);
                

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne".equals(action)) { // 來自maincourboar的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				
				String crpost_id = req.getParameter("crpost_id");
System.out.println("check"+crpost_id);
System.out.println(action);

				/*************************** 2.開始查詢資料 ***************************************/
				CourBoarService courBoarSVC = new CourBoarService();
				CourBoarVO courBoarVO= courBoarSVC.getOneCourboar(crpost_id);
System.out.println(courBoarVO);
				
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ***********/
				//Bootstrap_modal
				boolean openModal=true;
				req.setAttribute("openModal",openModal );				

				req.setAttribute("courBoarVO", courBoarVO);
				String url = "/front_end/course/courboar/page/maincourboar.jsp"; 
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交getOneCourboar.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
				failureView.forward(req, res);
			}
		}


	}
}
