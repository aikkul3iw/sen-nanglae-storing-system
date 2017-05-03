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
	function listIndustry() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listIndustry.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {
							html += "<tr>";

							html += "<td>"
									+ data[i].ins_year
									+ "</td>"
									+ "<td>"
									+ data[i].ins_name
									+ "</td>"
									+ "<td>"
									+ "หมู่ที่ "
									+ data[i].location.vil_number
									+ " บ้าน"
									+ data[i].location.vil_name
									+ "</td>"
									+ "<td>"
									+ data[i].ins_size
									+ "</td>"
									+ "<td>"
									+ data[i].ins_type
									+ "</td>"
									+ "<td>"
									+ data[i].ins_labor
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editIndustry\" data-toggle=\"tab\" onclick=\"setEditIndustry("
									+ data[i].ins_id
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteIndustry("
									+ data[i].ins_id
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"
							html += "</tr>";
						}
						$('#listIndustrys').html(html);
						$(document).ready(function() {
							var table = $('#resultTable').DataTable({
								lengthChange : false,
								buttons : ['excel',{extend : 'pdf',exportOptions : {
								columns : [ 0, 1, 2, 3, 4, 5 ]},customize : function(doc) {
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
	function createIndustry() {
		$("#loader").show();
		if ($('#ins_year').val() == "") {
			document.getElementById('ins_year').style.borderColor = "red";
			return false;
		} else if ($('#ins_name').val() == "") {
			document.getElementById('ins_name').style.borderColor = "red";
			return false;
		} else if ($('#ins_size').val() == "") {
			document.getElementById('ins_size').style.borderColor = "red";
			return false;
		} else if ($('#ins_type').val() == "") {
			document.getElementById('ins_type').style.borderColor = "red";
			return false;
		} else if ($('#ins_labor').val() == "") {
			document.getElementById('ins_labor').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				ins_id : 0,
				ins_year : $('#ins_year').val(),
				ins_name : $('#ins_name').val(),
				ins_size : $('#ins_size').val(),
				ins_type : $('#ins_type').val(),
				ins_labor : $('#ins_labor').val()

			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/saveIndustry.do?id=" + $("#villageSelect").val(),
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
	function deleteIndustry(ins_id) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
		var id = ins_id;
		var obj = {
			ins_id : id

		};
		$.ajax({
			url : "../NanglaeGov/deleteIndustry.do",
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
	function editIndustry() {
		var obj = {
			ins_id : $("#editInsId").val(),
			ins_year : $('#editInsYear').val(),
			ins_name : $('#editInsName').val(),
			ins_size : $('#editInsSize').val(),
			ins_type : $('#editInsType').val(),
			ins_labor : $('#editInsLabor').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveIndustry.do?id=" + $("#editVillageSelect").val(),
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
	function setEditIndustry(ins_id) {

		var obj = {
			ins_id : ins_id
		};

		$.ajax({
			url : "../NanglaeGov/findIndustry.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editInsId").val(data.ins_id);
				$("#editInsYear").val(data.ins_year);
				$("#editInsName").val(data.ins_name);
				$("#editInsSize").val(data.ins_size);
				$("#editInsType").val(data.ins_type);
				$("#editInsLabor").val(data.ins_labor);
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

<body onload="listIndustry();listVillage();editVillageSelect();">

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
	</div>
	<div id="page-wrapper" style="background-color: #d7f0f5">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">การอุตสาหกรรม</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.panel-heading -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#listIndust" data-toggle="tab">ข้อมูลการอุตสาหกรรม</a>
							</li>
							<li><a href="#addIndustry" data-toggle="tab">เพิ่มการอุตสาหกรรม</a>
							</li>
						</ul>
						<div class="panel-body">

							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane fade in active" id="listIndust">
									พ.ศ. <select>
										<option value="2558">2558</option>
										<option value="2559">2559</option>
									</select> <br>
									<br>
									<div class="table-responsive">
										<table id="resultTable"
											class="table table-striped table-bordered table-hover" style="white-space:nowrap;">
											<!-- Start change table -->
											<thead>
												<tr>
													<th>ปีข้อมูล</th>
													<th>ชื่ออุตสาหกรรม</th>
													<th>ที่ตั้ง</th>
													<th>ขนาด</th>
													<th>มูลค่าอุตสาหกรรม(ล้านบาท)</th>
													<th>จำนวนแรงงาน(คน)</th>
													<th style="text-align: center;">ตัวเลือก</th>
												</tr>
											</thead>
											<tbody id="listIndustrys">
											</tbody>
											<!-- End change table -->
										</table>
									</div>
								</div>
								<div class="tab-pane fade" id="addIndustry">
									<form role="form">
										<table width="50%" align="center">
											<tr>
												<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
												<td><input class="form-control" maxlength="4"
													id="ins_year" placeholder="" value="2558" name="vil-year"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ชื่อ</td>
												<td><input class="form-control" maxlength="100"
													id="ins_name" placeholder="ระบุชื่อ" name="vil-year"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ที่ตั้ง</td>
												<td><select id="villageSelect" class="form-control"
													name="vil-name" required="true">

												</select></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ขนาด</td>
												<td><select id="ins_size" class="form-control"
													name="water-location">
														<option value="เล็ก">เล็ก</option>
														<option value="กลาง">กลาง</option>
														<option value="ใหญ่">ใหญ่</option>
												</select></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">มูลค่าอุตสาหกรรม</td>
												<td><input id="ins_type" data-mask="000000000"
													class="form-control" placeholder="ระบุมูลค่าอุตสาหกรรม"
													name="vil-year"></td>
												<td style="padding: 10px">ล้านบาท</td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">จำนวนแรงงาน</td>
												<td><input id="ins_labor" data-mask="00000"
													class="form-control" placeholder="ระบุจำนวนแรงงาน"
													name="vil-year"></td>
												<td style="padding: 10px">คน</td>
											</tr>
											<tr>
												<td></td>
												<td align="center" style="padding: 15px">
													<button style="width: 100px" type="reset"
														class="btn btn-warning">ล้างข้อมูล</button> <input
													style="width: 100px" type="button" class="btn btn-success"
													value="บันทึก" onclick="createIndustry()" />
												</td>
											</tr>
										</table>
									</form>
								</div>
								<div class="tab-pane fade" id="editIndustry">
									<form role="form">
										<input type="hidden" id="editInsId">
										<table width="50%" align="center">
											<tr>
												<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
												<td><input class="form-control" maxlength="4"
													id="editInsYear" placeholder="" value="2558"
													name="vil-year"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ชื่อ</td>
												<td><input class="form-control" maxlength="100"
													id="editInsName" placeholder="ระบุชื่อ" name="vil-year"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ที่ตั้ง</td>
												<td><select id="editVillageSelect" class="form-control"
													name="vil-name" required="true">

												</select></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ขนาด</td>
												<td><select id="editInsSize" class="form-control"
													name="water-location">
														<option value="เล็ก">เล็ก</option>
														<option value="กลาง">กลาง</option>
														<option value="ใหญ่">ใหญ่</option>
												</select></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">มูลค่าอุตสาหกรรม</td>
												<td><input id="editInsType" 
													class="form-control" data-mask="00000000" placeholder="ระบุมูลค่าอุตสาหกรรม"
													name="vil-year"></td>
												<td style="padding: 10px">ล้านบาท</td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">จำนวนแรงงาน</td>
												<td><input id="editInsLabor" maxlength="4"
													class="form-control" placeholder="ระบุจำนวนแรงงาน"
													name="vil-year"></td>
												<td style="padding: 10px">คน</td>
											</tr>
											<tr>
												<td></td>
												<td align="center" style="padding: 15px"><a
													href="#listIndust" data-toggle="tab"><button
															style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
													<input style="width: 100px" type="button"
													class="btn btn-success" value="บันทึก"
													onclick="editIndustry()" /></td>
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
