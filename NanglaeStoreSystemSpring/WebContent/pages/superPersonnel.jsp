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
	function listPersonnel() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listPersonnel.do",
					type : "POST",
					success : function(data) {
						var successMsg = '';
						var errorMsg = '';
						var html = '';
						for (var i = 0; i < data.length; i++) {
							html += "<tr>";
							html += "<td>"
									+ data[i].per_title
									+ data[i].per_firstname
									+ " "
									+ data[i].per_lastname
									+ "</td>"
									+ "<td>"
									+ data[i].per_position
									+ "</td>"
									+ "<td>"
									+ data[i].per_tel_number
									+ "</td>"
									+ "<td>"
									+ data[i].per_address
									+ "</td>"
									+ "<td>"
									+ data[i].per_email
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editPersonnel\" data-toggle=\"tab\" onclick=\"setEditPersonnel("
									+ data[i].per_id
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deletePersonnel("
									+ data[i].per_id
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"

							html += "</tr>";
						}
						$('#listPersonnels').html(html);
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
<script type='text/javascript'>
	function createPersonnel() {
		$("#loader").show();
		if ($('#per_title').val() == "") {
			document.getElementById('per_title').style.borderColor = "red";
			return false;
		} else if ($('#per_firstname').val() == "") {
			document.getElementById('per_firstname').style.borderColor = "red";
			return false;
		} else if ($('#per_lastname').val() == "") {
			document.getElementById('per_lastname').style.borderColor = "red";
			return false;
		} else if ($('#per_position').val() == "") {
			document.getElementById('per_position').style.borderColor = "red";
			return false;
		} else if ($('#per_salary').val() == "") {
			document.getElementById('per_salary').style.borderColor = "red";
			return false;
		} else if ($('#per_tel_number').val() == "") {
			document.getElementById('per_tel_number').style.borderColor = "red";
			return false;
		} else if ($('#per_address').val() == "") {
			document.getElementById('per_address').style.borderColor = "red";
			return false;
		} else if ($('#per_email').val() == "") {
			document.getElementById('per_email').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				per_id : 0,
				per_title : $('#per_title').val(),
				per_firstname : $('#per_firstname').val(),
				per_lastname : $('#per_lastname').val(),
				per_position : $('#per_position').val(),
				per_salary : $('#per_salary').val(),
				per_tel_number : $('#per_tel_number').val(),
				per_address : $('#per_address').val(),
				per_email : $('#per_email').val(),
				per_picture : $('#per_picture').val()
			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/savePersonnel.do?user="+$('#userId').val(),
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
	function deletePersonnel(per_id) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
		var id = per_id;
		var obj = {
			per_id : id

		};
		$.ajax({
			url : "../NanglaeGov/deletePersonnel.do",
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
	function editPersonnel() {
		var obj = {
			per_id : $("#editPerId").val(),
			per_title : $('#editPerTitle').val(),
			per_firstname : $('#editPerFirstname').val(),
			per_lastname : $('#editPerLastname').val(),
			per_position : $('#editPerPosition').val(),
			per_salary : $('#editPerSalary').val(),
			per_tel_number : $('#editPerTelNumber').val(),
			per_address : $('#editPerAddress').val(),
			per_email : $('#editPerEmail').val(),
			per_picture : $('#editPerPicture').val()
		};

		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/savePersonnel.do?editUserId="+$('#editUserId').val(),
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
			}
		});
	}
	function setEditPersonnel(per_id) {

		var obj = {
			per_id : per_id
		};

		$.ajax({
			url : "../NanglaeGov/findPersonnel.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editPerId").val(data.per_id);
				$("#editPerTitle").val(data.per_title);
				$("#editPerFirstname").val(data.per_firstname);
				$("#editPerLastname").val(data.per_lastname);
				$("#editPerPosition").val(data.per_position);
				$("#editPerSalary").val(data.per_salary);
				$("#editPerTelNumber").val(data.per_tel_number);
				$("#editPerAddress").val(data.per_address);
				$("#editPerEmail").val(data.per_email);
				$("#editPerPicture").val(data.per_picture);
			},
			error : function(data, status, er) {
				alert('ไม่สามารถโหลดข้อมูลได้');
			}
		});
	}
</script>
</head>

<body onload="listPersonnel()">

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
	</div>
	<div id="page-wrapper" style="background-color: #d7f0f5">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">บุคลากร</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.panel-heading -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#listPersonnel"
								data-toggle="tab">รายชื่อบุคลากร</a></li>
							<li><a href="#addPersonnel" data-toggle="tab">เพิ่มบุคลากร</a>
							</li>
						</ul>
						<div class="panel-body">

							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane fade in active" id="listPersonnel">
									<center>
										<p id="successMsg"></p>
									</center>
									<div class="table-responsive">
										<table class="table table-striped table-bordered table-hover"
											id="resultTable">
<!-- Start change table -->
												<thead>
													<tr>
														<th>ชื่อ</th>
														<th>ตำแหน่ง</th>
														<th>เบอร์โทรศัพท์</th>
														<th>ที่อยู่</th>
														<th>อีเมลล์</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listPersonnels">
												</tbody>
<!-- End change table -->
										</table>
									</div>
								</div>
								<div class="tab-pane fade" id="addPersonnel">
									<form role="form">
										<%
											Object userid = session.getAttribute("user");
										%>
										<input type="hidden" id="userId" value="<%=userid %>">
										<table width="50%" align="center">
											<tr>

												<td align="pull-right" style="padding: 15px">คำนำหน้าชื่อ</td>
												<td><input class="form-control" maxlength="6"
													id="per_title" placeholder="นาย/นาง/นางสาว" name="pertitle"
													required></td>

											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ชื่อ</td>
												<td><input class="form-control" maxlength="50"
													id="per_firstname" placeholder="ระบุชื่อ"
													name="perfirstname" required></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">นามสกุล</td>
												<td><input class="form-control" maxlength="50"
													id="per_lastname" placeholder="ระบุนามสกุล"
													name="perlastname" required></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ตำแหน่ง</td>
												<td><input class="form-control" maxlength="50"
													id="per_position" placeholder="ระบุตำแหน่ง"
													name="perposition" required></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">เงินเดือน</td>
												<td><input class="form-control" maxlength="6"
													id="per_salary" placeholder="ต.ย. 75000" name="persalary"
													required></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">เบอร์โทรติดต่อ</td>
												<td><input class="form-control" data-mask="000-000-0000"placeholder="ต.ย. 089-8998999" maxlength="10"
													id="per_tel_number" 
													name="pertelnumber" required ></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">อีเมล์</td>
												<td><input class="form-control" maxlength="30"
													id="per_email" placeholder="ต.ย. test@test.com"
													name="peremail" required></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ที่อยู่</td>
												<td><textarea class="form-control" maxlength="100"
														id="per_address" placeholder="ระบุที่อยู่"
														name="peraddress" required></textarea></td>
											</tr>
											<tr>
												<td></td>
												<td align="center" style="padding: 15px">
													<button style="width: 100px" type="reset"
														class="btn btn-warning">ล้างข้อมูล</button> <input
													style="width: 100px" type="button" class="btn btn-success"
													value="บันทึก" onclick="createPersonnel()" />
												</td>
											</tr>
										</table>
									</form>
								</div>
								<div class="tab-pane fade" id="editPersonnel">
									<form role="form">
										<%
											Object edituserid = session.getAttribute("edituser");
										%>
										<input type="hidden" id="editUserId" value="<%=edituserid %>">
										<input type="hidden" id="editPerId">
										<table width="50%" align="center">
											<tr>

												<td align="pull-right" style="padding: 15px">คำนำหน้าชื่อ</td>
												<td><input class="form-control" maxlength="6"
													id="editPerTitle" placeholder="" name="per-title"
													required="true"></td>

											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ชื่อ</td>
												<td><input class="form-control" maxlength="50"
													id="editPerFirstname" placeholder="" name="per-firstname"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">นามสกุล</td>
												<td><input class="form-control" maxlength="50"
													id="editPerLastname" placeholder="" name="per-lastname"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ตำแหน่ง</td>
												<td><input class="form-control" maxlength="50"
													id="editPerPosition" placeholder="" name="per-position"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">เงินเดือน</td>
												<td><input class="form-control" maxlength="6"
													id="editPerSalary" placeholder="" name="per-salary"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">เบอร์โทรติดต่อ</td>
												<td><input class="form-control" 
													id="editPerTelNumber" data-mask="000-000-0000" placeholder="" name="per-tel"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">อีเมล์</td>
												<td><input class="form-control" maxlength="30"
													id="editPerEmail" placeholder="" name="per-email"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ที่อยู่</td>
												<td><textarea class="form-control" maxlength="100"
														id="editPerAddress" placeholder="" name="per-address"
														required="true"></textarea></td>
											</tr>
											<tr>
												<td><p id="errorMsg"></p></td>
											</tr>
											<tr>
												<td></td>
												<td align="center" style="padding: 15px"><a
													href="#listPersonnel" data-toggle="tab"><button
															style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
													<input style="width: 100px" type="button"
													class="btn btn-success" value="บันทึก"
													onclick="editPersonnel()" /></td>
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
