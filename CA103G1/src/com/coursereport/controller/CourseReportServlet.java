package com.coursereport.controller;

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
import javax.servlet.http.HttpSession;
import com.courlist.model.CourlistVO;
import com.coursereport.model.CourseReportService;
import com.coursereport.model.CourseReportVO;
import com.mem.model.MemVO;

@WebServlet("/CourseReportServlet")
public class CourseReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CourseReportServlet() {
		super();
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("addReport".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String courrepText = req.getParameter("courrepText");
				
				if (courrepText == null || (courrepText.trim()).length() == 0) {
					errorMsgs.add("請輸入檢舉內容");
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					boolean openModal = true;
					req.setAttribute("openModal", openModal);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/courlist/oneCourlist.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始註冊資料 *****************************************/

				String reportItem = req.getParameter("reportItem");
				
				Timestamp ts = new Timestamp(System.currentTimeMillis());  
				
				HttpSession session = req.getSession();
				MemVO memVO = (MemVO) session.getAttribute("memVO");
				CourlistVO courlistVO = (CourlistVO) session.getAttribute("brows_courlistVO");
				CourseReportService courseReportSvc = new CourseReportService();
				courseReportSvc.addCourseRep(ts, courlistVO.getCour_id(), memVO.getMem_id(), reportItem, courrepText);
				
				String url = "/front_end/course/courlist/oneCourlist.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

			} catch (Exception e) {
				errorMsgs.add("錯誤訊息: " + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/mem/login/FailPage.jsp");
				failureView.forward(req, res);
			}

		
			
		}
		
		
	}

}
