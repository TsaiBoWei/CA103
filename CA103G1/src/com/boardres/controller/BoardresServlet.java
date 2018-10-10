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

		if ("insert".equals(action)) { // 來自 的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String crres_text = req.getParameter("crres_text");

				if (crres_text == null || crres_text.trim().length() == 0) {
					errorMsgs.add("留言請勿空白");
				}


				Timestamp crres_time = new Timestamp(System.currentTimeMillis());
				String crpost_id = req.getParameter("crpost_id");
				String mem_id = req.getParameter("mem_id");

System.out.println(crres_text);
System.out.println(crpost_id);
System.out.println(mem_id);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					boolean openreplyform=true; // 再次打開openreplyform燈箱
					req.setAttribute("openreplyform",openreplyform);
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				BoardresService boardresSVC = new BoardresService();
				String crres_id=boardresSVC.addBoardres(crres_time, crpost_id, mem_id, crres_text);
               
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String whichPage=req.getParameter("whichPage");
				
				String url = "/front_end/course/courboar/page/maincourboar.jsp?whichPage="+whichPage+"&showCrres_id="+crres_id;
System.out.println("insertUrl"+url);
				req.setAttribute("localhref",url );
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交maincourbaor.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				boolean openreplyform=true; // 再次打開openreplyform燈箱
				req.setAttribute("openreplyform",openreplyform);
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自maincourboar.jsp 的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			BoardresVO boardresVO=new BoardresVO();
			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String crres_text = req.getParameter("crres_text");

				if (crres_text == null || crres_text.trim().length() == 0) {
					errorMsgs.add("content請勿空白");
				}

				String crres_id = req.getParameter("crres_id");
				
				
				boardresVO.setCrres_text(crres_text);
				boardresVO.setCrres_id(crres_id);

System.out.println(crres_text);
System.out.println(crres_id);
				
												

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					boolean openupdatereplyform=true; // 再次打開openupdatereplyform燈箱
					req.setAttribute("openupdatereplyform",openupdatereplyform);
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始更新資料 ***************************************/
				BoardresService boardresSVC = new BoardresService();
				boardresSVC.updateBoardres(crres_id, crres_text);

				/*************************** 3.更新完成,準備轉交(Send the Success view) ***********/
				String whichPage=req.getParameter("whichPage");
				String url = "/front_end/course/courboar/page/maincourboar.jsp?whichPage="+whichPage+"&showCrres_id="+crres_id;
System.out.println("insertUrl"+url);
				req.setAttribute("localhref",url );

				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				boolean openupdatereplyform=true; // 再次打開openupdatereplyform燈箱
				req.setAttribute("openupdatereplyform",openupdatereplyform);
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
				failureView.forward(req, res);
			}
		}

		if ("hide".equals(action)) { // 來自 的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				
				String crres_id = req.getParameter("crres_id");
System.out.println(crres_id);

				/*************************** 2.開始修改資料 ***************************************/
				BoardresService boardresSVC = new BoardresService();
				boardresSVC.hideBoardres("CPR2",crres_id);

				/*************************** 3.修改完成,準備轉交(Send the Success view) ***********/
				String whichPage=req.getParameter("whichPage");
				String url = "/front_end/course/courboar/page/maincourboar.jsp?whichPage="+whichPage;
System.out.println("insertUrl"+url);
				req.setAttribute("localhref",url );
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交maincourboar.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/courboar/page/maincourboar.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getOne".equals(action)) { // 來自 的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				
				String crres_id = req.getParameter("crres_id");

				/*************************** 2.開始查詢資料 ***************************************/
				BoardresService boardresSVC = new BoardresService();
				BoardresVO boardresVO= boardresSVC.getOneBoardres(crres_id);
				

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("boardresVO", boardresVO); 
				String url = "/front_end/course/courboar/page/maincourboar.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
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
