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
		 
	
			if ("getOne_For_Update".equals(action)) { // 來自listAllCourlist.jsp的請求

				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/***************************1.接收請求參數****************************************/
					String coa_id = new String(req.getParameter("coa_id"));
					
					/***************************2.開始查詢資料****************************************/
					CoachService coachSvc = new CoachService();
					CoachVO coachVO = coachSvc.getOneCoach(coa_id);
									
					/***************************3.查詢完成,準備轉交(Send the Success view)************/
					req.setAttribute("coachVO", coachVO);         // 資料庫取出的coachVO物件,存入req
					String url = "/front_end/course/coach/update_CoachText.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_CoachText.jsp
					successView.forward(req, res);

					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/coach/update_CoachText.jsp");
					failureView.forward(req, res);
				}
			}
			
			
			if ("update".equals(action)) { // 來自update_CoachText.jsp的請求
				
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
			
//				try {
					/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
					String coa_id = new String (req.getParameter("coa_id").trim());

					String mem_id = new String (req.getParameter("mem_id").trim());

		            String coa_text = req.getParameter("coa_text");
					
					String coa_status = req.getParameter("coa_status").trim();
					String coa_statusReg = "^[(CS)(0-9)]{4}$";
					if (coa_status == null || coa_status.trim().length() == 0) {
						errorMsgs.add("帳號狀態: 請勿空白");
					} else if(!coa_status.trim().matches(coa_statusReg)) { //以下練習正則(規)表示式(regular-expression)
						errorMsgs.add("帳號狀態: 只能是CS+兩位數字");
		            }
							
					CoachVO coachVO = new CoachVO();
					coachVO.setCoa_id(coa_id);
					coachVO.setMem_id(mem_id);
					coachVO.setCoa_text(coa_text);
					coachVO.setCoa_status(coa_status);


					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("coachVO", coachVO); // 含有輸入格式錯誤的coachVO物件,也存入req
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front_end/course/coach/update_CoachText.jsp");
						failureView.forward(req, res);
						return; //程式中斷
					}
				
					/***************************2.開始修改資料*****************************************/
					CoachService coachSvc = new CoachService();
					coachVO = coachSvc.updateCoach(coa_id, mem_id, coa_text, coa_status);
							
					/***************************3.修改完成,準備轉交(Send the Success view)*************/
					req.setAttribute("coachVO", coachVO); // 資料庫update成功後,正確的的coachVO物件,存入req
					String url = "/front_end/course/coach/update_CoachText.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneCoach.jsp
					successView.forward(req, res);

					/***************************其他可能的錯誤處理*************************************/
//				} catch (Exception e) {
//					errorMsgs.add("修改資料失敗:"+e.getMessage());
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front_end/course/coach/update_CoachText.jsp");
//					failureView.forward(req, res);
//				}
			}

	        if ("insert".equals(action)) { // 來自addCoachText.jsp的請求  
				
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);

//				try {
					/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
					String mem_id = new String (req.getParameter("mem_id").trim());

		            String coa_text = req.getParameter("coa_text");
					
					String coa_status = req.getParameter("coa_status").trim();



					CoachVO coachVO = new CoachVO();
					coachVO.setMem_id(mem_id);
					coachVO.setCoa_text(coa_text);
					coachVO.setCoa_status(coa_status);

					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("coachVO", coachVO); // 含有輸入格式錯誤的coachVO物件,也存入req
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front_end/course/coach/addCoachText.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.開始新增資料***************************************/
					CoachService coachSvc = new CoachService();
					coachVO = coachSvc.addCoach(mem_id, coa_text, coa_status);
					
					/***************************3.新增完成,準備轉交(Send the Success view)***********/
					String url = "/front_end/course/coach/addCoachText.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllCourlist.jsp
					successView.forward(req, res);				
					
					/***************************其他可能的錯誤處理**********************************/
//				} catch (Exception e) {
//					errorMsgs.add("新增資料失敗:"+e.getMessage());
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front_end/course/courlist/addCoachText.jsp");
//					failureView.forward(req, res);
//				}
			}
			

		}
}
