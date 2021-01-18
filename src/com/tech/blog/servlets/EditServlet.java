package com.tech.blog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.blog.dao.userDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.user;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
//		fetch all data
		String userEmail = request.getParameter("user_email");
		String userName = request.getParameter("user_name");
		String userPassword = request.getParameter("user_password");
		String userAbout = request.getParameter("user_about");
//		image
		Part part=request.getPart("image");
		String imageName=part.getSubmittedFileName();
		
		
//		get user from session
		
		HttpSession s=request.getSession();
		user user=(user)s.getAttribute("currentUser");
		
//		set edited details
		
		user.setEmail(userEmail);
		user.setName(userName);
		user.setPassword(userPassword);
		user.setAbout(userAbout);
		String oldFile=user.getProfile();
		user.setProfile(imageName);
		
//	update in database	
		
		userDao d=new userDao(ConnectionProvider.getConnection());
		
		boolean ans=d.updateUser(user);
		PrintWriter out=response.getWriter();
		if(ans)
		{
		
			
			String path=request.getRealPath("/")+"pics"+File.separator+user.getProfile();
			
//			delete code
			String pathOldFile=request.getRealPath("/")+"pics"+File.separator+oldFile; 
			Helper.deleteFile(pathOldFile);
			
				if(Helper.saveFile(part.getInputStream(), path))
				{
				
					Message msg=new Message("Profile details updated","success","alert-success");
					
					s.setAttribute("msg", msg);
					
				}
				else{
					Message msg=new Message("Something went wrong","error","alert-danger");
					
					s.setAttribute("msg", msg);
				}
			}
			
		
		else{
			
			Message msg=new Message("Something went wrong","error","alert-danger");
			
			s.setAttribute("msg", msg);
			
		}
		
		response.sendRedirect("profile.jsp");
	}

}
