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
	function listAIDSpatients() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listAIDSpatients.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {
							html += "<tr>";
							html += "<td>"
									+ data[i].name
									+ "</td>"
									+ "<td>"
									+ data[i].gender
									+ "</td>"
									+ "<td>"
									+ +data[i].age
									+ "</td>"
									+ "<td>"
									+ +data[i].birthday
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editAIDSpatients\" data-toggle=\"tab\" onclick=\"setAIDSpatients("
									+ data[i].AIDSpatientsId
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteAIDSpatients("
									+ data[i].AIDSpatientsId
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"

							html += "</tr>";
						}
						$('#listAIDSpatients1').html(html);
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
																		}, ]
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
	function createAIDSpatients() {
		$("#loader").show();
		if ($('#name').val() == "") {
			document.getElementById('name').style.borderColor = "red";
			return false;
		} else if ($('#gender').val() == "") {
			document.getElementById('gender').style.borderColor = "red";
			return false;
		} else if ($('#idCard').val() == "") {
			document.getElementById('idCard').style.borderColor = "red";
			return false;
		} else if ($('#birthday').val() == "") {
			document.getElementById('birthday').style.borderColor = "red";
			return false;
		} else if ($('#age').val() == "") {
			document.getElementById('age').style.borderColor = "red";
			return false;
		} else if ($('#address1').val() == "") {
			document.getElementById('address1').style.borderColor = "red";
			return false;
		} else if ($('#address2').val() == "") {
			document.getElementById('address2').style.borderColor = "red";
			return false;
		} else if ($('#tel1').val() == "") {
			document.getElementById('tel1').style.borderColor = "red";
			return false;
		} else if ($('#tel2').val() == "") {
			document.getElementById('tel2').style.borderColor = "red";
			return false;
		} else if ($('#regisDate').val() == "") {
			document.getElementById('regisDate').style.borderColor = "red";
			return false;
		} else if ($('#donateSartDate').val() == "") {
			document.getElementById('donateSartDate').style.borderColor = "red";
			return false;
		} else if ($('#offspring').val() == "") {
			document.getElementById('offspring').style.borderColor = "red";
			return false;
		} else if ($('#offspringIdCard').val() == "") {
			document.getElementById('offspringIdCard').style.borderColor = "red";
			return false;
		} else if ($('#donateEndDate').val() == "") {
			document.getElementById('donateEndDate').style.borderColor = "red";
			return false;
		} else if ($('#remark').val() == "") {
			document.getElementById('remark').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				AIDSpatientsId : 0,
				name : $('#name').val(),
				gender : $('#gender').val(),
				idCard : $('#idCard').val(),
				birthday : $('#birthday').val(),
				age : $('#age').val(),
				address1 : $('#address1').val(),
				address2 : $('#address2').val(),
				tel1 : $('#tel1').val(),
				tel2 : $('#tel2').val(),
				regisDate : $('#regisDate').val(),
				donateSartDate : $('#donateSartDate').val(),
				offspring : $('#offspring').val(),
				offspringIdCard : $('#offspringIdCard').val(),
				donateEndDate : $('#donateEndDate').val(),
				remark : $('#remark').val()

			};
			$.ajax({
				url : "../NanglaeGov/saveAIDSpatients.do",
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
	function deleteAIDSpatients(AIDSpatientsId) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
			var id = AIDSpatientsId;
			var obj = {
				AIDSpatientsId : id

			};
			$.ajax({
				url : "../NanglaeGov/deleteAIDSpatients.do",
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
	function editAIDSpatients() {
		var obj = {
			AIDSpatientsId : $("#editAIDSpatientsId").val(),
			name : $('#editName').val(),
			gender : $('#editGender').val(),
			idCard : $('#editIdCard').val(),
			birthday : $('#editBirthday').val(),
			age : $('#editAge').val(),
			address1 : $('#editAddress1').val(),
			address2 : $('#editAddress2').val(),
			tel1 : $('#editTel1').val(),
			tel2 : $('#edittel2').val(),
			regisDate : $('#editRegisDate').val(),
			donateSartDate : $('#editDonateSartDate').val(),
			offspring : $('#editOffspring').val(),
			offspringIdCard : $('#editOffspringIdCard').val(),
			donateEndDate : $('#editdDonateEndDate').val(),
			remark : $('#editRemark').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveAIDSpatients.do",
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
	function setEditAIDSpatients(AIDSpatientsId) {

		var obj = {
			AIDSpatientsId : AIDSpatientsId
		};

		$.ajax({
			url : "../NanglaeGov/findAIDSpatients.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editAIDSpatientsId").val(data.AIDSpatientsId);
				$("#editName").val(data.name);
				$("#editGender").val(data.gender);
				$("#editIdCard").val(data.idCard);
				$('#editBirthday').val(data.birthday);
				$('#editAge').val(data.age);
				$('#editAddress1').val(data.address1);
				$('#editAddress2').val(data.address2);
				$('#editTel1').val(data.tel1);
				$('#editTel2').val(data.tel2);
				$('#editRegisDate').val(data.regisDate);
				$('#editDonateSartDate').val(data.donateSartDate);
				$('#editOffspring').val(data.offspring);
				$('#editOffspringIdCard').val(data.offspringIdCard);
				$('#editDonateEndDate').val(data.donateEndDate);
				$('#editRemark').val(data.remark);
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
</script>
</head>

<body onload="listAIDSpatients();">

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

			<%@include file="superMenu.jsp"%>
		</nav>
	</div>
	<div id="page-wrapper" style="background-color: #d7f0f5">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">ผู้ป่วยเอดส์</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.panel-heading -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#listAIDSpatients"
								data-toggle="tab">ข้อมูลผู้ป่วยเอดส์</a></li>
							<li><a href="#addAIDSpatients" data-toggle="tab">เพิ่มข้อมูลผู้ป่วยเอดส์</a>
							</li>
						</ul>
						<div class="panel-body">

							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane fade in active" id="listAIDSpatients">
									<div class="table-responsive">
										<table id="resultTable"
											class="table table-striped table-bordered table-hover">
											<!-- Start change table -->
											<thead>
												<tr>
													<th>ชื่อ</th>
													<th>เพศ</th>
													<th>อายุ</th>
													<th>วันเดือนปีเกิด</th>
													<th style="text-align: center;">ตัวเลือก</th>
												</tr>
											</thead>
											<tbody id="listAIDSpatients">
											</tbody>
											<!-- End change table -->
										</table>
									</div>
								</div>
								<div class="tab-pane fade" id="addAIDSpatients">
									<form role="form">
										<table width="50%" align="center">
											<tr>
												<td align="pull-right" style="padding: 15px">ชื่อ</td>
												<td><input id="name" maxlength="50"
													class="form-control" placeholder="ระบุชื่อ" name="name"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">เพศ</td>
												<td><select id="gander" class="form-control"
													name="gander">
														<option value="">เลือกเพศ</option>
														<option value="ลำห้วย">ชาย</option>
														<option value="ลำห้วย">หญิง</option>
												</select></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">เลขบัตรประจำตัวประชาชน</td>
												<td><input id="idCard" maxlength="50"
													class="form-control"
													placeholder="ระบุเลขบัตรประจำตัวประชาชน" name="idCard"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">วันเดือนปีเกิด</td>
												<td><input type="date" id="birthday" maxlength="50"
													class="form-control" placeholder="" name="birthday"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">อายุ</td>
												<td><input id="age" maxlength="3" class="form-control"
													placeholder="ระบุอายุ" name="age" required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ที่อยุ่ตามทะเบียนบ้าน</td>
												<td><textarea id="address1" maxlength="255"
														class="form-control"
														placeholder="ระบุที่อยุ่ตามทะเบียนบ้าน" name="address1"
														required="true"></textarea></td>

											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">เบอร์โทรศัพท์</td>
												<td><input id="tel1" maxlength="10" class="form-control"
													placeholder="ระบุเบอร์โทรศัพท์" name="tel1" required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ที่อยุ่ปัจจุบัน</td>
												<td><textarea id="address2" maxlength="255"
														class="form-control"
														placeholder="ระบุที่อยุ่ปัจจุบัน" name="address2"
														required="true"></textarea></td>

											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">เบอร์โทรศัพท์</td>
												<td><input id="tel2" maxlength="10" class="form-control"
													placeholder="ระบุเบอร์โทรศัพท์" name="tel2" required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">วันเดือนปีที่ขึ้นทะเบียน</td>
												<td><input type="date" id="regisDate" maxlength="50"
													class="form-control" placeholder="" name="regisDate"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">วันเดือนปีที่เริ่มรับเงินสงเคราะห์</td>
												<td><input type="date" id="donateSartDate" maxlength="50"
													class="form-control" placeholder="" name="donateSartDate"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ชื่อ นามสกุลของทายาท</td>
												<td><input id="offspring" maxlength="50"
													class="form-control"
													placeholder="ระบุชื่อ นามสกุลของทายาท" name="offspring"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">เลขบัตรประจำตัวประชาชนของทายาท</td>
												<td><input id="offspringIdCard" maxlength="50"
													class="form-control"
													placeholder="ระบุเลขบัตรประจำตัวประชาชนของทายาท" name="offspringIdCard"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">วันเดือนปีที่สิ้นสุดการรับเงินสงเคราะห์</td>
												<td><input type="date" id="donateEndDate" maxlength="50"
													class="form-control" placeholder="" name="donateEndDate"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">หมายเหตุ</td>
												<td><textarea id="remark" maxlength="255"
														class="form-control"
														placeholder="ระบุหมายเหตุ" name="remark"
														required="true"></textarea></td>

											</tr>
											<tr>
												<td></td>
												<td align="center" style="padding: 15px">
													<button style="width: 100px" type="reset"
														class="btn btn-warning">ล้างข้อมูล</button> <input
													style="width: 100px" type="button" class="btn btn-success"
													value="บันทึก" onclick="createWater()" />
												</td>
											</tr>
										</table>
									</form>
								</div>
								<div class="tab-pane fade" id="editAIDSpatients">
									<form role="form">
										<input type="hidden" id="editAIDSpatientsId">
										<table width="50%" align="center">
											<tr>
												<td align="pull-right" style="padding: 15px">ชื่อ</td>
												<td><input id="editName" maxlength="50"
													class="form-control" placeholder="ระบุชื่อ" name="editName"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">เพศ</td>
												<td><select id="editGender" class="form-control"
													name="editGender">
														<option value="">เลือกเพศ</option>
														<option value="ลำห้วย">ชาย</option>
														<option value="ลำห้วย">หญิง</option>
												</select></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">เลขบัตรประจำตัวประชาชน</td>
												<td><input id="editIdCard" maxlength="50"
													class="form-control"
													placeholder="ระบุเลขบัตรประจำตัวประชาชน" name="editIdCard"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">วันเดือนปีเกิด</td>
												<td><input type="date" id="editBirthday" maxlength="50"
													class="form-control" placeholder="" name="editBirthday"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">อายุ</td>
												<td><input id="editAge" maxlength="3" class="form-control"
													placeholder="ระบุอายุ" name="editAge" required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ที่อยุ่ตามทะเบียนบ้าน</td>
												<td><textarea id="editAddress1" maxlength="255"
														class="form-control"
														placeholder="ระบุที่อยุ่ตามทะเบียนบ้าน" name="editAddress1"
														required="true"></textarea></td>

											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">เบอร์โทรศัพท์</td>
												<td><input id="editTel1" maxlength="10" class="form-control"
													placeholder="ระบุเบอร์โทรศัพท์" name="editTel1" required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ที่อยุ่ปัจจุบัน</td>
												<td><textarea id="editAddress2" maxlength="255"
														class="form-control"
														placeholder="ระบุที่อยุ่ปัจจุบัน" name="editAddress2"
														required="true"></textarea></td>

											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">เบอร์โทรศัพท์</td>
												<td><input id="editTel2" maxlength="10" class="form-control"
													placeholder="ระบุเบอร์โทรศัพท์" name="editTel2" required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">วันเดือนปีที่ขึ้นทะเบียน</td>
												<td><input type="date" id="editRegisDate" maxlength="50"
													class="form-control" placeholder="" name="editRegisDate"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">วันเดือนปีที่เริ่มรับเงินสงเคราะห์</td>
												<td><input type="date" id="editDonateSartDate" maxlength="50"
													class="form-control" placeholder="" name="editDonateSartDate"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ชื่อ นามสกุลของทายาท</td>
												<td><input id="editOffspring" maxlength="50"
													class="form-control"
													placeholder="ระบุชื่อ นามสกุลของทายาท" name="editOffspring"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">เลขบัตรประจำตัวประชาชนของทายาท</td>
												<td><input id="editOffspringIdCard" maxlength="50"
													class="form-control"
													placeholder="ระบุเลขบัตรประจำตัวประชาชนของทายาท" name="editOffspringIdCard"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">วันเดือนปีที่สิ้นสุดการรับเงินสงเคราะห์</td>
												<td><input type="date" id="editDonateEndDate" maxlength="50"
													class="form-control" placeholder="" name="editDonateEndDate"
													required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">หมายเหตุ</td>
												<td><textarea id="editRemark" maxlength="255"
														class="form-control"
														placeholder="ระบุหมายเหตุ" name="editRemark"
														required="true"></textarea></td>

											</tr>
											<tr>
												<td></td>
												<td align="center" style="padding: 15px"><a
													href="#listResourceWater" data-toggle="tab"><button
															style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
													<input style="width: 100px" type="button"
													class="btn btn-success" value="บันทึก"
													onclick="editWater()" /></td>
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
