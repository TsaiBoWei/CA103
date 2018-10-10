package com.coachReview.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.coach.model.*;


public class CoachReviewServlet extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		String action = req.getParameter("action");
		
		if ("review".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String coa_id = req.getParameter("coa_id");
				String result=req.getParameter("result");
				/***************************2.開始修改資料*****************************************/
				CoachService coaSvc = new CoachService();
//				CoachVO coaVO=coaSvc.getOneCoach(coa_id);
//				String coa_status=coaVO.getCoa_status();
			
				if("review_pass".equals(result)) {					
					coaSvc.updateStatus(coa_id, "CS02");
				}else {
					coaSvc.updateStatus(coa_id, "CS04");
				}
				
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				String url = "/back_end/review/coachReview.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/review/coachReviewToincluded.jsp");
				failureView.forward(req, res);
			}
		}
		
	}
}
