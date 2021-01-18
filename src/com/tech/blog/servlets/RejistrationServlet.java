package com.tech.blog.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.tech.blog.dao.userDao;
import com.tech.blog.entities.user;
import com.tech.blog.helper.ConnectionProvider;
@MultipartConfig
public class RejistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
			PrintWriter out = response.getWriter();
	String check=request.getParameter("check");
	if(check==null)
	{
	out.println("Box not checked");
	}
	
	else{
		
		String name=request.getParameter("user_name");
		String email=request.getParameter("user_email");
		String password=request.getParameter("user_password");
		String gender=request.getParameter("gender");
		String about=request.getParameter("about");
		
//		save this data in user class
		user user=new user(name,email,password,gender,about);
		
		
		
		
		
		
//		to insert in db create object of user dao
		
		userDao dao=new userDao(ConnectionProvider.getConnection());
		
		 if(dao.saveUser(user)){
			 
			 out.println("done");
		 }
		 else{
			 out.println("error");
		 }
		
		
		
	}
		
	}

	
	}


