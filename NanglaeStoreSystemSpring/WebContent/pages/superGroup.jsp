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
function getCurrentYear(){
	var year = new Date();
	document.getElementById("grp_year").value=(year.getFullYear()+543);
	}
	
	function listLocalg() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listLocalg.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {
							html += "<tr>";
							html += "<td>"
									+ data[i].grp_year
									+ "</td>"
									+ "<td>"
									+ data[i].grp_name
									+ "</td>"
									+ "<td>"
									+ data[i].grp_member
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editGroup\" data-toggle=\"tab\" onclick=\"setEditLocalg("
									+ data[i].grp_id
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteLocalg("
									+ data[i].vil_id
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"

							html += "</tr>";
						}
						$('#listLocalgs').html(html);
						$(document).ready(function() {
							var table = $('#resultTable').DataTable({
								lengthChange : false,
								buttons : ['excel',{extend : 'pdf',exportOptions : {
								columns : [ 0, 1, 2 ]},customize : function(doc) {
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
						alert('error');
						$("#loader").hide();
					}
				});
	}
</script>
<script type='text/javascript'>
	function createLocalg() {
		$("#loader").show();
		if ($('#grp_year').val() == "") {
			document.getElementById('grp_year').style.borderColor = "red";
			return false;
		} else if ($('#grp_name').val() == "") {
			document.getElementById('grp_name').style.borderColor = "red";
			return false;
		} else if ($('#grp_member').val() == "") {
			document.getElementById('grp_member').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				grp_id : 0,
				grp_year : $('#grp_year').val(),
				grp_name : $('#grp_name').val(),
				grp_member : $('#grp_member').val(),
				grp_area : $('#grp_area').val()

			};
			$.ajax({
				url : "../NanglaeGov/saveLocalg.do?user="+$('#userId').val(),
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
					$("#loader").hide();
				}
			});
		}
	}
	function deleteLocalg(grp_id) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
		var id = grp_id
		var obj = {
			grp_id : id

		};
		$.ajax({
			url : "../NanglaeGov/deleteLocalg.do?editUserId="+$('#editUserId').val(),
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				location.reload();
			}
		});
		});
	}
	function editLocalg() {
		var obj = {
			grp_id : $("#editGroupId").val(),
			grp_year : $('#editGroupYear').val(),
			grp_name : $('#editGroupName').val(),
			grp_member : $('#editGroupMember').val(),
			grp_area : $('#editGroupArea').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveLocalg.do",
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
	function setEditLocalg(grp_id) {

		var obj = {
			grp_id : grp_id
		};

		$.ajax({
			url : "../NanglaeGov/findLocalg.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editGroupId").val(data.grp_id);
				$("#editGroupYear").val(data.grp_year);
				$("#editGroupName").val(data.grp_name);
				$("#editGroupMember").val(data.grp_member);
				$("#editGroupArea").val(data.grp_area);
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
</script>
</head>

<body onload="listLocalg();getCurrentYear()">

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
					<h1 class="page-header">กลุ่มในชุมชน</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.panel-heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#listGroup" data-toggle="tab">ข้อมูลกลุ่มในชุมชน</a>
								</li>
								<li><a href="#addGroup" data-toggle="tab">เพิ่มกลุ่มในชุมชน</a>
								</li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->
								<div class="tab-content">
									<div class="tab-pane fade in active" id="listGroup">
										<div class="table-responsive">
											<table id="resultTable"
												class="table table-striped table-bordered table-hover">
												<!-- Start change table -->
												<thead>
													<tr>
														<th>ปีข้อมูล</th>
														<th>ชื่อ</th>
														<th>จำนวน</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listLocalgs">
												</tbody>
												<!-- End change table -->
											</table>
										</div>
									</div>
									<div class="tab-pane fade" id="addGroup">
										<form role="form">
										<%
											Object userid = session.getAttribute("user");
										%>
										<input type="hidden" id="userId" value="<%=userid %>">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input id="grp_year" maxlength="4"
														class="form-control" placeholder="" value="2558"
														name="vil-year"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">ชื่อ</td>
													<td><input id="grp_name" maxlength="100"
														class="form-control" placeholder="ระบุชื่อ"
														name="vil-number" required="true"></td>

												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">จำนวน</td>
													<td><input id="grp_member" maxlength="25"
														class="form-control" placeholder="ระบุจำนวน"
														name="vil-number" required="true"></td>

												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px">
														<button style="width: 100px" type="reset"
															class="btn btn-warning">ล้างข้อมูล</button> <input
														style="width: 100px" type="button" class="btn btn-success"
														value="บันทึก" onclick="createLocalg()" />
													</td>
												</tr>
											</table>
										</form>
									</div>
									<div class="tab-pane fade" id="editGroup">
										<form role="form">
										<%
											Object edituserid = session.getAttribute("edituser");
										%>
											<input type="hidden" id="editUserId" value="<%=edituserid %>">
											<input type="hidden" id="editGroupId">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input id="editGroupYear" maxlength="4"
														class="form-control" placeholder="" value="2558"
														name="vil-year"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">ชื่อ</td>
													<td><input id="editGroupName" maxlength="100"
														class="form-control" placeholder="ระบุชื่อ"
														name="vil-number" required="true"></td>

												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">จำนวน</td>
													<td><input id="editGroupMember" maxlength="25"
														class="form-control" placeholder="ระบุจำนวน"
														name="vil-number" required="true"></td>

												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px"><a
														href="#listGroup" data-toggle="tab"><button
																style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
														<input style="width: 100px" type="button"
														class="btn btn-success" value="บันทึก"
														onclick="editLocalg()" /></td>
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
