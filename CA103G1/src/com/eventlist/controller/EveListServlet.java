package com.eventlist.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.eve.model.*;
import com.eventlist.model.*;
import com.mem.model.MemService;
import com.mem.model.MemVO;







public class EveListServlet extends HttpServlet {


    Send se = new Send();
       
    public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
				
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getEvelists_By_EVE".equals(action)) { // �Ӧ�select_page.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.�����ШD�Ѽ� **********************/
				String eve_id = req.getParameter("eve_id");
			
				/***************************2.�}�l�d�߸��*****************************************/
				EventlistService eveListSvc = new EventlistService();
				List<EventListVO> eveListsByEve=eveListSvc.getEveListsByEve(eve_id);
//				if(eveListsByEve.size()==0) {
//					errorMsgs.add("�d�L���");
//				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventlist/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)*************/
				req.setAttribute("eveListsByEve",eveListsByEve); // ��Ʈw���X��empVO����,�s�Jreq				
				String url =req.getContextPath()+ "/front_end/event/eventlist/EvelistsByEve.jsp";		
				HttpSession session=req.getSession();
//				session.setAttribute("eveListsByEve", eveListsByEve);
				session.setAttribute("eve_id", eve_id);
				res.sendRedirect(url);
				return;//�{�����_

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventlist/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Display".equals(action)) { // �Ӧ�select_page.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.�����ШD�Ѽ� **********************/
				String eve_id = req.getParameter("eve_id");
				String mem_id = req.getParameter("mem_id");
			
				/***************************2.�}�l�d�߸��*****************************************/
				EventlistService eveListSvc = new EventlistService();
				EventListVO eventListVO=eveListSvc.getOneEveList(mem_id,eve_id);
				if(eventListVO==null) {
					errorMsgs.add("�d�L���");
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventlist/select_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)*************/
				req.setAttribute("eventListVO",eventListVO); // ��Ʈw���X��empVO����,�s�Jreq				
				String url ="/front_end/event/eventlist/listOneEvelist.jsp";		
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneEvelist.jsp
				successView.forward(req, res);
				
				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventlist/select_page.jsp");
				failureView.forward(req, res);
			}			
		}
		
		
		if ("insert".equals(action)) { // �Ӧ�addeveList.jsp���ШD  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				String mem_id = req.getParameter("mem_id").trim();;				
				String  eve_id= req.getParameter("eve_id").trim();
				
				Integer evepay_amount=null;
				try {
					evepay_amount=new Integer(req.getParameter("evepay_amount").trim());
				}catch(NumberFormatException e) {
					evepay_amount=0;
					errorMsgs.add("�I�ڪ��B����ƼƦr.");
				}
				
				java.sql.Date evepay_deadline = null;
				try {
					evepay_deadline = java.sql.Date.valueOf(req.getParameter("evepay_deadline").trim());
				} catch (IllegalArgumentException e) {
					evepay_deadline=new java.sql.Date(System.currentTimeMillis()+1000*86400*3);
					errorMsgs.add("�п�J���!");
				}
						
				String evelist_status ="EL0";
				if (evepay_amount>0) {
					 evelist_status ="EL1";
				}
				
				String eve_share ="ES0";				
				Integer eve_rating = 0;


				EventListVO eventListVO = new EventListVO();
				eventListVO.setMem_id(mem_id);
				eventListVO.setEve_id(eve_id);
				eventListVO.setEvepay_amount(evepay_amount);
				eventListVO.setEvepay_deadline(evepay_deadline);
				eventListVO.setEvelist_status(evelist_status);
				eventListVO.setEve_share(eve_share);
				eventListVO.setEve_rating(eve_rating);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("eventListVO", eventListVO); // �t����J�榡���~��eventListVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventlist/addeveList.jsp");
					failureView.forward(req, res);
					return;
				}
				System.out.println(mem_id);
				System.out.println(eve_id);
				System.out.println(eve_rating);
				System.out.println(evelist_status);
				System.out.println(evepay_amount);
				System.out.println(eve_share);
				System.out.println(evepay_deadline);
				System.out.println();
				/***************************2.�}�l�s�W���***************************************/
				EventlistService eveListSvc = new EventlistService();
				eventListVO=eveListSvc.addEveList(mem_id, eve_id, eve_rating, evelist_status, evepay_amount, eve_share, evepay_deadline);
				
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				
				if(evepay_amount==0) {
					List<EventListVO> eveListsByMem=eveListSvc.getEveListsByMem(mem_id);
					String url =req.getContextPath()+ "/front_end/event/eventlist/listEvesByMem.jsp";		
					HttpSession session=req.getSession();
					session.setAttribute("eveListsByMem", eveListsByMem);
					res.sendRedirect(url);
					return;//�{�����_		
				}
				//Bootstrap_modal
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				req.setAttribute("eventListVO",eventListVO );
				EveService eveSvc=new EveService();
				EventVO eveVO=eveSvc.getOneEve(eve_id);
				req.setAttribute("eveVO",eveVO );
				String url ="/front_end/event/eventlist/addeveList.jsp";		
				RequestDispatcher sucessView = req.getRequestDispatcher(url);
				sucessView.forward(req, res);
				return;//�{�����_
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventlist/addeveList.jsp");
				failureView.forward(req, res);
				e.printStackTrace();
			}
		}
		
		
//		if ("getOne_For_Update".equals(action)) { // �Ӧ�EvelistsByEve.jsp���ШD  
//			
//			List<String> errorMsgs = new LinkedList<String>();
//			try {
//				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
//				String mem_id = req.getParameter("mem_id");
//				String eve_id=req.getParameter("eve_id");
//				
//				/***************************2.�}�l�d�߸��****************************************/
//				EventlistService eveListSvc = new EventlistService();
//				EventListVO eventListVO=eveListSvc.getOneEveList(mem_id, eve_id);
//								
//				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
//				
//				req.setAttribute("eventListVO", eventListVO);         // ��Ʈw���X��eventListVO����,�s�Jreq
//				String url = "/front_end/event/eventlist/update_evelist_input.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_evelist_input.jsp
//				successView.forward(req, res);
//
//				/***************************��L�i�઺���~�B�z**********************************/
//			} catch (Exception e) {
//				errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
//				HttpSession session=req.getSession();
//				session.setAttribute("errorMsgs", errorMsgs);
//				res.sendRedirect(req.getContextPath()+"/front_end/event/eventlist/EvelistsByEve.jsp");
//				return;
//			}
//		}
		
//		
//		if ("update".equals(action)) { // �Ӧ�update_evelist_input.jsp���ШD
//		
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//			
//		
//			try {
//				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
//				
//				String mem_id = req.getParameter("mem_id");
//				
//				String enameReg = "^M\\d{6}$";
//				if (mem_id == null || mem_id.trim().length() == 0) {
//					errorMsgs.add("�|���s��: �ФŪť�");
//				} else if(!mem_id.trim().matches(enameReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
//					errorMsgs.add("�|���s��: �u��}�Y�OM�A�B�ᱵ����6���Ʀr");
//	            }
//				
//				String  eve_id= req.getParameter("eve_id").trim();
//				
//				Integer evepay_amount=null;
//				try {
//					evepay_amount=new Integer(req.getParameter("evepay_amount").trim());
//				}catch(NumberFormatException e) {
//					evepay_amount=0;
//					errorMsgs.add("�I�ڪ��B����ƼƦr.");
//				}
//			
//				java.sql.Date evepay_deadline = null;
//				if(req.getParameter("evepay_deadline")!=null) {
//					try {
//						evepay_deadline = java.sql.Date.valueOf(req.getParameter("evepay_deadline").trim());
//					} catch (IllegalArgumentException e) {
//						evepay_deadline=new java.sql.Date(System.currentTimeMillis()+1000*86400*3);
//						errorMsgs.add("�п�J���!");
//					}
//				}
//				
//				
//				String evelist_status = req.getParameter("evelist_status").trim();
//				if (evelist_status == null || evelist_status.trim().length() == 0) {
//					errorMsgs.add("���ʲM�檬�A�ФŪť�");
//				}
//				
//				String eve_share = req.getParameter("eve_share").trim();
//				if (eve_share == null || eve_share.trim().length() == 0) {
//					errorMsgs.add("���ʤ��ɪ��A�ФŪť�");
//				}
//				
//				Integer eve_rating = 0;
//				try {
//					eve_rating=new Integer(req.getParameter("eve_rating").trim());
//					if(eve_rating>5||eve_rating<1) {
//						eve_rating=0;						
//					}
//				}catch(NumberFormatException e) {
//					eve_rating=0;
//					errorMsgs.add("���ʵ�����1-5�����");
//				}
//				EventListVO eventListVO = new EventListVO();
//				eventListVO.setMem_id(mem_id);
//				eventListVO.setEve_id(eve_id);
//				eventListVO.setEvepay_amount(evepay_amount);
//				eventListVO.setEvepay_deadline(evepay_deadline);
//				eventListVO.setEvelist_status(evelist_status);
//				eventListVO.setEve_share(eve_share);
//				eventListVO.setEve_rating(eve_rating);
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("eventListVO", eventListVO); // �t����J�榡���~��eventListVO����,�]�s�Jreq
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front_end/event/eventlist/update_evelist_input.jsp");
//					failureView.forward(req, res);
//					return;
//				}
//				
//				/***************************2.�}�l�ק���***************************************/
//				EventlistService eveListSvc = new EventlistService();
//				eventListVO=eveListSvc.updateEveList(mem_id, eve_id, eve_rating, evelist_status, evepay_amount, eve_share, evepay_deadline);
//				/***************************3.�ק粒��,�ǳ����(Send the Success view)***********/
//				req.setAttribute("eventListVO",eventListVO);
//				String requestURL = req.getParameter("requestURL");
//				if("/front_end/event/eventlist/EvelistsByEve.jsp".equals(requestURL)) {
//					List<EventListVO> list=eveListSvc.getEveListsByEve(eve_id);
//					HttpSession session=req.getSession();
//					session.setAttribute("eveListsByEve", list);	
//				}
//				System.out.println(requestURL);
//				RequestDispatcher successView = req.getRequestDispatcher(requestURL); // �ק令�\����� listOneEvelist.jsp
//				successView.forward(req, res);	
//				
//				/***************************��L�i�઺���~�B�z**********************************/
//			} catch (Exception e) {
//				errorMsgs.add(e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front_end/event/eventlist/update_evelist_input.jsp");
//				failureView.forward(req, res);
//				e.printStackTrace();
//			}
//		}
//		
		if ("delete_By_Participant".equals(action)||"delete_By_Organizer".equals(action)) { // �Ӧ�listEvesByMem.jsp �� listEvesByMem.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
		    req.setAttribute("errorMsgs",errorMsgs );
		    String requestURL = req.getParameter("requestURL");
			try {
				/***************************1.�����ШD�Ѽ�***************************************/
				String mem_id=req.getParameter("mem_id");
				String eve_id=req.getParameter("eve_id");
				String whichPage=req.getParameter("whichPage");
				String evelist_status=null;
				
				EventlistService eveListSvc = new EventlistService();
				EventListVO eventListVO=(EventListVO) eveListSvc.getOneEveList(mem_id, eve_id);
				Integer evepay_amount= eventListVO.getEvepay_amount();
				String ori_evelist_status=eventListVO.getEvelist_status();
				if("delete_By_Participant".equals(action)&& evepay_amount!=0 && ori_evelist_status.equals("EL3")) {				
					evelist_status="EL4";				
				}
				else{
					evelist_status="EL9";
				}
				
				/***************************2.�}�l�R�����***************************************/
				
				eveListSvc.changeEveListStatus(mem_id, eve_id, evelist_status);
				if("/front_end/event/eventlist/EvelistsByEve.jsp".equals(requestURL)) {
//					List<EventListVO> list=eveListSvc.getEveListsByEve(eve_id);
					HttpSession session=req.getSession();
					session.setAttribute("eve_id", eve_id);	
					session.setAttribute("errorMsgs",errorMsgs );
				}
				
				/***************************3.�R������,�ǳ����(Send the Success view)*************/		
//				RequestDispatcher successView = req.getRequestDispatcher(requestURL); // �R�����\��,���^�e�X�R�����ӷ�����
//				successView.forward(req, res);
				res.sendRedirect(requestURL+"?whichPage="+whichPage+"&eve_id="+eve_id+"&mem_id="+mem_id);
				return;//�{�����_
				
				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {				
				errorMsgs.add("�R����ƥ���:" +e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
				e.printStackTrace();
				return;//�{�����_
			}
		}
		
		if ("update_modal".equals(action)) {

			try {
				// Retrieve form parameters.
				String eve_id = req.getParameter("eve_id");
				String mem_id = req.getParameter("mem_id");

				EventlistService eveListSvc = new EventlistService();
				EventListVO eventListVO=eveListSvc.getOneEveList(mem_id,eve_id);

				req.setAttribute("eventListVO", eventListVO); // ��Ʈw���X��empVO����,�s�Jreq
				
//				//Bootstrap_modal
				boolean openupModal=true;
				req.setAttribute("openupModal",openupModal );
				
				// ���X��empVO�e��listOneEmp.jsp
				RequestDispatcher successView = req
						.getRequestDispatcher("/front_end/event/eventlist/listEvesByMem.jsp");
				successView.forward(req, res);
				return;

				// Handle any unusual exceptions
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
		if ("getOne_modal".equals(action)) {

			try {
				// Retrieve form parameters.
				String eve_id = req.getParameter("eve_id");
				String mem_id = req.getParameter("mem_id");

				EventlistService eveListSvc = new EventlistService();
				EventListVO eventListVO=eveListSvc.getOneEveList(mem_id,eve_id);

				req.setAttribute("eventListVO", eventListVO); // ��Ʈw���X��empVO����,�s�Jreq
				
//				//Bootstrap_modal
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				
				// ���X��empVO�e��listOneEmp.jsp
				RequestDispatcher successView = req
						.getRequestDispatcher("/front_end/event/eventlist/listEvesByMem.jsp");
				successView.forward(req, res);
				return;

				// Handle any unusual exceptions
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
		if ("update_ShareStatus".equals(action)) {

			try {
				// Retrieve form parameters.
				String eve_id = req.getParameter("eve_id");
				String mem_id = req.getParameter("mem_id");
				String share_status = req.getParameter("sharestatus");
				
				EventlistService eveListSvc = new EventlistService();
				eveListSvc.changeShareStatus(mem_id, eve_id,share_status);
				EventListVO eventListVO=eveListSvc.getOneEveList(mem_id,eve_id);
				System.out.println(eventListVO.getEve_share());
				RequestDispatcher successView = req
						.getRequestDispatcher("/front_end/event/eventlist/listEvesByMem.jsp");
				successView.forward(req, res);
				return;
				
				// Handle any unusual exceptions
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
		
		if ("Update_ELStatus".equals(action)||"pay_Update_Status".equals(action)) {

			try {
				// Retrieve form parameters.
				String eve_id = req.getParameter("eve_id");
				String mem_id = req.getParameter("mem_id");
				String oriEvelist_Status = req.getParameter("evelist_status");
				String requestURL=req.getParameter("requestURL");
				
				if("pay_Update_Status".equals(action)) {
					oriEvelist_Status ="EL1";
					requestURL=req.getContextPath()+"/front_end/event/eventlist/listEvesByMem.jsp";				
				}
				
				String whichPage=req.getParameter("whichPage");
				String updateEvelist_Status=null;
				
				if(oriEvelist_Status.equals("EL1")) {
					updateEvelist_Status="EL2";
				}
				
				if(oriEvelist_Status.equals("EL2")) {
					updateEvelist_Status="EL3";
				}
//				if(oriEvelist_Status.equals("EL3")) {
//					updateEvelist_Status="EL4";
//				}
				if(oriEvelist_Status.equals("EL4")) {
					updateEvelist_Status="EL5";
				}
				if(oriEvelist_Status.equals("EL5")) {
					updateEvelist_Status="EL6";
				}
				EventlistService eveListSvc = new EventlistService();
				EventListVO eventListVO= eveListSvc.changeEveListStatus(mem_id, eve_id, updateEvelist_Status);
//				List<EventListVO> eveListsByEve=eveListSvc.getEveListsByEve(eve_id);
				HttpSession session=req.getSession();
				session.setAttribute("eve_id", eve_id);
				res.sendRedirect(requestURL+"?whichPage="+whichPage+"&eve_id="+eve_id+"&mem_id="+mem_id);
				
				//�T�{�I�� �o�e²�T
				if(oriEvelist_Status.equals("EL2")) {
					
					MemService memSvc=new MemService();
					String name=memSvc.getOneMem(mem_id).getMem_name();
					EveService eveSvc=new EveService();
					EventVO eveVO=eveSvc.getOneEve(eve_id);
					String eve_title=eveVO.getEve_title();
					Integer evepay_amount=eventListVO.getEvepay_amount();
					Send payMsgSeend = new Send();
				 	String[] tel ={"0975976761"};
				 	String message = name+" �z�n! �w����z�ѻP"+eve_title+"���O�Φ@"+evepay_amount+"�� !  �P�±z���ѻP";
				 	System.out.println(message);
//				 	payMsgSeend.sendMessage(tel , message);
				 	System.out.println("�w�o�e²�T!"); 
					
				}				
				return;
				
//				RequestDispatcher successView = req
//				.getRequestDispatcher(requestURL);
//				successView.forward(req, res);
				
				// Handle any unusual exceptions
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
		if("get_Mem_Evelist".equals(action)) {
			
			res.setContentType("text/html;charset=UTF8");
			PrintWriter out=res.getWriter();
			String mem_account=req.getParameter("mem_account");
			String mem_password=req.getParameter("mem_password");
			String eve_id=req.getParameter("eve_id");
			System.out.println( mem_account);
			System.out.println( mem_password);
			System.out.println( eve_id);
			MemService memSvc=new MemService();
			MemVO memVO=memSvc.loginMem(mem_account, mem_password);
			if(memVO==null) {
				out.print("noneMem");
				return;
			}
			HttpSession session=req.getSession();
//			session.setAttribute("memVO", memVO);
			EventlistService evelistSvc =new EventlistService();
			EventListVO evelistVO=evelistSvc.getOneEveList(memVO.getMem_id(), eve_id);
			 if(evelistVO==null){
				out.print("noneEvelist");				
			}else if(evelistVO.getMem_id()==memVO.getMem_id()) {
				out.print("organizer");
				
			}else {			
				JSONObject evelist = new JSONObject();	
				Map eveListStatusMap=(Map)getServletContext().getAttribute("eveListStatusMap");
				
				String pay_deadline;
				
				if(evelistVO.getEvepay_deadline()==null) {
					pay_deadline="�L";
				}else {
					pay_deadline=evelistVO.getEvepay_deadline().toString();
				}
				
				String pay_amount=null;
				if(evelistVO.getEvepay_amount()==null||evelistVO.getEvepay_amount()==0) {
					pay_amount="�L";
				}else {
					pay_amount=evelistVO.getEvepay_amount().toString();
				}
				System.out.println(pay_amount);
				System.out.println(pay_deadline);
				try {
					//�N����নJSONObject	
					evelist.put("mem_name", memVO.getMem_name());
					evelist.put("evepay_amount", pay_amount);
					evelist.put("evepay_deadline",pay_deadline);
					evelist.put("evelist_status",eveListStatusMap.get(evelistVO.getEvelist_status()));
					out.print(evelist);
				}catch(JSONException e) {
					e.printStackTrace();
				}
				
				
			}
			
		}


	}


}
