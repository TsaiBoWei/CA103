package com.Mgr.controller;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MgrLoginFilter implements Filter{
	
	private FilterConfig config;
	
	
	public void init(FilterConfig config) {
		
		this.config= config;	
	}
	
	public void destroy() {
		config = null;
	}
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		HttpSession session = req.getSession();
		Object islogin = session.getAttribute("islogin");
		if(islogin == null) {
			session.setAttribute("location", req.getRequestURI());
			res.sendRedirect(req.getContextPath()+"/back_end/mgr/mgrlogin.jsp");
			return;
		}else {
			chain.doFilter(request, response);
		}
		
	}
	
}
