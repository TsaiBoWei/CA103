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
	
	/*
	 * 提供以下幾個功能
	 * 單個新增
	 * 單個更新
	 * */
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		
		// 設定請求編碼
		req.setCharacterEncoding("UTF-8");
		// 取得請求中的參數"action"以知道是什麼呼叫servlet的
		String action = req.getParameter("action");
		
		// 判斷是什麼action,並執行相對程式
		// 依照memid 列出所有該會員感興趣的運動
		// 在dao的搜尋條件我有加"只列感興趣"的敘述, 要改再說
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
		}
		
		// 單個運動喜好新增
		if ("getOne_For_Update".equals(action)) {
			// 用來儲存錯誤訊息
			List<String> errorMsgs = new ArrayList<String>();
			// 在requset scope中加入 errorMsgs, 當我們要回傳錯誤訊息給提出要求的頁面時
			// 可以從頁面中getAttribute errorMsgs以得到錯誤資訊
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				MemSpLikeService memService = (MemSpLikeService)req.getAttribute("memSpLikeVO");
			}
			catch(Exception e) {
				
			}
		}

		super.doPost(req, res);
	}

}
