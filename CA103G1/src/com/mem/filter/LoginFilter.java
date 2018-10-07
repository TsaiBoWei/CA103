package com.mem.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;


public class LoginFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		
		HttpSession session = req.getSession();
		
		Object account = session.getAttribute("memVO");
		if(account ==null){
			session.setAttribute("location", req.getRequestURI());
			res.sendRedirect(req.getContextPath()+"/Mem_Login_Signup.jsp");
			return;
		}else {
			chain.doFilter(request, response);
		}
	}

}
