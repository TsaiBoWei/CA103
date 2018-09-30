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
		// attritube�� mem_id, sptype_id
		// memsplikeVO
		// �]�w�ШD�s�X
		req.setCharacterEncoding("UTF-8");
		// ���o�ШD�����Ѽ�"action"�H���D�O����I�sservlet��
		String action = req.getParameter("action");
		
		if ("insert".equals(action)) { // �Ӧ�addMemSpLike.jsp���ШD
			// �Ψ��x�s���~�T��
			List<String> errorMsgs = new ArrayList<String>();
			// �brequset scope���[�J errorMsgs, ��ڭ̭n�^�ǿ��~�T�������X�n�D��������
			// �i�H�q������getAttribute errorMsgs�H�o����~��T
			req.setAttribute("errorMsgs", errorMsgs);
						
			try {
				String mem_id = req.getParameter("mem_id").trim();
				if ( mem_id == null || mem_id == null )
					errorMsgs.add("�|���s�����i����");
				String sptype_id = req.getParameter("sptype_id").trim();
				if ( sptype_id == null || sptype_id == null )
					errorMsgs.add("�B�ʽs�����i����");
				String like_status =req.getParameter("like_status").trim();
				if ( like_status == null || like_status == null )
					errorMsgs.add("�ߦn�{�פ��i����");
				
				MemSpLikeVO memsplikeVO = new MemSpLikeVO(mem_id, sptype_id, like_status);
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memsplikeVO", memsplikeVO); // �t����J�榡���~��empVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/memsplike/addMemSpLike.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.�}�l�s�W���***************************************/
				MemSpLikeService memsplikeSvc = new MemSpLikeService();
				// �d�߬O�_�w�����
				if ( memsplikeSvc.getOneByMemIdAndSpTypeId(mem_id, sptype_id) != null) {
					errorMsgs.add("�w�g���ӥΤ�����ӹB�ʤ��ߦn���");
					req.setAttribute("memsplikeVO", memsplikeVO); // �t����J�榡���~��empVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/memsplike/addMemSpLike.jsp");
					failureView.forward(req, res);
					return;
				}
				memsplikeSvc.insert(memsplikeVO);
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				String url = "/memsplike/listAllMemSpLike.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllEmp.jsp
				successView.forward(req, res);
			
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/memsplike/addMemSpLike.jsp");
				failureView.forward(req, res);
			}
			
		} // if insert
		
		if ("delete".equals(action)) { // �Ӧ�listAllMemSpLike.jsp		
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			
			req.setAttribute("errorMsgs", errorMsgs);
			String mem_id="", sptype_id="";
			try {
				/***************************1.�����ШD�Ѽ�***************************************/
				mem_id = new String(req.getParameter("mem_id"));
				sptype_id = req.getParameter("sptype_id");
				
				/***************************2.�}�l�R�����***************************************/
				MemSpLikeService memsplikeSvc = new MemSpLikeService();
				memsplikeSvc.delete(mem_id, sptype_id);
				
				/***************************3.�R������,�ǳ����(Send the Success view)***********/								
				String url = "/memsplike/listAllMemSpLike.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
				successView.forward(req, res);
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�R����ƥ���:"+e.getMessage() + mem_id + sptype_id);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/memsplike/listAllMemSpLike.jsp");
				failureView.forward(req, res);
			}
		} // if delete
		
		if ("update".equals(action)) { // �Ӧ�listAllMemSpLike.jsp		
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			
			req.setAttribute("errorMsgs", errorMsgs);
			String mem_id="", sptype_id="", like_status="";
			try {
				/***************************1.�����ШD�Ѽ�***************************************/
				mem_id = new String(req.getParameter("mem_id"));
				sptype_id = req.getParameter("sptype_id");
				like_status = req.getParameter("like_status");
				MemSpLikeVO memsplikeVO = new MemSpLikeVO(mem_id, sptype_id, like_status);
				
				/***************************2.�}�l�ק���***************************************/
				MemSpLikeService memsplikeSvc = new MemSpLikeService();
				memsplikeSvc.update(memsplikeVO);				
				/***************************3.�ק粒��,�ǳ����(Send the Success view)***********/
				req.setAttribute("memsplikeVO", memsplikeVO);
				String url = "/memsplike/listOneMemSpLike.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ��s���\��,���^�e�X�R�����ӷ�����
				successView.forward(req, res);
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("��s��ƥ���:"+e.getMessage() + mem_id + sptype_id);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/memsplike/listAllMemSpLike.jsp");
				failureView.forward(req, res);
			}
		} // if delete
		
		// ��s��
		if ("getOne_For_Update".equals(action)) {
			// �Ψ��x�s���~�T��
			List<String> errorMsgs = new ArrayList<String>();
			// �brequset scope���[�J errorMsgs, ��ڭ̭n�^�ǿ��~�T�������X�n�D��������
			// �i�H�q������getAttribute errorMsgs�H�o����~��T
			req.setAttribute("errorMsgs", errorMsgs);
			String mem_id="", sptype_id="";
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				mem_id = req.getParameter("mem_id");
				sptype_id = req.getParameter("sptype_id");
				
				/***************************2.�}�l�d�߸��****************************************/
				MemSpLikeService memService = new MemSpLikeService();
				MemSpLikeVO memsplikeVO = memService.getOneByMemIdAndSpTypeId(mem_id, sptype_id);
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("memsplikeVO", memsplikeVO);
				String url = "/memsplike/update_memsplike_input.jsp";
				// ���\��� update_memsplike_input.jsp
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}
			catch(Exception e) {
				errorMsgs.add("�L�k���o�n��s�����"+ e.getMessage() );
				RequestDispatcher failureView = req
						.getRequestDispatcher("/memsplike/listAllMemSpLike.jsp");
				failureView.forward(req, res);
			}
		} // if getOne_For_Update
		
		if ("get_one_for_display".equals(action)) {
			// �Ψ��x�s���~�T��
			List<String> errorMsgs = new ArrayList<String>();
			// �brequset scope���[�J errorMsgs, ��ڭ̭n�^�ǿ��~�T�������X�n�D��������
			// �i�H�q������getAttribute errorMsgs�H�o����~��T
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				String memid = req.getParameter("mem_id");
				if (memid == null || (memid.trim()).length() == 0) {
					errorMsgs.add("�п�J�|���s��");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/memsplike/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				String sptypeid = req.getParameter("sptype_id");
				if (sptypeid == null || (sptypeid.trim()).length() == 0) {
					errorMsgs.add("�п�J�ߦn�s��");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/memsplike/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************2.�}�l�d�߸��*****************************************/
				MemSpLikeService memsplikesvc = new MemSpLikeService();
				MemSpLikeVO memsplikeVO = memsplikesvc.getOneByMemIdAndSpTypeId(memid, sptypeid);
				if (memsplikeVO == null) {
					errorMsgs.add("�d�L���");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/memsplike/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)*************/
				req.setAttribute("memsplikeVO", memsplikeVO); // ��Ʈw���X��VO����,�s�Jreq
				String url = "/memsplike/listOneMemSpLike.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneMemSpLike.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/memsplike/select_page.jsp");
				failureView.forward(req, res);
			}			
		} // if get_one_for_display

		if ( "get_list_by_mem_id".equals(action) ) {
			// �Ψ��x�s���~�T��
			List<String> errorMsgs = new ArrayList<String>();
			// �brequset scope���[�J errorMsgs, ��ڭ̭n�^�ǿ��~�T�������X�n�D��������
			// �i�H�q������getAttribute errorMsgs�H�o����~��T
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				String str = (String)req.getAttribute("mem_id");
				
				if ( str == null || (str.trim()).length() == 0 ) {
					errorMsgs.add("�п�J�|��ID");
				}

				List<MemSpLikeVO> memsplikeList = new ArrayList<MemSpLikeVO>();
				req.setAttribute("memsplikeList", memsplikeList);
			}
			catch(Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/memsplike/select_page.jsp");
				failureView.forward(req, res);
			}
		} // if get_list_by_mem_id
		

	}

}
