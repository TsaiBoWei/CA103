package com.Mgr.controller;

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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Mgr.model.MgrService;
import com.Mgr.model.MgrVO;

public class MgrLostPSServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String actionMgrLostPS = req.getParameter("actionMgrLostPS");
		
		if("Mgr_LostPS".equals(actionMgrLostPS)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
		
			try {
				
	/************************接受帳號、email，進行輸入格式錯誤處裡**************************/
				String mgr_account = req.getParameter("mgr_account");
				String mgr_mail = req.getParameter("mgr_mail");
				
				String accountchk = "^[(a-zA-Z0-9_)]{3,10}$"; //驗證帳號正規表示法
				if (mgr_account == null || (mgr_account.trim()).length() == 0) {
					errorMsgs.add("帳號不得空白");
				}else if(!mgr_account.trim().matches(accountchk)) {
				errorMsgs.add("帳號格式錯誤，只能填入英文字母、數字及_符號，且長度必需在3到10之間");
				}
				
				if (mgr_mail == null || (mgr_mail.trim()).length() == 0) {
					errorMsgs.add("email不得空白");
				}
				
				if(!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/mgr/mgrLostPS.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
   /***************************2.開始查詢資料庫比對資料*****************************************/
				MgrService mgrSvc = new MgrService();
				MgrVO mgrVO = mgrSvc.getMgrLostPS(mgr_account,mgr_mail);
				
				if (mgrVO == null) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back_end/mgr/mgrlogin.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
	/**************************資料正確，寄送密碼**************************************************************/
				  String to = mgr_mail;     
			      String subject = "密碼通知";      
			      String ch_name = mgr_account;
			      String passRandom = mgrVO.getMgr_password();
			      String messageText = "您好，管理員 " + ch_name + " 以下為您遺失的密碼，請謹慎保管: " + passRandom + "\n" +" (已經啟用)"; 
			       
				
				 try {
					   // 設定使用SSL連線至 Gmail smtp Server
					   Properties props = new Properties();
					   props.put("mail.smtp.host", "smtp.gmail.com");
					   props.put("mail.smtp.socketFactory.port", "465");
					   props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
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
					   message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(to));
					  
					   //設定信中的主旨  
					   message.setSubject(subject);
					   //設定信中的內容 
					   message.setText(messageText);

					   Transport.send(message);
					   System.out.println("傳送成功!");
			     }catch (MessagingException e){
				     System.out.println("傳送失敗!");
				     e.printStackTrace();
				     }	
	     /*****************************************************************/
				 String url = "/back_end/mgr/mgrlogin.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); 
					successView.forward(req, res);
				 
			}catch(Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/mgr/mgrlogin.jsp");
				failureView.forward(req, res);
				
				
				
			}
				
				
	}
	
	
	}
}
