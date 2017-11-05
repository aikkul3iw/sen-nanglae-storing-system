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
var year = new Date().getFullYear()+543;
function getCurrentYear(){
	document.getElementById('tran_year').value = year;
	}
	function listTransport() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listTransport.do",
					type : "POST",
					success : function(data) {
						var html = '';
						var count = 1;
						for (var i = 0; i < data.length; i++) {
							html += "<tr>";
							html += "<td>"+count+"</td><td>"
									+ data[i].tran_year
									+ "</td>"
									+ "<td>"
									+ data[i].tran_name
									+ "</td>"
									+ "<td>"
									+ data[i].type
									+ "</td>"
									+ "<td>"
									+ data[i].description
									+ "</td>"
									+ "<td nowrap=\"nowrap\" style=\"text-align: center;\"><button href=\"#editTransport\" data-toggle=\"tab\" onclick=\"setEditTransport("
									+ data[i].tran_id
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteTransport("
									+ data[i].tran_id
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"

							html += "</tr>";
							count++;
						}
						$('#listTransports').html(html);
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
						alert('error');
						$("#loader").hide();
					}
				});
	}
</script>
<script type='text/javascript'>
	function createTransport() {
		$("#loader").show();
		if ($('#tran_year').val() == "") {
			document.getElementById('tran_year').style.borderColor = "red";
			return false;
		} else if ($('#tran_name').val() == "") {
			document.getElementById('tran_name').style.borderColor = "red";
			return false;
		} else if ($('#type').val() == "") {
			document.getElementById('type').style.borderColor = "red";
			return false;
		} else if ($('#description').val() == "") {
			document.getElementById('description').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				tran_id : 0,
				tran_year : $('#tran_year').val(),
				tran_name : $('#tran_name').val(),
				type : $('#type').val(),
				description : $('#description').val()
			};
			$.ajax({
				url : "../NanglaeGov/saveTransport.do",
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
	function deleteTransport(tran_id) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
		var id = tran_id;
		var obj = {
			tran_id : id

		};
		$.ajax({
			url : "../NanglaeGov/deleteTransport.do",
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
	function editTransport() {
		var obj = {
			tran_id : $("#editTranId").val(),
			tran_year : $('#editTranYear').val(),
			tran_name : $('#editTranName').val(),
			type : $('#editType').val(),
			description : $('#editDescription').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveTransport.do",
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
	function setEditTransport(tran_id) {

		var obj = {
			tran_id : tran_id
		};

		$.ajax({
			url : "../NanglaeGov/findTransport.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editTranId").val(data.tran_id);
				$("#editTranYear").val(data.tran_year);
				$("#editTranName").val(data.tran_name);
				$("#editType").val(data.type);
				$("#editDescription").val(data.description);
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
</script>
</head>

<body onload="listTransport();getCurrentYear();">

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
					class="navbar-brand" href="userIndex.do">เทศบาลตำบลนางแล</a>
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

			<%@include file="userMenu.jsp" %>
		</nav>
		<div id="page-wrapper" style="background-color: #d7f0f5">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">ระบบคมนาคมขนส่ง</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.panel-heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#listTransport"
									data-toggle="tab">รายชื่อระบบคมนาคมขนส่ง</a></li>
								<li><a href="#addTransport" data-toggle="tab">เพิ่มระบบคมนาคมขนส่ง</a>
								</li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->
								<div class="tab-content">
									<div class="tab-pane fade in active" id="listTransport">
										<div class="table-responsive">
											<table id="resultTable"
												class="table table-striped table-bordered table-hover">
<!-- Start change table -->
												<thead>
													<tr>
														<th>ที่</th>
														<th>ปีที่บันทึกข้อมูล</th>
														<th>การคมนาคม</th>
														<th>ประเภท</th>
														<th>รายละเอียด</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listTransports">
												</tbody>
<!-- End change table -->
											</table>
										</div>
									</div>
									<div class="tab-pane fade" id="addTransport">
										<form role="form">
											<table width="70%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input class="form-control" maxlength="4"
														id="tran_year" placeholder="" value=""
														name="tran_year" required="true" style="width: 70%"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">การคมนาคม</td>
													<td><input class="form-control" maxlength="50"
														id="tran_name" placeholder="ระบุการคมนาคม"
														name="tran-name" required="true" style="width: 70%"></td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ประเภท</td>
													<td><input class="form-control" maxlength="50"
														id="type" placeholder="" name="tran-distance"
														required="true" style="width: 70%"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">รายละเอียด</td>
													<td><textarea class="form-control" maxlength="255"
															id="description" rows="3" name="tran-connect"
															required="true" placeholder="ระบุรายละเอียดเพิ่มเติม"></textarea></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px">
														<button style="width: 100px" type="reset"
															class="btn btn-warning">ล้างข้อมูล</button> <input
														style="width: 100px" type="button" class="btn btn-success"
														value="บันทึก" onclick="createTransport()" />
													</td>
												</tr>
											</table>
										</form>
									</div>
									<div class="tab-pane fade" id="editTransport">
										<form role="form">
											<input type="hidden" id="editTranId">
											<table width="70%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input class="form-control" maxlength="4"
														id="editTranYear" placeholder="" value="2558"
														name="tran-year" required="true" style="width: 70%"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">การคมนาคม</td>
													<td><input class="form-control" maxlength="50"
														id="editTranName" placeholder="" name="tran-name"
														required="true" style="width: 70%"></td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ประเภท</td>
													<td><input class="form-control" maxlength="50"
														id="editType" placeholder="" name="tran-distance"
														required="true" style="width: 70%"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">รายละเอียด</td>
													<td><textarea class="form-control" maxlength="255"
															id="editDescription" rows="3" name="tran-connect"
															required="true"></textarea></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px"><a
														href="#listTransport" data-toggle="tab"><button
																style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
														<input style="width: 100px" type="button"
														class="btn btn-success" value="บันทึก"
														onclick="editTransport()" /></td>
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
