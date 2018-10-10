package com.courunit.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.courlist.model.CourlistService;
import com.courlist.model.CourlistVO;
import com.courunit.model.CourunitService;
import com.mem.model.MemService;
import com.mem.model.MemVO;



@MultipartConfig
public class CourunitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   


	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("insert".equals(action)) { // �Ӧ�courunit���ШD
System.out.println("insert");
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z *************************/
				String cour_id = req.getParameter("cour_id");
				Double cour_length =new Double(req.getParameter("cour_length"));
//				Double cour_length=0.0;
System.out.println("cour_id=" + cour_id);
System.out.println("cour_length=" + cour_length);
				

                //cu_name

				String cu_name = req.getParameter("cu_name");
System.out.println("cu_name=" + cu_name);
				
				if (cu_name == null || (cu_name.trim()).length() == 0) {
					errorMsgs.add("�п�J�椸�W��");
				} 

                Part part=req.getPart("videofile");//
                
                System.out.println("part.getSize()="+part.getSize());
				String cour_vtype=part.getContentType();
				String cour_vtypeEx = part.getContentType().substring(0,cour_vtype.indexOf("/"));
				System.out.println("cour_vtypeEx="+cour_vtypeEx);	
                

				byte[] cour_film_blob = null;

				if (part.getSize() != 0 && cour_vtypeEx.equalsIgnoreCase("video") ) {
					InputStream in = part.getInputStream();
					cour_film_blob = new byte[in.available()];
					in.read(cour_film_blob);
System.out.println(cour_film_blob.length);
					in.close();
				}else {
					errorMsgs.add("���n���v���ɮשO");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					boolean openaddunitform=true; // �A�����}openreplyform�O�c
					req.setAttribute("openaddunitform",openaddunitform);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/courlist/courunit.jsp?courpageloc=tabfour");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.�}�l�s�W��� ***************************************/

				CourunitService courunitService=new CourunitService();
				
				courunitService.addCourUnit(cour_id, cu_name, cour_film_blob, cour_length,
						 cour_vtype);

				/*************************** 3.�s�W����,�ǳ����(Send the Success view) ***********/

				String url = "/front_end/course/courlist/courunit.jsp?courpageloc=tabfour";

				System.out.println("OK");
				req.setAttribute("localhref", url);//����navbar��m
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����maincourbaor.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				boolean openaddunitform=true; // �A�����}openreplyform�O�c
				req.setAttribute("openaddunitform",openaddunitform);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/course/courlist/courunit.jsp?courpageloc=tabfour");
				failureView.forward(req, res);
			}
		}
	}

}
