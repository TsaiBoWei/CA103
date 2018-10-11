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
				// �]�w�ϥ�SSL�s�u�� Gmail smtp Server
				Properties props = new Properties();
				props.put("mail.smtp.host", "smtp.gmail.com");
				props.put("mail.smtp.socketFactory.port", "465");
				props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
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
				message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));

				// �]�w�H�����D��
				message.setSubject(subject);
				// �]�w�H�������e
				message.setText(messageText);

				Transport.send(message);
				System.out.println("�ǰe���\!");
			} catch (MessagingException e) {
				System.out.println("�ǰe����!");
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
		if ("refundconfirm".equals(action)) { // �Ӧ�coach.jsp���ШD
			
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z *************************/
				
				String crorder_id = req.getParameter("crorder_id");

				/*************************** 2.�}�l�ק��� ***************************************/
				PurchcourService purchcourSvc = new PurchcourService();
				purchcourSvc.updatePurchCourRefund( "CO3", crorder_id);
System.out.println(crorder_id);

				/*************************** 3.�ק粒��,�ǳ����(Send the Success view) ***********/
               
                String url = "/front_end/course/coach/page/coach.jsp";
                PurchCourVO purchCourVO = purchcourSvc.getonePurchCour(crorder_id);
                
                CourlistService courlistSvc=new CourlistService();
                
                CourlistVO courlistVO=courlistSvc.getOneCourlist(purchCourVO.getCour_id());
                
                MemService memSvc = new MemService();
				MemVO menVO = memSvc.getOneMem(purchCourVO.getMem_id());


				String to = "chtseng89@gmail.com";

				String subject = "�ҵ{�h�ڽT�{";

				String messageText = "Hello! " + menVO.getMem_name() + " �z�� " + courlistVO.getCname() + "�ҵ{�w�T�{�h��, �U���ЦҼ{�P�� ";
				MailService mailService = new MailService();
				mailService.sendMail(to, subject, messageText);

				System.out.println("OK");
                req.setAttribute("localhref",url );
				RequestDispatcher successView = req.getRequestDispatcher(url); // 
				successView.forward(req, res);
  
				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/coach/page/coach.jsp");
				failureView.forward(req, res);
			}
		}
		
		//cc
		if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllCourlist.jsp���ШD

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.�����ШD�Ѽ�****************************************/
				String coa_id = new String(req.getParameter("coa_id"));
				
				/***************************2.�}�l�d�߸��****************************************/
				CoachService coachSvc = new CoachService();
				CoachVO coachVO = coachSvc.getOneCoach(coa_id);
								
				/***************************3.�d�ߧ���,�ǳ����(Send the Success view)************/
				req.setAttribute("coachVO", coachVO);         // ��Ʈw���X��coachVO����,�s�Jreq
				String url = "/front_end/course/coach/page/update_CoachText.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_CoachText.jsp
				successView.forward(req, res);

				/***************************��L�i�઺���~�B�z**********************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/course/coach/page/update_CoachText.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { // �Ӧ�update_CoachText.jsp���ШD
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
//			try {
				/***************************1.�����ШD�Ѽ� - ��J�榡�����~�B�z**********************/
				String coa_id = new String (req.getParameter("coa_id").trim());
System.out.println(coa_id);
				String mem_id = req.getParameter("mem_id");

	            String coa_text = req.getParameter("coa_text");
				
				String coa_status = req.getParameter("coa_status").trim();
				String coa_statusReg = "^[(CS)(0-9)]{4}$";
				if (coa_status == null || coa_status.trim().length() == 0) {
					errorMsgs.add("�b�����A: �ФŪť�");
				} else if(!coa_status.trim().matches(coa_statusReg)) { //�H�U�m�ߥ��h(�W)��ܦ�(regular-expression)
					errorMsgs.add("�b�����A: �u��OCS+���Ʀr");
	            }
						
				CoachVO coachVO = new CoachVO();
				coachVO.setCoa_id(coa_id);
				coachVO.setMem_id(mem_id);
				coachVO.setCoa_text(coa_text);
				coachVO.setCoa_status(coa_status);
System.out.println("����");

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("coachVO", coachVO); // �t����J�榡���~��coachVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/coach/page/update_CoachText.jsp");
					failureView.forward(req, res);
					return; //�{�����_
				}

			
				/***************************2.�}�l�ק���*****************************************/
				CoachService coachSvc = new CoachService();
				coachVO = coachSvc.updateCoach(coa_id, mem_id, coa_text, coa_status);
System.out.println("�ק�");
						
				/***************************3.�ק粒��,�ǳ����(Send the Success view)*************/
				req.setAttribute("coachVO", coachVO); // ��Ʈwupdate���\��,���T����coachVO����,�s�Jreq
				String url = "/front_end/course/coach/page/coach.jsp";
				
				RequestDispatcher successView = req.getRequestDispatcher(url); // �ק令�\��,���listOneCoach.jsp
				successView.forward(req, res);
System.out.println("���");

				/***************************��L�i�઺���~�B�z*************************************/
//			} catch (Exception e) {
//				errorMsgs.add("�ק��ƥ���:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front_end/course/coach/update_CoachText.jsp");
//				failureView.forward(req, res);
//			}
		}

        if ("insert".equals(action)) { // �Ӧ�addCoachText.jsp���ШD  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

//			try {
				/***********************1.�����ШD�Ѽ� - ��J�榡�����~�B�z*************************/
				String mem_id = new String (req.getParameter("mem_id").trim());

	            String coa_text = req.getParameter("coa_text");
				
//				String coa_status = req.getParameter("coa_status").trim();



				CoachVO coachVO = new CoachVO();
				coachVO.setMem_id(mem_id);
				coachVO.setCoa_text(coa_text);
				coachVO.setCoa_status("CS01");

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("coachVO", coachVO); // �t����J�榡���~��coachVO����,�]�s�Jreq
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/coach/addCoachText.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.�}�l�s�W���***************************************/
				CoachService coachSvc = new CoachService();
				coachVO = coachSvc.addCoach(mem_id, coa_text, "CS01");
				
				/***************************3.�s�W����,�ǳ����(Send the Success view)***********/
				String url = "/front_end/mem/updateMember/updateMember.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllCourlist.jsp
				successView.forward(req, res);				
				
				/***************************��L�i�઺���~�B�z**********************************/
//			} catch (Exception e) {
//				errorMsgs.add("�s�W��ƥ���:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front_end/course/courlist/addCoachText.jsp");
//				failureView.forward(req, res);
//			}
		}

	}

}
