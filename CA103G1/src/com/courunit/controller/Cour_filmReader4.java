package com.courunit.controller;

import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.sql.DataSource;

import com.courunit.model.CourunitDAO;
import com.courunit.model.CourunitService;
import com.courunit.model.CourunitVO;

public class Cour_filmReader4 extends HttpServlet {


	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		ServletOutputStream out = res.getOutputStream();
		res.setContentType("video/mp4");
		

//		https://stackoverflow.com/questions/8088364/html5-video-will-not-loop?rq=1
//		rangeValue.Replace("=", " ") + (resource.Value.Length - 1).ToString() + "/" + resource.Value.Length.ToString(); 
//		res.StatusCode = HttpStatusCode.PartialContent;
		
		String cour_unit_id = req.getParameter("cour_unit_id").trim();
//		CourunitDAO courunitDAO = new CourunitDAO();
		CourunitService courunitSvc =new CourunitService();
		CourunitVO courunitVO = courunitSvc.findByPK(cour_unit_id);
		byte[] buf = courunitVO.getCour_film_blob(); 
		System.out.println("length=" + buf.length);
		
		res.addHeader("Accept-Ranges", "bytes");
		res.addHeader("Content-Range", "bytes 0-"+(buf.length-1)+"/"+(buf.length)); 
		res.setStatus(206);
		
		out.write(buf);
		out.flush();
		out.close();

	}
	
	

}