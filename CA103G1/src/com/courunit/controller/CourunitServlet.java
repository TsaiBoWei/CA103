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
		
		if ("insert".equals(action)) { // 來自courunit的請求
System.out.println("insert");
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String cour_id = req.getParameter("cour_id");
				Double cour_length =new Double(req.getParameter("cour_length"));
//				Double cour_length=0.0;
System.out.println("cour_id=" + cour_id);
System.out.println("cour_length=" + cour_length);
				

                //cu_name

				String cu_name = req.getParameter("cu_name");
System.out.println("cu_name=" + cu_name);
				
				if (cu_name == null || (cu_name.trim()).length() == 0) {
					errorMsgs.add("請輸入單元名稱");
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
					errorMsgs.add("說好的影片檔案呢");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					boolean openaddunitform=true; // 再次打開openreplyform燈箱
					req.setAttribute("openaddunitform",openaddunitform);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/course/courlist/courunit.jsp?courpageloc=tabfour");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/

				CourunitService courunitService=new CourunitService();
				
				courunitService.addCourUnit(cour_id, cu_name, cour_film_blob, cour_length,
						 cour_vtype);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/

				String url = "/front_end/course/courlist/courunit.jsp?courpageloc=tabfour";

				System.out.println("OK");
				req.setAttribute("localhref", url);//跳到navbar位置
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交maincourbaor.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				boolean openaddunitform=true; // 再次打開openreplyform燈箱
				req.setAttribute("openaddunitform",openaddunitform);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/course/courlist/courunit.jsp?courpageloc=tabfour");
				failureView.forward(req, res);
			}
		}
	}

}
