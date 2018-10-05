package com.eve.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.city.model.CityService;
import com.eve.model.EveService;
import com.eve.model.EventVO;
import com.evechat.controller.JedisPoolUtil;
import com.eventlist.model.EventListVO;
import com.eventlist.model.EventlistService;

@MultipartConfig(fileSizeThreshold = 6 * 1024 * 1024, maxFileSize = 10 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024
* 1024)
public class EveServlet extends HttpServlet {
	

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)) { // �Ӧ�select_page.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				String eve_id = req.getParameter("eve_id");
				/***************************2.�}�l�d�߸��*****************************************/
				EveService eveSvc = new EveService();
				EventVO eveVO = eveSvc.getOneEve(eve_id);
				if (eveVO == null) {
					errorMsgs.add("�d�L���");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eve/select_event_page.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)*************/
				 // ��Ʈw���X��empVO����,�s�Jreq
				req.setAttribute("eveVO", eveVO);
				
				String url = "/front_end/event/eve/listOneEvent.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\���listOneEmp.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eve/select_event_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("insert".equals(action)) { 
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				String eve_title = req.getParameter("eve_title");
//				String etitleReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (eve_title == null || eve_title.trim().length() == 0) {
					errorMsgs.put("eve_title","���ʼ��D: �ФŪť�");
				} 
//				else if(!eve_title.trim().matches(etitleReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
//					errorMsgs.put("eve_title","���ʼ��D: �u��O���B�^��r���B�Ʀr�B_ , �B���צb1��20����");
//	            }
				
				
				String mem_id = req.getParameter("mem_id").trim();
				if (mem_id == null || mem_id.trim().length() == 0) {
					errorMsgs.put("mem_id","�D��H�����|��");
				}
				
				java.sql.Date ereg_startdate = null;
				java.sql.Date ereg_enddate = null;
				try {		
					ereg_startdate = java.sql.Date.valueOf(req.getParameter("ereg_startdate").trim());
					ereg_enddate = java.sql.Date.valueOf(req.getParameter("ereg_enddate").trim());
				} catch (IllegalArgumentException e) {
					errorMsgs.put("ereg_startdate","�п�ܬ��ʳ��W�}�l�P�������!");
				}
				
				Timestamp eve_startdate = null;
				Timestamp eve_enddate = null;
				
				try {
					String eve_startStr=req.getParameter("eve_startdate").trim();					
					String eve_endStr=req.getParameter("eve_enddate").trim();					
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
					eve_startdate=new Timestamp(sdf.parse(eve_startStr).getTime());	
					eve_enddate=new Timestamp(sdf.parse(eve_endStr).getTime());
				} catch (ParseException e) {
					errorMsgs.put("eve_startdate","�п�ܬ��ʶ}�l�P�����ɶ�!");
				}
				
				
				
				Integer estart_limit = null;
				if("1".equals(req.getParameter("estart_limit_check"))){
					try {			
						estart_limit = new Integer(req.getParameter("estart_limit").trim());
						if(estart_limit<0) {
							errorMsgs.put("estart_limit","���ʳ̧C�H�ƽж�j��0��ƼƦr.");
						}
					} catch (NumberFormatException e) {
						estart_limit = 0;
						errorMsgs.put("estart_limit","���ʳ̧C�H�ƽж��ƼƦr.");
					}
				}else {
					estart_limit = 0;
				}
				Integer estart_max = null;
				if("1".equals(req.getParameter("estart_max_check"))){
					try {			
						estart_max = new Integer(req.getParameter("estart_max").trim());
						if(estart_max<0) {
							errorMsgs.put("estart_max","���ʤW���H�ƽж�j��0��ƼƦr.");
						}else if(estart_max<estart_limit) {
							errorMsgs.put("estart_max","���ʤW���H�ƻݤj�󬡰ʳ̧C�H��");
						}
					} catch (NumberFormatException e) {
						estart_max = 0;
						errorMsgs.put("estart_max","���ʳ̧C�H�ƽж��ƼƦr.");
					}
				}else {
					estart_max =0;
				}
				
				
				String city_id=req.getParameter("city_id");
				String eve_location=req.getParameter("eve_location").trim();
				if (eve_location == null || eve_location.trim().length() == 0) {
					errorMsgs.put("eve_location","���ʦa�I�ФŪť�");
				}
				
				Integer eve_charge = null;
				if("1".equals(req.getParameter("eve_charge_check"))){
					try {			
						eve_charge = new Integer(req.getParameter("eve_charge").trim());
						if(eve_charge<0) {
							errorMsgs.put("eve_charge","���ʶO�νж�j��0��ƼƦr.");
						}
					} catch (NumberFormatException e) {
						eve_charge = 0;
						errorMsgs.put("eve_charge","���ʶO�νж��ƼƦr.");
					}
				}else {
					eve_charge = 0;
				}
				
				String econtact_info=req.getParameter("econtact_info");
				String econctReg = "^09[0-9]{2}-\\d{6}$";
				if (econtact_info == null || econtact_info.trim().length() == 0) {
					errorMsgs.put("econtact_info","�ж�W������X");
				} else if(!econtact_info.trim().matches(econctReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.put("econtact_info","������X: �榡�ж�09XX-XXXXXX");
	            }
				
				String eve_content=req.getParameter("eve_content");
				if (eve_content == null || eve_content.trim().length() == 0) {
					errorMsgs.put("eve_content","�ж�W���ʱԭz");
				}
				
				String eve_status=null;
				if(eve_charge>500||estart_limit>20) {
					eve_status="E1";
				}else if(estart_limit>0) {
					eve_status="E2";
				}else { 				
					eve_status="E3";
				}
				
				Part photo = req.getPart("eve_photo");
				byte[] eve_photo=null;	
				if (photo.getSubmittedFileName() != null && photo.getContentType() != null) {
					InputStream in = photo.getInputStream();
					eve_photo=new byte[in.available()];
					in.read(eve_photo);
					in.close();				
				}
				
				String sptype_id=req.getParameter("sptype_id").trim();
				byte[] eve_logo=null;
				String eve_ptype=null;
				Double eve_long=0.0;
				Double eve_lat=0.0;
				Integer eve_view=0;
				
//				
				
//				System.out.println("title :"+eve_title);
//				System.out.println("mem_id :"+mem_id);
//				System.out.println("ereg_startdate :"+ereg_startdate);
//				System.out.println("ereg_enddate :"+ereg_enddate);
//				System.out.println("evestart :"+eve_startdate);
//				System.out.println("eveend :"+eve_enddate);
//				System.out.println("limit :"+estart_limit);
//				System.out.println("max :"+estart_max);
//				System.out.println("city :"+city_id);
//				System.out.println("location :"+eve_location);
//				System.out.println("charge :"+eve_charge);
//				System.out.println("conctact :"+econtact_info);
//				System.out.println("estatus :"+eve_status);
//				System.out.println("sptype :"+sptype_id);
//				System.out.println("content :"+eve_content);
				
				EventVO eveVO=new EventVO();
				eveVO.setMem_id(mem_id);		
				eveVO.setEve_title(eve_title);
				
				eveVO.setEreg_startdate(ereg_startdate);
				eveVO.setEreg_startdate(ereg_startdate);
				eveVO.setEve_startdate(eve_startdate);
				eveVO.setEve_enddate(eve_enddate);				
				
				eveVO.setEve_status(eve_status);
				eveVO.setEve_charge(eve_charge);
				eveVO.setEstart_limit(estart_limit);
				eveVO.setEstart_max(estart_max);				
				
				eveVO.setSptype_id(sptype_id);
				eveVO.setCity_id(city_id);
				eveVO.setEve_location(eve_location);	
				eveVO.setEcontact_info(econtact_info);
				eveVO.setEve_content(eve_content);
				
					

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("eveVO", eveVO); // �t����J�榡���~��empVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eve/addEve.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.�}�l�s�W���***************************************/
				EveService eveSvc = new EveService();
				eveVO = eveSvc.addEve(mem_id,eve_photo,eve_logo,eve_ptype,eve_title, eve_content,eve_startdate, eve_enddate,
						ereg_startdate, ereg_enddate,estart_limit, estart_max, eve_status,  eve_location, eve_long, eve_lat,
						city_id, sptype_id, eve_view, eve_charge, econtact_info);
				
							
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				String url = "/front_end/event/eve/listEvesByOrganizer.jsp";
				req.setAttribute("eveVO", eveVO); 
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eve/addEve.jsp");
				failureView.forward(req, res);
			}			
		}

		if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllEmp.jsp ��  /dept/listEmps_ByDeptno.jsp ���ШD

			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);			
			String requestURL = req.getParameter("requestURL"); 

			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				String eve_id = req.getParameter("eve_id").trim();	
				/***************************2.�}�l�d�߸��****************************************/
				EveService eveSvc = new EveService();
				EventVO eveVO = eveSvc.getOneEve(eve_id);
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("eveVO", eveVO); // ��Ʈw���X��eveVO����,�s�Jreq
				String url = "/front_end/event/eve/updateEve.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\���update_emp_input.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception","�ק��ƨ��X�ɥ���:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { 
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL"); 
			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				String eve_id=req.getParameter("eve_id");
				String eve_title = req.getParameter("eve_title");
				if (eve_title == null || eve_title.trim().length() == 0) {
					errorMsgs.put("eve_title","���ʼ��D: �ФŪť�");
				} 

								
				String mem_id = req.getParameter("mem_id").trim();
				if (mem_id == null || mem_id.trim().length() == 0) {
					errorMsgs.put("mem_id","�D��H�����|��");
				}
				
				java.sql.Date ereg_startdate = null;
				java.sql.Date ereg_enddate = null;
				try {		
					ereg_startdate = java.sql.Date.valueOf(req.getParameter("ereg_startdate").trim());
					ereg_enddate = java.sql.Date.valueOf(req.getParameter("ereg_enddate").trim());
				} catch (IllegalArgumentException e) {
					errorMsgs.put("ereg_startdate","�п�ܬ��ʳ��W�}�l�P�������!");
				}
				
				Timestamp eve_startdate = null;
				Timestamp eve_enddate = null;
				
				try {
					String eve_startStr=req.getParameter("eve_startdate").trim();					
					String eve_endStr=req.getParameter("eve_enddate").trim();					
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
					eve_startdate=new Timestamp(sdf.parse(eve_startStr).getTime());	
					eve_enddate=new Timestamp(sdf.parse(eve_endStr).getTime());
				} catch (ParseException e) {
					errorMsgs.put("eve_startdate","�п�ܬ��ʶ}�l�P�����ɶ�!");
				}
				
				
				
				Integer estart_limit = null;
				if("1".equals(req.getParameter("estart_limit_check"))){
					try {			
						estart_limit = new Integer(req.getParameter("estart_limit").trim());
						if(estart_limit<0) {
							errorMsgs.put("estart_limit","���ʳ̧C�H�ƽж�j��0��ƼƦr.");
						}
					} catch (NumberFormatException e) {
						estart_limit = 0;
						errorMsgs.put("estart_limit","���ʳ̧C�H�ƽж��ƼƦr.");
					}
				}else {
					estart_limit = 0;
				}
				Integer estart_max = null;
				if("1".equals(req.getParameter("estart_max_check"))){
					try {			
						estart_max = new Integer(req.getParameter("estart_max").trim());
						if(estart_max<0) {
							errorMsgs.put("estart_max","���ʤW���H�ƽж�j��0��ƼƦr.");
						}else if(estart_max<estart_limit) {
							errorMsgs.put("estart_max","���ʤW���H�ƻݤj�󬡰ʳ̧C�H��");
						}
					} catch (NumberFormatException e) {
						estart_max = 0;
						errorMsgs.put("estart_max","���ʳ̧C�H�ƽж��ƼƦr.");
					}
				}else {
					estart_max =0;
				}
				
				
				String city_id=req.getParameter("city_id");
				String eve_location=req.getParameter("eve_location").trim();
				if (eve_location == null || eve_location.trim().length() == 0) {
					errorMsgs.put("eve_location","���ʦa�I�ФŪť�");
				}
				
				Integer eve_charge = null;
				if("1".equals(req.getParameter("eve_charge_check"))){
					try {			
						eve_charge = new Integer(req.getParameter("eve_charge").trim());
						if(eve_charge<0) {
							errorMsgs.put("eve_charge","���ʶO�νж�j��0��ƼƦr.");
						}
					} catch (NumberFormatException e) {
						eve_charge = 0;
						errorMsgs.put("eve_charge","���ʶO�νж��ƼƦr.");
					}
				}else {
					eve_charge = 0;
				}
				
				String econtact_info=req.getParameter("econtact_info");
				String econctReg = "^09[0-9]{2}-\\d{6}$";
				if (econtact_info == null || econtact_info.trim().length() == 0) {
					errorMsgs.put("econtact_info","�ж�W������X");
				} else if(!econtact_info.trim().matches(econctReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.put("econtact_info","������X: �榡�ж�09XX-XXXXXX");
	            }
				
				String eve_content=req.getParameter("eve_content");
				if (eve_content == null || eve_content.trim().length() == 0) {
					errorMsgs.put("eve_content","�ж�W���ʱԭz");
				}
				
				String eve_status=null;
				if(eve_charge>500||estart_limit>20) {
					eve_status="E1";
				}else if(estart_limit>0) {
					eve_status="E2";
				}else { 				
					eve_status="E3";
				}
				
				Part photo = req.getPart("eve_photo");
				byte[] eve_photo=null;	
//				System.out.println(photo.getSubmittedFileName().isEmpty());
				if (!photo.getSubmittedFileName().isEmpty()) {
					InputStream in = photo.getInputStream();
					eve_photo=new byte[in.available()];
					in.read(eve_photo);
					in.close();				
				}else {
					EveService eveSvc = new EveService();
					eve_photo=eveSvc.getOneEve(eve_id).getEve_photo();	
				}
//				System.out.println(eve_photo);
				
				String sptype_id=req.getParameter("sptype_id").trim();
				byte[] eve_logo=null;
				String eve_ptype=null;
				Double eve_long=0.0;
				Double eve_lat=0.0;
				Integer eve_view=0;
				
//				
				
//				System.out.println("title :"+eve_title);
//				System.out.println("mem_id :"+mem_id);
//				System.out.println("ereg_startdate :"+ereg_startdate);
//				System.out.println("ereg_enddate :"+ereg_enddate);
//				System.out.println("evestart :"+eve_startdate);
//				System.out.println("eveend :"+eve_enddate);
//				System.out.println("limit :"+estart_limit);
//				System.out.println("max :"+estart_max);
//				System.out.println("city :"+city_id);
//				System.out.println("location :"+eve_location);
//				System.out.println("charge :"+eve_charge);
//				System.out.println("conctact :"+econtact_info);
//				System.out.println("estatus :"+eve_status);
//				System.out.println("sptype :"+sptype_id);
//				System.out.println("content :"+eve_content);
				
				EventVO eveVO=new EventVO();
				eveVO.setEve_id(eve_id);
				eveVO.setMem_id(mem_id);		
				eveVO.setEve_title(eve_title);
				
				eveVO.setEreg_startdate(ereg_startdate);
				eveVO.setEreg_startdate(ereg_startdate);
				eveVO.setEve_startdate(eve_startdate);
				eveVO.setEve_enddate(eve_enddate);				
				
				eveVO.setEve_status(eve_status);
				eveVO.setEve_charge(eve_charge);
				eveVO.setEstart_limit(estart_limit);
				eveVO.setEstart_max(estart_max);				
				
				eveVO.setSptype_id(sptype_id);
				eveVO.setCity_id(city_id);
				eveVO.setEve_location(eve_location);	
				eveVO.setEcontact_info(econtact_info);
				eveVO.setEve_content(eve_content);
				
					

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("eveVO", eveVO); // �t����J�榡���~��empVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher(requestURL);
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.�}�l�ק���***************************************/
				EveService eveSvc = new EveService();
				eveVO = eveSvc.updateEve(eve_id,mem_id,eve_photo,eve_logo,eve_ptype,eve_title, eve_content,eve_startdate, eve_enddate,
						ereg_startdate, ereg_enddate,estart_limit, estart_max, eve_status,  eve_location, eve_long, eve_lat,
						city_id, sptype_id, eve_view, eve_charge, econtact_info);
				
//				
				/***************************3.�ק粒��,�ǳ����(Send the Success view)***********/

				req.setAttribute("eveVO", eveVO); 
				RequestDispatcher successView = req.getRequestDispatcher(requestURL); // �s�W���\�����listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}	
		
					
		}
		
		if ("review".equals(action)) { // �Ӧ�select_page.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				String eve_id = req.getParameter("eve_id");
				String result=req.getParameter("result");
				/***************************2.�}�l�ק���*****************************************/
				EveService eveSvc = new EveService();
				EventVO eveVO=eveSvc.getOneEve(eve_id);
				Integer estart_limit=eveVO.getEstart_limit();
				String eve_status=estart_limit>0?"E2":"E3";
			
				if("review_pass".equals(result)) {					
					eveSvc.updateEveStatus(eve_id, eve_status);
				}else {
					eveSvc.updateEveStatus(eve_id, "E6");
				}
				
				
				/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/
				String url = "/front_end/event/eve/ReviewEve.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\���listOneEmp.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z*************************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eve/select_event_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("listEves_ByCompositeQuery".equals(action)) { // �Ӧ�select_page.jsp���ƦX�d�߽ШD
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				
				/***************************1.�N��J����ରMap**********************************/ 
				//�ĥ�Map<String,String[]> getParameterMap()����k 
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
				if (req.getParameter("whichPage") == null){
					HashMap<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
					session.setAttribute("map",map1);
					map = map1;
				} 
				
				Map<String,String> eveQuery = new LinkedHashMap<String,String>();
				String keyword=req.getParameter("keyword");
				String eve_startdate=req.getParameter("eve_startdate");
				String eve_enddate=req.getParameter("eve_enddate");
				String eve_charge=req.getParameter("eve_charge");
				String city_id=req.getParameter("city_id");
				String sptype_id=req.getParameter("sptype_id");
				String orderBy=req.getParameter("orderBy");
				
				if(keyword!=null && keyword.trim().length() != 0) {
					eveQuery.put("keyword","����r : "+keyword);
				}
				if(eve_startdate!=null && eve_startdate.trim().length() != 0) {
					eveQuery.put("eve_startdate"," ���ʮɶ� : "+eve_startdate);
					
				}
				if(eve_enddate!=null && eve_enddate.trim().length() != 0) {
					eveQuery.put("eve_enddate"," ~ " +eve_enddate);
				}
				if(eve_charge!=null && eve_charge.trim().length() != 0) {
					switch(eve_charge) {
					case "0": 
						eve_charge="�K�O";
						break;
					case "300":	
						eve_charge="0 ~ 300 ��";
						break;
					case "500":	
						eve_charge="300 ~ 500 ��";
						break;
					case "1000":	
						eve_charge="500 ~ 1000 ��";
						break;
					case "1001":	
						eve_charge="1000 �� �H�W";
						break;		
					}					
					eveQuery.put("eve_charge"," ���ʪ��B  : " +eve_charge);
				}
				if(city_id!=null && city_id.trim().length() != 0) {
					CityService citySvc=new  CityService();
					System.out.println();
					eveQuery.put("city_id"," �a�� : " +citySvc.getCityName(city_id));
				}
				if(sptype_id!=null && sptype_id.trim().length() != 0) {
					Map sportTypeMap=(Map)getServletContext().getAttribute("sportTypeMap");
					eveQuery.put("sptype_id"," �B�����O : "+sportTypeMap.get(sptype_id));
				}
				if(orderBy!=null && orderBy.trim().length() != 0) {
					switch(orderBy) {
					case "hot":
						orderBy="��������";
						break;
					case "eve_startdate":
						orderBy="���ʮɶ�";
						break;
					case "new":
						orderBy="�̷s�Z�n";
						break;
					}
					eveQuery.put("orderBy"," �ƧǨ� : "+orderBy);
				}
				session.setAttribute("eveQuery", eveQuery);
				
				
				
				/***************************2.�}�l�ƦX�d��***************************************/
				EveService eveSvc = new EveService();
				List<EventVO> list  = eveSvc.getCompositeQueryEves(map);
				
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				session.setAttribute("listEves_ByCompositeQuery", list); // ��Ʈw���X��list����,�s�Jrequest
				res.sendRedirect(req.getContextPath()+"/front_end/event/eve/listAllEve.jsp"); // ���\���listEmps_ByCompositeQuery.jsp
				return;
				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eve/select_event_page.jsp");
				failureView.forward(req, res);
			}
		}
		

		
		
//		if("upload_photo".equals(action)) {			
//			Part photo = req.getPart("eve_photo");
//			byte[] eve_photo=null;	
//			if (photo.getSubmittedFileName() != null && photo.getContentType() != null) {
//				InputStream in = photo.getInputStream();
//				eve_photo=new byte[in.available()];
//				in.read(eve_photo);
//				in.close();				
//			}
//			EveService eveSvc = new EveService();
//			EventVO eveVO = eveSvc.updatePhoto(eve_photo, "E000001");
//			System.out.println(eveVO.getEve_title());					
//		}
		
		
		
	}
	
//	public void init() {
//		eveStatusMap=new LinkedHashMap<>();
//		eveStatusMap.put("E0", "�U�[");
//		eveStatusMap.put("E1", "�ݼf��");
//		eveStatusMap.put("E2", "�H�Ʃ|���F��"); 
//		eveStatusMap.put("E3", "�H�ƹF�� �������W");
//		eveStatusMap.put("E4", "���W�w����");//�H�ƹF�� ���ʥ��}�lor���W�ɶ��������}�l
//		eveStatusMap.put("E5", "���ʤw����");
//		eveStatusMap.put("E6", "�f�֥��q�L");
//		eveStatusMap.put("E7", "�������ʧ@�~��");
//		eveStatusMap.put("E8", "���ʤw����");
//		getServletContext().setAttribute("eveStatusMap", eveStatusMap);
//		
//		sportTypeMap=new LinkedHashMap<>();
//		sportTypeMap.put("SP000001", "�Ю|");
//		sportTypeMap.put("SP000002", "�樮");
//		sportTypeMap.put("SP000003", "�y��");
//		sportTypeMap.put("SP000004", "���V");
//		sportTypeMap.put("SP000005", "����");
//		sportTypeMap.put("SP000006", "�Z�N");
//		sportTypeMap.put("SP000007", "���W");
//		sportTypeMap.put("SP000008", "��L");
//		getServletContext().setAttribute("sportTypeMap", sportTypeMap);
//		
//		eveListStatusMap=new HashMap<>();
//		eveListStatusMap.put("EL0", "�����I��");
//		eveListStatusMap.put("EL1", "���I��");
//		eveListStatusMap.put("EL2", "�w�I�ڥ��T�{");
//		eveListStatusMap.put("EL3", "�T�{�w�I��");
//		eveListStatusMap.put("EL4", "�h�ڥ��B�z");
//		eveListStatusMap.put("EL5", "�w�h�� �ݽT�{");
//		eveListStatusMap.put("EL6", "�h�ڤw�T�{");
////		eveListStatusMap.put("EL7", "�w�h�X");//�����I��
//		eveListStatusMap.put("EL9", "����");
//		getServletContext().setAttribute("eveListStatusMap", eveListStatusMap);
//		
//		
//	}
//	
//	//����redis�s�u�� �n��blistener
//	public void destroy() {
//		JedisPoolUtil.shutdownJedisPool();
//	}

}
