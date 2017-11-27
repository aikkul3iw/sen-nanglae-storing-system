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
function getAddress(){
	var address = $('#address1').val();
	$("#address2").val(address);
}
	
	function listCommerce() {
		$("#loader").show();
		$.ajax({
			url : "../NanglaeGov/listCommerce.do",
			type : "POST",
			success : function(data) {
				var html = '';
				for (var i = 0; i < data.length; i++) {
							html += "<tr>";
							html += "<td>"
									+ data[i].com_name
									+ "</td>"
									+ "<td>"
									+ data[i].com_type
									+ "</td>"
									+ "<td>"
									+ "หมู่ที่ "
									+ data[i].location.vil_number
									+ " บ้าน"
									+ data[i].location.vil_name
									+ "</td>"
									+ "<td>"
									+ data[i].com_description
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editCommerce\" data-toggle=\"tab\" onclick=\"setEditCommerce("
									+ data[i].com_id
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteCommerce("
									+ data[i].com_id
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"
							html += "</tr>";
						}
						$('#listCommerces').html(html);
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
						alert('error');
						$("#loader").hide();
					}
			});
	}
</script>
<script type='text/javascript'>
	function createAIDSpatients() {
		$("#loader").show();
		var obj = {
				AIDSpatientsId : 0,
			titles : $('#titles').val(),
			firstName : $('#firstName').val(),
			lastName : $('#lastName').val(),
			gender : $('#gender').val(),
			idCard : $('#idCard').val(),
			birthday : $('#birthday').val(),
			age : $('#age').val(),
			address1 : $('#address1').val(),
			address2 : $('#address2').val(),
			tel : $('#tel').val(),
			regisDate : $('#regisDate').val(),
			allowanceStartDate : $('#allowanceStartDate').val(),
			offspringTitle : $('#offspringTitle').val(),
			offspringFirstname : $('#offspringFirstname').val(),
			offspringLastname : $('#offspringLastname').val(),
			offspringIdCard : $('#offspringIdCard').val(),
			allowanceEndDate : $('#allowanceEndDate').val(),
			remark : $('#remark').val()
			
		};
		$.ajax({
			url : "../NanglaeGov/saveAIDSpatients.do?id="+ $("#villageSelect").val() + "&user="+ $('#userId').val(),
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
	function deleteCommerce(com_id) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
		var id = com_id
		var obj = {
			com_id : id

		};
		//alert(id);
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/deleteCommerce.do",
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
	function editCommerce() {
		var obj = {
			com_id : $("#editComId").val(),
			com_name : $('#editComName').val(),
			com_type : $('#editComType').val(),
			com_house_number : $('#editComHouseNumber').val(),
			com_description : $('#editComDescription').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveCommerce.do?id=" + $("#editVillageSelect").val() + "&editUserId="+$('#editUserId').val(),
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
	function setEditCommerce(com_id) {

		var obj = {
			com_id : com_id
		};

		$.ajax({
			url : "../NanglaeGov/findCommerce.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editComId").val(data.com_id);
				$("#editComName").val(data.com_name);
				$("#editComType").val(data.com_type);
				$("#editComHouseNumber").val(data.com_house_number);
				$("#editComDescription").val(data.com_description);
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

<body onload="listCommerce();listVillage();editVillageSelect()">

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
								<li class="active"><a href="#listCommerce"
									data-toggle="tab">ข้อมูลผู้ป่วยเอดส์</a></li>
								<li><a href="#addCommerce" data-toggle="tab" id="addaid">เพิ่มผู้ป่วยเอดส์</a>
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
														<th>ชื่อ</th>
														<th>ประเภท</th>
														<th>ที่ตั้ง</th>
														<th>รายละเอียด</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listCommerces">
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
										<input type="hidden" id="userId" value="<%=userid %>">
											<table width="50%" align="center">
											<tr>
												<th colspand="2">ข้อมูลผู้ป่วยเอดส์</th>
											</tr>
											<tr>
													<td align="pull-right" style="padding: 15px">คำนำหน้าชื่อ</td>
													<td><select id="titles" class="form-control"
														placeholder="" name="titles" required="true">
															<option value="">เลือกคำนำหน้าชื่อ</option>
															<option value="นาย">นาย</option>
															<option value="นาง">นาง</option>
															<option value="นางสาว">นางสาว</option>
															<option value="เด็กชาย">เด็กชาย</option>
															<option value="เด็กหญิง">เด็กหญิง</option>
													</select></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ชื่อ</td>
													<td><input id="firstName" maxlength="100"
														class="form-control" placeholder="ระบุชื่อ"
														name="firstName" required="true"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">นามสกุล</td>
													<td><input id="lastName" maxlength="100"
														class="form-control" placeholder="ระบุนามสกุล"
														name="lastName" required="true"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">เพศ</td>
													<td><select id="gender" class="form-control"
														placeholder="" name="gender" required="true">
															<option value="">เลือกเพศ</option>
															<option value="ชาย">ชาย</option>
															<option value="หญิง">หญิง</option>
													</select></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">เลขบัตรประจำตัวประชาชน</td>
													<td><input id="idCard" maxlength="100"
														class="form-control" data-mask="0-0000-00000-00-0" placeholder="ระบุเลขบัตรประจำตัวประชาชน"
														name="idCard" required="true"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">วันเกิด</td>
													<td><input data-mask="00/00/0000" id="birthday" maxlength="100"
														class="form-control"
														name="birthday" required="true"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">อายุ</td>
													<td><input id="age" maxlength="100"
														class="form-control" data-mask="000" placeholder="ระบุอายุ"
														name="age" required="true"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">หมู่บ้านที่ตั้ง</td>
													<td><select id="villageSelect" class="form-control"
														placeholder="" name="villageSelect" required="true">
													</select></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ที่อยู่ตามทะเบียนบ้าน</td>
													<td><textarea id="address1" maxlength="255"
															class="form-control"
															placeholder="ระบุที่อยู่ตามทะเบียนบ้าน" name="address1"
															required="true"></textarea>
															<input type="checkbox" onclick="getAddress()" /> ใช้ที่อยู่เดิม
															</td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ที่อยู่ปัจจุบัน</td>
													<td><textarea id="address2" maxlength="255"
															class="form-control"
															placeholder="ระบุที่อยู่ปัจจุบัน" name="address2"
															required="true"></textarea></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">เบอร์โทรศัพท์</td>
													<td><input id="tel" maxlength="100"
														class="form-control" data-mask="000-0000000" placeholder="ระบุเเบอร์โทรศัพท์"
														name="tel" required="true"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">วันที่ขึ้นทะเบียน</td>
													<td><input data-mask="00/00/0000" id="regisDate" maxlength="100"
														class="form-control"
														name="regisDate" required="true"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">วันที่เริ่มรับเงินสงเคราะห์</td>
													<td><input data-mask="00/00/0000" id="allowanceStartDate" maxlength="100"
														class="form-control"
														name="allowanceStartDate" required="true"></td>
												</tr>
											<tr>
												<th colspand="2">ข้อมูลทายาท</th>
											</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">คำนำหน้าชื่อ</td>
													<td><select id="offspringTitle" class="form-control"
														placeholder="" name="offspringTitle" required="true">
															<option value="">เลือกคำนำหน้าชื่อ</option>
															<option value="นาย">นาย</option>
															<option value="นาง">นาง</option>
															<option value="นางสาว">นางสาว</option>
															<option value="เด็กชาย">เด็กชาย</option>
															<option value="เด็กหญิง">เด็กหญิง</option>
													</select></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ชื่อ</td>
													<td><input id="offspringFirstname" maxlength="100"
														class="form-control" placeholder="ระบุชื่อ"
														name="offspringFirstname" required="true"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">นามสกุล</td>
													<td><input id="offspringLastname" maxlength="100"
														class="form-control" placeholder="ระบุนามสกุล"
														name="offspringLastname" required="true"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">เลขบัตรประจำตัวประชาชน</td>
													<td><input id="offspringIdCard" maxlength="100"
														class="form-control" data-mask="0-0000-00000-00-0" placeholder="ระบุเลขบัตรประจำตัวประชาชน"
														name="offspringIdCard" required="true"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">วันที่สิ้นสุดรับเงินสงเคราะห์</td>
													<td><input data-mask="00/00/0000" id="allowanceEndDate" maxlength="100"
														class="form-control"
														name="allowanceEndDate" required="true"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">หมายเหตุ</td>
													<td><textarea id="remark" maxlength="255"
															class="form-control"
															placeholder="หมายเหตุ" name="remark"
															required="true"></textarea></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px">
														<button style="width: 100px" type="reset"
															class="btn btn-warning">ล้างข้อมูล</button> <input
														style="width: 100px" type="button" class="btn btn-success"
														value="บันทึก" id="save"onclick="createAIDSpatients()" />
													</td>
												</tr>
											</table>
										</form>
									</div>
									<div class="tab-pane fade" id="editCommerce">
										<form role="form">
										<%
											Object edituserid = session.getAttribute("edituser");
										%>
										<input type="hidden" id="editUserId" value="<%=edituserid %>">
											<input type="hidden" id="editComId">
											<table width="50%" align="center">
												<tr>

													<td align="pull-right" style="padding: 15px">ชื่อ</td>
													<td><input id="editComName" maxlength="100"
														class="form-control" placeholder="ระบุชื่อการพาณิชย์"
														name="vil-number" required="true"></td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ประเภท</td>
													<td><select id="editComType" class="form-control"
														placeholder="" name="vil-name" required="true">
															<option value="">เลือกประเภท</option>
															<option value="ร้านค้า">ร้านค้า</option>
															<option value="ร้านอาหาร">ร้านอาหาร</option>
															<option value="ร้านเสริมสวย">ร้านเสริมสวย</option>
															<option value="ตลาด">ตลาด</option>
															<option value="สถานีบริการน้ำมัน">สถานีบริการน้ำมัน</option>
													</select></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">เลขที่ตั้ง</td>
													<td><input id="editComHouseNumber" maxlength="7"
														class="form-control" placeholder="ระบุเลขที่ตั้ง"
														name="vil-number" required="true"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">หมู่บ้านที่ตั้ง</td>
													<td><select id="editVillageSelect"
														class="form-control" placeholder="" name="vil-name"
														required="true">

													</select></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">รายละเอียด</td>
													<td><textarea id="editComDescription" maxlength="255"
															class="form-control"
															placeholder="ระบุรายละเอียดเพิ่มเติม" name="vil-number"
															required="true"></textarea></td>

												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px"><a
														href="#listCommerce" data-toggle="tab"><button
																style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
														<input style="width: 100px" type="button"
														class="btn btn-success" value="บันทึก"
														onclick="editCommerce()" /></td>
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
