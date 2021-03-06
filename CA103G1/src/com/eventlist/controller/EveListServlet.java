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
		
		if ("getEvelists_By_EVE".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 **********************/
				String eve_id = req.getParameter("eve_id");
			
				/***************************2.開始查詢資料*****************************************/
				EventlistService eveListSvc = new EventlistService();
				List<EventListVO> eveListsByEve=eveListSvc.getEveListsByEve(eve_id);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("eveListsByEve",eveListsByEve); // 資料庫取出的empVO物件,存入req				
				String url =req.getContextPath()+ "/front_end/event/eventlist/eveEventlist.jsp?perpageloc=event#personalnav";		
				HttpSession session=req.getSession();
				session.setAttribute("eve_id", eve_id);
				res.sendRedirect(url);
				return;//程式中斷

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventlist/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Display".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 **********************/
				String eve_id = req.getParameter("eve_id");
				String mem_id = req.getParameter("mem_id");
			
				/***************************2.開始查詢資料*****************************************/
				EventlistService eveListSvc = new EventlistService();
				EventListVO eventListVO=eveListSvc.getOneEveList(mem_id,eve_id);
				if(eventListVO==null) {
					errorMsgs.add("查無資料");
				}
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventlist/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("eventListVO",eventListVO); // 資料庫取出的empVO物件,存入req				
				String url ="/front_end/event/eventlist/listOneEvelist.jsp";		
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEvelist.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventlist/select_page.jsp");
				failureView.forward(req, res);
			}			
		}
		
		if("openAddElModal".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			try{
				String eve_id = req.getParameter("eve_id");
			
				HttpSession session=req.getSession();
				MemVO memVO=(MemVO)session.getAttribute("memVO");
				if(memVO==null) {
					session.setAttribute("location",req.getRequestURI()+"?action=openAddElModal&eve_id="+eve_id);
					res.sendRedirect(req.getContextPath()+"/Mem_Login_Signup.jsp");
					return;					
				}
				
				
				EveService eveSvc = new EveService();
				EventVO eveVO = eveSvc.getOneEve(eve_id);
				
				if (eveVO == null) {
					errorMsgs.add("查無資料");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eve/select_event_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				req.setAttribute("eveVO", eveVO); // 資料庫取出的empVO物件,存入req				
				
				boolean openAddElModal=true;
				req.setAttribute("openAddElModal",openAddElModal );
				String url ="/front_end/event/eve/listOneEvent.jsp";		
				RequestDispatcher sucessView = req.getRequestDispatcher(url);
				sucessView.forward(req, res);
				return;//程式中斷
			}catch(Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eve/listOneEvent.jsp");
				failureView.forward(req, res);
				e.printStackTrace();				
			}
			
			
			
		}
		
		
		if ("insert".equals(action)) { // 來自addeveList.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String mem_id = req.getParameter("mem_id").trim();;				
				String  eve_id= req.getParameter("eve_id").trim();
				
				Integer evepay_amount=null;
				try {
					evepay_amount=new Integer(req.getParameter("evepay_amount").trim());
				}catch(NumberFormatException e) {
					evepay_amount=0;
					errorMsgs.add("付款金額為整數數字.");
				}
				
				java.sql.Date evepay_deadline = null;
				try {
					evepay_deadline = java.sql.Date.valueOf(req.getParameter("evepay_deadline").trim());
				} catch (IllegalArgumentException e) {
					//若無繳費截止日 evepay_deadline = null 存入空值
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
					req.setAttribute("eventListVO", eventListVO); // 含有輸入格式錯誤的eventListVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/event/eventlist/addeveList.jsp");
					failureView.forward(req, res);
					return;
				}
//				System.out.println(mem_id);
//				System.out.println(eve_id);
//				System.out.println(eve_rating);
//				System.out.println(evelist_status);
//				System.out.println(evepay_amount);
//				System.out.println(eve_share);
//				System.out.println(evepay_deadline);
//				System.out.println();
				/***************************2.開始新增資料***************************************/
				EventlistService eveListSvc = new EventlistService();
				eventListVO=eveListSvc.addEveList(mem_id, eve_id, eve_rating, evelist_status, evepay_amount, eve_share, evepay_deadline);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				
				if(evepay_amount==0) {
					List<EventListVO> eveListsByMem=eveListSvc.getEveListsByMem(mem_id);
					String url =req.getContextPath()+ "/front_end/event/eventlist/listEvesByMem.jsp";		
					HttpSession session=req.getSession();
					session.setAttribute("eveListsByMem", eveListsByMem);
					res.sendRedirect(url);
					return;//程式中斷		
				}
				//Bootstrap_modal
				boolean openPayModal=true;
				req.removeAttribute("openAddElModal");
				req.setAttribute("openPayModal",openPayModal );
				req.setAttribute("eventListVO",eventListVO );
				EveService eveSvc=new EveService();
				EventVO eveVO=eveSvc.getOneEve(eve_id);
				req.setAttribute("eveVO",eveVO );
				String url ="/front_end/event/eve/listOneEvent.jsp";		
				RequestDispatcher sucessView = req.getRequestDispatcher(url);
				sucessView.forward(req, res);
				return;//程式中斷
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/event/eventlist/addeveList.jsp");
				failureView.forward(req, res);
				e.printStackTrace();
			}
		}
		
		
		if ("delete_By_Participant".equals(action)||"delete_By_Organizer".equals(action)) { // 來自listEvesByMem.jsp 或 listEvesByMem.jsp

			List<String> errorMsgs = new LinkedList<String>();
		    req.setAttribute("errorMsgs",errorMsgs );
		    String requestURL = req.getParameter("requestURL");
			try {
				/***************************1.接收請求參數***************************************/
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
				
				/***************************2.開始刪除資料***************************************/
				
				eveListSvc.changeEveListStatus(mem_id, eve_id, evelist_status);
				if("/front_end/event/eventlist/eveEventlist.jsp".equals(requestURL)) {
					HttpSession session=req.getSession();
					session.setAttribute("eve_id", eve_id);	
					session.setAttribute("errorMsgs",errorMsgs );
				}
				
				/***************************3.刪除完成,準備轉交(Send the Success view)*************/		
				res.sendRedirect(requestURL+"?whichPage="+whichPage+"&eve_id="+eve_id+"&mem_id="+mem_id);
				return;//程式中斷
				
				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {				
				errorMsgs.add("刪除資料失敗:" +e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
				e.printStackTrace();
				return;//程式中斷
			}
		}
		
		if ("update_modal".equals(action)) {

			try {
				// Retrieve form parameters.
				String eve_id = req.getParameter("eve_id");
				String mem_id = req.getParameter("mem_id");

				EventlistService eveListSvc = new EventlistService();
				EventListVO eventListVO=eveListSvc.getOneEveList(mem_id,eve_id);

				req.setAttribute("eventListVO", eventListVO); // 資料庫取出的empVO物件,存入req
				
//				//Bootstrap_modal
				boolean openupModal=true;
				req.setAttribute("openupModal",openupModal );
				
				// 取出的empVO送給listOneEmp.jsp
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

				req.setAttribute("eventListVO", eventListVO); // 資料庫取出的empVO物件,存入req
				
//				//Bootstrap_modal
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				
				// 取出的empVO送給listOneEmp.jsp
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
				String phone=req.getParameter("phone_number");
				
				
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
				
		
				//確認付款 發送簡訊
				if(oriEvelist_Status.equals("EL1")) {
					
					MemService memSvc=new MemService();
					String name=memSvc.getOneMem(mem_id).getMem_name();
					EveService eveSvc=new EveService();
					EventVO eveVO=eveSvc.getOneEve(eve_id);
					String eve_title=eveVO.getEve_title();
					Integer evepay_amount=eventListVO.getEvepay_amount();
					Send payMsgSeend = new Send();
					
					
					String[] tel=new String[1];
					tel[0]=phone;
					

				 	String message = name+" 您好! 已收到您參與"+eve_title+"的費用共"+evepay_amount+"元 !  感謝您的參與";
				 	System.out.println(message);
				 	payMsgSeend.sendMessage(tel , message);
				 	System.out.println("已發送簡訊!"); 
					
				}		
				HttpSession session=req.getSession();
				session.setAttribute("eve_id", eve_id);
				res.sendRedirect(requestURL+"?whichPage="+whichPage+"&eve_id="+eve_id+"&mem_id="+mem_id);
				return;
				
				
				// Handle any unusual exceptions
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
		
		//活動頁面查看報名狀態 以AJAX傳送
		if("get_Mem_Evelist".equals(action)) { 
			
			res.setContentType("text/html;charset=UTF8");
			PrintWriter out=res.getWriter();
			String mem_account=req.getParameter("mem_account");
			String mem_password=req.getParameter("mem_password");
			String eve_id=req.getParameter("eve_id");
//			System.out.println( mem_account);
//			System.out.println( mem_password);
//			System.out.println( eve_id);
			MemService memSvc=new MemService();
			MemVO memVO=memSvc.loginMem(mem_account, mem_password);
			if(memVO==null) {
				out.print("noneMem");
				return;
			}
			HttpSession session=req.getSession();
			session.setAttribute("memVO", memVO);
			EventlistService evelistSvc =new EventlistService();
			EventListVO evelistVO=evelistSvc.getOneEveList(memVO.getMem_id(), eve_id);
			EveService eveSvc=new EveService();
			EventVO eveVO=eveSvc.getOneEve(eve_id);
			
			if(eveVO.getMem_id().equals(memVO.getMem_id())) {
				out.print("organizer");
			}else if(evelistVO==null){
				out.print("noneEvelist");	
				
			}else {			
				JSONObject evelist = new JSONObject();	
				Map eveListStatusMap=(Map)getServletContext().getAttribute("eveListStatusMap");
				
				String pay_deadline;
				
				if(evelistVO.getEvepay_deadline()==null) {
					pay_deadline="無";
				}else {
					pay_deadline=evelistVO.getEvepay_deadline().toString();
				}
				
				String pay_amount=null;
				if(evelistVO.getEvepay_amount()==null||evelistVO.getEvepay_amount()==0) {
					pay_amount="無";
				}else {
					pay_amount=evelistVO.getEvepay_amount().toString();
				}
//				System.out.println(pay_amount);
//				System.out.println(pay_deadline);
				try {
					//將資料轉成JSONObject	
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
