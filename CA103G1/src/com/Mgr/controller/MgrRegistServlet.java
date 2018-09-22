package com.Mgr.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.Mgr.model.MgrService;
import com.Mgr.model.MgrVO;
@MultipartConfig
public class MgrRegistServlet extends HttpServlet {
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException { 
			
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		String actionRg = req.getParameter("actionRg");
		
		
		if("Mgr_Regist".equals(actionRg)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs",errorMsgs);
		
			try {
/***************************1.接收註冊資料 - 輸入格式的錯誤處理**********************/
				//生成亂數密碼
				StringBuffer mgrPassword = new StringBuffer();
				String str="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
				
				for (int i = 0; i < 10 ; i++) {
					int n = (int)((Math.random()*61+1));
					char c = str.charAt(n);
					mgrPassword.append(c);
				}
				

				String mgr_account = req.getParameter("mgr_account");
				String mgr_name = req.getParameter("mgr_name");
				String mgr_mail = req.getParameter("mgr_mail");
				String mgr_password = mgrPassword.toString();
//				byte[] mgr_photo = null;
		
				
				Part part =	req.getPart("mgr_photo");		
				InputStream in = part.getInputStream();				
				byte[] mgr_photo = new byte[in.available()];
				in.read(mgr_photo);			
				in.close();
				
				
				
				String accountchk = "^[(a-zA-Z0-9_)]{3,10}$";
				if (mgr_account == null || (mgr_account.trim()).length() == 0) {
					errorMsgs.add("帳號不得空白");
				}else if(!mgr_account.trim().matches(accountchk)) {
				errorMsgs.add("帳號格式錯誤，只能填入英文字母、數字及_符號，且長度必需在3到10之間");	
				}
			
				String namechk = "^[(\u4e00-\u9fa5)(a-zA-Z0-9)]{2,10}$";
				if (mgr_name == null || mgr_name.trim().length() == 0) {
					errorMsgs.add("姓名不得空白");
				} else if(!mgr_name.trim().matches(namechk)) { 
					errorMsgs.add("姓名格式錯誤，只能是中、英文字母, 且長度必需在2到10之間");
					System.out.println(mgr_name);
	            }
				
			
				
				String mailchk = "^[(a-zA-Z0-9_@)]{5,20}$";
				
				if (mgr_mail == null || mgr_mail.trim().length() == 0) {
					errorMsgs.add("E-mail不得空白");
				} else if(mgr_mail.trim().matches(mailchk)) { 
					errorMsgs.add("E-mail格式錯誤");
	            }
				
				
				if(!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/mgr/mgrregist.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
/***************************2.開始新增管理員資料*****************************************/
				
				MgrService mgrSvc = new MgrService();
				MgrVO mgrVO = mgrSvc.addMgr(mgr_account,mgr_name,mgr_password,mgr_photo,mgr_mail);
				
				
			/******************以下做密碼email通知*****************************/	
				  String to = mgr_mail;     
			      String subject = "密碼通知";      
			      String ch_name = mgr_account;
			      String passRandom = mgr_password;
			      String messageText = "您好，管理員 " + ch_name + " 以下為您的密碼，請謹慎保管: " + passRandom + "\n" +" (已經啟用)"; 
			       
				
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
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交mgrlogin.jsp
				successView.forward(req, res);
			
			}catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/mgr/mgrlogin.jsp");
				failureView.forward(req, res);
			}

		}
	}
	
}
	

