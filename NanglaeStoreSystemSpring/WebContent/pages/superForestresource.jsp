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
	function listForest() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listForest.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {
							html += "<tr>";

							html += "<td>"
									+ data[i].frs_type
									+ "</td>"
									+ "<td>"
									+ "หมู่ที่ "
									+ data[i].location.vil_number
									+ " บ้าน"
									+ data[i].location.vil_name
									+ "</td>"
									+ "<td>"
									+ data[i].frs_usage
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editForest\" data-toggle=\"tab\" onclick=\"setEditForest("
									+ data[i].frs_id
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteForest("
									+ data[i].frs_id
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"

							html += "</tr>";
						}
						$('#listForests').html(html);
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
	function createForest() {
		$("#loader").show();
		if ($('#frs_type').val() == "") {
			document.getElementById('frs_type').style.borderColor = "red";
			return false;
		} else if ($('#frs_usage').val() == "") {
			document.getElementById('frs_usage').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				frs_id : 0,
				frs_type : $('#frs_type').val(),
				frs_usage : $('#frs_usage').val()

			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/saveForest.do?id=" + $("#villageSelect").val() + "&user="+$('#userId').val(),
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
				html += "<option value=\"\">เลือกหมู่บ้าน</option>";
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
	function deleteForest(frs_id) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
			<%Object userdelete = session.getAttribute("userdelete");%>
			var usdelete="<%=userdelete%>";
			var id = frs_id
			var obj = {
				frs_id : id

		};
		$.ajax({
			url : "../NanglaeGov/deleteForest.do?userdelete=" + usdelete,
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
	function editForest() {
		if ($('#editFrsType').val() == "") {
			document.getElementById('editFrsType').style.borderColor = "red";
			return false;
		} else if ($('#editFrsUsage').val() == "") {
			document.getElementById('editFrsUsage').style.borderColor = "red";
			return false;
		} else {
		var obj = {
			frs_id : $("#editFrsId").val(),
			frs_type : $('#editFrsType').val(),
			frs_usage : $('#editFrsUsage').val()

		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveForest.do?id=" + $("#editVillageSelect").val() + "&editUserId="+$('#editUserId').val(),
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
	function setEditForest(frs_id) {

		var obj = {
			frs_id : frs_id
		};

		$.ajax({
			url : "../NanglaeGov/findForest.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editFrsId").val(data.frs_id);
				$("#editFrsType").val(data.frs_type);
				$("#editFrsUsage").val(data.frs_usage);
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

<body onload="listForest();listVillage();editVillageSelect()">
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
					<h1 class="page-header">ทรัพยากรป่าไม้</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.panel-heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#listForest" data-toggle="tab">ข้อมูลทรัพยากรป่าไม้</a>
								</li>
								<li><a href="#addForest" data-toggle="tab">เพิ่มข้อมูลทรัพยากรป่าไม้</a>
								</li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->
								<div class="tab-content">
									<div class="tab-pane fade in active" id="listForest">
										<div class="table-responsive">
											<table id="resultTable"
												class="table table-striped table-bordered table-hover">
<!-- Start change table -->
												<thead>
													<tr>
														<th>ประเภทของป่าไม้</th>
														<th>ตัอยู่หมู่บ้าน้ง</th>
														<th>การนำไปใช้ประโยนช์</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listForests">
												</tbody>
<!-- End change table -->
											</table>
										</div>
									</div>
									<div class="tab-pane fade" id="addForest">
										<form role="form">
										<%
											Object userid = session.getAttribute("user");
										%>
										<input type="hidden" id="userId" value="<%=userid %>">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ประเภทของป่าไม้
														<font color="red" size="3">*</font>
													</td>
													<td><select id="frs_type" class="form-control"
														placeholder="" name="frs_type">
															<option value="">เลือกประเภทของป่าไม้</option>
															<option value="ป่าดิบชื้น">ป่าดิบชื้น</option>
															<option value="ป่าดิบแล้ง">ป่าดิบแล้ง</option>
															<option value="ป่าดิบเขา">ป่าดิบเขา</option>
															<option value="ป่าสน">ป่าสน</option>
															<option value="ป่าพรุ">ป่าพรุ</option>
															<option value="ป่าชายเลน">ป่าชายเลน</option>
															<option value="ป่าชายหาด">ป่าชายหาด</option>
															<option value="ป่าสงวน">ป่าสงวน</option>
															<option value="ป่าชุมชน">ป่าชุมชน</option>
															<option value="ป่าสาธารณะ">ป่าสาธารณะ</option>
													</select></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ตั้งอยู่หมู่บ้าน <font color="red" size="3">*</font></td>
													<td><select id="villageSelect" class="form-control"
														name="villageSelect">
													</select></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">การนำไปใช้ประโยชน์ <font color="red" size="3">*</font></td>
													<td><input id="frs_usage" maxlength="255"
														class="form-control" placeholder="ระบุการนำไปใช้ประโยชน์" name="frs_usage"></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px">
														<button style="width: 100px" type="reset"
															class="btn btn-warning">ล้างข้อมูล</button> <input
														style="width: 100px" type="button" class="btn btn-success"
														value="บันทึก" onclick="createForest()" />
													</td>
												</tr>
											</table>
										</form>
									</div>
									<div class="tab-pane fade" id="editForest">
										<form role="form">
										<%
											Object edituserid = session.getAttribute("edituser");
										%>
										<input type="hidden" id="editUserId" value="<%=edituserid %>">
											<input type="hidden" id="editFrsId">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ประเภทของป่าไม้
														<font color="red" size="3">*</font>
													</td>
													<td><select id="editFrsType" class="form-control"
														placeholder="" name="editFrsType">
															<option value="ป่าดิบชื้น">ป่าดิบชื้น</option>
															<option value="ป่าดิบแล้ง">ป่าดิบแล้ง</option>
															<option value="ป่าดิบเขา">ป่าดิบเขา</option>
															<option value="ป่าสน">ป่าสน</option>
															<option value="ป่าพรุ">ป่าพรุ</option>
															<option value="ป่าชายเลน">ป่าชายเลน</option>
															<option value="ป่าชายหาด">ป่าชายหาด</option>
															<option value="ป่าสงวน">ป่าสงวน</option>
															<option value="ป่าชุมชน">ป่าชุมชน</option>
															<option value="ป่าสาธารณะ">ป่าสาธารณะ</option>
													</select></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ตั้งอยู่หมู่บ้าน <font color="red" size="3">*</font></td>
													<td><select id="editVillageSelect"
														class="form-control" name="editVillageSelect">
													</select></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">การนำไปใช้ประโยชน์ <font color="red" size="3">*</font></td>
													<td><input id="editFrsUsage" maxlength="255"
														class="form-control" placeholder="ระบุการนำไปใช้ประโยชน์" name="editFrsUsage"></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px"><a
														href="#listForest" data-toggle="tab"><button
																style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
														<input style="width: 100px" type="button"
														class="btn btn-success" value="บันทึก"
														onclick="editForest()" /></td>
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
