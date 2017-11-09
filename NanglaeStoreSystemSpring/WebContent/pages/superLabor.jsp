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
	document.getElementById("lab_year").value=(year.getFullYear()+543);
	}
	
	function listLabor() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listLabor.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {
							html += "<tr>";
							html += "<td>"
									+ data[i].lab_year
									+ "</td>"
									+ "<td>"
									+ data[i].lab_type
									+ "</td>"
									+ "<td>"
									+ data[i].lab_work
									+ "</td>"
									+ "<td>"
									+ data[i].lab_amount
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editLabor\" data-toggle=\"tab\" onclick=\"setEditLabor("
									+ data[i].lab_id
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteLabor("
									+ data[i].lab_id
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"

							html += "</tr>";
						}
						$('#listLabors').html(html);
						$(document).ready(function() {
							var table = $('#resultTable').DataTable({
								lengthChange : false,
								buttons : ['excel',{extend : 'pdf',exportOptions : {
								columns : [ 0, 1, 2, 3 ]},customize : function(doc) {
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
	function createLabor() {
		$("#loader").show();
		if ($('#lab_year').val() == "") {
			document.getElementById('lab_year').style.borderColor = "red";
			return false;
		} else if ($('#lab_type').val() == "") {
			document.getElementById('lab_type').style.borderColor = "red";
			return false;
		} else if ($('#lab_amount').val() == "") {
			document.getElementById('lab_amount').style.borderColor = "red";
			return false;
		} else if ($('#lab_work').val() == "") {
			document.getElementById('lab_work').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				lab_id : 0,
				lab_year : $('#lab_year').val(),
				lab_type : $('#lab_type').val(),
				lab_amount : $('#lab_amount').val(),
				lab_work : $('#lab_work').val()
			};
			$.ajax({
				url : "../NanglaeGov/saveLabor.do?user="+$('#userId').val(),
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
					alert('ไม่สามารถบันทึกข้อมูลได้');
					$("#loader").hide();
				}
			});
		}
	}
	function deleteLabor(lab_id) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
		var id = lab_id;
		var obj = {
			lab_id : id

		};
		$.ajax({
			url : "../NanglaeGov/deleteLabor.do",
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
	function editLabor() {
		var obj = {
			lab_id : $("#editLabId").val(),
			lab_year : $('#editLabYear').val(),
			lab_type : $('#editLabType').val(),
			lab_amount : $('#editLabAmount').val(),
			lab_work : $('#editLabWork').val(),
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveLabor.do?editUserId="+$('#editUserId').val(),
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
				alert('ไม่สามารถบนนทึกข้อมูลได้');
			}
		});
	}
	function setEditLabor(lab_id) {

		var obj = {
			lab_id : lab_id
		};

		$.ajax({
			url : "../NanglaeGov/findLabor.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editLabId").val(data.lab_id);
				$("#editLabYear").val(data.lab_year);
				$("#editLabType").val(data.lab_type);
				$("#editLabAmount").val(data.lab_amount);
				$("#editLabWork").val(data.lab_work);
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
</script>
</head>

<body onload="listLabor();getCurrentYear()">

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
					<h1 class="page-header">แรงงาน</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.panel-heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#listLabor" data-toggle="tab">ข้อมูลแรงงาน</a>
								</li>
								<li><a href="#addLabor" data-toggle="tab">เพิ่มแรงงาน</a></li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->
								<div class="tab-content">
									<div class="tab-pane fade in active" id="listLabor">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover"
												id="resultTable">
<!-- Start change table -->
												<thead>
													<tr>
														<th>ปีที่บันทึกข้อมูล</th>
														<th>แรงงาน</th>
														<th>การใช้แรงงาน</th>
														<th>จำนวน</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listLabors">
												</tbody>
<!-- End change table -->
											</table>
										</div>
									</div>
									<div class="tab-pane fade" id="addLabor">
										<form role="form" data-toggle="validator" id="testform">
										<%
											Object userid = session.getAttribute("user");
										%>
										<input type="hidden" id="userId" value="<%=userid %>">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input maxlength="4" data-mask="0000"class="form-control"
														id="lab_year" placeholder="" value="2558" name="vil-year"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">ชื่อ</td>
													<td><input class="form-control" maxlength="100"
														id="lab_type" placeholder="ระบุชื่อแรงงาน" required></td>

												</tr>

												<tr>

													<td align="pull-right" style="padding: 15px">จำนวนแรงงาน</td>
													<td><input class="form-control" maxlength="5"
														id="lab_amount" data-mask="00000" placeholder="ระบุจำนวนแรงงาน" required></td>
													<td style="padding: 15px">คน</td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">การใช้แรงงาน</td>
													<td><textarea class="form-control" maxlength="255"
															id="lab_work" placeholder="ระบุรายละเอียดการใช้แรงงาน"
															name="per-address" required></textarea></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px">
														<button style="width: 100px" type="reset"
															class="btn btn-warning">ล้างข้อมูล</button> <input
														style="width: 100px" type="button" class="btn btn-success"
														value="บันทึก" onclick="createLabor()" />
													</td>
												</tr>
											</table>
										</form>
									</div>
									<div class="tab-pane fade" id="editLabor">
										<form role="form">
										<%
											Object edituserid = session.getAttribute("edituser");
										%>
											<input type="hidden" id="editUserId" value="<%=edituserid %>">
											<input type="hidden" id="editLabId">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input class="form-control" maxlength="4"
														id="editLabYear" data-mask="00000"placeholder="" value="2558"
														name="vil-year"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">ชื่อ</td>
													<td><input class="form-control" maxlength="100"
														id="editLabType" placeholder="" required="true"></td>

												</tr>

												<tr>

													<td align="pull-right" style="padding: 15px">จำนวนแรงงาน</td>
													<td><input class="form-control" maxlength="5"
														id="editLabAmount" data-mask="0000000" placeholder="" required="true"></td>
													<td style="padding: 15px">คน</td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">การใช้แรงงาน</td>
													<td><textarea class="form-control" maxlength="255"
															id="editLabWork" placeholder="" name="per-address"
															required="true"></textarea></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px"><a
														href="#listLabor" data-toggle="tab"><button
																style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
														<input style="width: 100px" type="button"
														class="btn btn-success" value="บันทึก"
														onclick="editLabor()" /></td>
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
