<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registeration page</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="css/mystyle.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
.banner-background{
   clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 85%, 70% 100%, 12% 93%, 0 100%, 0 0);
   }
</style>

</head>
<body>
<%@include file="normal_navbar.jsp" %>

<main class="primary-background p-5 banner-background">
<div class="container">
<div class="col-md-6 offset-md-3">
<div class="card">
<div class="card-header text-center primary-background text-white">
<span class="fa fa-3x fa-group"></span>
<br>
REGISTER here
</div>
<div class="card-body">

<form id="reg-form" action="RejistrationServlet" method="POST">
  
 <div class="form-group">
    <label for="user_name">Name</label>
    <input name="user_name" type="text" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter name" required="required" >
     </div>


  <div class="form-group">
    <label for="exampleInputEmail1">Email address</label>
    <input name="user_email" type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email" required="required" pattern="^[\w.+\-]+@gmail\.com$">
    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Password</label>
    <input  name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password" required="required" >
  </div>
  
  
  <div class="form-group">
    <label for="gender">Select Gender</label><br>
    <input type="radio"  id="gender" name="gender" value="male">Male
    <input type="radio"  id="gender" name="gender" value="female">Female
    </div>
  
  <div class="form-group">
  <label>Something about yourself</label><br>
   <textarea name="about" class="form-control" placeholder="Enter something about yourself" rows="5" > </textarea> 
  </div>
  
  <div class="form-check">
    <input  name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
    <label class="form-check-label" for="exampleCheck1">Agree terms and conditions</label>
  </div>
   
  <br>
  <div class="container text-center" id="loader" style="display:none;">
  <span class="fa fa-refresh fa-spin fa-3x"></span>
  <h4>Please wait...</h4>
  </div>
  <button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
</form>


</div>
<div class="card-footer">


</div>
</div>


</div>
</div>
</main>




 <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<script
  src="https://code.jquery.com/jquery-3.4.1.min.js"
  integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
  crossorigin="anonymous"></script> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="js/myjs.js" type="text/javascript"></script>
<script>

 

  $(document).ready(function() {
	console.log('Loaded......!!!!')
	
	
	$('#reg-form').on('submit',function(event){
	
	event.preventDefault();
	
	let form=new FormData(this);
	   
	$("#submit-btn").hide();
	$("#loader").show();
	
	
	
	$.ajax({
	
		url:"RejistrationServlet",
		type:'POST',
		data: form,
		success: function (data, textStatus, jqXHR) {
			console.log(data)
			
			$("#submit-btn").show();
			$("#loader").hide();   
			
			
			if(data.trim()==='done')
				{
				swal("Successfully Rejistered..Redirecting to Login page.")
				.then((value) => {
				  window.location="login_page.jsp"
				}); 
				}else{
					swal("Errrrror");
				}
			
			
			
		},
		error: function (jqXHR, textStatus, errorThrown){
			$("#submit-btn").show();
			$("#loader").hide(); 
			swal("Something went wrong!");
			
		},
		processData:false,
		contentType:false
	});
  });
	
	});
	


</script>
</body>
</html>