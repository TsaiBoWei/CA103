package com.friendlist.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.friendlist.model.FriendListService;
import com.friendlist.model.FriendListVO;

public class FriendListServlet extends HttpServlet{
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)) { // 來自select_friendlist_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			//第一步驟
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				
				//會員A
				String fl_memA_id = req.getParameter("fl_memA_id");
				String fl_memA_idReg ="^M\\d{6}$";
				
				if (fl_memA_id == null || (fl_memA_id).length() == 0) {
					errorMsgs.add("請輸入A會員編號，請勿空白");
				}else if(!fl_memA_id.trim().matches(fl_memA_idReg)) {
					errorMsgs.add("格式輸入錯誤，會員編號只能是英文 M 開頭加六位 0-9 數字");
				}
				//Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/friendlist/select_friendlist_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
			
				//會員A的好友清單內的會員B
				String fl_memB_id = req.getParameter("fl_memB_id");
				String fl_memB_idReg ="^M\\d{6}$";
				if (fl_memB_id == null || (fl_memB_id).length() == 0) {
					errorMsgs.add("請輸入B會員編號，請勿空白");
				}else if(!fl_memB_id.trim().matches(fl_memB_idReg)) {
					errorMsgs.add("格式輸入錯誤，會員編號只能是英文 M 開頭加六位 0-9 數字");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/friendlist/select_friendlist_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
			
				/***************************2.開始查詢資料*****************************************/
				FriendListService friendlistSvc = new FriendListService();
				FriendListVO firendlistVO = friendlistSvc.getOneFriendList(fl_memA_id,fl_memB_id);
				if (firendlistVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/friendlist/select_friendlist_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("firendlistVO", firendlistVO); // 資料庫取出的empVO物件,存入req
				String url ="/front_end/friendlist/listOneFriendList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);
			
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/friendlist/select_friendlist_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		//第二步驟
		if ("getOne_For_Update".equals(action)) { // 來自listAllFriend.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {		
				/***************************1.接收請求參數****************************************/
				String fl_memA_id = new String(req.getParameter("fl_memA_id"));
				String fl_memB_id = new String(req.getParameter("fl_memB_id"));
				
				/***************************2.開始查詢資料****************************************/
				FriendListService friendlistSvc = new FriendListService();
				FriendListVO firendlistVO = friendlistSvc.getOneFriendList(fl_memA_id, fl_memB_id);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("firendlistVO", firendlistVO);         // 資料庫取出的empVO物件,存入req
				String url ="/front_end/friendlist/update_friendlist_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
				/***************************其他可能的錯誤處理**********************************/
			} catch(Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/emp/listAllEmp.jsp");
				failureView.forward(req, res);
			}
		}
		
		//第三步驟 修改
		if ("update".equals(action)) { // 來自update_friendlist_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				String fl_memA_id = new String (req.getParameter("fl_memA_id").trim());
				String fl_memB_id = new String (req.getParameter("fl_memB_id").trim());
				
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String fl_friend_name = req.getParameter("fl_friend_name");
				String fl_friend_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (fl_friend_name == null || fl_friend_name.trim().length() == 0) {
					errorMsgs.add("好友姓名: 請勿空白");
				} else if(!fl_friend_name.trim().matches(fl_friend_nameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("好友姓名: 只能是中、英文字母、數字和_ , 且長度必需在3到24之間");
	            }
				
				String fl_status = req.getParameter("fl_status").trim();
				if (fl_status == null || fl_status.trim().length() == 0) {
					errorMsgs.add("發起好友邀清的狀態請勿空白");
				}	
				
				String fl_block = req.getParameter("fl_block");
				if (fl_status == null || fl_status.trim().length() == 0) {
					errorMsgs.add("好友是否封鎖的狀態請勿空白");
				}	
				
				FriendListVO firendlistVO = new FriendListVO();	
				firendlistVO.setFl_memA_id(fl_memA_id);
				firendlistVO.setFl_memB_id(fl_memB_id);
				firendlistVO.setFl_friend_name(fl_friend_name);
				firendlistVO.setFl_status(fl_status);
				firendlistVO.setFl_block(fl_block);
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("firendlistVO", firendlistVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/friendlist/update_friendlist_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				/***************************2.開始修改資料*****************************************/
				FriendListService friendlistSvc = new FriendListService();
				firendlistVO = friendlistSvc.UpdateFriendList(fl_memA_id, fl_memB_id, fl_friend_name, fl_status, fl_block);
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("firendlistVO", firendlistVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url ="/front_end/friendlist/listOneFriendList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch(Exception e){
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/friendlist/update_friendlist_input.jsp");
				failureView.forward(req, res);
			}
		}
	
		//第四步驟 新增(發出好友邀請)
        if ("insert".equals(action)) { // 來自addfriend1014.jsp的請求  
        	
        	System.out.println("success");
			PrintWriter out=res.getWriter();
			
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
			
				String fl_memA_id = req.getParameter("fl_memA_id");
				String fl_memB_id = req.getParameter("fl_memB_id");
				String fl_status = "FLS0";				
				String fl_block = "FLB0";
				String fl_friend_name=null;

				FriendListVO firendlistVO = new FriendListVO();
				firendlistVO.setFl_memA_id(fl_memA_id);
				firendlistVO.setFl_memB_id(fl_memB_id);
				firendlistVO.setFl_friend_name(fl_friend_name);
				firendlistVO.setFl_status(fl_status);
				firendlistVO.setFl_block(fl_block);
				

				/***************************2.開始新增資料***************************************/
				FriendListService friendlistSvc = new FriendListService();
				firendlistVO = friendlistSvc.addFriendList(fl_memA_id, fl_memB_id, fl_friend_name, fl_status, fl_block);
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				out.print("success");	
				/***************************其他可能的錯誤處理***********************************/
				
			} catch(Exception e){
				out.print(e.getMessage());
			}
        }

        
        
        //第五步驟刪除
		if ("delete".equals(action)) { // 來自listAllFriendList.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數***************************************/
				String fl_memA_id = new String(req.getParameter("fl_memA_id"));
				String fl_memB_id = new String(req.getParameter("fl_memB_id"));
				
				/***************************2.開始刪除資料***************************************/
				FriendListService friendlistSvc = new FriendListService();
				friendlistSvc.deleteFriendList(fl_memA_id, fl_memB_id);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								

				String url ="/front_end/friendlist/listAllFriendList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+ e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/friendlist/listAllFriendList.jsp");
				failureView.forward(req, res);
			}
		}
		
		//第六步驟 新增(確認成為好友)
        if ("insert_friend".equals(action)) { // 來自addfriend1014.jsp的請求  
        	
        	System.out.println("success2");
			PrintWriter out=res.getWriter();
			
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
			
				String fl_memA_id = req.getParameter("fl_memA_id");
				String fl_memB_id = req.getParameter("fl_memB_id");
				String fl_status = "FLS1";				
				String fl_block = "FLB0";
				String fl_friend_name=null;

				FriendListVO firendlistVO = new FriendListVO();
				firendlistVO.setFl_memA_id(fl_memA_id);
				firendlistVO.setFl_memB_id(fl_memB_id);
				firendlistVO.setFl_friend_name(fl_friend_name);
				firendlistVO.setFl_status(fl_status);
				firendlistVO.setFl_block(fl_block);
				

				/***************************2.開始新增資料***************************************/
				FriendListService friendlistSvc = new FriendListService();
				if(friendlistSvc.getOneFriendList(fl_memA_id, fl_memB_id)==null) {
					friendlistSvc.addFriendList(fl_memA_id, fl_memB_id, fl_friend_name, fl_status, fl_block);
				}else {
					friendlistSvc.UpdateFriendList(fl_memA_id, fl_memB_id, fl_friend_name, fl_status, fl_block);
				}
				if(friendlistSvc.getOneFriendList(fl_memB_id,fl_memA_id)==null) {
					friendlistSvc.addFriendList( fl_memB_id,fl_memA_id, fl_friend_name, fl_status, fl_block);
				}else {
					friendlistSvc.UpdateFriendList(fl_memB_id,fl_memA_id, fl_friend_name, fl_status, fl_block);
				}
				
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				out.print("success");	
				/***************************其他可能的錯誤處理***********************************/
				
			} catch(Exception e){
				out.print(e.getMessage());
			}
        }
	}
}
