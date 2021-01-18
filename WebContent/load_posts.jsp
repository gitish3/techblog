<%@page import="com.tech.blog.entities.user"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<div class="row">
	<%
	
	user uuu=(user)session.getAttribute("currentUser");
	
	
	
	
	Thread.sleep(1000);
		PostDao dd = new PostDao(ConnectionProvider.getConnection());
	List<Post> ppposts=null;
	int cid= Integer.parseInt(request.getParameter("cid"));
	if(cid==0)
	{
		ppposts = dd.getAllPosts();		
	}
	else{
		ppposts = dd.gePostByCatId(cid);
	}
	if(ppposts.size() == 0)
	{
		
		out.println("<h4 class='display-3 text-center'>No post in this category!</h4>");
		return;
	}

		
		for (Post pp : ppposts) {
	%>

	<div class="col-md-6 mt-2">
		<div class="card">
		 <img class="card-img-top" src="blog_pics/<%= pp.getpPic() %>" alt="Card image cap">
			<div class="card-body">

				<b><%=pp.getpTitle()%></b>
				<p><%=pp.getpContent()%></p>
				
			</div>
			<div class="card-footer primary-background text-center">
			
			<%
			LikeDao ld=new LikeDao(ConnectionProvider.getConnection());
			
			%>
			
			
				<a href="#" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%= ld.countLikeOnPost(pp.getPid()) %></span></a>
			<a href="show_blog_page.jsp?post_id=<%= pp.getPid() %>" class="btn btn-outline-light btn-sm">Read More...</a>
			<a href="#" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i> <span>20</span></a>
			
			</div>
        </div>

	</div>


	<%
		}
	%>
</div>
