package com.eventlist.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.eventlist.model.EventListVO;
import com.eventlist.model.EventlistService;







public class EveListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Map<String,String> eveListStatusMap=null;
       
    public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
				
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		HttpSession mapSession=req.getSession();
		mapSession.setAttribute("eveListStatusMap", eveListStatusMap);
		
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
				if(eveListsByEve.size()==0) {
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
				req.setAttribute("eveListsByEve",eveListsByEve); // ��Ʈw���X��empVO����,�s�Jreq				
				String url =req.getContextPath()+ "/front_end/event/eventlist/EvelistsByEve.jsp";		
				HttpSession session=req.getSession();
				session.setAttribute("eveListsByEve", eveListsByEve);
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
				String mem_id = req.getParameter("mem_id");
				
				String enameReg = "^M\\d{6}$";
				if (mem_id == null || mem_id.trim().length() == 0) {
					errorMsgs.add("�|���s��: �ФŪť�");
				} else if(!mem_id.trim().matches(enameReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|���s��: �u��}�Y�OM�A�B�ᱵ����6���Ʀr");
	            }
				
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
				
				String evelist_status = req.getParameter("evelist_status").trim();
				if (evelist_status == null || evelist_status.trim().length() == 0) {
					errorMsgs.add("���ʲM�檬�A�ФŪť�");
				}
				
				String eve_share = req.getParameter("eve_share").trim();
				if (eve_share == null || eve_share.trim().length() == 0) {
					errorMsgs.add("���ʤ��ɪ��A�ФŪť�");
				}
				
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

				List<EventListVO> eveListsByMem=eveListSvc.getEveListsByMem(mem_id);
				String url =req.getContextPath()+ "/front_end/event/eventlist/listEvesByMem.jsp";		
				HttpSession session=req.getSession();
				session.setAttribute("eveListsByMem", eveListsByMem);
				res.sendRedirect(url);
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
		
		
		if ("getOne_For_Update".equals(action)) { // �Ӧ�EvelistsByEve.jsp���ШD  
			
			List<String> errorMsgs = new LinkedList<String>();
			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				String mem_id = req.getParameter("mem_id");
				String eve_id=req.getParameter("eve_id");
				
				/***************************2.�}�l�d�߸��****************************************/
				EventlistService eveListSvc = new EventlistService();
				EventListVO eventListVO=eveListSvc.getOneEveList(mem_id, eve_id);
								
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				
				req.setAttribute("eventListVO", eventListVO);         // ��Ʈw���X��eventListVO����,�s�Jreq
				String url = "/front_end/event/eventlist/update_evelist_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_evelist_input.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
				HttpSession session=req.getSession();
				session.setAttribute("errorMsgs", errorMsgs);
				res.sendRedirect(req.getContextPath()+"/front_end/event/eventlist/EvelistsByEve.jsp");
				return;
			}
		}
		
		
		if ("update".equals(action)) { // �Ӧ�update_evelist_input.jsp���ШD
		
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
		
			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				
				String mem_id = req.getParameter("mem_id");
				
				String enameReg = "^M\\d{6}$";
				if (mem_id == null || mem_id.trim().length() == 0) {
					errorMsgs.add("�|���s��: �ФŪť�");
				} else if(!mem_id.trim().matches(enameReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�|���s��: �u��}�Y�OM�A�B�ᱵ����6���Ʀr");
	            }
				
				String  eve_id= req.getParameter("eve_id").trim();
				
				Integer evepay_amount=null;
				try {
					evepay_amount=new Integer(req.getParameter("evepay_amount").trim());
				}catch(NumberFormatException e) {
					evepay_amount=0;
					errorMsgs.add("�I�ڪ��B����ƼƦr.");
				}
			
				java.sql.Date evepay_deadline = null;
				if(req.getParameter("evepay_deadline")!=null) {
					try {
						evepay_deadline = java.sql.Date.valueOf(req.getParameter("evepay_deadline").trim());
					} catch (IllegalArgumentException e) {
						evepay_deadline=new java.sql.Date(System.currentTimeMillis()+1000*86400*3);
						errorMsgs.add("�п�J���!");
					}
				}
				
				
				String evelist_status = req.getParameter("evelist_status").trim();
				if (evelist_status == null || evelist_status.trim().length() == 0) {
					errorMsgs.add("���ʲM�檬�A�ФŪť�");
				}
				
				String eve_share = req.getParameter("eve_share").trim();
				if (eve_share == null || eve_share.trim().length() == 0) {
					errorMsgs.add("���ʤ��ɪ��A�ФŪť�");
				}
				
				Integer eve_rating = 0;
				try {
					eve_rating=new Integer(req.getParameter("eve_rating").trim());
					if(eve_rating>5||eve_rating<1) {
						eve_rating=0;						
					}
				}catch(NumberFormatException e) {
					eve_rating=0;
					errorMsgs.add("���ʵ�����1-5�����");
				}
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
							.getRequestDispatcher("/front_end/event/eventlist/update_evelist_input.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.�}�l�ק���***************************************/
				EventlistService eveListSvc = new EventlistService();
				eventListVO=eveListSvc.updateEveList(mem_id, eve_id, eve_rating, evelist_status, evepay_amount, eve_share, evepay_deadline);
				/***************************3.�ק粒��,�ǳ����(Send the Success view)***********/
				req.setAttribute("eventListVO",eventListVO);
				String requestURL = req.getParameter("requestURL");
				if("/front_end/event/eventlist/EvelistsByEve.jsp".equals(requestURL)) {
					List<EventListVO> list=eveListSvc.getEveListsByEve(eve_id);
					HttpSession session=req.getSession();
					session.setAttribute("eveListsByEve", list);	
				}
				System.out.println(requestURL);
				RequestDispatcher successView = req.getRequestDispatcher(requestURL); // �ק令�\����� listOneEvelist.jsp
				successView.forward(req, res);	
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventlist/update_evelist_input.jsp");
				failureView.forward(req, res);
				e.printStackTrace();
			}
		}
		
		if ("delete".equals(action)) { // �Ӧ�listEvesByMem.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
		    req.setAttribute("errorMsgs",errorMsgs );
		    String requestURL = req.getParameter("requestURL");
			try {
				/***************************1.�����ШD�Ѽ�***************************************/
				String mem_id=req.getParameter("mem_id");
				String eve_id=req.getParameter("eve_id");
				String evelist_status="EL9";
				
				/***************************2.�}�l�R�����***************************************/
				EventlistService eveListSvc = new EventlistService();
				eveListSvc.changeEveListStatus(mem_id, eve_id, evelist_status);
				if("/front_end/event/eventlist/EvelistsByEve.jsp".equals(requestURL)) {
					List<EventListVO> list=eveListSvc.getEveListsByEve(eve_id);
					HttpSession session=req.getSession();
					session.setAttribute("eveListsByEve", list);	
					session.setAttribute("errorMsgs",errorMsgs );
				}
				
				/***************************3.�R������,�ǳ����(Send the Success view)*************/		
				RequestDispatcher successView = req.getRequestDispatcher(requestURL); // �R�����\��,���^�e�X�R�����ӷ�����
				successView.forward(req, res);
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
		
		if ("update_status".equals(action)) {

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


	}
	
	
	public void init() {
		eveListStatusMap=new HashMap<>();
		eveListStatusMap.put("EL0", "�����I��");
		eveListStatusMap.put("EL1", "���I��");
		eveListStatusMap.put("EL2", "�w�I�ڥ��T�{");
		eveListStatusMap.put("EL3", "�T�{�w�I��");
		eveListStatusMap.put("EL4", "�h�ڥ��B�z");
		eveListStatusMap.put("EL5", "�w�h�ڥ��T�{");
		eveListStatusMap.put("EL6", "�h�ڤw�T�{");
		eveListStatusMap.put("EL7", "�h�X(�����I��)");
		eveListStatusMap.put("EL9", "����");
		
		
	}

}
