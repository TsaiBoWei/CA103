package com.coach.controller;

import java.io.File;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.coach.model.CoachService;
import com.coach.model.CoachVO;
import com.courlist.model.CourlistService;
import com.courlist.model.CourlistVO;
import com.mem.model.MemService;
import com.mem.model.MemVO;
import com.purchcour.controller.PurchcourServlet.MailService;
import com.purchcour.model.PurchCourVO;
import com.purchcour.model.PurchcourService;


@MultipartConfig
public class CoachServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public String getFileNameFromPart(Part part) {
		  String header = part.getHeader("content-disposition");
		  String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();
		  if (filename.length() == 0) {
		   return null;
		  }
		  return filename;
		 }
       
	public class MailService {
		public void sendMail(String to, String subject, String messageText) {

			try {
				// 設定使用SSL連線至 Gmail smtp Server
				Properties props = new Properties();
				props.put("mail.smtp.host", "smtp.gmail.com");
				props.put("mail.smtp.socketFactory.port", "465");
				props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.port", "465");

				// ●設定 gmail 的帳號 & 密碼 (將藉由你的Gmail來傳送Email)
				// ●須將myGmail的【安全性較低的應用程式存取權】打開
				final String myGmail = "ixlogic.wu@gmail.com";
				final String myGmail_password = "BBB45678";
				Session session = Session.getInstance(props, new Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(myGmail, myGmail_password);
					}
				});

				Message message = new MimeMessage(session);
				message.setFrom(new InternetAddress(myGmail));
				message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));

				// 設定信中的主旨
				message.setSubject(subject);
				// 設定信中的內容
				message.setText(messageText);

				Transport.send(message);
				System.out.println("傳送成功!");
			} catch (MessagingException e) {
				System.out.println("傳送失敗!");
				e.printStackTrace();
			}
		}
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
System.out.println(action);		
		
		
		//ashley
		if ("refundconfirm".equals(action)) { // 來自coach.jsp的請求
			
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				
				String crorder_id = req.getParameter("crorder_id");

				/*************************** 2.開始修改資料 ***************************************/
				PurchcourService purchcourSvc = new PurchcourService();
				purchcourSvc.updatePurchCourRefund( "CO3", crorder_id);
System.out.println(crorder_id);

				/*************************** 3.修改完成,準備轉交(Send the Success view) ***********/
               
                String url = "/front_end/course/coach/page/coach.jsp";
                PurchCourVO purchCourVO = purchcourSvc.getonePurchCour(crorder_id);
                
                CourlistService courlistSvc=new CourlistService();
                
                CourlistVO courlistVO=courlistSvc.getOneCourlist(purchCourVO.getCour_id());
                
                MemService memSvc = new MemService();
				MemVO menVO = memSvc.getOneMem(purchCourVO.getMem_id());


				String to = "chtseng89@gmail.com";

				String subject = "課程退款確認";

				String messageText = "Hello! " + menVO.getMem_name() + " 您的 " + courlistVO.getCname() + "課程已確認退款, 下次請考慮周全 ";
				MailService mailService = new MailService();
				mailService.sendMail(to, subject, messageText);

				System.out.println("OK");
                req.setAttribute("localhref",url );
				RequestDispatcher successView = req.getRequestDispatcher(url); // 
				successView.forward(req, res);
  
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/coach/page/coach.jsp");
				failureView.forward(req, res);
			}
		}
		
		//cc
		if ("getOne_For_Update".equals(action)) { // 來自listAllCourlist.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				String coa_id = new String(req.getParameter("coa_id"));
				
				/***************************2.開始查詢資料****************************************/
				CoachService coachSvc = new CoachService();
				CoachVO coachVO = coachSvc.getOneCoach(coa_id);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("coachVO", coachVO);         // 資料庫取出的coachVO物件,存入req
				String url = "/front_end/course/coach/page/update_CoachText.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_CoachText.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/course/coach/page/update_CoachText.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // 來自update_CoachText.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
//			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String coa_id = new String (req.getParameter("coa_id").trim());
System.out.println(coa_id);
				String mem_id = req.getParameter("mem_id");

	            String coa_text = req.getParameter("coa_text");
				
				String coa_status = req.getParameter("coa_status").trim();
				String coa_statusReg = "^[(CS)(0-9)]{4}$";
				if (coa_status == null || coa_status.trim().length() == 0) {
					errorMsgs.add("帳號狀態: 請勿空白");
				} else if(!coa_status.trim().matches(coa_statusReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("帳號狀態: 只能是CS+兩位數字");
	            }
						
				CoachVO coachVO = new CoachVO();
				coachVO.setCoa_id(coa_id);
				coachVO.setMem_id(mem_id);
				coachVO.setCoa_text(coa_text);
				coachVO.setCoa_status(coa_status);
System.out.println("接收");

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("coachVO", coachVO); // 含有輸入格式錯誤的coachVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/coach/page/update_CoachText.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}

			
				/***************************2.開始修改資料*****************************************/
				CoachService coachSvc = new CoachService();
				coachVO = coachSvc.updateCoach(coa_id, mem_id, coa_text, coa_status);
System.out.println("修改");
						
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("coachVO", coachVO); // 資料庫update成功後,正確的的coachVO物件,存入req
				String url = "/front_end/course/coach/page/coach.jsp";
				
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneCoach.jsp
				successView.forward(req, res);
System.out.println("轉交");

				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e) {
//				errorMsgs.add("修改資料失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front_end/course/coach/update_CoachText.jsp");
//				failureView.forward(req, res);
//			}
		}

        if ("insert".equals(action)) { // 來自addCoachText.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

//			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String mem_id = new String (req.getParameter("mem_id").trim());

	            String coa_text = req.getParameter("coa_text");
				
//				String coa_status = req.getParameter("coa_status").trim();



				CoachVO coachVO = new CoachVO();
				coachVO.setMem_id(mem_id);
				coachVO.setCoa_text(coa_text);
				coachVO.setCoa_status("CS01");

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("coachVO", coachVO); // 含有輸入格式錯誤的coachVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/coach/addCoachText.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				CoachService coachSvc = new CoachService();
				coachVO = coachSvc.addCoach(mem_id, coa_text, "CS01");
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/front_end/mem/updateMember/updateMember.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllCourlist.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
//			} catch (Exception e) {
//				errorMsgs.add("新增資料失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front_end/course/courlist/addCoachText.jsp");
//				failureView.forward(req, res);
//			}
		}

	}

}
