package com.memsplike.controller;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

import com.memsplike.model.*;

public class MemSpLikeServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		super.doGet(req, resp);
	}	

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		// attritube為 mem_id, sptype_id
		// memsplikeVO
		// 設定請求編碼
		req.setCharacterEncoding("UTF-8");
		// 取得請求中的參數"action"以知道是什麼呼叫servlet的
		String action = req.getParameter("action");
		
		if ("insert".equals(action)) { // 來自addMemSpLike.jsp的請求
			// 用來儲存錯誤訊息
			List<String> errorMsgs = new ArrayList<String>();
			// 在requset scope中加入 errorMsgs, 當我們要回傳錯誤訊息給提出要求的頁面時
			// 可以從頁面中getAttribute errorMsgs以得到錯誤資訊
			req.setAttribute("errorMsgs", errorMsgs);
						
			try {
				String mem_id = req.getParameter("mem_id").trim();
				if ( mem_id == null || mem_id == null )
					errorMsgs.add("會員編號不可為空");
				String sptype_id = req.getParameter("sptype_id").trim();
				if ( sptype_id == null || sptype_id == null )
					errorMsgs.add("運動編號不可為空");
				String like_status =req.getParameter("like_status").trim();
				if ( like_status == null || like_status == null )
					errorMsgs.add("喜好程度不可為空");
				
				MemSpLikeVO memsplikeVO = new MemSpLikeVO(mem_id, sptype_id, like_status);
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memsplikeVO", memsplikeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/memsplike/addMemSpLike.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始新增資料***************************************/
				MemSpLikeService memsplikeSvc = new MemSpLikeService();
				// 查詢是否已有資料
				if ( memsplikeSvc.getOneByMemIdAndSpTypeId(mem_id, sptype_id) != null) {
					errorMsgs.add("已經有該用戶對應該運動之喜好資料");
					req.setAttribute("memsplikeVO", memsplikeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/memsplike/addMemSpLike.jsp");
					failureView.forward(req, res);
					return;
				}
				memsplikeSvc.insert(memsplikeVO);
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/memsplike/listAllMemSpLike.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
			
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/memsplike/addMemSpLike.jsp");
				failureView.forward(req, res);
			}
			
		} // if insert
		
		if ("delete".equals(action)) { // 來自listAllMemSpLike.jsp		
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			
			req.setAttribute("errorMsgs", errorMsgs);
			String mem_id="", sptype_id="";
			try {
				/***************************1.接收請求參數***************************************/
				mem_id = new String(req.getParameter("mem_id"));
				sptype_id = req.getParameter("sptype_id");
				
				/***************************2.開始刪除資料***************************************/
				MemSpLikeService memsplikeSvc = new MemSpLikeService();
				memsplikeSvc.delete(mem_id, sptype_id);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/memsplike/listAllMemSpLike.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage() + mem_id + sptype_id);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/memsplike/listAllMemSpLike.jsp");
				failureView.forward(req, res);
			}
		} // if delete
		
		if ("update".equals(action)) { // 來自listAllMemSpLike.jsp		
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			
			req.setAttribute("errorMsgs", errorMsgs);
			String mem_id="", sptype_id="", like_status="";
			try {
				/***************************1.接收請求參數***************************************/
				mem_id = new String(req.getParameter("mem_id"));
				sptype_id = req.getParameter("sptype_id");
				like_status = req.getParameter("like_status");
				MemSpLikeVO memsplikeVO = new MemSpLikeVO(mem_id, sptype_id, like_status);
				
				/***************************2.開始修改資料***************************************/
				MemSpLikeService memsplikeSvc = new MemSpLikeService();
				memsplikeSvc.update(memsplikeVO);				
				/***************************3.修改完成,準備轉交(Send the Success view)***********/
				req.setAttribute("memsplikeVO", memsplikeVO);
				String url = "/memsplike/listOneMemSpLike.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 更新成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("更新資料失敗:"+e.getMessage() + mem_id + sptype_id);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/memsplike/listAllMemSpLike.jsp");
				failureView.forward(req, res);
			}
		} // if delete
		
		// 更新用
		if ("getOne_For_Update".equals(action)) {
			// 用來儲存錯誤訊息
			List<String> errorMsgs = new ArrayList<String>();
			// 在requset scope中加入 errorMsgs, 當我們要回傳錯誤訊息給提出要求的頁面時
			// 可以從頁面中getAttribute errorMsgs以得到錯誤資訊
			req.setAttribute("errorMsgs", errorMsgs);
			String mem_id="", sptype_id="";
			try {
				/***************************1.接收請求參數****************************************/
				mem_id = req.getParameter("mem_id");
				sptype_id = req.getParameter("sptype_id");
				
				/***************************2.開始查詢資料****************************************/
				MemSpLikeService memService = new MemSpLikeService();
				MemSpLikeVO memsplikeVO = memService.getOneByMemIdAndSpTypeId(mem_id, sptype_id);
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("memsplikeVO", memsplikeVO);
				String url = "/memsplike/update_memsplike_input.jsp";
				// 成功轉交 update_memsplike_input.jsp
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}
			catch(Exception e) {
				errorMsgs.add("無法取得要更新的資料"+ e.getMessage() );
				RequestDispatcher failureView = req
						.getRequestDispatcher("/memsplike/listAllMemSpLike.jsp");
				failureView.forward(req, res);
			}
		} // if getOne_For_Update
		
		if ("get_one_for_display".equals(action)) {
			// 用來儲存錯誤訊息
			List<String> errorMsgs = new ArrayList<String>();
			// 在requset scope中加入 errorMsgs, 當我們要回傳錯誤訊息給提出要求的頁面時
			// 可以從頁面中getAttribute errorMsgs以得到錯誤資訊
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String memid = req.getParameter("mem_id");
				if (memid == null || (memid.trim()).length() == 0) {
					errorMsgs.add("請輸入會員編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/memsplike/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				String sptypeid = req.getParameter("sptype_id");
				if (sptypeid == null || (sptypeid.trim()).length() == 0) {
					errorMsgs.add("請輸入喜好編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/memsplike/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				MemSpLikeService memsplikesvc = new MemSpLikeService();
				MemSpLikeVO memsplikeVO = memsplikesvc.getOneByMemIdAndSpTypeId(memid, sptypeid);
				if (memsplikeVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/memsplike/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("memsplikeVO", memsplikeVO); // 資料庫取出的VO物件,存入req
				String url = "/memsplike/listOneMemSpLike.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneMemSpLike.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/memsplike/select_page.jsp");
				failureView.forward(req, res);
			}			
		} // if get_one_for_display

		if ( "get_list_by_mem_id".equals(action) ) {
			// 用來儲存錯誤訊息
			List<String> errorMsgs = new ArrayList<String>();
			// 在requset scope中加入 errorMsgs, 當我們要回傳錯誤訊息給提出要求的頁面時
			// 可以從頁面中getAttribute errorMsgs以得到錯誤資訊
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = (String)req.getAttribute("mem_id");
				
				if ( str == null || (str.trim()).length() == 0 ) {
					errorMsgs.add("請輸入會員ID");
				}
				else {
					
				}
			}
			catch(Exception e) {
				
			}
		} // if get_list_by_mem_id
		

	}

}
