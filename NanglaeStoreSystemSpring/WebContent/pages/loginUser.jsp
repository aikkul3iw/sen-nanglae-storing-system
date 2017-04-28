<%@include file="include.jsp"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Bootstrap Admin Theme</title>

    <!-- Bootstrap Core CSS -->
    <link href="../NanglaeGov/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="../NanglaeGov/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../NanglaeGov/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="../NanglaeGov/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body style="background-color: #d7f0f5">

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">เข้าสู่ระบบ</h3>
                    </div>
                    <div class="panel-body">
		<form:form id="loginForm" method="post" action="login.do" modelAttribute="loginBean">

			<form:label path="username">ชื่อผู้ใช้งาน</form:label>
			<form:input class="form-control" placeholder="ผู้ใช้งาน" id="username" name="username" path="username" /><br>
			
			<form:label path="password">รหัสผ่าน</form:label>
			<form:password class="form-control" placeholder="รหัสผ่าน" id="password" name="password" path="password" /><br>
			
			<!-- <form:label path="role">ตำแหน่งผู้ใช้งาน</form:label>
			<form:input class="form-control" placeholder="ตำแหน่งผู้ใช้งาน" id="role" name="role" path="role" /><br> -->
			
			 <form:label path="role">ตำแหน่งผู้ใช้งาน</form:label>
            <form:select path="role">
				<form:option value="1" label="1" />
				<form:option value="2" label="2" />
			</form:select><br>
			
			<a href="logout.do"><input  class="btn btn-danger" style="width: 160px" value="ยกเลิก" /></a>
			<input class="btn btn-success" style="width: 160px" type="submit" value="เข้าสู่ระบบ" />
		</form:form>
	 </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="../NanglaeGov/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../NanglaeGov/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="../NanglaeGov/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="../NanglaeGov/dist/js/sb-admin-2.js"></script>

</body>

</html>