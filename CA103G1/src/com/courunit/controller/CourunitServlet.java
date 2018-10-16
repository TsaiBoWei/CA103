package com.courunit.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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
import com.courunit.model.CourunitVO;
import com.mem.model.MemService;
import com.mem.model.MemVO;
import com.watchedhr.model.WatchedhrService;
import com.watchedhr.model.WatchedhrVO;



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
		

		
		
		if ("queryforcourlist".equals(action)) { // 來自courunit的請求
			System.out.println("queryforcourlist");
						List<String> errorMsgs = new LinkedList<String>();
						// Store this set in the request scope, in case we need to
						// send the ErrorPage view.
						req.setAttribute("errorMsgs", errorMsgs);

						try {
							/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
							String cour_id = req.getParameter("cour_id");
							String crorder_id = req.getParameter("crorder_id");
							
						
							/*************************** 2.開始新增資料 ***************************************/

							CourunitService courunitService=new CourunitService();
							
							List<CourunitVO>courunitlist=courunitService.getCourUnit(cour_id);
							WatchedhrVO watchedhrVO= new WatchedhrService().getFirstByCrorder_id(crorder_id);
			System.out.println(courunitlist.size());

			
							
							StringBuilder str = new StringBuilder();
							for(int i=0; i<courunitlist.size();i++) {
								
								str.append("<li class=\"pb-1\" id=\""+courunitlist.get(i).getCour_unit_id()+"\"+data-dismiss=\"modal\">Unit &nbsp;·&nbsp;"+(i+1)+"&nbsp;<font class=\""+(courunitlist.get(i).getCour_unit_id()+i)+"\">"+(courunitlist.get(i).getCu_name())+"</font></li>");

								if (watchedhrVO!=null&&courunitlist.get(i).getCour_unit_id().equals(watchedhrVO.getCour_unit_id())) {
									
									Double watchedhr=watchedhrVO.getWatched_hr();
									Double mins=watchedhr/60;
									Double secs=watchedhr%60;
									
									int min = Integer.valueOf((mins).intValue());
									int sec = Integer.valueOf((secs).intValue());
								str.append("<script>\r\n" + 
//										" 								$(document).ready(function() {  \r\n" + 
										"					            alert(\"OKOK\"); var strli=$(\"#"+courunitlist.get(i).getCour_unit_id()+"\").text()+\"Latest\";\r\n" + 
										"									$(\"#"+courunitlist.get(i).getCour_unit_id()+"\").text(strli); \r\n" + 
//										"							}); \r\n" + 
										"								</script>");
								}
								
				
                               
								str.append("<script>" + 
								          " $(function() {\r\n" + 
								          "  $(\"#"+courunitlist.get(i).getCour_unit_id()+"\").click( function(){\r\n" + 
								          "   alert($(this).text());\r\n" + 
								          "    var courplantext=\"<a class='linkclass btn btn-outline-primary btn-sm' id='linkclass"+(courunitlist.get(i).getCour_unit_id()+i)+"' href='"+req.getContextPath()+"/front_end/course/courlist/courunit.jsp?cour_id="+courunitlist.get(i).getCour_id()+"&courpageloc=tabfour'>"+courunitlist.get(i).getCu_name()+"<font class='linkclose' id='linkclose"+(courunitlist.get(i).getCour_unit_id()+i)+"'>X</font></a>\";\r\n" + 
								          "    var courplantext2=\"<a class='linkclass' id='linkclass"+(courunitlist.get(i).getCour_unit_id()+i)+"' href='"+req.getContextPath()+"/front_end/course/courlist/courunit.jsp?cour_id="+courunitlist.get(i).getCour_id()+"&courpageloc=tabfour'>"+courunitlist.get(i).getCu_name()+"<font class='linkclose' id='linkclose"+(courunitlist.get(i).getCour_unit_id()+i)+"'></font></a>\";\r\n" + 
								          "     $('#courseplan').append(courplantext);"+
//								          "     inputcourplan+=courplantext2;\r\n" + 
//								          "$(\"#plan_votext\").val(inputcourplan);" + 
								          "\r\n" + 
								          "  });\r\n" + 
								          "  \r\n" + 
											"	$('#courseplan').on('click', '#linkclose"+(courunitlist.get(i).getCour_unit_id()+i)+"', function(){\r\n" +
											"      event.preventDefault();"+
											"		$('#courseplan').find('#linkclass"+(courunitlist.get(i).getCour_unit_id()+i)+"').remove();\r\n" + 
//											"       var plancourcontent=$(\"#courseplan\").html();"+                                    
//											"		$(\"#plan_votext\").val(plancourcontent);\r\n" + 
											"	 });\r\n" + 
											"	\r\n" + 
								          
								          " });\r\n" + 
								          " </script>");
								
							}
							res.setContentType("text/html;charset=utf-8");
							PrintWriter out = res.getWriter();
							
					   

							/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/

		 System.out.println(str.toString());
							out.println(str.toString());
                  

							/*************************** 其他可能的錯誤處理 **********************************/
						} catch (Exception e) {
							
						}
					}
		
		
		
	}

}
