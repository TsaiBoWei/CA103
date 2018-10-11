package com.eventsave.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eventsave.model.EventSaveService;
import com.eventsave.model.EventSaveVO;
import com.friendlist.model.FriendListService;
import com.friendlist.model.FriendListVO;

public class EventSaveServlet extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { // 來自select_eventsave_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/

				//會員編號驗證
				String mem_id = req.getParameter("mem_id");
				String mem_iddReg ="^M\\d{6}$";
				if (mem_id == null || (mem_id.trim()).length() == 0) {
					errorMsgs.add("請輸入會員編號");
				}else if(!mem_id.trim().matches(mem_iddReg)) {
					errorMsgs.add("格式輸入錯誤，會員編號只能是英文 M 開頭加六位 0-9 數字");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventsave/select_eventsave_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				//活動編號驗證
				String eve_id = req.getParameter("eve_id");
				String eve_idReg ="^E\\d{6}$";
				if (eve_id == null || (eve_id).length() == 0) {
					errorMsgs.add("請輸入活動編號，請勿空白");
				}else if(!eve_id.trim().matches(eve_idReg)) {
					errorMsgs.add("格式輸入錯誤，活動編號只能是英文 E 開頭加六位 0-9 數字");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventsave/select_eventsave_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				/***************************2.開始查詢資料*****************************************/
				EventSaveService eventSaveSvc = new EventSaveService();
				EventSaveVO eventsaveVO = eventSaveSvc.getOneEventSave(mem_id, eve_id);
				if (eventsaveVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventsave/select_eventsave_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("eventsaveVO", eventsaveVO); // 資料庫取出的empVO物件,存入req
				String url = "/front_end/event/eventsave/listOneEvenSave.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventsave/select_eventsave_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllFriend.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {		
				/***************************1.接收請求參數****************************************/
				String mem_id = new String(req.getParameter("mem_id"));
				String eve_id = new String(req.getParameter("eve_id"));

				/***************************2.開始查詢資料****************************************/
				EventSaveService eventSaveSvc = new EventSaveService();
				EventSaveVO eventsaveVO = eventSaveSvc.getOneEventSave(mem_id, eve_id);

				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("eventsaveVO", eventsaveVO);         // 資料庫取出的empVO物件,存入req
				String url ="/front_end/event/eventsave/update_eventsave_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
				/***************************其他可能的錯誤處理**********************************/
			} catch(Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventsave/listAllEventSave.jsp");
				failureView.forward(req, res);
			}
		}

		//修改
		if ("update".equals(action)) { // 來自update_eventsave_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String mem_id = new String (req.getParameter("mem_id").trim());
				String eve_id = new String (req.getParameter("eve_id").trim());

				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String es_status = req.getParameter("es_status");
				if (es_status == null || es_status.trim().length() == 0) {
					errorMsgs.add("活動收藏狀態請勿空白");
				}		

				EventSaveVO eventsaveVO = new EventSaveVO();	
				eventsaveVO.setMem_id(mem_id);
				eventsaveVO.setEve_id(eve_id);
				eventsaveVO.setEs_status(es_status);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("eventsaveVO", eventsaveVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventsave/update_eventsave_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				/***************************2.開始修改資料*****************************************/
				EventSaveService eventSaveSvc = new EventSaveService();
				eventsaveVO = eventSaveSvc.UpdateEventSave(mem_id, eve_id, es_status);
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("eventsaveVO", eventsaveVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url ="/front_end/event/eventsave/listOneEvenSave.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch(Exception e){
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventsave/update_eventsave_input.jsp");
				failureView.forward(req, res);
			}
		}

		//新增
		if ("insert".equals(action)) { // 來自addFriendList.jsp的請求  
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				//會員編號驗證
				String mem_id = req.getParameter("mem_id");
				String mem_iddReg ="^M\\d{6}$";
				if (mem_id == null || (mem_id.trim()).length() == 0) {
					errorMsgs.add("請輸入會員編號");
				}else if(!mem_id.trim().matches(mem_iddReg)) {
					errorMsgs.add("格式輸入錯誤，會員編號只能是英文 M 開頭加六位 0-9 數字");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventsave/select_eventsave_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				//活動編號驗證
				String eve_id = req.getParameter("eve_id");
				String eve_idReg ="^E\\d{6}$";
				if (eve_id == null || (eve_id).length() == 0) {
					errorMsgs.add("請輸入B會員編號，請勿空白");
				}else if(!eve_id.trim().matches(eve_idReg)) {
					errorMsgs.add("格式輸入錯誤，活動編號只能是英文 E 開頭加六位 0-9 數字");
				}

				//活動收藏狀態驗證
				String es_status = req.getParameter("es_status").trim();
				if (es_status == null || es_status.trim().length() == 0) {
					errorMsgs.add("活動收藏狀態，請勿空白");
				}


				EventSaveVO eventsaveVO = new EventSaveVO();
				eventsaveVO.setMem_id(mem_id);
				eventsaveVO.setEve_id(eve_id);
				eventsaveVO.setEs_status(es_status);
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("eventsaveVO", eventsaveVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventsave/select_eventsave_page.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				/***************************2.開始新增資料***************************************/
				EventSaveService eventSaveSvc = new EventSaveService();
				eventsaveVO = eventSaveSvc.addEventSave(mem_id, eve_id, es_status);			
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				
				String url ="/front_end/event/eventsave/eveSave.jsp";
				System.out.println(url);
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				
				successView.forward(req, res);	
				
				/***************************其他可能的錯誤處理***********************************/

			} catch(Exception e){
				errorMsgs.add("新增資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventsave/addEventSave.jsp");
				failureView.forward(req, res);
			}
		}

		//刪除
		if ("delete".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數***************************************/
				String mem_id = new String(req.getParameter("mem_id"));
				String eve_id = new String(req.getParameter("eve_id"));

				/***************************2.開始刪除資料***************************************/
				EventSaveService eventSaveSvc = new EventSaveService();
				eventSaveSvc.deleteEventSave(mem_id, eve_id);

				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								

				String url ="/front_end/event/eventsave/eveSave.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+ e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventsave/listAllEventSave.jsp");
				failureView.forward(req, res);
			}
		}      
	}
}
