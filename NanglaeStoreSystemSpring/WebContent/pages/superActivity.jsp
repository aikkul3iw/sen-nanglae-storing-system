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
	function listActivity() {
		$("#loader").show();
		$.ajax({
			url : "../NanglaeGov/listActivity.do",
			type : "POST",
			success : function(data) {
				var html = '';
				for (var i = 0; i < data.length; i++) {
								html += "<tr>";
								html += "<td>"
										+ data[i].atv_date
										+ "</td>"
										+ "<td>"
										+ data[i].user.location.per_title+""+data[i].user.location.per_firstname+" "+data[i].user.location.per_lastname
										+ "</td>"
										+ "<td>"
										+ data[i].atv_action
										+ "</td>"
										+ "<td>"
										+ data[i].atv_data
										+ "</td>"
										+ "<td>"
										+ data[i].atv_old
										+ "</td>"
										+ "<td>"
										+ data[i].atv_new
										+ "</td>"

								html += "</tr>";
						}
						$('#listVillages').html(html);
						$(document).ready(function() {
							var table = $('#resultTable').DataTable({
								lengthChange : false,
								buttons : ['excel',{extend : 'pdf',exportOptions : {
								columns : [ 0, 1, 2, 3 ]},customize : function(doc) {
								doc.defaultStyle['font'] = 'THSarabun';
										}
									},
								],
								
								    language: {
							              sProcessing: 'กำลังดำเนินการ...',
							              sLengthMenu: 'แสดง_MENU_ แถว',
							              sZeroRecords: 'ไม่พบข้อมูล',
							              sInfo: 'แสดง _START_ ถึง _END_ จาก _TOTAL_ แถว',
							              sInfoEmpty: 'แสดง 0 ถึง 0 จาก 0 แถว',
							              sInfoFiltered: '(กรองข้อมูล _MAX_ ทุกแถว)',
							              sInfoPostFix: '',
							              sSearch: 'ค้นหา:',
								              oPaginate: {
								                            sFirst: 'เิริ่มต้น',
								                            sPrevious: 'ก่อนหน้า',
								                            sNext: 'ถัดไป',
								                            sLast: 'สุดท้าย'
								              }
							     }
								
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
</head>

<body onload="listActivity()">

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
					<h1 class="page-header">หมู่บ้าน</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.panel-heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#listVillage" data-toggle="tab">รายชื่อหมู่บ้าน</a>
								</li>
								<li><a href="#addVillage" data-toggle="tab">เพิ่มหมู่บ้าน</a>
								</li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->
								<div class="tab-content">
									<div class="tab-pane fade in active" id="listVillage">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover"
												id="resultTable">
												<!-- Start change table -->
												<thead>
													<tr>
														<th>วันที่</th>
														<th>ผู้ใช้</th>
														<th>กิจกรรม</th>
														<th>ข้อมูล</th>
														<th>ข้อมูลเก่า</th>
														<th>ข้อมูลใหม่</th>
														
													</tr>
												</thead>
												<tbody id="listVillages">
												</tbody>
												<!-- End change table -->
											</table>
										</div>
									</div>
									<div class="tab-pane fade" id="addVillage">
										<form role="form" name="vilForm" id="formCreate">
										<%
											Object userid = session.getAttribute("user");
										%>
										<input type="hidden" id="userId" value="<%=userid %>">
											<table width="50%" align="center">
												<tr>

													<td align="pull-right" style="padding: 15px">หมู่ที่</td>
													<td><input class="form-control"
														placeholder="ระบุเลขที่หมู่บ้าน" name="vil-number"
														maxlength="2" id="vil_number" required onblur="validate()"></td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ชื่อหมู่บ้าน</td>
													<td><input class="form-control"
														placeholder="ระบุชื่อหมู่บ้าน" name="vil-name"
														maxlength="50" id="vil_name" required></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ชื่อกำนัน/ผู้ใหญ่บ้าน</td>
													<td><input class="form-control"
														placeholder="ระบุชื่อผู้ใหญ่บ้าน" name="vilChief"
														maxlength="50" id="vil_chief" required></td>
												</tr>

												<tr>
													<td></td>
													<td>
														<div class="form-group">
															<div class="col-md-9 col-md-offset-3">
																<div id="messages"></div>
															</div>
														</div>
													</td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px">
														<button style="width: 100px" type="reset"
															class="btn btn-warning">ล้างข้อมูล</button> <input
														style="width: 100px" type="button" value="บันทึก"
														onclick="createVillage()" class="btn btn-success" />
													</td>
												</tr>
											</table>
										</form>
									</div>
									<div class="tab-pane fade" id="editVillage">
										<form role="form">
										<%
											Object edituserid = session.getAttribute("edituser");
										%>
											<input type="hidden" id="editUserId" value="<%=edituserid %>">
											<input type="hidden" id="editVilId">
											<table width="50%" align="center">
												<tr>

													<td align="pull-right" style="padding: 15px">หมู่ที่</td>
													<td><input class="form-control" placeholder=""
														name="vil-number" maxlength="2" id="editVilNumber"
														required=""></td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ชื่อหมู่บ้าน</td>
													<td><input class="form-control" placeholder=""
														name="vil-name" maxlength="50" id="editVilName"
														required=""></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ชื่อกำนัน/ผู้ใหญ่บ้าน</td>
													<td><input class="form-control" placeholder=""
														name="vilChief" maxlength="50" id="editVilChief"
														required=""></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px"><a
														href="#listVillage" data-toggle="tab"><button
																style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
														<input style="width: 100px" type="button" value="บันทึก"
														onclick="editVillage()" class="btn btn-success" /></td>
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
