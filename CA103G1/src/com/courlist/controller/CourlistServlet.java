package com.courlist.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.courlist.model.*;

@MultipartConfig
public class CourlistServlet extends HttpServlet {

		public void doGet(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {
			doPost(req, res);
		}
		
		public String getFileNameFromPart(Part part) {
			  String header = part.getHeader("content-disposition");
			  String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();
			  if (filename.length() == 0) {
			   return null;
			  }
			  return filename;
			 }
		
		public void doPost(HttpServletRequest req, HttpServletResponse res)
				throws ServletException, IOException {

			req.setCharacterEncoding("UTF-8");
			String action = req.getParameter("action");
					
		
			if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
					String str = req.getParameter("cour_id");
					if (str == null || (str.trim()).length() == 0) {
						errorMsgs.add("請輸入課程編號");
					}
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front_end/course/courlist/select_page.jsp");
						failureView.forward(req, res);
						return;//程式中斷
					}
					
					String cour_id = null;
					try {
						cour_id = new String(str);
					} catch (Exception e) {
						errorMsgs.add("課程編號格式不正確");
					}
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front_end/course/courlist/select_page.jsp");
						failureView.forward(req, res);
						return;//程式中斷
					}
					
					/***************************2.開始查詢資料*****************************************/
					CourlistService courlistSvc = new CourlistService();
					CourlistVO courlistVO = courlistSvc.getOneCourlist(cour_id);
					if (courlistVO == null) {
						errorMsgs.add("查無資料");
					}
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front_end/course/courlist/select_page.jsp");
						failureView.forward(req, res);
						return;//程式中斷
					}
					
					/***************************3.查詢完成,準備轉交(Send the Success view)*************/
					req.setAttribute("courlistVO", courlistVO); // 資料庫取出的courlistVO物件,存入req
					String url = "/front_end/course/courlist/oneCourlist.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneCourlist.jsp
					successView.forward(req, res);

					/***************************其他可能的錯誤處理*************************************/
				} catch (Exception e) {
					errorMsgs.add("無法取得資料:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/courlist/select_page.jsp");
					failureView.forward(req, res);
				}
			}
			
			
			if ("getOne_For_Update".equals(action)) { // 來自listAllCourlist.jsp的請求

				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/***************************1.接收請求參數****************************************/
					String cour_id = new String(req.getParameter("cour_id"));
					
					/***************************2.開始查詢資料****************************************/
					CourlistService courlistSvc = new CourlistService();
					CourlistVO courlistVO = courlistSvc.getOneCourlist(cour_id);
									
					/***************************3.查詢完成,準備轉交(Send the Success view)************/
					req.setAttribute("courlistVO", courlistVO);         // 資料庫取出的courlistVO物件,存入req
					String url = "/front_end/course/courlist/update_courlist.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_courlist_input.jsp
					successView.forward(req, res);

					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/courlist/listAllCourlist.jsp");
					failureView.forward(req, res);
				}
			}
			
			
			if ("update".equals(action)) { // 來自update_courlist_input.jsp的請求
				
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
			
				try {
					/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
					String cour_id = new String (req.getParameter("cour_id").trim());
System.out.println("cour_id="+cour_id);

					String sptype_id = req.getParameter("sptype_id");
					String sptype_idReg = "^[(SP)(0-9)]{8}$";
					if (sptype_id == null || sptype_id.trim().length() == 0) {
						errorMsgs.add("運動類別編號: 請勿空白");
					} else if(!sptype_id.trim().matches(sptype_idReg)) { //以下練習正則(規)表示式(regular-expression)
						errorMsgs.add("運動類別編號: 只能是SP+六位數字");
		            }
System.out.println(sptype_id);

		            String coa_id = req.getParameter("coa_id");
					String coa_idReg = "^[(C)(0-9)]{7}$";
					if (coa_id == null || coa_id.trim().length() == 0) {
						errorMsgs.add("教練編號: 請勿空白");
					} else if(!coa_id.trim().matches(coa_idReg)) { //以下練習正則(規)表示式(regular-expression)
						errorMsgs.add("教練編號: 只能是C+六位數字");
		            }
System.out.println(coa_id);


					String cname = req.getParameter("cname").trim();
					if (cname == null || cname.trim().length() == 0) {
						errorMsgs.add("課程名稱請勿空白");
					}
System.out.println(cname);
					
					String cour_text = req.getParameter("cour_text");
System.out.println(cour_text);

					Integer cour_cost = null;
					try {
						cour_cost = new Integer(req.getParameter("cour_cost").trim());
					} catch (NumberFormatException e) {
						cour_cost = 0;
						errorMsgs.add("課程費用請填數字.");
					}
System.out.println(cour_cost);
					
                    byte[] cour_pho=null;
					//上傳圖片
					Part part = req.getPart("cour_pho");
					if (getFileNameFromPart(part) != null && part.getContentType() != null) {
						InputStream in = part.getInputStream();
						cour_pho = new byte[in.available()]; // buffer
						in.read(cour_pho);
					}else {
						CourlistService courlistService = new CourlistService();
						CourlistVO courlistVO = courlistService.getOneCourlist(cour_id);
						cour_pho = courlistVO.getCour_pho();
					}
//					String string = null;
//					if (getFileNameFromPart(part) == null || part.getContentType() == null) {
//						CourlistService courlistSvc = new CourlistService();
//						CourlistVO courlistVO = courlistSvc.getOneCourlist(cour_id);
//						cour_pho = courlistVO.getCour_pho();
//						System.out.println("cour_pho.length="+cour_pho.length);
//					}else {
//						InputStream in = part.getInputStream();
//						cour_pho = new byte[in.available()]; // buffer
//						in.read(cour_pho);
//						in.close();
//						string = "in";
//					}				

System.out.println(cour_pho);
//System.out.println(string);

					String cour_lau = req.getParameter("cour_lau");
					String cour_lauReg = "^[(CL)(0-9)]{4}$";
					if (cour_lau == null || cour_lau.trim().length() == 0) {
						errorMsgs.add("課程狀態: 請勿空白");
					} else if(!cour_lau.trim().matches(cour_lauReg)) { //以下練習正則(規)表示式(regular-expression)
						errorMsgs.add("課程狀態: 只能是CL+兩位數字");
		            }
System.out.println(cour_lau);
					
					String cour_ann = req.getParameter("cour_ann");	
System.out.println(cour_ann);
			
					CourlistVO courlistVO = new CourlistVO();
					courlistVO.setCour_id(cour_id);
					courlistVO.setSptype_id(sptype_id);
					courlistVO.setCoa_id(coa_id);
					courlistVO.setCname(cname);
					courlistVO.setCour_text(cour_text);
					courlistVO.setCour_cost(cour_cost);
					courlistVO.setCour_pho(cour_pho);
System.out.println(cour_pho);
					courlistVO.setCour_lau(cour_lau);
					courlistVO.setCour_ann(cour_ann);
System.out.println("111111");

					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("courlistVO", courlistVO); // 含有輸入格式錯誤的courlistVO物件,也存入req
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front_end/course/courlist/update_courlist.jsp");
						failureView.forward(req, res);
						return; //程式中斷
					}
System.out.println("22222222222");					
					/***************************2.開始修改資料*****************************************/
					CourlistService courlistSvc = new CourlistService();
System.out.println(courlistSvc);	
					courlistVO = courlistSvc.updateCourlist(cour_id, sptype_id, coa_id, cname, cour_text, cour_cost, 
							cour_pho, cour_lau, cour_ann);
System.out.println(courlistVO);							
					/***************************3.修改完成,準備轉交(Send the Success view)*************/
					req.setAttribute("courlistVO", courlistVO); // 資料庫update成功後,正確的的courlistVO物件,存入req
					String url = "/front_end/course/courlist/oneCourlist.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneCourlist.jsp
					successView.forward(req, res);

					/***************************其他可能的錯誤處理*************************************/
				} catch (Exception e) {
					errorMsgs.add("修改資料失敗:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/courlist/update_courlist.jsp");
					failureView.forward(req, res);
				}
			}

	        if ("insert".equals(action)) { // 來自addCourlist.jsp的請求  
				
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);

//				try {
					/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
					String sptype_id = req.getParameter("sptype_id");
					String sptype_idReg = "^[(SP)(0-9)]{8}$";
					if (sptype_id == null || sptype_id.trim().length() == 0) {
						errorMsgs.add("運動類別編號: 請勿空白");
					} else if(!sptype_id.trim().matches(sptype_idReg)) { //以下練習正則(規)表示式(regular-expression)
						errorMsgs.add("運動類別編號: 只能是SP+六位數字");
		            }

					String coa_id = req.getParameter("coa_id");
					String coa_idReg = "^[(C)(0-9)]{7}$";
					if (coa_id == null || coa_id.trim().length() == 0) {
						errorMsgs.add("教練編號: 請勿空白");
					} else if(!coa_id.trim().matches(coa_idReg)) { //以下練習正則(規)表示式(regular-expression)
						errorMsgs.add("教練編號: 只能是C+六位數字");
		            }


					String cname = req.getParameter("cname").trim();
					if (cname == null || cname.trim().length() == 0) {
						errorMsgs.add("課程名稱請勿空白");
					}
					
					String cour_text = req.getParameter("cour_text");

					Integer cour_cost = null;
					try {
						cour_cost = new Integer(req.getParameter("cour_cost").trim());
					} catch (NumberFormatException e) {
						cour_cost = 0;
						errorMsgs.add("課程費用請填數字.");
					}
					
					//上傳圖片
					Part part = req.getPart("cour_pho");
					InputStream in = part.getInputStream();
					byte[] cour_pho = new byte[in.available()]; // buffer
					in.read(cour_pho);

					String cour_lau = req.getParameter("cour_lau");
					String cour_lauReg = "^[(CL)(0-9)]{4}$";
					if (cour_lau == null || cour_lau.trim().length() == 0) {
						errorMsgs.add("課程狀態: 請勿空白");
					} else if(!cour_lau.trim().matches(cour_lauReg)) { //以下練習正則(規)表示式(regular-expression)
						errorMsgs.add("課程狀態: 只能是CL+兩位數字");
		            }
					
					String cour_ann = req.getParameter("cour_ann");

					CourlistVO courlistVO = new CourlistVO();
					courlistVO.setSptype_id(sptype_id);
					courlistVO.setCoa_id(coa_id);
					courlistVO.setCname(cname);
					courlistVO.setCour_text(cour_text);
					courlistVO.setCour_cost(cour_cost);
					courlistVO.setCour_pho(cour_pho);
					courlistVO.setCour_lau(cour_lau);
					courlistVO.setCour_ann(cour_ann);

					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("courlistVO", courlistVO); // 含有輸入格式錯誤的courlistVO物件,也存入req
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front_end/course/courlist/addCourlist.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.開始新增資料***************************************/
					CourlistService courlistSvc = new CourlistService();
					courlistVO = courlistSvc.addCourlist(sptype_id, coa_id, cname, cour_text, cour_cost, 
							cour_pho, cour_lau, cour_ann);
					
					/***************************3.新增完成,準備轉交(Send the Success view)***********/
					String url = "/front_end/course/courlist/listAllCourlist.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllCourlist.jsp
					successView.forward(req, res);				
					
					/***************************其他可能的錯誤處理**********************************/
//				} catch (Exception e) {
//					errorMsgs.add(e.getMessage());
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front_end/course/courlist/addCourlist.jsp");
//					failureView.forward(req, res);
//				}
			}
			
			
			if ("delete".equals(action)) { // 來自listAllCourlist.jsp

				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
		
				try {
					/***************************1.接收請求參數***************************************/
					String cour_id = new String(req.getParameter("cour_id"));
					
					/***************************2.開始刪除資料***************************************/
					CourlistService courlistSvc = new CourlistService();
					courlistSvc.deleteCourlist(cour_id);
					
					/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
					String url = "/front_end/course/courlist/listAllCourlist.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
					successView.forward(req, res);
					
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add("刪除資料失敗:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/courlist/listAllCourlist.jsp");
					failureView.forward(req, res);
				}
			}
		}
}
