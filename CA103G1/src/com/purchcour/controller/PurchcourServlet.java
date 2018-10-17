package com.purchcour.controller;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

///email
import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.courlist.model.CourlistService;
import com.courlist.model.CourlistVO;
import com.mem.model.MemService;
import com.mem.model.MemVO;
import com.purchcour.model.PurchCourVO;
import com.purchcour.model.PurchcourService;

/**
 * Servlet implementation class PurchcourServlet
 */

public class PurchcourServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
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

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("insert".equals(action)) { // 來自purchaseform的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String mem_id = req.getParameter("mem_id");
				String cour_id = req.getParameter("cour_id");
				System.out.println("mem_id=" + mem_id);
				System.out.println("cour_id=" + cour_id);
				PurchcourService purchcourSVC = new PurchcourService();
				List<String> ownlist = purchcourSVC.findMemOwnCourse(mem_id);
				if (ownlist != null) {
					boolean purchasAlready = ownlist.contains(cour_id);
					System.out.println("purchasAlready=" + purchasAlready);
					if (purchasAlready) {
						errorMsgs.add("此課程已購買");
					}

				}
				System.out.println("perrorMsgs=" + errorMsgs);

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/purchcour/page/purchcourform.jsp");
					failureView.forward(req, res);
					return;
				}

				Date crorder_time = new Date(System.currentTimeMillis());
				System.out.println("mem_id=" + mem_id);
				System.out.println("cour_id=" + cour_id);
				System.out.println("crorder_time=" + crorder_time);

				// card holder

				String cardholder = req.getParameter("cardholder");
				System.out.println("cardholder=" + cardholder);
				String cardholderReg = "^[(\u4e00-\u9fa5)(a-zA-Z)]{2,10}$";
				if (cardholder == null || cardholder.trim().length() == 0) {
					errorMsgs.add("Card Holder 請勿空白");
				} else if (!cardholder.trim().matches(cardholderReg)) {
					errorMsgs.add("Card Holder只能是中英文字母 ,長度需在2-10");
				}

				// card Number

				String cardNumber = req.getParameter("cardNumber");
				System.out.println("cardholder=" + cardNumber);
				String cardNumberReg = "^[0-9]{16}$";
				if (cardNumber == null || (cardNumber.trim()).length() == 0) {
					errorMsgs.add("請輸入 Card Number");
				} else if (!cardNumber.trim().matches(cardNumberReg)) {
					errorMsgs.add("Card Number只能是數字,長度為16");
				}

				// valid mon

				String validMon = req.getParameter("validmonth");
				System.out.println("validMon=" + validMon);
				String validMonReg = "^(0[1-9]|1[0-2])$";
				if (validMon == null || (validMon.trim()).length() == 0) {
					errorMsgs.add("請輸入 Valid Month");
				} else if (!validMon.trim().matches(validMonReg)) {
					errorMsgs.add("Valid Month格式錯誤");
				}

				// valid year

				String validYear = req.getParameter("validYear");
				System.out.println("validYear=" + validYear);
				String validYearReg = "^[0-9]{2}$";
				;
				if (validYear == null || (validYear.trim()).length() == 0) {
					errorMsgs.add("請輸入 Valid Year");
				} else if (!validYear.trim().matches(validYearReg)) {
					errorMsgs.add("Valid Year格式錯誤");
				}

				// valid cvc

				String cvc = req.getParameter("cvc");
				System.out.println("cvc=" + cvc);
				String cvcReg = "^[0-9]{3}$";
				;
				if (cvc == null || (cvc.trim()).length() == 0) {
					errorMsgs.add("請輸入CVC");
				} else if (!cvc.trim().matches(cvcReg)) {
					errorMsgs.add("CVC格式錯誤");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/purchcour/page/purchcourform.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/

				String crorder_id = purchcourSVC.addPurchCour(crorder_time, mem_id, cour_id);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
//				String whichPage = req.getParameter("whichPage");

				MemService memSvc = new MemService();
				MemVO menVO = memSvc.getOneMem(mem_id);

				CourlistService courlistSvc = new CourlistService();
				CourlistVO courlistVO = courlistSvc.getOneCourlist(cour_id);

//				String url = "/front_end/course/purchcour/page/purchcour.jsp?perpageloc=course";
				String url = "/front_end/course/purchcour/page/purchcour.jsp?perpageloc=course&successpayment=successpayment";

				String to = "chtseng89@gmail.com";

				String subject = "課程購買確認";

				String messageText = "Hello! " + menVO.getMem_name() + " 感謝您購買 " + courlistVO.getCname() + "課程, 訂單編號為:"
						+ crorder_id;
				MailService mailService = new MailService();
				mailService.sendMail(to, subject, messageText);

				System.out.println("OK");
				req.setAttribute("localhref", url);
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交maincourbaor.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());

				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/course/purchcour/page/purchcourform.jsp");
				failureView.forward(req, res);
			}
		}

		if ("updateforrate".equals(action)) { // 來自purchcour.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/

				String crorder_id = req.getParameter("crorder_id");

				String courscostr = req.getParameter("coursco");
System.out.println("crorder_id"+crorder_id);
				if (courscostr == null || courscostr.trim().length() == 0) {
					errorMsgs.add("請評分");
System.out.println("errorMsgs="+errorMsgs);
				}
				String whichPage = req.getParameter("whichPage");

				if (!errorMsgs.isEmpty()) {
					String returncname=req.getParameter("returncname");
System.out.println("returncname"+returncname);
					boolean openrateform=true;
					req.setAttribute("openrateform",openrateform);	// 再次打開update燈箱
					req.setAttribute("returncname",returncname);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/purchcour/page/purchcour.jsp?perpageloc=course");
					failureView.forward(req, res);
					return;
				}

				Double coursco = new Double(courscostr);

				/*************************** 2.開始修改資料 ***************************************/

				PurchcourService purchcourSvc = new PurchcourService();
				purchcourSvc.updatePurchCourScore(coursco, crorder_id);

				/*************************** 3.修改完成,準備轉交(Send the Success view) ***********/

				System.out.println(whichPage);
				String url = "/front_end/course/purchcour/page/purchcour.jsp?perpageloc=course&whichPage" + whichPage;
System.out.println("coursco"+coursco);
				req.setAttribute("localhref", url);
				RequestDispatcher successView = req.getRequestDispatcher(url); //
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				String returncname=req.getParameter("returncname");
System.out.println("returncname"+returncname);		
				boolean openrateform=true;
				req.setAttribute("openrateform",openrateform );// 再次打開update燈箱
				req.setAttribute("returncname",returncname);
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/course/purchcour/page/purchcour.jsp?perpageloc=course");
				failureView.forward(req, res);
			}
		}
		
		
		if ("updateforrefund".equals(action)) { // 來自maincourboar.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				
				String crorder_id = req.getParameter("crorder_id");

				/*************************** 2.開始修改資料 ***************************************/
				PurchcourService purchcourSvc = new PurchcourService();
				purchcourSvc.updatePurchCourRefund( "CO2", crorder_id);
System.out.println(crorder_id);

				/*************************** 3.修改完成,準備轉交(Send the Success view) ***********/
                String whichPage=req.getParameter("whichPage");
                String url = "/front_end/course/purchcour/page/purchcour.jsp?perpageloc=course&whichPage="+whichPage;
                req.setAttribute("localhref",url );
				RequestDispatcher successView = req.getRequestDispatcher(url); // 
				successView.forward(req, res);
  
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/course/purchcour/page/purchcour.jsp?perpageloc=course");
				failureView.forward(req, res);
			}
		}

	}
}
