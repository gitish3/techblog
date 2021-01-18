package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tech.blog.dao.userDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.user;
import com.tech.blog.helper.ConnectionProvider;

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
	String userEmail=request.getParameter("email");
	String userPassword=request.getParameter("password");
	
	userDao dao=new userDao(ConnectionProvider.getConnection());
	user u=dao.getUserbyEmailandPassword(userEmail, userPassword);
	
		if(u==null)
		{
		//out.println("Invalid user..Try again");
		
		Message msg=new Message("Invalid user..Try again","error","alert-danger");
		HttpSession s=request.getSession();
		s.setAttribute("msg", msg);
		response.sendRedirect("login_page.jsp");
		
		
		}
		else{
			HttpSession s=request.getSession();
			s.setAttribute("currentUser", u);
			response.sendRedirect("profile.jsp");
		}
		
		
	}

}
