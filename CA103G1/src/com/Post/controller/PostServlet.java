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

import com.Post.model.*;

public class PostServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doGet(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		req.setCharacterEncoding("utf-8");
		String action = (String)req.getAttribute("action");
		
		if ( "find_by_post_id".equals(action) ) {
			// �x�s���~�T��
			List<String> errorMsgs = new LinkedList<String>();			
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				String post_id = (String)req.getAttribute("post_id");
				/***************************2.�}�l�d�߸��****************************************/
				PostService postservice = new PostService();
				PostVO postVO = new PostVO();				
				postVO = postservice.getOnePost(post_id);
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("postVO", postVO);
				
				// url part �S�g
				
			} catch (Exception e) {
				errorMsgs.add(e.getMessage() + "test");
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/plan/Create_Plan.jsp");
				failureView.forward(req, res);
			}			
		}
		
		else if ( "search_by_mem_id".equals(action) ) {
			// �x�s���~�T��
			List<String> errorMsgs = new LinkedList<String>();			
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				String mem_id = (String)req.getAttribute("mem_id");
				/***************************2.�}�l�d�߸��****************************************/
				PostService postservice = new PostService();
				List<PostVO> postVO = new ArrayList<PostVO>();				
				postVO = postservice.getByMemID(mem_id);
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("postVO", postVO);
				
				// url part �S�g
				
			} catch (Exception e) {
				errorMsgs.add(e.getMessage() + "test");
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/plan/Create_Plan.jsp");
				failureView.forward(req, res);
			}	
		}
		
		else if ( "update_by_post_id".equals(action) ) {
			// �x�s���~�T��
			List<String> errorMsgs = new LinkedList<String>();			
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				
				String post_id = (String)req.getAttribute("post_id");
				String mem_id = (String)req.getAttribute("mem_id");
				String post_con = (String)req.getAttribute("post_con");
				java.sql.Timestamp post_time = ((java.sql.Timestamp)req.getAttribute("post_time"));
				Integer post_view = (Integer)req.getAttribute("post_view");
				String sptype_id = (String)req.getAttribute("sptype_id");
				String post_status = (String)req.getAttribute("post_status");
				String post_title =(String)req.getAttribute("post_title");
				String post_privacy=(String)req.getAttribute("post_privacy");
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
				//�K��W�[�F���A�ݭק�   10/04
				postservice.updatePost(post_id, mem_id, post_con, post_time, post_view, sptype_id, post_status,post_title,post_privacy);
				//postservice.getOnePost(post_id);
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("postVO", postVO);
				
				// url part �S�g
				
			} catch (Exception e) {
				errorMsgs.add(e.getMessage() + "test");
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/plan/Create_Plan.jsp");
				failureView.forward(req, res);
			}	
			
		}
		
		else if ( "insert".equals(action) ) {
			// �x�s���~�T��
			List<String> errorMsgs = new LinkedList<String>();			
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				
				String post_id = (String)req.getAttribute("post_id");
				String mem_id = (String)req.getAttribute("mem_id");
				String post_con = (String)req.getAttribute("post_con");
				java.sql.Timestamp post_time = ((java.sql.Timestamp)req.getAttribute("post_time"));
				Integer post_view = (Integer)req.getAttribute("post_view");
				String sptype_id = (String)req.getAttribute("sptype_id");
				String post_status = (String)req.getAttribute("post_status");
				String post_title =(String)req.getAttribute("post_title");
				String post_privacy=(String)req.getAttribute("post_privacy");
				
				/***************************2.�}�l��s���****************************************/
				PostService postservice = new PostService();
				PostVO postVO = new PostVO();
				postVO.setMem_id(mem_id);
				postVO.setPost_con(post_con);
				postVO.setPost_time(post_time);
				postVO.setPost_view(post_view);
				postVO.setSptype_id(sptype_id);				
				postVO.setPost_title(post_title);
				postVO.setPost_privacy(post_privacy);
								
				postservice.addPost(mem_id, post_con, post_time, post_view, sptype_id,post_title,post_privacy);
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("postVO", postVO);
				
				// url part �S�g
				
			} catch (Exception e) {
				errorMsgs.add(e.getMessage() + "test");
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/plan/Create_Plan.jsp");
				failureView.forward(req, res);
			}	
			
		}
		
	}

}
