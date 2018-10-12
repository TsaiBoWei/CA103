package com.Post.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.Mgr.model.MgrVO;
import com.Post.model.*;

public class PostServlet extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		String action = req.getParameter("action");
		
		//�s����@�K��
		if ( "find_by_post_id".equals(action) ) {
			// �x�s���~�T��
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);					
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				String post_id = req.getParameter("post_id");
				
				/***************************2.�}�l�d�߸��****************************************/
				PostService postSvc = new PostService();
				PostVO postVO = postSvc.getOnePostToDisplay(post_id);
								
				if (postVO == null) {
					errorMsgs.add("�d�L���,�ӶK��i��w�Q�R���Ϋ���");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/post/listAllPostByMem.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				PostVO postVO1=postSvc.updatePostView(postVO.getPost_view(), postVO.getPost_id());
				postVO1.setMem_id(post_id);
				
				postVO1.setPost_view(postVO.getPost_view());
				
				//�K��W�[�F���A�ݭק�   10/04�w��
				
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/	
				req.setAttribute("postVO", postVO);
				
				String url ="/front_end/post/listOnePost.jsp"; 
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\���listOnePost.jsp
				successView.forward(req, res);
				// url part �S�g
				
			} catch (Exception e) {
				errorMsgs.add(e.getMessage() + "test");
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/post/listAllPostByMem09.jsp");
				failureView.forward(req, res);
			}			
		}
		
//		if ( "search_by_mem_id".equals(action) ) {
//			// �x�s���~�T��
//			List<String> errorMsgs = new LinkedList<String>();			
//			try {
//				/***************************1.�����ШD�Ѽ�****************************************/
//				String mem_id = (String)req.getAttribute("mem_id");
//				/***************************2.�}�l�d�߸��****************************************/
//				PostService postservice = new PostService();
//				List<PostVO> postVO = new ArrayList<PostVO>();				
//				postVO = postservice.getByMemID(mem_id);
//				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
//				req.setAttribute("postVO", postVO);
//				
//				// url part �S�g
//				
//			} catch (Exception e) {
//				errorMsgs.add(e.getMessage() + "test");
//				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/post/Create_Post.jsp");
//				failureView.forward(req, res);
//			}	
//		}
	//�i�J�ק�K�孶��	
	if("getOnePostToUpdate".equals(action)) {
		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);	
		String requestURL = req.getParameter("requestURL");
		
		try{
			String post_id=req.getParameter("post_id");
			PostService postSvc = new PostService();
			PostVO postVO = postSvc.getOnePostToDisplay(post_id);
			req.setAttribute("postVO", postVO);
			String url ="/front_end/post/updatePost.jsp"; 
			RequestDispatcher successView = req.getRequestDispatcher(url); // ���\���listOnePost.jsp
			successView.forward(req, res);
		}catch(Exception e) {
			errorMsgs.add(e.getMessage() + "�L�k���o�K��A�i��w�Q�R��");
			RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
			failureView.forward(req, res);
						
		}
		
	}
	
		//�ק�K��
	 if ( "update_by_post_id".equals(action) ) {
			// �x�s���~�T��
			List<String> errorMsgs = new LinkedList<String>();			
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				
				String post_id = req.getParameter("post_id");
				String mem_id = req.getParameter("mem_id");
				
				String post_con = req.getParameter("post_con");
				if(post_con == null||post_con.trim().length()==0) {					
					errorMsgs.add("�K����D���o�ť�");
				}
				
				Date date=new Date();				
				Timestamp post_time = new Timestamp(date.getTime());
				String post_viewStr = req.getParameter("post_view");
				System.out.println(post_viewStr);
				Integer post_view=null;
				try {
				 post_view=Integer.parseInt(post_viewStr);
						}catch(Exception e) {
							
						post_view=2;	
						}
				
				
				String sptype_id = req.getParameter("sptype_id");
				if(sptype_id == null||sptype_id.trim().length()==0) {					
					errorMsgs.add("�B�����O���o�ť�");
				}
				
				String post_status = "POS0";
				
				String post_title =req.getParameter("post_title");
				System.out.println("Title = " + post_title);
				if(post_title == null||post_title.trim().length()==0) {					
					errorMsgs.add("�K����D���o�ť�");
				}
				
			
				
				
				String post_privacy=req.getParameter("post_privacy");
				if(post_privacy == null||post_privacy.trim().length()==0) {					
					errorMsgs.add("���p�v�]�w���o�ť�");
				}
				/***************************2.�}�l��s���****************************************/
				PostService postservice = new PostService();
				PostVO postVO = new PostVO();
				postVO.setMem_id(mem_id);
				postVO.setPost_con(post_con);
				postVO.setPost_time(post_time);
				postVO.setPost_view(post_view);
				postVO.setSptype_id(sptype_id);
				postVO.setPost_status(post_status);
				postVO.setPost_title(post_title);
				postVO.setPost_privacy(post_privacy);
				//�K��W�[�F���A�ݭק�   10/04�w��
				postservice.updatePost(post_id, mem_id, post_con, post_time, post_view, sptype_id, post_status,post_title,post_privacy);
				//postservice.getOnePost(post_id);
				/***************************3.�ק粒��,�ǳ����(Send the Success view)************/
				req.setAttribute("postVO", postVO);
				String url ="/front_end/post/listAllPostByMem09.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);				
				
				// url part �S�g
				
			} catch (Exception e) {
				e.printStackTrace();
//				errorMsgs.add(e.getMessage() + "test");
//				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/post/listAllPostByMem09.jsp");
//				failureView.forward(req, res);
			}	
			
		}
		
		 if ("insert".equals(action)) {
			// �x�s���~�T��
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
//				
				String mem_id = req.getParameter("mem_id");
				
				
//				String mem_id = "M000001";//���g��
				
				String post_title =req.getParameter("post_title");
				if(post_title == null||post_title.trim().length()==0) {					
					errorMsgs.add("�K����D���o�ť�");
				}
				
				String post_con = req.getParameter("post_con");
				if(post_con == null||post_con.trim().length()==0) {					
					errorMsgs.add("�K�夺�e���o�ť�");
				}
				
				
	     	
	          	  
				
//				try {
					Date date=new Date();				
					Timestamp post_time = new Timestamp(date.getTime());
				
//				}catch(Exception e) {errorMsgs.add("�ɶ��榡���~");}
////				System.out.println(date.toString());
//			
				
				
				String sptype_id = req.getParameter("sptype_id");
				if(sptype_id == null||sptype_id.trim().length()==0) {					
					errorMsgs.add("�B�����O���o�ť�");
				}
				
				
				String post_privacy=req.getParameter("post_privacy");
				if(post_privacy == null||post_privacy.trim().length()==0) {					
					errorMsgs.add("���p�v�]�w���o�ť�");
				}
				
				
				/***************************2.�}�l��s���****************************************/
				
				PostVO postVO = new PostVO();
				postVO.setMem_id(mem_id);
				postVO.setPost_con(post_con);
				postVO.setPost_time(post_time);
			
				postVO.setSptype_id(sptype_id);				
				postVO.setPost_title(post_title);
				postVO.setPost_privacy(post_privacy);
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("postVO", postVO); // �t����J�榡���~��empVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/post/Create_Post.jsp");
					failureView.forward(req, res);
					return;
				}
				PostService postSvc = new PostService();				
				postSvc.addPost(mem_id, post_con, post_time,0, sptype_id,post_title,post_privacy);
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("postVO", postVO);
				String url="/front_end/post/listAllPostByMem09.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllEmp.jsp
				successView.forward(req, res);		
				// url part �S�g
				
			} catch (Exception e) {
				errorMsgs.add(e.getMessage() + "test");
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/post/Create_Post.jsp");
				failureView.forward(req, res);
			}	
			
		}
		 
		 if("delete_post".equals(action)) {
			 List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs );
		 
				try {
					/***************************1.�����ШD�Ѽ�****************************************/
					String post_id = req.getParameter("post_id");
				
					/**************************2.�}�l�R��***********************/
					PostService postSvc = new PostService();
					postSvc.updatePostStatus(post_id,"POS2");
					
					String url="/front_end/post/listAllPostByMem09.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); 
					successView.forward(req, res);
				
				}catch(Exception e) {
					String url="/front_end/post/listAllPostByMem09.jsp";
					errorMsgs.add("�R���K�奢��:" +e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher(url);
					failureView.forward(req, res);
					e.printStackTrace();
					
					return;
					};
				}
		 
			 
		 }
		 
		 
		 
	}


