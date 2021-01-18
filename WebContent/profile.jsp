<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.user"%>
<%@page errorPage="error_page.jsp"%>
<%
	user user = (user) session.getAttribute("currentUser");
	if (user == null) {
		response.sendRedirect("login_page.jsp");
	}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile page</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
.banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 85%, 70% 100%, 34% 94%, 0 100%, 0 0
		);
}
body{
background: url(img/bg.jpg);
background-size: cover;
background-attachment: fix;
}
</style>
</head>
<body>

	<!-- navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
	<a class="navbar-brand" href="index.jsp"><span
		class="fa fa-certificate  "></span> Tech Blog</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="#"><span
					class="fa fa-pencil  "></span> Study <span class="sr-only">(current)</span></a>
			</li>

			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <span class="fa fa-unsorted  "></span>
					Categories
			</a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#">Programming Language</a> <a
						class="dropdown-item" href="#">Project Implementation</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">Data Structures</a>
				</div></li>
			<li class="nav-item"><a class="nav-link" href="#"><span
					class="fa fa-volume-control-phone  "></span> Contact</a></li>

			<li class="nav-item"><a class="nav-link" href="#"
				data-toggle="modal" data-target="#add-post-modal"><span
					class="fa fa-asterisk   "></span> Post</a></li>

		</ul>

		<ul class="navbar-nav mr-right">

			<li class="nav-item"><a class="nav-link" href="#!"
				data-toggle="modal" data-target="#profile-modal"><span
					class="fa fa-user-circle  "></span> <%=user.getName()%></a></li>

			<li class="nav-item"><a class="nav-link" href="LogoutServlet"><span
					class="fa fa-group  "></span> Logout</a></li>

		</ul>


	</div>
	</nav>

	<!-- end of navbar -->
	<%
		Message m = (Message) session.getAttribute("msg");

		if (m != null) {
	%>
	<div class="alert alert-danger" role="alert">
		<%=m.getContent()%>
	</div>

	<%
		session.removeAttribute("msg");
		}
	%>

	<!-- main body -->

	<main>

	<div class="container">
		<div class="row mt-4">

			<div class="col-md-4">
				<!-- categories -->
				<div class="list-group">
					<a href="#" onclick="getPosts(0, this)" class="c-link list-group-item list-group-item-action active">	All Posts </a> 
					<%
					
					PostDao d=new PostDao(ConnectionProvider.getConnection());
					ArrayList<Category> list1 = d.getAllCategories();
					 for(Category cc : list1)
					 {
						 
					%>
					
						<a href="#" onclick="getPosts(<%= cc.getId() %>, this)" class="c-link list-group-item list-group-item-action"><%= cc.getName() %></a>
			<%
					 }
			%>
			
			
				</div>



			</div>

			<div class="col-md-8">
				<!-- posts -->
<div class="container text-center" id="loader">
<i class="fa fa-refresh fa-3x fa-spin"></i>
<h3 class="mt-2">Loading...</h3>
</div>
			
<div class="container-fluid" id="post-container">


</div>
</div>

		</div>

	</div>

	</main>


	<!-- main body ends -->


	<!--profile modal -->

	<!-- Modal -->
	<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white ">
					<h5 class="modal-title text-center" id="exampleModalLabel">TECHBLOG</h5>

					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img src="pics/<%=user.getProfile()%>" class="img-fluid"
							style="border-radius: 50%; max-width: 150px"><br>
						<h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>

						<!-- details -->


						<div id="profile-details">
							<table class="table">

								<tbody>
									<tr>
										<th scope="row">ID :</th>
										<td><%=user.getId()%></td>

									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail()%></td>

									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender()%></td>

									</tr>
									<tr>
										<th scope="row">Status :</th>
										<td><%=user.getProfile()%></td>

									</tr>

									<tr>
										<th scope="row">Registered on :</th>
										<td><%=user.getDateTime().toString()%></td>

									</tr>
								</tbody>
							</table>
						</div>

						<div id="profile-edit" style="display: none;">
							<h3 class="mt-2">Please Edit Carefully</h3>
							<form action="EditServlet" method="POST"
								enctype="multipart/form-data">
								<table>
									<tr>
										<td>ID :</td>
										<td><%=user.getId()%></td>
									</tr>

									<tr>
										<td>Email :</td>
										<td><input type="email" class="form-control"
											name="user_email" value="<%=user.getEmail()%>"></td>
									</tr>
									<tr>
										<td>Name :</td>
										<td><input type="text" class="form-control"
											name="user_name" value="<%=user.getName()%>"></td>
									</tr>
									<tr>
										<td>Password :</td>
										<td><input type="password" class="form-control"
											name="user_password" value="<%=user.getPassword()%>"></td>
									</tr>
									<tr>
										<td>Gender :</td>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>
									<tr>
										<td>About :</td>
										<td><textarea rows="3" class="form-control"
												name="user_about"><%=user.getAbout()%> </textarea></td>
									</tr>

									<tr>
										<td>Profile picture :</td>
										<td><input type="file" class="form-control" name="image">
										</td>
									</tr>

								</table>

								<div class="container">

									<button type="submit" class="btn btn-outline-primary mt-2">Save</button>


								</div>


							</form>
						</div>





					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id="edit-profile-btn" type="button" class="btn btn-primary">Edit</button>
				</div>



			</div>
		</div>
	</div>

	<!-- post modal -->



	<!-- Modal -->
	<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Give Post
						Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="add-post-form" action="AddPostServlet" method="post">

						<div class="form-group">
							<select class="form-control" name="cid">


								<option selected disabled>---Select Category---</option>
								<%
									PostDao postd = new PostDao(ConnectionProvider.getConnection());
									ArrayList<Category> list = postd.getAllCategories();
									for (Category c : list) {
								%>

								<option value="<%=c.getId()%>"><%=c.getName()%></option>

								<%
									}
								%>

							</select>
						</div>



						<div class="form-group">
							<input name="pTitle" type="text" placeholder="Enter post title"
								class="form-control">
						</div>
						<div class="form-group">
							<textarea name="pContent" rows="5" class="form-control"
								placeholder="Enter your content"></textarea>
						</div>
						<div class="form-group">
							<textarea name="pCode" rows="5" class="form-control"
								placeholder="Enter your program (if any)"></textarea>
						</div>
						<div class="form-group">
							<lable>Select your pic :</lable>
							<br> <input name="pic" type="file">
						</div>





						<div class="container text-center">

							<button type="submit" class="btn btn-outline-primary">POST</button>

						</div>
					</form>
				</div>
			</div>
		</div>
	</div>



	<!-- post modal ends -->

	<script src="https://code.jquery.com/jquery-3.5.1.min.js"
		integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>

	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

	<script src="js/myjs.js" type="text/javascript"></script>
	<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- toggle of details and edit -->
	<script>
		$(document).ready(function() {
			let
			editStatus = false;
			$("#edit-profile-btn").click(function() {

				if (editStatus == false) {
					$("#profile-details").hide();
					$("#profile-edit").show();
					editStatus = true;
					$("#edit-profile-btn").text("Done");
				} else {
					$("#profile-details").show();
					$("#profile-edit").hide();
					editStatus = false;
					$("#edit-profile-btn").text("Edit");
				}
			});

		});
	</script>




	<!--Add post javascript  -->

	<script>
		$(document)
				.ready(
						function() {
							console.log("clicked submit button.........!1...");
							$("#add-post-form")
									.on(
											"submit",
											function(event) {
												//called when form is submitted
												console.log("sssssssssss.");
												event.preventDefault();

												let
												form = new FormData(this);

												//requesting to server

												$
														.ajax({
															url : "AddPostServlet",
															type : 'POST',
															data : form,
															success : function(
																	data,
																	textStatus,
																	jqXHR) {
																console
																		.log(data);
																if (data.trim() == 'done') {
																	swal(
																			"Good job!",
																			"Saved Successfully !",
																			"success");
																} else {
																	swal(
																			"Error!",
																			"Something went wrong !",
																			"error");
																}
															},
															error : function(
																	jqXHR,
																	textStatus,
																	errorThrown) {
																swal(
																		"Error!",
																		"Something went wrong !",
																		"error");
															},
															processData : false,
															contentType : false
														})

											});

						});
	</script>


<script>

function getPosts(catId, temp){
	$("#loader").show();
	$("#post-container").hide()
	
	$(".c-link").removeClass('active');
	
	
	 $.ajax({
			url:"load_posts.jsp",
			data:{cid: catId},
		    success:function(data,textStatus,jqXHR){
		    	console.log(data);
		    //	Thread.sleep(1000);
		    	$("#loader").hide();
		    	$("#post-container").show();
		    	$('#post-container').html(data)
		    	
		    	$(temp).addClass('active');
		    }
		

		
		}) 
}

 $(document).ready(function(e){
	
	 let allPostRef=$('.c-link')[0]
		getPosts(0,allPostRef)
	 
	 
 })

</script>













</body>
</html>