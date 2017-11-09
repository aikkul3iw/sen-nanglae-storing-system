<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>เทศบาลตำบลนางแล</title>

<!-- Bootstrap Core CSS -->
<link href="../NanglaeGov/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="../NanglaeGov/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- DataTables CSS -->
<link
	href="../NanglaeGov/vendor/datatables-plugins/dataTables.bootstrap.css"
	rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link
	href="../NanglaeGov/vendor/datatables-responsive/dataTables.responsive.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="../NanglaeGov/dist/css/sb-admin-2.css" rel="stylesheet">
<link href="../NanglaeGov/dist/css/sweetalert2.min.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="../NanglaeGov/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- Data Table -->
<link href="css/dataTable/dataTables.bootstrap.min.css" rel="stylesheet">
<link href="css/dataTable/buttons.bootstrap.min.css" rel="stylesheet">


<script type='text/javascript' src="../NanglaeGov/js/jquery.js"></script>
<script type='text/javascript'>
	function listDisabled() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listDisabled.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {
							html += "<tr>";
							html += "<td>"
									+ data[i].firstName
									+ "</td>"
									+ "<td>"
									+ data[i].lastName
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editDis\" data-toggle=\"tab\" onclick=\"setEditDisabled("
									+ data[i].DisabledId
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteDisabled("
									+ data[i].DisabledId
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"

							html += "</tr>";

						}
						$('#listDisabled').html(html);
						$(document).ready(function() {
							var table = $('#resultTable').DataTable({
								lengthChange : false,
								buttons : ['excel',{extend : 'pdf',exportOptions : {
								columns : [ 0, 1, 2, 3]},customize : function(doc) {
								doc.defaultStyle['font'] = 'THSarabun';
										}
									},
								]
						});
						table.buttons().container().appendTo('#page-wrapper .col-sm-6:eq(0)');
					});
						$("#loader").hide();
					},
					error : function(data, status, er) {
						alert('ไม่สามารถโหลดข้อมูลได้');
						$("#loader").hide();
					}
				});
	}
</script>
<script type='text/javascript'>
	function createDisabled() {
		if ($('#firstName').val() == "") {
			document.getElementById('firstName').style.borderColor = "red";
			return false;
		} else if ($('#lastName').val() == "") {
			document.getElementById('lastName').style.borderColor = "red";
			return false;
		} else {
			$("#loader").show();
			var errDetectMsg = 'ไม่สามารถบันทึกข้อมูลได้';
			var errDetec = false;
			var obj = {
				DisabledId : 0,
				firstName : $('#firstName').val(),
				lastName : $('#lastName').val()
			};
			$.ajax({
				url : "../NanglaeGov/saveDisabled.do?user="+$('#userId').val(),
				type : "POST",
				dataType : "JSON",
				data : JSON.stringify(obj),
				contentType : "application/json",
				mimeType : "application/json",
				success : function(data) {
					swal({
						title : 'บันทึกข้อมูลสำเร็จ',
						type : 'success'
					}).then(function() {
						location.reload();
					});
				},
				error : function(data, status, er) {
					alert(errDetectMsg);
					$("#loader").hide();
				}
			});
		}

	}
	function deleteDisabled(DisabledId) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
			var id = DisabledId
			var obj = {
				DisabledId : id

			};
			//alert(id);
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/deleteDisabled.do",
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
		});
	}
	function editDisabled() {
		var obj = {
			DisabledId : $("#editDisabledId").val(),
			firstName : $('#editFirstName').val(),
			lastName : $('#editLastName').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveDisabled.do?editUserId="+$('#editUserId').val(),
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				swal({
					title : 'บันทึกข้อมูลสำเร็จ',
					type : 'success'
				}).then(function() {
					location.reload();
				});
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
	function setEditDisabled(DisabledId) {

		var obj = {
			DisabledId : DisabledId
		};

		$.ajax({
			url : "../NanglaeGov/findDisabled.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editDisabledId").val(data.DisabledId);
				$("#editFirstName").val(data.firstName);
				$("#editLastName").val(data.lastName);
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
</script>
</head>

<body onload="listDisabled();">

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
					class="navbar-brand" href="superIndex.do">เทศบาลตำบลนางแล</a>
			</div>
			<!-- /.navbar-header -->

			<ul class="nav navbar-top-links navbar-right">
			<%
				Object Name = session.getAttribute("Name");
				out.println("ยินดีต้อนรับ    " +Name);
			%>
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
						<li><a href="index.do"><i class="fa fa-sign-out fa-fw"></i>
								ออกจากระบบ</a></li>
					</ul> <!-- /.dropdown-user --></li>
				<!-- /.dropdown -->
			</ul>
			<!-- /.navbar-top-links -->

			<%@include file="superMenu.jsp" %>
			
		</nav>
		<div id="page-wrapper" style="background-color: #d7f0f5">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">ผู้พิการ</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.panel-heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#listDis" data-toggle="tab">ข้อมูลผู้พิการ</a>
								</li>
								<li><a href="#addDis" data-toggle="tab">เพิ่มผู้พิการ</a>
								</li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->

								<div class="tab-content">
									<div class="tab-pane fade in active" id="listDis">
										<div class="table-responsive">
											<table id="resultTable"
												class="table table-striped table-bordered table-hover">

												<!-- Start change table -->
												<thead>
													<tr>
														<th>คำนำหน้า</th>
														<th>ชื่อ</th>
														<th>นามสกุล</th>
														<th>เพศ</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listDisabled">
												</tbody>
												<!-- End change table -->
											</table>
										</div>
									</div>
									<div class="tab-pane fade" id="addDis">
										<form role="form">
										<%
											Object userid = session.getAttribute("user");
										%>
										<input type="hidden" id="userId" value="<%=userid %>">
											<table width="50%" align="center">
												<tr>

													<td align="pull-right" style="padding: 15px">ชื่อ</td>
													<td><input id="firstName" maxlength="30"
														class="form-control" placeholder="ระบุชื่อผู้พิการ"
														name="firstName" required="true"></td>

												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">นามสกุล</td>
													<td><input id="lastName" maxlength="30"
														class="form-control" placeholder="ระบุนามสกุลผู้พิการ"
														name="lastName" required="true"></td>

												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px">
														<button style="width: 100px" type="reset"
															class="btn btn-warning">ล้างข้อมูล</button> <input
														style="width: 100px" type="button" class="btn btn-success"
														value="บันทึก" onclick="createDisabled()" />
													</td>
												</tr>
											</table>
										</form>
									</div>
									<div class="tab-pane fade" id="editDis">
										<form role="form">
										<%
											Object edituserid = session.getAttribute("edituser");
										%>
											<input type="hidden" id="editUserId" value="<%=edituserid %>">
											<input type="hidden" id="editDisabledId">
											<table width="50%" align="center">
												<tr>

													<td align="pull-right" style="padding: 15px">ชื่อ</td>
													<td><input id="editFirstName" maxlength="30"
														class="form-control" placeholder="ระบุชื่อผู้พิการ"
														name="editFirstName" required="true"></td>

												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">นามสกุล</td>
													<td><input id="editLastName" maxlength="30"
														class="form-control" placeholder="ระบุนามสกุลผู้พิการ"
														name="editLastName" required="true"></td>

												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px"><a
														href="#listAgri" data-toggle="tab"><button
																style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
														<input style="width: 100px" type="button"
														class="btn btn-success" value="บันทึก"
														onclick="editDisabled()" /></td>
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
		<script
			src="../NanglaeGov/vendor/datatables/js/jquery.dataTables.min.js"></script>
		<script src="../NanglaeGov/js/dataTables.buttons.min.js"></script>
		<script src="../NanglaeGov/js/pdfmake.min.js"></script>
		<script src="../NanglaeGov/vendor/datatables/js/vfs_fonts.js"></script>
		<script src="../NanglaeGov/js/buttons.html5.min.js"></script>
		<script src="../NanglaeGov/js/buttons.print.min.js"></script>
		<script
			src="../NanglaeGov/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
		<script
			src="../NanglaeGov/vendor/datatables-responsive/dataTables.responsive.js"></script>
		<script src="../NanglaeGov/js/buttons.bootstrap.min.js"></script>
		<script src="../NanglaeGov/js/buttons.colVis.min.js"></script>
		<script src="../NanglaeGov/js/jszip.min.js"></script>

		<!-- Custom Theme JavaScript -->
		<script src="../NanglaeGov/dist/js/sb-admin-2.js"></script>
		<!-- Sweetalert2 JavaScript -->
		<script src="../NanglaeGov/js/sweetalert2.min.js"></script>
		<!-- Mask plug in -->
		<script src="../NanglaeGov/js/jquery.mask.js"></script>
		<script src="../NanglaeGov/js/jquery.mask.min.js"></script>
</body>

</html>