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
	function listAgriculture() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listAgriculture.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {
							html += "<tr>";
							html += "<td>"
									+ data[i].agi_year
									+ "</td>"
									+ "<td>"
									+ data[i].agi_name
									+ "</td>"
									+ "<td>"
									+ data[i].agi_area
									+ "</td>"
									+ "<td>"
									+ data[i].agi_description
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editAgri\" data-toggle=\"tab\" onclick=\"setEditAgriculture("
									+ data[i].agi_id
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteAgriculture("
									+ data[i].agi_id
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"

							html += "</tr>";

						}
						$('#listAgriculture').html(html);
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
	function createAgriculture() {
		if ($('#agi_year').val() == "") {
			document.getElementById('agi_year').style.borderColor = "red";
			return false;
		} else if ($('#agi_name').val() == "") {
			document.getElementById('agi_name').style.borderColor = "red";
			return false;
		} else if ($('#agi_area').val() == "") {
			document.getElementById('agi_area').style.borderColor = "red";
			return false;
		} else if ($('#agi_description').val() == "") {
			document.getElementById('agi_description').style.borderColor = "red";
			return false;
		} else {
			$("#loader").show();
			var errDetectMsg = 'ไม่สามารถบันทึกข้อมูลได้';
			var errDetec = false;
			var obj = {
				agi_id : 0,
				agi_year : $('#agi_year').val(),
				agi_name : $('#agi_name').val(),
				agi_area : $('#agi_area').val(),
				agi_description : $('#agi_description').val()
			};
			$.ajax({
				url : "../NanglaeGov/saveAgriculture.do",
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
	function deleteAgriculture(agi_id) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
			var id = agi_id
			var obj = {
				agi_id : id

			};
			//alert(id);
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/deleteAgriculture.do",
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
	function editAgriculture() {
		var obj = {
			agi_id : $("#editAgiId").val(),
			agi_year : $('#editAgiYear').val(),
			agi_name : $('#editAgiName').val(),
			agi_area : $('#editAgiArea').val(),
			agi_description : $('#editAgiDescription').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveAgriculture.do",
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
	function setEditAgriculture(agi_id) {

		var obj = {
			agi_id : agi_id
		};

		$.ajax({
			url : "../NanglaeGov/findAgriculture.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editAgiId").val(data.agi_id);
				$("#editAgiYear").val(data.agi_year);
				$("#editAgiName").val(data.agi_name);
				$("#editAgiArea").val(data.agi_area);
				$("#editAgiDescription").val(data.agi_description);
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
</script>
</head>

<body onload="listAgriculture()">

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
						<li><a href="superCopy.do"><i class="fa fa-copy"></i>
								คัดลอกข้อมูล</a></li>
						<li><a href="superCreateUser.do"><i class="glyphicon glyphicon-user"></i>
								จัดการผู้ใช้งาน</a></li>
					</ul>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
		</nav>
		<div id="page-wrapper" style="background-color: #d7f0f5">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">การเกษตรกรรม</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.panel-heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#listAgri" data-toggle="tab">การเกษตรกรรม</a>
								</li>
								<li><a href="#addAgri" data-toggle="tab">เพิ่มการเกษตรกรรม</a>
								</li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->

								<div class="tab-content">
									<div class="tab-pane fade in active" id="listAgri">
										พ.ศ. <select>
											<option value="2558">2558</option>
											<option value="2559">2559</option>
										</select> <br>
										<h1></h1>
										<div class="table-responsive">
											<table id="resultTable"
												class="table table-striped table-bordered table-hover">

												<!-- Start change table -->
												<thead>
													<tr>
														<th>ปีที่ข้อมูล</th>
														<th>พื้นที่เกษตรกรรม</th>
														<th>จำนวน(ไร่)</th>
														<th>การทำการเกษตร</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listAgriculture">
												</tbody>
												<!-- End change table -->
											</table>
										</div>
									</div>
									<div class="tab-pane fade" id="addAgri">
										<form role="form">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input id="agi_year" maxlength="4"
														class="form-control" placeholder="" value="2558"
														name="vil-year"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">พื้นที่การเกษตร</td>
													<td><input id="agi_name" maxlength="100"
														class="form-control" placeholder="ระบุพื้นที่การเกษตร"
														name="vil-number" required="true"></td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">จำนวนพื้นที่</td>
													<td><input id="agi_area" maxlength="5"
														class="form-control" placeholder="ระบุจำนวนพื้นที่"
														name="vil-name" required="true"></td>
													<td style="padding: 15px">ไร่</td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">การทำการเกษตร</td>
													<td><textarea id="agi_description" maxlength="255"
															class="form-control"
															placeholder="ระบุรายละเอียดเพิ่มเติม" name="vil-name"
															required="true"></textarea></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px">
														<button style="width: 100px" type="reset"
															class="btn btn-warning">ล้างข้อมูล</button> <input
														style="width: 100px" type="button" class="btn btn-success"
														value="บันทึก" onclick="createAgriculture()" />
													</td>
												</tr>
											</table>
										</form>
									</div>
									<div class="tab-pane fade" id="editAgri">
										<form role="form">
											<input type="hidden" id="editAgiId">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input id="editAgiYear" maxlength="4"
														class="form-control" placeholder="" value="2558"
														name="vil-year"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">พื้นที่การเกษตร</td>
													<td><input id="editAgiName" maxlength="100"
														class="form-control" placeholder="" name="vil-number"
														required="true"></td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">จำนวนพื้นที่</td>
													<td><input id="editAgiArea" maxlength="5"
														class="form-control" placeholder="" name="vil-name"
														required="true"></td>
													<td style="padding: 15px">ไร่</td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">การทำการเกษตร</td>
													<td><textarea id="editAgiDescription" maxlength="255"
															class="form-control" placeholder="" name="vil-name"
															required="true"></textarea></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px"><a
														href="#listAgri" data-toggle="tab"><button
																style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
														<input style="width: 100px" type="button"
														class="btn btn-success" value="บันทึก"
														onclick="editAgriculture()" /></td>
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
</body>

</html>
