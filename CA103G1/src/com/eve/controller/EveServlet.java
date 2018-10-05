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
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String eve_id = req.getParameter("eve_id");
				/***************************2.開始查詢資料*****************************************/
				EveService eveSvc = new EveService();
				EventVO eveVO = eveSvc.getOneEve(eve_id);
				if (eveVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eve/select_event_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				 // 資料庫取出的empVO物件,存入req
				req.setAttribute("eveVO", eveVO);
				
				String url = "/front_end/event/eve/listOneEvent.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eve/select_event_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("insert".equals(action)) { 
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String eve_title = req.getParameter("eve_title");
//				String etitleReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{1,20}$";
				if (eve_title == null || eve_title.trim().length() == 0) {
					errorMsgs.put("eve_title","活動標題: 請勿空白");
				} 
//				else if(!eve_title.trim().matches(etitleReg)) { //以下練習正則(規)表示式(regular-expression)
//					errorMsgs.put("eve_title","活動標題: 只能是中、英文字母、數字、_ , 且長度在1到20之間");
//	            }
				
				
				String mem_id = req.getParameter("mem_id").trim();
				if (mem_id == null || mem_id.trim().length() == 0) {
					errorMsgs.put("mem_id","主辦人須為會員");
				}
				
				java.sql.Date ereg_startdate = null;
				java.sql.Date ereg_enddate = null;
				try {		
					ereg_startdate = java.sql.Date.valueOf(req.getParameter("ereg_startdate").trim());
					ereg_enddate = java.sql.Date.valueOf(req.getParameter("ereg_enddate").trim());
				} catch (IllegalArgumentException e) {
					errorMsgs.put("ereg_startdate","請選擇活動報名開始與結束日期!");
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
					errorMsgs.put("eve_startdate","請選擇活動開始與結束時間!");
				}
				
				
				
				Integer estart_limit = null;
				if("1".equals(req.getParameter("estart_limit_check"))){
					try {			
						estart_limit = new Integer(req.getParameter("estart_limit").trim());
						if(estart_limit<0) {
							errorMsgs.put("estart_limit","活動最低人數請填大於0整數數字.");
						}
					} catch (NumberFormatException e) {
						estart_limit = 0;
						errorMsgs.put("estart_limit","活動最低人數請填整數數字.");
					}
				}else {
					estart_limit = 0;
				}
				Integer estart_max = null;
				if("1".equals(req.getParameter("estart_max_check"))){
					try {			
						estart_max = new Integer(req.getParameter("estart_max").trim());
						if(estart_max<0) {
							errorMsgs.put("estart_max","活動上限人數請填大於0整數數字.");
						}else if(estart_max<estart_limit) {
							errorMsgs.put("estart_max","活動上限人數需大於活動最低人數");
						}
					} catch (NumberFormatException e) {
						estart_max = 0;
						errorMsgs.put("estart_max","活動最低人數請填整數數字.");
					}
				}else {
					estart_max =0;
				}
				
				
				String city_id=req.getParameter("city_id");
				String eve_location=req.getParameter("eve_location").trim();
				if (eve_location == null || eve_location.trim().length() == 0) {
					errorMsgs.put("eve_location","活動地點請勿空白");
				}
				
				Integer eve_charge = null;
				if("1".equals(req.getParameter("eve_charge_check"))){
					try {			
						eve_charge = new Integer(req.getParameter("eve_charge").trim());
						if(eve_charge<0) {
							errorMsgs.put("eve_charge","活動費用請填大於0整數數字.");
						}
					} catch (NumberFormatException e) {
						eve_charge = 0;
						errorMsgs.put("eve_charge","活動費用請填整數數字.");
					}
				}else {
					eve_charge = 0;
				}
				
				String econtact_info=req.getParameter("econtact_info");
				String econctReg = "^09[0-9]{2}-\\d{6}$";
				if (econtact_info == null || econtact_info.trim().length() == 0) {
					errorMsgs.put("econtact_info","請填上手機號碼");
				} else if(!econtact_info.trim().matches(econctReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("econtact_info","手機號碼: 格式請填09XX-XXXXXX");
	            }
				
				String eve_content=req.getParameter("eve_content");
				if (eve_content == null || eve_content.trim().length() == 0) {
					errorMsgs.put("eve_content","請填上活動敘述");
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
					req.setAttribute("eveVO", eveVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eve/addEve.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				EveService eveSvc = new EveService();
				eveVO = eveSvc.addEve(mem_id,eve_photo,eve_logo,eve_ptype,eve_title, eve_content,eve_startdate, eve_enddate,
						ereg_startdate, ereg_enddate,estart_limit, estart_max, eve_status,  eve_location, eve_long, eve_lat,
						city_id, sptype_id, eve_view, eve_charge, econtact_info);
				
							
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/front_end/event/eve/listEvesByOrganizer.jsp";
				req.setAttribute("eveVO", eveVO); 
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eve/addEve.jsp");
				failureView.forward(req, res);
			}			
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp 或  /dept/listEmps_ByDeptno.jsp 的請求

			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);			
			String requestURL = req.getParameter("requestURL"); 

			try {
				/***************************1.接收請求參數****************************************/
				String eve_id = req.getParameter("eve_id").trim();	
				/***************************2.開始查詢資料****************************************/
				EveService eveSvc = new EveService();
				EventVO eveVO = eveSvc.getOneEve(eve_id);
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("eveVO", eveVO); // 資料庫取出的eveVO物件,存入req
				String url = "/front_end/event/eve/updateEve.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_emp_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理************************************/
			} catch (Exception e) {
				errorMsgs.put("Exception","修改資料取出時失敗:"+e.getMessage());
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
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String eve_id=req.getParameter("eve_id");
				String eve_title = req.getParameter("eve_title");
				if (eve_title == null || eve_title.trim().length() == 0) {
					errorMsgs.put("eve_title","活動標題: 請勿空白");
				} 

								
				String mem_id = req.getParameter("mem_id").trim();
				if (mem_id == null || mem_id.trim().length() == 0) {
					errorMsgs.put("mem_id","主辦人須為會員");
				}
				
				java.sql.Date ereg_startdate = null;
				java.sql.Date ereg_enddate = null;
				try {		
					ereg_startdate = java.sql.Date.valueOf(req.getParameter("ereg_startdate").trim());
					ereg_enddate = java.sql.Date.valueOf(req.getParameter("ereg_enddate").trim());
				} catch (IllegalArgumentException e) {
					errorMsgs.put("ereg_startdate","請選擇活動報名開始與結束日期!");
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
					errorMsgs.put("eve_startdate","請選擇活動開始與結束時間!");
				}
				
				
				
				Integer estart_limit = null;
				if("1".equals(req.getParameter("estart_limit_check"))){
					try {			
						estart_limit = new Integer(req.getParameter("estart_limit").trim());
						if(estart_limit<0) {
							errorMsgs.put("estart_limit","活動最低人數請填大於0整數數字.");
						}
					} catch (NumberFormatException e) {
						estart_limit = 0;
						errorMsgs.put("estart_limit","活動最低人數請填整數數字.");
					}
				}else {
					estart_limit = 0;
				}
				Integer estart_max = null;
				if("1".equals(req.getParameter("estart_max_check"))){
					try {			
						estart_max = new Integer(req.getParameter("estart_max").trim());
						if(estart_max<0) {
							errorMsgs.put("estart_max","活動上限人數請填大於0整數數字.");
						}else if(estart_max<estart_limit) {
							errorMsgs.put("estart_max","活動上限人數需大於活動最低人數");
						}
					} catch (NumberFormatException e) {
						estart_max = 0;
						errorMsgs.put("estart_max","活動最低人數請填整數數字.");
					}
				}else {
					estart_max =0;
				}
				
				
				String city_id=req.getParameter("city_id");
				String eve_location=req.getParameter("eve_location").trim();
				if (eve_location == null || eve_location.trim().length() == 0) {
					errorMsgs.put("eve_location","活動地點請勿空白");
				}
				
				Integer eve_charge = null;
				if("1".equals(req.getParameter("eve_charge_check"))){
					try {			
						eve_charge = new Integer(req.getParameter("eve_charge").trim());
						if(eve_charge<0) {
							errorMsgs.put("eve_charge","活動費用請填大於0整數數字.");
						}
					} catch (NumberFormatException e) {
						eve_charge = 0;
						errorMsgs.put("eve_charge","活動費用請填整數數字.");
					}
				}else {
					eve_charge = 0;
				}
				
				String econtact_info=req.getParameter("econtact_info");
				String econctReg = "^09[0-9]{2}-\\d{6}$";
				if (econtact_info == null || econtact_info.trim().length() == 0) {
					errorMsgs.put("econtact_info","請填上手機號碼");
				} else if(!econtact_info.trim().matches(econctReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("econtact_info","手機號碼: 格式請填09XX-XXXXXX");
	            }
				
				String eve_content=req.getParameter("eve_content");
				if (eve_content == null || eve_content.trim().length() == 0) {
					errorMsgs.put("eve_content","請填上活動敘述");
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
					req.setAttribute("eveVO", eveVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher(requestURL);
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始修改資料***************************************/
				EveService eveSvc = new EveService();
				eveVO = eveSvc.updateEve(eve_id,mem_id,eve_photo,eve_logo,eve_ptype,eve_title, eve_content,eve_startdate, eve_enddate,
						ereg_startdate, ereg_enddate,estart_limit, estart_max, eve_status,  eve_location, eve_long, eve_lat,
						city_id, sptype_id, eve_view, eve_charge, econtact_info);
				
//				
				/***************************3.修改完成,準備轉交(Send the Success view)***********/

				req.setAttribute("eveVO", eveVO); 
				RequestDispatcher successView = req.getRequestDispatcher(requestURL); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}	
		
					
		}
		
		if ("review".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String eve_id = req.getParameter("eve_id");
				String result=req.getParameter("result");
				/***************************2.開始修改資料*****************************************/
				EveService eveSvc = new EveService();
				EventVO eveVO=eveSvc.getOneEve(eve_id);
				Integer estart_limit=eveVO.getEstart_limit();
				String eve_status=estart_limit>0?"E2":"E3";
			
				if("review_pass".equals(result)) {					
					eveSvc.updateEveStatus(eve_id, eve_status);
				}else {
					eveSvc.updateEveStatus(eve_id, "E6");
				}
				
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				String url = "/front_end/event/eve/ReviewEve.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eve/select_event_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("listEves_ByCompositeQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				
				/***************************1.將輸入資料轉為Map**********************************/ 
				//採用Map<String,String[]> getParameterMap()的方法 
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
					eveQuery.put("keyword","關鍵字 : "+keyword);
				}
				if(eve_startdate!=null && eve_startdate.trim().length() != 0) {
					eveQuery.put("eve_startdate"," 活動時間 : "+eve_startdate);
					
				}
				if(eve_enddate!=null && eve_enddate.trim().length() != 0) {
					eveQuery.put("eve_enddate"," ~ " +eve_enddate);
				}
				if(eve_charge!=null && eve_charge.trim().length() != 0) {
					switch(eve_charge) {
					case "0": 
						eve_charge="免費";
						break;
					case "300":	
						eve_charge="0 ~ 300 元";
						break;
					case "500":	
						eve_charge="300 ~ 500 元";
						break;
					case "1000":	
						eve_charge="500 ~ 1000 元";
						break;
					case "1001":	
						eve_charge="1000 元 以上";
						break;		
					}					
					eveQuery.put("eve_charge"," 活動金額  : " +eve_charge);
				}
				if(city_id!=null && city_id.trim().length() != 0) {
					CityService citySvc=new  CityService();
					System.out.println();
					eveQuery.put("city_id"," 地區 : " +citySvc.getCityName(city_id));
				}
				if(sptype_id!=null && sptype_id.trim().length() != 0) {
					Map sportTypeMap=(Map)getServletContext().getAttribute("sportTypeMap");
					eveQuery.put("sptype_id"," 運動類別 : "+sportTypeMap.get(sptype_id));
				}
				if(orderBy!=null && orderBy.trim().length() != 0) {
					switch(orderBy) {
					case "hot":
						orderBy="熱門活動";
						break;
					case "eve_startdate":
						orderBy="活動時間";
						break;
					case "new":
						orderBy="最新刊登";
						break;
					}
					eveQuery.put("orderBy"," 排序依 : "+orderBy);
				}
				session.setAttribute("eveQuery", eveQuery);
				
				
				
				/***************************2.開始複合查詢***************************************/
				EveService eveSvc = new EveService();
				List<EventVO> list  = eveSvc.getCompositeQueryEves(map);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				session.setAttribute("listEves_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
				res.sendRedirect(req.getContextPath()+"/front_end/event/eve/listAllEve.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
				return;
				/***************************其他可能的錯誤處理**********************************/
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
//		eveStatusMap.put("E0", "下架");
//		eveStatusMap.put("E1", "待審核");
//		eveStatusMap.put("E2", "人數尚未達成"); 
//		eveStatusMap.put("E3", "人數達成 接受報名");
//		eveStatusMap.put("E4", "報名已結束");//人數達成 活動未開始or報名時間結束未開始
//		eveStatusMap.put("E5", "活動已結束");
//		eveStatusMap.put("E6", "審核未通過");
//		eveStatusMap.put("E7", "取消活動作業中");
//		eveStatusMap.put("E8", "活動已取消");
//		getServletContext().setAttribute("eveStatusMap", eveStatusMap);
//		
//		sportTypeMap=new LinkedHashMap<>();
//		sportTypeMap.put("SP000001", "田徑");
//		sportTypeMap.put("SP000002", "單車");
//		sportTypeMap.put("SP000003", "球類");
//		sportTypeMap.put("SP000004", "重訓");
//		sportTypeMap.put("SP000005", "有氧");
//		sportTypeMap.put("SP000006", "武術");
//		sportTypeMap.put("SP000007", "水上");
//		sportTypeMap.put("SP000008", "其他");
//		getServletContext().setAttribute("sportTypeMap", sportTypeMap);
//		
//		eveListStatusMap=new HashMap<>();
//		eveListStatusMap.put("EL0", "不須付款");
//		eveListStatusMap.put("EL1", "未付款");
//		eveListStatusMap.put("EL2", "已付款未確認");
//		eveListStatusMap.put("EL3", "確認已付款");
//		eveListStatusMap.put("EL4", "退款未處理");
//		eveListStatusMap.put("EL5", "已退款 待確認");
//		eveListStatusMap.put("EL6", "退款已確認");
////		eveListStatusMap.put("EL7", "已退出");//不須付款
//		eveListStatusMap.put("EL9", "隱藏");
//		getServletContext().setAttribute("eveListStatusMap", eveListStatusMap);
//		
//		
//	}
//	
//	//關閉redis連線池 要放在listener
//	public void destroy() {
//		JedisPoolUtil.shutdownJedisPool();
//	}

}
