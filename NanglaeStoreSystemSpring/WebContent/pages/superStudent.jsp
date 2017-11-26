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
	function getCurrentYear() {
		var year = new Date();
		document.getElementById("stu_year").value = (year.getFullYear() + 543);
	}

	function listStudent() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listStudent.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {
							html += "<tr>";
							html += "<td>"
									+ data[i].stu_year
									+ "</td>"
									+ "<td>"
									+ data[i].location.edu_name
									+ "</td>"
									+ "<td>"
									+ data[i].stu_male
									+ "</td>"
									+ "<td>"
									+ data[i].stu_female
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editStudent\" data-toggle=\"tab\" onclick=\"setEditStudent("
									+ data[i].studentId
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteStudent("
									+ data[i].studentId
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"
							html += "</tr>";
						}
						$('#listStudent').html(html);
						$(document)
								.ready(
										function() {
											var table = $('#resultTable')
													.DataTable(
															{
																lengthChange : false,
																buttons : [
																		'excel',
																		{
																			extend : 'pdf',
																			exportOptions : {
																				columns : [
																						0,
																						1,
																						2,
																						3 ]
																			},
																			customize : function(
																					doc) {
																				doc.defaultStyle['font'] = 'THSarabun';
																			}
																		}, ],
																language : {
																	sProcessing : 'กำลังดำเนินการ...',
																	sLengthMenu : 'แสดง_MENU_ แถว',
																	sZeroRecords : 'ไม่พบข้อมูล',
																	sInfo : 'แสดง _START_ ถึง _END_ จาก _TOTAL_ แถว',
																	sInfoEmpty : 'แสดง 0 ถึง 0 จาก 0 แถว',
																	sInfoFiltered : '(กรองข้อมูล _MAX_ ทุกแถว)',
																	sInfoPostFix : '',
																	sSearch : 'ค้นหา:',
																	oPaginate : {
																		sFirst : 'เิริ่มต้น',
																		sPrevious : 'ก่อนหน้า',
																		sNext : 'ถัดไป',
																		sLast : 'สุดท้าย'
																	}
																}
															});
											table
													.buttons()
													.container()
													.appendTo(
															'#page-wrapper .col-sm-6:eq(0)');
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
	function createStudent() {
		$("#loader").show();
		if ($('#stu_year').val() == "") {
			document.getElementById('stu_year').style.borderColor = "red";
			return false;
		} else if ($('#stu_male').val() == "") {
			document.getElementById('stu_male').style.borderColor = "red";
			return false;
		} else if ($('#stu_female').val() == "") {
			document.getElementById('stu_female').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				studentId : 0,
				stu_year : $('#stu_year').val(),
				stu_male : $('#stu_male').val(),
				stu_female : $('#stu_female').val()

			};
			$
					.ajax({
						url : "../NanglaeGov/saveStudent.do?id="
								+ $("#eduSelect").val() + "&user="
								+ $('#userId').val(),
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
							alert(JSON.stringify(obj));
							$("#loader").hide();
						}
					});
		}
	}
	function listEducation() {
		$("#loader").show();
		$.ajax({
			url : "../NanglaeGov/listEducation.do",
			type : "POST",
			success : function(data) {
				var html = '';
				for (var i = 0; i < data.length; i++) {
					html += "<option value=\""+data[i].edu_id+"\">"
							+ data[i].edu_name + "</option>";
				}
				$('#eduSelect').html(html);

			},
			error : function(data, status, er) {
				alert('error');
				$("#loader").hide();
			}
		});
	}
	function deleteStudent(studentId) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
			var obj = {
				studentId : studentId

			};
			//alert(id);
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/deleteStudent.do",
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
	function editStudent() {
		if ($('#editStuYear').val() == "") {
			document.getElementById('editStuYear').style.borderColor = "red";
			return false;
		} else if ($('#editStuMale').val() == "") {
			document.getElementById('editStuMale').style.borderColor = "red";
			return false;
		} else if ($('#editStuFemale').val() == "") {
			document.getElementById('editStuFemale').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				studentId : $("#editStudentId").val(),
				stu_year : $('#editStuYear').val(),
				stu_male : $('#editStuMale').val(),
				stu_female : $('#editStuFemale').val()
			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/saveStudent.do?id="
						+ $("#editEduSelect").val() + "&editUserId="
						+ $('#editUserId').val(),
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
	}
	function setEditStudent(studentId) {

		var obj = {
			studentId : studentId
		};

		$.ajax({
			url : "../NanglaeGov/findStudent.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editStudentId").val(data.studentId);
				$("#editStuYear").val(data.stu_year);
				$("#editStuMale").val(data.stu_male);
				$("#editStuFemale").val(data.stu_female);
				$('#editEduSelect').val(data.location.edu_id);
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
	function editEducationSelect() {
		$("#loader").show();
		$.ajax({
			url : "../NanglaeGov/listEducation.do",
			type : "POST",
			success : function(data) {
				var html = '';
				for (var i = 0; i < data.length; i++) {
					html += "<option value=\""+data[i].edu_id+"\">"
							+ data[i].edu_name + "</option>";
				}
				$('#editEduSelect').html(html);

			},
			error : function(data, status, er) {
				alert('error');
				$("#loader").hide();
			}
		});
	}
</script>
</head>

<body
	onload="listStudent();listEducation();editEducationSelect();getCurrentYear()">

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
					out.println("ยินดีต้อนรับ    " + Name);
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

			<%@include file="superMenu.jsp"%>
		</nav>
		<div id="page-wrapper" style="background-color: #d7f0f5">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">นักเรียน</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.panel-heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#listCommerce"
									data-toggle="tab">ข้อมูลนักเรียน</a></li>
								<li><a href="#addCommerce" data-toggle="tab" id="addstudent">เพิ่มข้อมูลนักเรียน</a>
								</li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->

								<div class="tab-content">
									<div class="tab-pane fade in active" id="listCommerce">
										<div class="table-responsive">
											<table id="resultTable"
												class="table table-striped table-bordered table-hover">
												<!-- Start change table -->
												<thead>
													<tr>
														<th>ปีข้อมูล</th>
														<th>โรงเรียน</th>
														<th>ชาย</th>
														<th>หญิง</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listStudent">
												</tbody>
												<!-- End change table -->
											</table>
										</div>
									</div>
									<div class="tab-pane fade" id="addCommerce">
										<form role="form">
											<%
												Object userid = session.getAttribute("user");
											%>
											<input type="hidden" id="userId" value="<%=userid%>">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล
														<font color="red" size="3">*</font>
													</td>
													<td><input id="stu_year" maxlength="100"
														class="form-control" name="stu-year" placeholder="ระบุปีข้อมูล"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">โรงเรียน
														<font color="red" size="3">*</font>
													</td>
													<td><select id="eduSelect" class="form-control" name="edu-Select" required="true">
													</select></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">จำนวนนักเรียนชาย
														<font color="red" size="3">*</font>
													</td>
													<td><input id="stu_male" class="form-control"
														placeholder="ระบุจำนวนนักเรียน" data-mask="0000" name="stu-male"></td>
													<td style="padding-left: 10px">คน</td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">จำนวนนักเรียนหญิง
														<font color="red" size="3">*</font>
													</td>
													<td><input id="stu_female" class="form-control"
														placeholder="ระบุจำนวนนักเรียน" data-mask="0000" name="stu-female"></td>
													<td style="padding-left: 10px">คน</td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px">
														<button style="width: 100px" type="reset"
															class="btn btn-warning">ล้างข้อมูล</button> <input
														style="width: 100px" type="button" class="btn btn-success"
														id="save" value="บันทึก" onclick="createStudent()" />
													</td>
												</tr>
											</table>
										</form>
									</div>
									<div class="tab-pane fade" id="editStudent">
										<form role="form">
											<%
												Object edituserid = session.getAttribute("edituser");
											%>
											<input type="hidden" id="editUserId" value="<%=edituserid%>">
											<input type="hidden" id="editStudentId">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล
														<font color="red" size="3">*</font>
													</td>
													<td><input id="editStuYear" maxlength="4"
														class="form-control" placeholder="ระบุปีข้อมูล" name="stu-year"
														required="true"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">โรงเรียน
														<font color="red" size="3">*</font>
													</td>
													<td><select id="editEduSelect" class="form-control"
														placeholder="" name="edu-Select">

													</select></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">จำนวนนักเรียนชาย
														<font color="red" size="3">*</font>
													</td>
													<td><input id="editStuMale" class="form-control"
														placeholder="ระบุจำนวนนักเรียน" data-mask="0000" name="stu-male"></td>
													<td style="padding-left: 10px">คน</td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">จำนวนนักเรียนหญิง
														<font color="red" size="3">*</font>
													</td>
													<td><input id="editStuFemale" class="form-control"
														placeholder="ระบุจำนวนนักเรียน" data-mask="0000" name="stu-female"></td>
													<td style="padding-left: 10px">คน</td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px"><a
														href="#listCommerce" data-toggle="tab"><button
																style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
														<input style="width: 100px" type="button"
														class="btn btn-success" value="บันทึก"
														onclick="editStudent()" /></td>
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
