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
		
		if ("getOne_For_Display".equals(action)) { // �Ӧ�select_friendlist_page.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			//�Ĥ@�B�J
			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				
				//�|��A
				String fl_memA_id = req.getParameter("fl_memA_id");
				String fl_memA_idReg ="^M\\d{6}$";
				
				if (fl_memA_id == null || (fl_memA_id).length() == 0) {
					errorMsgs.add("�п�JA�|���s���A�ФŪť�");
				}else if(!fl_memA_id.trim().matches(fl_memA_idReg)) {
					errorMsgs.add("�榡��J���~�A�|���s���u��O�^�� M �}�Y�[���� 0-9 �Ʀr");
				}
				//Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/friendlist/select_friendlist_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
			
				//�|��A���n�ͲM�椺���|��B
				String fl_memB_id = req.getParameter("fl_memB_id");
				String fl_memB_idReg ="^M\\d{6}$";
				if (fl_memB_id == null || (fl_memB_id).length() == 0) {
					errorMsgs.add("�п�JB�|���s���A�ФŪť�");
				}else if(!fl_memB_id.trim().matches(fl_memB_idReg)) {
					errorMsgs.add("�榡��J���~�A�|���s���u��O�^�� M �}�Y�[���� 0-9 �Ʀr");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/friendlist/select_friendlist_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
			
				/***************************2.�}�l�d�߸��*****************************************/
				FriendListService friendlistSvc = new FriendListService();
				FriendListVO firendlistVO = friendlistSvc.getOneFriendList(fl_memA_id,fl_memB_id);
				if (firendlistVO == null) {
					errorMsgs.add("�d�L���");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/friendlist/select_friendlist_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)*************/
				req.setAttribute("firendlistVO", firendlistVO); // ��Ʈw���X��empVO����,�s�Jreq
				String url ="/front_end/friendlist/listOneFriendList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneEmp.jsp
				successView.forward(req, res);
			
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/friendlist/select_friendlist_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		//�ĤG�B�J
		if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllFriend.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {		
				/***************************1.�����ШD�Ѽ�****************************************/
				String fl_memA_id = new String(req.getParameter("fl_memA_id"));
				String fl_memB_id = new String(req.getParameter("fl_memB_id"));
				
				/***************************2.�}�l�d�߸��****************************************/
				FriendListService friendlistSvc = new FriendListService();
				FriendListVO firendlistVO = friendlistSvc.getOneFriendList(fl_memA_id, fl_memB_id);
								
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("firendlistVO", firendlistVO);         // ��Ʈw���X��empVO����,�s�Jreq
				String url ="/front_end/friendlist/update_friendlist_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
				successView.forward(req, res);
				/***************************��L�i�઺���~�B�z**********************************/
			} catch(Exception e) {
				errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/emp/listAllEmp.jsp");
				failureView.forward(req, res);
			}
		}
		
		//�ĤT�B�J �ק�
		if ("update".equals(action)) { // �Ӧ�update_friendlist_input.jsp���ШD
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				String fl_memA_id = new String (req.getParameter("fl_memA_id").trim());
				String fl_memB_id = new String (req.getParameter("fl_memB_id").trim());
				
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				String fl_friend_name = req.getParameter("fl_friend_name");
				String fl_friend_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (fl_friend_name == null || fl_friend_name.trim().length() == 0) {
					errorMsgs.add("�n�ͩm�W: �ФŪť�");
				} else if(!fl_friend_name.trim().matches(fl_friend_nameReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�n�ͩm�W: �u��O���B�^��r���B�Ʀr�M_ , �B���ץ��ݦb3��24����");
	            }
				
				String fl_status = req.getParameter("fl_status").trim();
				if (fl_status == null || fl_status.trim().length() == 0) {
					errorMsgs.add("�o�_�n���ܲM�����A�ФŪť�");
				}	
				
				String fl_block = req.getParameter("fl_block");
				if (fl_status == null || fl_status.trim().length() == 0) {
					errorMsgs.add("�n�ͬO�_���ꪺ���A�ФŪť�");
				}	
				
				FriendListVO firendlistVO = new FriendListVO();	
				firendlistVO.setFl_memA_id(fl_memA_id);
				firendlistVO.setFl_memB_id(fl_memB_id);
				firendlistVO.setFl_friend_name(fl_friend_name);
				firendlistVO.setFl_status(fl_status);
				firendlistVO.setFl_block(fl_block);
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("firendlistVO", firendlistVO); // �t����J�榡���~��empVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/friendlist/update_friendlist_input.jsp");
					failureView.forward(req, res);
					return; //�{�����_
				}
				/***************************2.�}�l�ק���*****************************************/
				FriendListService friendlistSvc = new FriendListService();
				firendlistVO = friendlistSvc.UpdateFriendList(fl_memA_id, fl_memB_id, fl_friend_name, fl_status, fl_block);
				/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/
				req.setAttribute("firendlistVO", firendlistVO); // ��Ʈwupdate���\��,���T����empVO����,�s�Jreq
				String url ="/front_end/friendlist/listOneFriendList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �ק令�\��,���listOneEmp.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch(Exception e){
				errorMsgs.add("�ק��ƥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/friendlist/update_friendlist_input.jsp");
				failureView.forward(req, res);
			}
		}
	
		//�ĥ|�B�J �s�W(�o�X�n���ܽ�)
        if ("insert".equals(action)) { // �Ӧ�addfriend1014.jsp���ШD  
        	
        	System.out.println("success");
			PrintWriter out=res.getWriter();
			
			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
			
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
				

				/***************************2.�}�l�s�W���***************************************/
				FriendListService friendlistSvc = new FriendListService();
				firendlistVO = friendlistSvc.addFriendList(fl_memA_id, fl_memB_id, fl_friend_name, fl_status, fl_block);
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				out.print("success");	
				/***************************��L�i�઺���~�B�z***********************************/
				
			} catch(Exception e){
				out.print(e.getMessage());
			}
        }

        
        
        //�Ĥ��B�J�R��
		if ("delete".equals(action)) { // �Ӧ�listAllFriendList.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.�����ШD�Ѽ�***************************************/
				String fl_memA_id = new String(req.getParameter("fl_memA_id"));
				String fl_memB_id = new String(req.getParameter("fl_memB_id"));
				
				/***************************2.�}�l�R�����***************************************/
				FriendListService friendlistSvc = new FriendListService();
				friendlistSvc.deleteFriendList(fl_memA_id, fl_memB_id);
				
				/***************************3.�R������,�ǳ����(Send the Success view)***********/								

				String url ="/front_end/friendlist/listAllFriendList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
				successView.forward(req, res);
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�R����ƥ���:"+ e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/friendlist/listAllFriendList.jsp");
				failureView.forward(req, res);
			}
		}
		
		//�Ĥ��B�J �s�W(�T�{�����n��)
        if ("insert_friend".equals(action)) { // �Ӧ�addfriend1014.jsp���ШD  
        	
        	System.out.println("success2");
			PrintWriter out=res.getWriter();
			
			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
			
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
				

				/***************************2.�}�l�s�W���***************************************/
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
				
				
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				out.print("success");	
				/***************************��L�i�઺���~�B�z***********************************/
				
			} catch(Exception e){
				out.print(e.getMessage());
			}
        }
	}
}
