package com.Post.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Post.model.PostService;
import com.Post.model.PostVO;
import com.mem.model.MemService;
import com.mem.model.MemVO;

public class memHomepageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		String action = req.getParameter("action");
		
		if ( "toHomePage".equals(action) ) {
						
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");
			try {
System.out.println("1");
				String mem_id = req.getParameter("mem_id");
System.out.println(mem_id);
				PostService postSvc = new PostService();
				List<PostVO> postVO = new ArrayList<PostVO>();				
				postVO = postSvc.getByMemIDToHomePage(mem_id);
				
				MemVO memVO = new MemVO();
				MemService memSvc = new MemService();
				memVO=memSvc.getOneMem(mem_id);
				
				
				req.setAttribute("memVOtoHg", memVO);
				req.setAttribute("postVOtoHg", postVO);
				String url ="/front_end/post/HomePage.jsp"; 
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交HomePage.jsp
				successView.forward(req, res);
System.out.println("2");
			}catch(Exception e) {
				
				errorMsgs.add(e.getMessage() + "無法進入該會員個人網頁貼文，可能該會員帳號已被註銷");
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);								
				
			}
			
			
		}
		
		
	}
}
