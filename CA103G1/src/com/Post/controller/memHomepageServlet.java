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
import com.friendlist.model.FriendListService;
import com.friendlist.model.FriendListVO;
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
				String visitor_mem_id = req.getParameter("visitor_mem_id");
System.out.println(mem_id);
System.out.println(visitor_mem_id);


				FriendListService flSvc= new FriendListService();
				FriendListVO flVO = new FriendListVO();
				
				flVO = flSvc.getOneFriendList(mem_id, visitor_mem_id);

				PostService postSvc = new PostService();
				List<PostVO> postVO = new ArrayList<PostVO>();	
				
				
				if(flVO != null&&flVO.getFl_status().equals("FLS1")) { //�p�G�O�B��
					
					postVO=postSvc.getByMemIDToHomePageToFriend(mem_id);
		System.out.println("yy");			
					
				}else {			//�p�G���O�B��
					
					postVO = postSvc.getByMemIDToHomePage(mem_id);
		System.out.println("xx");			
				}
				
							
				
				
				MemVO memVO = new MemVO();
				MemService memSvc = new MemService();
				memVO=memSvc.getOneMem(mem_id);
				
				
				req.setAttribute("memVOtoHg", memVO);

				req.setAttribute("postVOtoHg", postVO);
	
				String url ="/front_end/post/HomePage.jsp"; 
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\���HomePage.jsp
System.out.println("1.8");	
				successView.forward(req, res);
System.out.println("2");
			}catch(Exception e) {
				e.printStackTrace();
				errorMsgs.add(e.getMessage() + "�L�k�i�J�ӷ|���ӤH�����K��A�i��ӷ|���b���w�Q���P");
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
				System.out.println("3");	
				
			}
			
			
		}
		
		
	}
}
