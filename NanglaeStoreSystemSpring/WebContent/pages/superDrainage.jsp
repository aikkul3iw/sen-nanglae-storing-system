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
	document.getElementById("drain_year").value=(year.getFullYear()+543);
	}
	
	function listDrainage() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listDrainage.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {
							html += "<tr>";
							html += "<td>"
									+ data[i].drain_year
									+ "</td>"
									+ "<td>"
									+ data[i].drain_name
									+ "</td>"
									+ "<td>"
									+ "หมู่ที่ "
									+ data[i].location.vil_number
									+ " บ้าน"
									+ data[i].location.vil_name
									+ "</td>"
									+ "<td>"
									+ data[i].drain_location_connected
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editDrain\" data-toggle=\"tab\" onclick=\"setEditDrainage("
									+ data[i].drain_id
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteDrainage("
									+ data[i].drain_id
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"

							html += "</tr>";
						}
						$('#listDrainages').html(html);
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
	function createDrainage() {
		$("#loader").show();
		if ($('#drain_year').val() == "") {
			document.getElementById('drain_year').style.borderColor = "red";
			return false;
		} else if ($('#drain_name').val() == "") {
			document.getElementById('drain_name').style.borderColor = "red";
			return false;
		} else if ($('#drain_location_connected').val() == "") {
			document.getElementById('drain_location_connected').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				drain_id : 0,
				drain_year : $('#drain_year').val(),
				drain_name : $('#drain_name').val(),
				drain_location_connected : $('#drain_location_connected').val()
			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/saveDrainage.do?id=" + $("#villageSelect").val() + "&user="+$('#userId').val(),
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
	function deleteDrainage(drain_id) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
		var id = drain_id;
		var obj = {
			drain_id : id
		};
		$.ajax({
			url : "../NanglaeGov/deleteDrainage.do",
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
	function editDrainage() {
		var obj = {
			drain_id : $("#editDrainId").val(),
			drain_year : $('#editDrainYear').val(),
			drain_name : $('#editDrainName').val(),
			drain_location_connected : $('#editDrainLocalConnect').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveDrainage.do?id=" + $("#editVillageSelect").val() + "&editUserId="+$('#editUserId').val(),
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
	function setEditDrainage(drain_id) {

		var obj = {
			drain_id : drain_id
		};

		$.ajax({
			url : "../NanglaeGov/findDrainage.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editDrainId").val(data.drain_id);
				$("#editDrainYear").val(data.drain_year);
				$("#editDrainName").val(data.drain_name);
				$("#editDrainLocalConnect").val(data.drain_location_connected);
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

<body onload="listDrainage();listVillage();editVillageSelect();getCurrentYear()">

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
				<h1 class="page-header">ระบบระบายน้ำ</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.panel-heading -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#listDrain" data-toggle="tab">ข้อมูลระบบระบายน้ำ</a>
							</li>
							<li><a href="#addDrain" data-toggle="tab">เพิ่มระบบระบายน้ำ</a>
							</li>
						</ul>
						<div class="panel-body">

							<!-- Tab panes -->

							<div class="tab-content">
								<div class="tab-pane fade in active" id="listDrain">
									<div class="table-responsive">
										<table id="resultTable"
											class="table table-striped table-bordered table-hover">
											<!-- Start change table -->
											<thead>
												<tr>
													<th>ปีข้อมูล</th>
													<th>ระบบระบายน้ำ</th>
													<th>ที่ตั้ง</th>
													<th>พื้นที่เชื่อมต่อ</th>
													<th style="text-align: center;">ตัวเลือก</th>
												</tr>
											</thead>
											<tbody id="listDrainages">
											</tbody>
											<!-- End change table -->
										</table>
									</div>
								</div>
								<div class="tab-pane fade" id="addDrain">
									<form role="form">
										<%
											Object userid = session.getAttribute("user");
										%>
										<input type="hidden" id="userId" value="<%=userid %>">
										<table width="50%" align="center">
											<tr>
												<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
												<td><input id="drain_year" maxlength="4"
													class="form-control" placeholder="" value="2558"
													name="vil-year"></td>
											</tr>
											<tr>

												<td align="pull-right" style="padding: 15px">ชื่อ</td>
												<td><input id="drain_name" maxlength="50"
													class="form-control" placeholder="ระบุชื่อระบบระบายน้ำ"
													name="vil-number" required="true"></td>

											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ที่ตั้ง</td>
												<td><select id="villageSelect" class="form-control"
													placeholder="" name="vil-name" required="true">

												</select></td>
											</tr>
											<tr>

												<td align="pull-right" style="padding: 15px">ไหลผ่าน</td>
												<td><textarea id="drain_location_connected"
														maxlength="255" class="form-control"
														placeholder="ระบุหมู่บ้านที่ไหลผ่าน" name="vil-number"
														required="true"></textarea></td>

											</tr>
											<tr>
												<td></td>
												<td align="center" style="padding: 15px">
													<button style="width: 100px" type="reset"
														class="btn btn-warning">ล้างข้อมูล</button> <input
													style="width: 100px" type="button" class="btn btn-success"
													value="บันทึก" onclick="createDrainage()" />
												</td>
											</tr>
										</table>
									</form>
								</div>
								<div class="tab-pane fade" id="editDrain">
									<form role="form">
										<%
											Object edituserid = session.getAttribute("edituser");
										%>
										<input type="hidden" id="editUserId" value="<%=edituserid %>">
										<input type="hidden" id="editDrainId">
										<table width="50%" align="center">
											<tr>
												<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
												<td><input id="editDrainYear" maxlength="4"
													class="form-control" placeholder="" value="2558"
													name="vil-year"></td>
											</tr>
											<tr>

												<td align="pull-right" style="padding: 15px">ชื่อ</td>
												<td><input id="editDrainName" maxlength="50"
													class="form-control" placeholder="ระบุชื่อระบบระบายน้ำ"
													name="vil-number" required="true"></td>

											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">ที่ตั้ง</td>
												<td><select id="editVillageSelect" class="form-control"
													placeholder="" name="vil-name" required="true">

												</select></td>
											</tr>
											<tr>

												<td align="pull-right" style="padding: 15px">ไหลผ่าน</td>
												<td><textarea id="editDrainLocalConnect"
														maxlength="255" class="form-control"
														placeholder="ระบุหมู่บ้านที่ไหลผ่าน" name="vil-number"
														required="true"></textarea></td>

											</tr>
											<tr>
												<td></td>
												<td align="center" style="padding: 15px"><a
													href="#listDrain" data-toggle="tab"><button
															style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
													<input style="width: 100px" type="button"
													class="btn btn-success" value="บันทึก"
													onclick="editDrainage()" /></td>
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
