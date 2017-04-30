<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>Create User</title>

<!-- Bootstrap Core CSS -->
<link href="../NanglaeGov/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="../NanglaeGov/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- DataTables CSS -->
<link href="../NanglaeGov/vendor/datatables-plugins/dataTables.bootstrap.css"
	rel="stylesheet">


<!-- DataTables Responsive CSS -->
<link href="../NanglaeGov/vendor/datatables-responsive/dataTables.responsive.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="../NanglaeGov/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="../NanglaeGov/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->


<script type='text/javascript' src="../NanglaeGov/js/jquery.js"></script>
<script type='text/javascript' charset="utf-8">
	function listUser() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listUser.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {
							html += "<tr>";
							html += "<td>"
									+ data[i].username
									+ "</td>"
									+ "<td>"
									+ data[i].password
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editUser\" data-toggle=\"tab\" onclick=\"setEditUser("
									+ data[i].user_id
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button data-toggle=\"modal\" data-id="
									+ data[i].user_id
									+ " onclick=\"openDeleteModal(this);\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>";

							html += "</tr>";
						}
						$('#listUsers').html(html);
						$('#resultTable').DataTable({

							dom : 'Bfrtip',
							buttons : [ {
								extend : 'pdfHtml5',
								exportOptions : {
									columns : [ 0, 1, 2 ]
								},
								customize : function(doc) {
									doc.defaultStyle['font'] = 'THSarabun';
								}
							}, 'excelHtml5' ]
						});
						$("#loader").hide();
					},
					error : function(data, status, er) {
						alert('error');
						$("#loader").hide();
					}
				});
	}
</script>
<script type='text/javascript'>
	function createUser() {
		$("#loader").show();
		if ($('#username').val() == "") {
			document.getElementById('username').style.borderColor = "red";
			return false;
		} else if ($('#password').val() == "") {
			document.getElementById('password').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				user_id : 0,
				username : $('#username').val(),
				password : $('#password').val()
			};
			$.ajax({
				url : "../NanglaeGov/saveUser.do",
				type : "POST",
				dataType : "JSON",
				data : JSON.stringify(obj),
				contentType : "application/json",
				mimeType : "application/json",
				success : function(data) {
					$("#loader").hide();
					location.reload();
				},
				error : function(data, status, er) {
					alert('error');
					$("#loader").hide();
				}
			});
		}

	}
	function deleteUser() {
		var id = document.getElementById("user_id").value;

		var obj = {
				user_id : id

		};
		//alert(id);
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/deleteUser.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert('success');
				location.reload();
			}
		});
	}
	function editUser() {
		var obj = {
			user_id : $("#editUserId").val(),
			username : $('#editUsername').val(),
			password : $('#editPassword').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveUser.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert('success');
				location.reload();
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
	function setEditUser(user_id) {

		var obj = {
				user_id : user_id
		};

		$.ajax({
			url : "../NanglaeGov/findUser.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editUserId").val(data.user_id);
				$("#editUsername").val(data.username);
				$("#editPassword").val(data.password);
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
</script>
</head>

<body onload="listUser()">

	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0; background-color: #98c3e8">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<img src="../NanglaeGov/images/logo-nanglae.png"> <a
					class="navbar-brand" href="index.do">เทศบาลตำบลนางแล</a>
			</div>
			<!-- /.navbar-header -->

			<ul class="nav navbar-top-links navbar-right">
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
						<i class="fa fa-caret-down"></i>
				</a>
					<ul class="dropdown-menu dropdown-user">
						<li><a href="#"><i class="fa fa-user fa-fw"></i>
								ดูข้อมูลส่วนตัว</a></li>
						<li><a href="#"><i class="fa fa-gear fa-fw"></i> ตั้งค่า</a>
						</li>
						<li class="divider"></li>
						<li><a href="login.html"><i class="fa fa-sign-out fa-fw"></i>
								ออกจากระบบ</a></li>
					</ul> <!-- /.dropdown-user --></li>
				<!-- /.dropdown -->
			</ul>
			<!-- /.navbar-top-links -->

			<div class="navbar-default sidebar" role="navigation">
				<div class="sidebar-nav navbar-collapse">
					<ul class="nav" id="side-menu">
						<li><a href="#"><i class="fa fa-child fa-fw"></i> บุคคล<span
								class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="superPersonnel.do">บุคลากร</a></li>
								<li><a href="superPopulation.do">ประชากร</a></li>
								<li><a href="superLabor.do">แรงงาน</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="fa fa-road fa-fw"></i>
								สาธารณูปโภค<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="superTransport.do">ระบบคมนาคมขนส่ง</a></li>
								<li><a href="superElectric.do">ระบบไฟฟ้า</a></li>
								<li><a href="superPipeline.do">ระบบประปา</a></li>
								<li><a href="superDrainage.do">ระบบระบายน้ำ</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="fa fa-home fa-fw"></i>
								สาธารณุปการ<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="#">เคหะ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="superVillage.do">หมู่บ้าน</a></li>
										<li><a href="superIndustry.do">การอุตสาหกรรม</a></li>
										<li><a href="superEducation.do">การศึกษา</a></li>
										<li><a href="superReligion.do">การศาสนา</a></li>
										<li><a href="superCommerce.do">การพาณิชย์</a></li>
										<li><a href="superTourism.do">แหล่งท่องเที่ยว</a></li>
									</ul> <!-- /.nav-third-level --></li>
								<li><a href="#">บริการ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="superHealth.do">การสาธารสุข</a></li>
										<li><a href="superSecurity.do">ความปลอดภัยในชีวิตและทรัพย์สิน</a>
										</li>
										<li><a href="superGroup.do">กลุ่มในชุมชน</a></li>
										<li><a href="superService.do">ศูนย์บริการประชาชน</a></li>
										<li><a href="superInventory.do">การคลัง</a></li>
									</ul> <!-- /.nav-third-level --></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="glyphicon glyphicon-leaf"></i>
								ธรรมชาติและสิ่งแวดล้อม<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="superAgriculture.do">การเกษตรกรรม</a></li>
								<li><a href="#">ทรัพยากรธรรมชาติ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="superWaterresource.do">ทรัพยากรณ์น้ำ</a></li>
										<li><a href="superLandresource.do">ทรัพยากรณ์ดิน</a></li>
										<li><a href="superForestresource.do">ทรัพยากรณ์ป่าไม้</a></li>
									</ul></li>
								<li><a href="superPolution.do">มลพิษ</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="copy.do"><i class="fa fa-copy"></i>
								คัดลอกข้อมูล</a></li>
						<li><a href="createUser.do"><i class="glyphicon glyphicon-user"></i>
								สร้างผู้ใช้งาน</a></li>
					</ul>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
		</nav>
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">จัดการ User</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.panel-heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#listUser" data-toggle="tab">ข้อมูล User</a>
								</li>
								<li><a href="#addUser" data-toggle="tab">เพิ่ม User</a>
								</li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->

								<div class="tab-content">
									<div class="tab-pane fade in active" id="listUser">
										<h1></h1>
										<div class="table-responsive">
											<table id="resultTable"
												class="table table-striped table-bordered table-hover">

<!-- Start change table -->
												<thead>
													<tr>
														<th>Username</th>
														<th>Password</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listUsers">
												</tbody>
<!-- End change table -->
											</table>
										</div>
									</div>
									<div class="tab-pane fade" id="addUser">
										<form role="form">
											<table width="50%" align="center">
												
												<tr>
													<td align="pull-right" style="padding: 15px">Username User</td>
													<td><input id="username" maxlength="100"
														class="form-control" placeholder="Username"
														name="User_name" required="true"></td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">Password User</td>
													<td><input id="password" maxlength="20"
														class="form-control" placeholder="Password"
														name="User_password" required="true"></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px">
														<button style="width: 100px" type="reset"
															class="btn btn-warning">ล้างข้อมูล</button> <input
														style="width: 100px" type="button" class="btn btn-success"
														value="บันทึก" onclick="createUser()" />
													</td>
												</tr>
											</table>
										</form>
									</div>
									<!-- Start modal -->
									<div>
										<div class="modal fade" id="DeleteModal" tabindex="-1"
											role="dialog" aria-labelledby="myModalLabel"
											aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal"
															aria-hidden="true">&times;</button>
														<h4 class="modal-title" id="H3">-----
															ยืนยันการลบข้อมูล !! -----</h4>
													</div>
													<div class="modal-body">
														<p>คุณต้องการลบข้อมูลชุดนี้?</p>
														<input type="hidden" name="user_id" id="user_id" value="" />
													</div>

													<div class="modal-footer">
														<button type="button" class="btn btn-default"
															data-dismiss="modal">ยกเลิก</button>
														<button type="button" id="deleteUser"
															class="btn btn-danger" onclick="deleteUser();">ลบข้อมูล</button>

													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- End modal -->

									<div class="tab-pane fade" id="editUser">
										<form role="form">
											<input type="hidden" id="editUserId">
											<table width="50%" align="center">
												
												<tr>
													<td align="pull-right" style="padding: 15px">Username User</td>
													<td><input id="editUsername" maxlength="100"
														class="form-control" placeholder="Username"
														name="User_name" required="true"></td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">Password User</td>
													<td><input id="editPassword" maxlength="20"
														class="form-control" placeholder="Password"
														name="User_password" required="true"></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px"><a
														href="#listUser" data-toggle="tab"><button
																style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
														<input style="width: 100px" type="button"
														class="btn btn-success" value="บันทึก"
														onclick="editUser()" /></td>
												</tr>
											</table>
										</form>
									</div>
								</div>
							</div>
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

		<!-- DataTables JavaScript -->
		<script src="../NanglaeGov/vendor/datatables/js/jquery.dataTables.min.js"></script>
		<script
			src="https://cdn.datatables.net/buttons/1.2.4/js/dataTables.buttons.min.js"></script>
		<script
			src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.24/build/pdfmake.min.js"></script>
		<script src="../NanglaeGov/vendor/datatables/js/vfs_fonts.js"></script>
		<script
			src="//cdn.datatables.net/buttons/1.2.4/js/buttons.html5.min.js"></script>
		<script
			src="//cdn.datatables.net/buttons/1.2.4/js/buttons.print.min.js"></script>
		<script src="../NanglaeGov/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
		<script src="../NanglaeGov/vendor/datatables-responsive/dataTables.responsive.js"></script>
		<script
			src="https://cdn.datatables.net/buttons/1.2.4/js/buttons.bootstrap.min.js"></script>
		<script
			src="//cdn.datatables.net/buttons/1.2.4/js/buttons.colVis.min.js"></script>
		<script
			src="//cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>


		<!-- Custom Theme JavaScript -->
		<script src="../NanglaeGov/dist/js/sb-admin-2.js"></script>

		<!-- Page-Level Demo Scripts - Tables - Use for reference -->
		<script>
			$(document).ready(function() {

			});

			function openDeleteModal(id) {
				$('#user_id').val($(id).data('id'));
				$('#DeleteModal').modal('show');
			}
		</script>
</body>

</html>
