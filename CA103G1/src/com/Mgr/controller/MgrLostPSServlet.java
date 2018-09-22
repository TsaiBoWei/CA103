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
				
	/************************�����b���Bemail�A�i���J�榡���~�B��**************************/
				String mgr_account = req.getParameter("mgr_account");
				String mgr_mail = req.getParameter("mgr_mail");
				
				String accountchk = "^[(a-zA-Z0-9_)]{3,10}$"; //���ұb�����W��ܪk
				if (mgr_account == null || (mgr_account.trim()).length() == 0) {
					errorMsgs.add("�b�����o�ť�");
				}else if(!mgr_account.trim().matches(accountchk)) {
				errorMsgs.add("�b���榡���~�A�u���J�^��r���B�Ʀr��_�Ÿ��A�B���ץ��ݦb3��10����");
				}
				
				if (mgr_mail == null || (mgr_mail.trim()).length() == 0) {
					errorMsgs.add("email���o�ť�");
				}
				
				if(!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/mgr/mgrLostPS.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
   /***************************2.�}�l�d�߸�Ʈw�����*****************************************/
				MgrService mgrSvc = new MgrService();
				MgrVO mgrVO = mgrSvc.getMgrLostPS(mgr_account,mgr_mail);
				
				if (mgrVO == null) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back_end/mgr/mgrlogin.jsp");
					failureView.forward(req, res);
					return;//�{�����_
				}
				
	/**************************��ƥ��T�A�H�e�K�X**************************************************************/
				  String to = mgr_mail;     
			      String subject = "�K�X�q��";      
			      String ch_name = mgr_account;
			      String passRandom = mgrVO.getMgr_password();
			      String messageText = "�z�n�A�޲z�� " + ch_name + " �H�U���z�򥢪��K�X�A���ԷV�O��: " + passRandom + "\n" +" (�w�g�ҥ�)"; 
			       
				
				 try {
					   // �]�w�ϥ�SSL�s�u�� Gmail smtp Server
					   Properties props = new Properties();
					   props.put("mail.smtp.host", "smtp.gmail.com");
					   props.put("mail.smtp.socketFactory.port", "465");
					   props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
					   props.put("mail.smtp.auth", "true");
					   props.put("mail.smtp.port", "465");

			       // ���]�w gmail ���b�� & �K�X (�N�ǥѧA��Gmail�ӶǰeEmail)
			       // �����NmyGmail���i�w���ʸ��C�����ε{���s���v�j���}
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
					  
					   //�]�w�H�����D��  
					   message.setSubject(subject);
					   //�]�w�H�������e 
					   message.setText(messageText);

					   Transport.send(message);
					   System.out.println("�ǰe���\!");
			     }catch (MessagingException e){
				     System.out.println("�ǰe����!");
				     e.printStackTrace();
				     }	
	     /*****************************************************************/
				 String url = "/back_end/mgr/mgrlogin.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); 
					successView.forward(req, res);
				 
			}catch(Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/mgr/mgrlogin.jsp");
				failureView.forward(req, res);
				
				
				
			}
				
				
	}
	
	
	}
}
