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
		
		if ("review".equals(action)) { // �Ӧ�select_page.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				String coa_id = req.getParameter("coa_id");
				String result=req.getParameter("result");
				/***************************2.�}�l�ק���*****************************************/
				CoachService coaSvc = new CoachService();
//				CoachVO coaVO=coaSvc.getOneCoach(coa_id);
//				String coa_status=coaVO.getCoa_status();
			
				if("review_pass".equals(result)) {					
					coaSvc.updateStatus(coa_id, "CS02");
				}else {
					coaSvc.updateStatus(coa_id, "CS04");
				}
				
				
				/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/
				String url = "/back_end/review/coachReview.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\���listOneEmp.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/review/coachReviewToincluded.jsp");
				failureView.forward(req, res);
			}
		}
		
	}
}
