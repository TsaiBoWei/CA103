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

		if ("getOne_For_Display".equals(action)) { // �Ӧ�select_eventsave_page.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/

				//�|���s������
				String mem_id = req.getParameter("mem_id");
				String mem_iddReg ="^M\\d{6}$";
				if (mem_id == null || (mem_id.trim()).length() == 0) {
					errorMsgs.add("�п�J�|���s��");
				}else if(!mem_id.trim().matches(mem_iddReg)) {
					errorMsgs.add("�榡��J���~�A�|���s���u��O�^�� M �}�Y�[���� 0-9 �Ʀr");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventsave/select_eventsave_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}

				//���ʽs������
				String eve_id = req.getParameter("eve_id");
				String eve_idReg ="^E\\d{6}$";
				if (eve_id == null || (eve_id).length() == 0) {
					errorMsgs.add("�п�J���ʽs���A�ФŪť�");
				}else if(!eve_id.trim().matches(eve_idReg)) {
					errorMsgs.add("�榡��J���~�A���ʽs���u��O�^�� E �}�Y�[���� 0-9 �Ʀr");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventsave/select_eventsave_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}

				/***************************2.�}�l�d�߸��*****************************************/
				EventSaveService eventSaveSvc = new EventSaveService();
				EventSaveVO eventsaveVO = eventSaveSvc.getOneEventSave(mem_id, eve_id);
				if (eventsaveVO == null) {
					errorMsgs.add("�d�L���");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventsave/select_eventsave_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}

				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)*************/
				req.setAttribute("eventsaveVO", eventsaveVO); // ��Ʈw���X��empVO����,�s�Jreq
				String url = "/front_end/event/eventsave/listOneEvenSave.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneEmp.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventsave/select_eventsave_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllFriend.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {		
				/***************************1.�����ШD�Ѽ�****************************************/
				String mem_id = new String(req.getParameter("mem_id"));
				String eve_id = new String(req.getParameter("eve_id"));

				/***************************2.�}�l�d�߸��****************************************/
				EventSaveService eventSaveSvc = new EventSaveService();
				EventSaveVO eventsaveVO = eventSaveSvc.getOneEventSave(mem_id, eve_id);

				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("eventsaveVO", eventsaveVO);         // ��Ʈw���X��empVO����,�s�Jreq
				String url ="/front_end/event/eventsave/update_eventsave_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
				successView.forward(req, res);
				/***************************��L�i�઺���~�B�z**********************************/
			} catch(Exception e) {
				errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventsave/listAllEventSave.jsp");
				failureView.forward(req, res);
			}
		}

		//�ק�
		if ("update".equals(action)) { // �Ӧ�update_eventsave_input.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String mem_id = new String (req.getParameter("mem_id").trim());
				String eve_id = new String (req.getParameter("eve_id").trim());

				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				String es_status = req.getParameter("es_status");
				if (es_status == null || es_status.trim().length() == 0) {
					errorMsgs.add("���ʦ��ê��A�ФŪť�");
				}		

				EventSaveVO eventsaveVO = new EventSaveVO();	
				eventsaveVO.setMem_id(mem_id);
				eventsaveVO.setEve_id(eve_id);
				eventsaveVO.setEs_status(es_status);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("eventsaveVO", eventsaveVO); // �t����J�榡���~��empVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventsave/update_eventsave_input.jsp");
					failureView.forward(req, res);
					return; //�{�����_
				}
				/***************************2.�}�l�ק���*****************************************/
				EventSaveService eventSaveSvc = new EventSaveService();
				eventsaveVO = eventSaveSvc.UpdateEventSave(mem_id, eve_id, es_status);
				/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/
				req.setAttribute("eventsaveVO", eventsaveVO); // ��Ʈwupdate���\��,���T����empVO����,�s�Jreq
				String url ="/front_end/event/eventsave/listOneEvenSave.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �ק令�\��,���listOneEmp.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch(Exception e){
				errorMsgs.add("�ק��ƥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventsave/update_eventsave_input.jsp");
				failureView.forward(req, res);
			}
		}

		//�s�W
		if ("insert".equals(action)) { // �Ӧ�addFriendList.jsp���ШD  
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				//�|���s������
				String mem_id = req.getParameter("mem_id");
				String mem_iddReg ="^M\\d{6}$";
				if (mem_id == null || (mem_id.trim()).length() == 0) {
					errorMsgs.add("�п�J�|���s��");
				}else if(!mem_id.trim().matches(mem_iddReg)) {
					errorMsgs.add("�榡��J���~�A�|���s���u��O�^�� M �}�Y�[���� 0-9 �Ʀr");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventsave/select_eventsave_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				//���ʽs������
				String eve_id = req.getParameter("eve_id");
				String eve_idReg ="^E\\d{6}$";
				if (eve_id == null || (eve_id).length() == 0) {
					errorMsgs.add("�п�JB�|���s���A�ФŪť�");
				}else if(!eve_id.trim().matches(eve_idReg)) {
					errorMsgs.add("�榡��J���~�A���ʽs���u��O�^�� E �}�Y�[���� 0-9 �Ʀr");
				}

				//���ʦ��ê��A����
				String es_status = req.getParameter("es_status").trim();
				if (es_status == null || es_status.trim().length() == 0) {
					errorMsgs.add("���ʦ��ê��A�A�ФŪť�");
				}


				EventSaveVO eventsaveVO = new EventSaveVO();
				eventsaveVO.setMem_id(mem_id);
				eventsaveVO.setEve_id(eve_id);
				eventsaveVO.setEs_status(es_status);
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("eventsaveVO", eventsaveVO); // �t����J�榡���~��empVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventsave/select_eventsave_page.jsp");
					failureView.forward(req, res);
					return; //�{�����_
				}
				/***************************2.�}�l�s�W���***************************************/
				EventSaveService eventSaveSvc = new EventSaveService();
				eventsaveVO = eventSaveSvc.addEventSave(mem_id, eve_id, es_status);			
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				
				String url ="/front_end/event/eventsave/eveSave.jsp";
				System.out.println(url);
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllEmp.jsp
				
				successView.forward(req, res);	
				
				/***************************��L�i�઺���~�B�z***********************************/

			} catch(Exception e){
				errorMsgs.add("�s�W��ƥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventsave/addEventSave.jsp");
				failureView.forward(req, res);
			}
		}

		//�R��
		if ("delete".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.�����ШD�Ѽ�***************************************/
				String mem_id = new String(req.getParameter("mem_id"));
				String eve_id = new String(req.getParameter("eve_id"));

				/***************************2.�}�l�R�����***************************************/
				EventSaveService eventSaveSvc = new EventSaveService();
				eventSaveSvc.deleteEventSave(mem_id, eve_id);

				/***************************3.�R������,�ǳ����(Send the Success view)***********/								

				String url ="/front_end/event/eventsave/eveSave.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�R����ƥ���:"+ e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventsave/listAllEventSave.jsp");
				failureView.forward(req, res);
			}
		}      
	}
}
