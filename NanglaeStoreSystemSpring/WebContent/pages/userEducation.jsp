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
	document.getElementById('edu_year').value = year;
	}
	function listEducation() {

		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listEducation.do",
					type : "POST",
					success : function(data) {
						var html = '';
						var count =1;
						for (var i = 0; i < data.length; i++) {
							html += "<tr>";
							html += "<td>"+count+"</td><td>"
									+ data[i].edu_year
									+ "</td>"
									+ "<td>"
									+ data[i].edu_name
									+ "</td><td>"
									+ data[i].edu_type
									+ "</td><td>"
									+ data[i].student
									+ "</td><td>"
									+ "หมู่ที่ "
									+ data[i].location.vil_number
									+ " บ้าน"
									+ data[i].location.vil_name
									+ "</td>"
									+ "<td style=\"text-align: center;\" ><button href=\"#editEducation\" data-toggle=\"tab\" onclick=\"setEditEducation('"
									+ data[i].edu_id
									+ "');\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteEducation("
									+ data[i].edu_id
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"
							html += "</tr>";
							count++;
						}
						$('#listEducation').html(html);
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
	function createEducation() {
		$("#loader").show();
		if ($('#edu_year').val() == "") {
			document.getElementById('edu_year').style.borderColor = "red";
			return false;
		} else if ($('#edu_name').val() == "") {
			document.getElementById('edu_name').style.borderColor = "red";
			return false;
		} else if ($('#edu_type').val() == "") {
			document.getElementById('edu_type').style.borderColor = "red";
			return false;
		} else if ($('#student').val() == "") {
			document.getElementById('student').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				edu_id : 0,
				edu_year : $('#edu_year').val(),
				edu_name : $('#edu_name').val(),
				edu_type : $('#edu_type').val(),
				student : $('#student').val()

			};
			$.ajax({
				url : "../NanglaeGov/saveEducation.do?id=" + $("#villageSelect").val(),
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
	function listVillage() {
		$("#loader").show();
		$.ajax({
			url : "../NanglaeGov/listVillage.do",
			type : "POST",
			success : function(data) {
				var html = '';
				for (var i = 0; i < data.length; i++) {
					html += "<option value=\""+data[i].vil_id+"\">"
							+ data[i].vil_name + "</option>";
				}
				$('#villageSelect').html(html);

			},
			error : function(data, status, er) {
				alert('error');
				$("#loader").hide();
			}
		});
	}
	function deleteEducation(edu_id) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
		var id = edu_id
		var obj = {
			edu_id : id
		};
		$.ajax({
			url : "../NanglaeGov/deleteEducation.do",
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
	function editEducation() {
		var obj = {
			edu_id : $("#editEduId").val(),
			edu_year : $('#editEduYear').val(),
			edu_name : $('#editEduName').val(),
			edu_type : $('#editEduType').val(),
			student : $('#editStudent').val()

		};
		$.ajax({
			url : "../NanglaeGov/saveEducation.do?id=" + $("#editVillageSelect").val(),
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
	function setEditEducation(edu_id) {

		var obj = {
			edu_id : edu_id
		};

		$.ajax({
			url : "../NanglaeGov/findEducation.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				$("#editEduId").val(data.edu_id);
				$("#editEduYear").val(data.edu_year);
				$("#editEduName").val(data.edu_name);
				$("#editEduType").val(data.edu_type);
				$("#editStudent").val(data.student);
				$('#editVillageSelect').val(data.location.vil_id);
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
	function editVillageSelect() {
		$("#loader").show();
		$.ajax({
			url : "../NanglaeGov/listVillage.do",
			type : "POST",
			success : function(data) {
				var html = '';
				for (var i = 0; i < data.length; i++) {
					html += "<option value=\""+data[i].vil_id+"\">"
							+ data[i].vil_name + "</option>";
				}
				$('#editVillageSelect').html(html);

			},
			error : function(data, status, er) {
				alert('error');
				$("#loader").hide();
			}
		});
	}
</script>
</head>

<body onload="listEducation();listVillage();editVillageSelect();getCurrentYear();">

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
					<h1 class="page-header">การศึกษา</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.panel-heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#listEduPrime"
									data-toggle="tab">รายชื่อโรงเรียนประถม</a></li>
								<li><a href="#addEducation" data-toggle="tab">เพิ่มการศึกษา</a>
								</li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->

								<div class="tab-content">
									<div class="tab-pane fade in active" id="listEduPrime">
										<div class="table-responsive">
											<table id="resultTable"
												class="table table-striped table-bordered table-hover">
												
<!-- Start change table -->
												<thead>
													<tr>
														<th>ที่</th>
														<th>ปีที่บันทึกข้อมูล</th>
														<th>ชื่อสถานศึกษา</th>
														<th>ประเภท</th>
														<th>จำนวนนักเรียน(คน)</th>
														<th>ที่ตั้ง</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listEducation">
												</tbody>
<!-- End change table -->
												
											</table>
										</div>
									</div>
									<div class="tab-pane fade" id="listEduKid">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover">
												<thead>
													<tr>
														<th><center>
																ที่</b>
															</center></th>
														<th><center>
																ชื่อโรงเรียน</b>
															</center></th>
														<th><center>
																ที่ตั้ง</b>
															</center></th>
														<th><center>
																จำนวนนักเรียน(คน)</b>
															</center></th>
													</tr>

												</thead>
												<tbody>
													<tr>
														<td><center>1</center></td>
														<td>ศูนย์พัฒนาเด็กเล็กโรงเรียนบ้านนางแล</td>
														<td>หมู่ 3 บ้านนางแลเหนือ</td>
														<td><center>18</center></td>
													</tr>
													<tr>
														<td><center>2</center></td>
														<td>ศูนย์พัฒนาเด็กเล็กโรงเรียนอนุบาลนางแล(บ้านทุ่ง)</td>
														<td>หมู่ 5 บ้านเด่น</td>
														<td><center>40</center></td>
													</tr>
													<tr>
														<td><center>3</center></td>
														<td>ศูนย์พัฒนาเด็กเล็กโรงเรียนบ้านนางแลใน</td>
														<td>หมู่ 7 บ้านนางอลใน</td>
														<td><center>32</center></td>
													</tr>
													<tr>
														<td><center>4</center></td>
														<td>ศูนย์พัฒนาเด็กเล็กบ้านลิไข่</td>
														<td>หมู่ 7 บ้านนางอลใน(บ้านลิไข่)</td>
														<td><center>13</center></td>
													</tr>
													<tr>
														<td><center>5</center></td>
														<td>ศูนย์พัฒนาเด็กเล็กบเานป่ารวก</td>
														<td>เทศบาลตำบลนางแล หมู่ 12 บ้านขัวแตะ</td>
														<td><center>29</center></td>
													</tr>
													<tr>
														<td><center>6</center></td>
														<td>ศูนย์พัฒนาเด็กเล็กโรงเรียนบ้านสันต้นขาม</td>
														<td>หมู่ 16 บ้านสันต้นขาม</td>
														<td><center>28</center></td>
													</tr>
													<tr>
														<td colspan="3"><center>รวม</center></td>
														<td><center>160</center></td>
													</tr>
												</tbody>
											</table>
											<table class="table table-striped table-bordered table-hover">
												<thead>
													<tr>
														<th><center>
																ที่</b>
															</center></th>
														<th><center>
																ชื่อโรงเรียน</b>
															</center></th>
														<th><center>
																ที่ตั้ง</b>
															</center></th>
														<th><center>
																จำนวนนักเรียน(คน)</b>
															</center></th>
													</tr>

												</thead>
												<tbody>
													<tr>
														<td><center>1</center></td>
														<td>โรงเรียนบ้านนางแล</td>
														<td>หมู่ 3 บ้านนางแลเหนือ</td>
														<td><center>85</center></td>
													</tr>
													<tr>
														<td><center>2</center></td>
														<td>โรงเรียนเม็งรายวิทยาคม(โรงเรียนมัธยมศึกษา)</td>
														<td>หมู่ 3 บ้านนางแลเหนือ</td>
														<td><center>1,083</center></td>
													</tr>
													<tr>
														<td><center>3</center></td>
														<td>โรงเรียนอนุบาลนางแล(บ้านทุ่ง)</td>
														<td>หมู่ 5 บ้านเด่น</td>
														<td><center>293</center></td>
													</tr>
													<tr>
														<td><center>4</center></td>
														<td>โรงเรียนบ้านนางใน</td>
														<td>หมู่ 7 บ้านนางอลใน</td>
														<td><center>127</center></td>
													</tr>
													<tr>
														<td><center>5</center></td>
														<td>โรงเรียนบ้านป่ารวก</td>
														<td>หมู่ 10 บ้านป่าซางวิวัฒน์</td>
														<td><center>67</center></td>
													</tr>
													<tr>
														<td><center>6</center></td>
														<td>โรงเรียนบ้านสันต้นขาม</td>
														<td>หมู่ 16 บ้านสันต้นขาม</td>
														<td><center>64</center></td>
													</tr>

													<tr>
														<td colspan="3"><center>รวม</center></td>
														<td><center>1,719</center></td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									<div class="tab-pane fade" id="addEducation">
										<form role="form">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input id="edu_year" maxlength="4"
														class="form-control" placeholder="" value=""
														name="tran-year" required="true"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">ชื่อสถานศึกษา</td>
													<td><input type="text" id="edu_name" maxlength="100"
														class="form-control" placeholder="ระบุชื่อสถานศึกษา"
														name="edu-name" required="true"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ประเภทสถานศึกษา</td>
													<td><select id="edu_type" class="form-control"
														name="water-location">
															<option value="">เลือกประเภท</option>
															<option value="ศูนย์เด็กเล็ก">ศูนย์เด็กเล็ก</option>
															<option value="โรงเรียน">โรงเรียน</option>
													</select></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">จำนวนนักเรียน</td>
													<td><input id="student" maxlength="4"
														class="form-control" placeholder="ระบุจำนวนนักเรียน"
														name="edu-amount" required="true"></td>
													<td style="padding: 15px">คน</td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ที่ตั้ง</td>
													<td><select id="villageSelect" class="form-control"
														name="edu-location">
													</select></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px">
														<button style="width: 100px" type="reset"
															class="btn btn-warning">ล้างข้อมูล</button> <input
														style="width: 100px" type="button" class="btn btn-success"
														value="บันทึก" onclick="createEducation()" />
													</td>
												</tr>
											</table>
										</form>
									</div>
									<div class="tab-pane fade" id="editEducation">
										<form role="form">
											<input type="hidden" id="editEduId">
											<table width="50%" align="center">
												<tr>
													<td style="padding: 10px">ปีข้อมูล</td>
													<td><input id="editEduYear" maxlength="4"
														class="form-control" placeholder="" value="2558"
														name="tran-year" required="true"></td>
												</tr>
												<tr>
													<td style="padding: 10px">ชื่อสถานศึกษา</td>
													<td><input type="text" id="editEduName"
														maxlength="100" class="form-control"
														placeholder="ระบุชื่อสถานศึกษา" name="edu-name"
														required="true"></td>
												</tr>
												<tr>
													<td style="padding: 10px">ประเภทสถานศึกษา</td>
													<td><select id="editEduType" class="form-control"
														name="water-location">
															<option value="">เลือกประเภท</option>
															<option value="ศูนย์เด็กเล็ก">ศูนย์เด็กเล็ก</option>
															<option value="โรงเรียน">โรงเรียน</option>
													</select></td>
												</tr>
												<tr>
													<td style="padding: 10px">จำนวนนักเรียน</td>
													<td><input id="editStudent" maxlength="4"
														class="form-control" placeholder="" name="edu-amount"
														required="true"></td>
												</tr>
												<tr>
													<td style="padding: 10px">ที่ตั้ง</td>
													<td><select id="editVillageSelect"
														class="form-control" name="edu-location">
													</select></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px"><a
														href="#listEduKid" data-toggle="tab"><button
																style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
														<input style="width: 100px" type="button"
														class="btn btn-success" value="บันทึก"
														onclick="editEducation()" /></td>
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
		<div id="piechart" style="width: 900px; height: 500px;"></div>

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
