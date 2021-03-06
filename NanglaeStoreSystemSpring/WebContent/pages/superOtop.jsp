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
	function listOtop() {
		$("#loader").show();

		$
				.ajax({
					url : "../NanglaeGov/listOtop.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {

							var id = data[i].otopId;

							html += "<tr>";
							html += "<td>"
									+ data[i].otop_name
									+ "</td>"
									+ "<td>"
									+ data[i].otop_price
									+ "</td>"
									+ "<td>"
									+ data[i].tel
									+ "</td>"
									+ "<td>"
									+ data[i].otop_description
									+ "</td>"
									+ "<td>"
									+ data[i].latitute
									+ "</td>"
									+ "<td>"
									+ data[i].longitute
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editOtop\" data-toggle=\"tab\" onclick=\"setEditOtop("
									+ data[i].otopId
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteOtop("
									+ data[i].otopId
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"

							html += "</tr>";
						}
						$('#listOtops').html(html);
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
																						3,
																						4,
																						5 ]
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
	function createOtop() {
		$("#loader").show();
		if ($('#otop_name').val() == "") {
			document.getElementById('otop_name').style.borderColor = "red";
			return false;
		} else if ($('#tel').val() == "") {
			document.getElementById('tel').style.borderColor = "red";
			return false;
		} else if ($('#otop_price').val() == "") {
			document.getElementById('otop_price').style.borderColor = "red";
			return false;
		} else if ($('#otop_description').val() == "") {
			document.getElementById('otop_description').style.borderColor = "red";
			return false;
		} else if ($('#latitute').val() == "") {
			document.getElementById('latitute').style.borderColor = "red";
			return false;
		} else if ($('#longitute').val() == "") {
			document.getElementById('longitute').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				otopId : 0,
				otop_name : $('#otop_name').val(),
				tel : $('#otop_tel').val(),
				otop_price : $('#otop_price').val(),
				otop_description : $('#otop_description').val(),
				latitute : $('#otop_latitute').val(),
				longitute : $('#otop_longitute').val()
			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/saveOtop.do?user=" + $('#userId').val(),
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

	function deleteOtop(otopId) {
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
			var id = otopId;
			var obj = {
				otopId : id
			};

			$.ajax({
				url : "../NanglaeGov/deleteOtop.do?userdelete=" + usdelete,
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
	function editOtop() {
		if ($('#editotop_name').val() == "") {
			document.getElementById('editotop_name').style.borderColor = "red";
			return false;
		} else if ($('#editotop_tel').val() == "") {
			document.getElementById('editotop_tel').style.borderColor = "red";
			return false;
		} else if ($('#editotop_price').val() == "") {
			document.getElementById('editotop_price').style.borderColor = "red";
			return false;
		} else if ($('#editotop_description').val() == "") {
			document.getElementById('editotop_description').style.borderColor = "red";
			return false;
		} else if ($('#editotop_latitute').val() == "") {
			document.getElementById('editotop_latitute').style.borderColor = "red";
			return false;
		} else if ($('#editotop_longitute').val() == "") {
			document.getElementById('editotop_longitute').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				otopId : $('#editOtopId').val(),
				otop_name : $('#editotop_name').val(),
				tel : $('#editotop_tel').val(),
				otop_price : $('#editotop_price').val(),
				otop_description : $('#editotop_description').val(),
				latitute : $('#editotop_latitute').val(),
				longitute : $('#editotop_longitute').val()
			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/saveOtop.do?editUserId="
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

	function setEditOtop(otopId) {

		var obj = {
			otopId : otopId
		};

		$.ajax({
			url : "../NanglaeGov/findOtop.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editOtopId").val(data.otopId);
				$("#editotop_name").val(data.otop_name);
				$("#editotop_tel").val(data.tel);
				$("#editotop_price").val(data.otop_price);
				$("#editotop_description").val(data.otop_description);
				$("#editotop_latitute").val(data.latitute);
				$("#editotop_longitute").val(data.longitute);
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
</script>
</head>

<body onload="listOtop();getCurrentYear()">

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
	</div>
	<div id="page-wrapper" style="background-color: #d7f0f5">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">โอทอป</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.panel-heading -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#listOtop" data-toggle="tab">ข้อมูลโอทอป</a>
							</li>
							<li><a href="#addOtop" data-toggle="tab">เพิ่มข้อมูลโอทอป</a>
							</li>
						</ul>
						<div class="panel-body">
							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane fade in active" id="listOtop">
									<div class="table-responsive">
										<table id="resultTable"
											class="table table-striped table-bordered table-hover">
											<!-- Start change table -->
											<thead>
												<tr>
													<th>ชื่อสินค้า</th>
													<th>ราคา (บาท)</th>
													<th>เบอร์โทรศัพท์</th>
													<th>รายละเอียด</th>
													<th>ละดิจูด</th>
													<th>ลองจิจูด</th>
													<th style="text-align: center;">ตัวเลือก</th>
												</tr>
											</thead>
											<tbody id="listOtops">
											</tbody>
											<!-- End change table -->
										</table>
									</div>
								</div>
								<div class="tab-pane fade" id="addOtop">
									<form role="form">
										<%
											Object userid = session.getAttribute("user");
										%>
										<input type="hidden" id="userId" value="<%=userid%>">
										<table width="50%" align="center">
											<tr>
												<td style="padding: 15px">ชื่อสินค้า <font color="red"
													size="3">*</font></td>
												<td><input id="otop_name" maxlength="50"
													class="form-control" placeholder="ระบุชื่อสินค้า"
													name="otop_name"></td>
											</tr>
											<tr>
												<td style="padding: 15px">ราคา <font color="red"
													size="3">*</font></td>
												<td><input id="otop_price" data-mask="0000"
													class="form-control" placeholder="ระบุราคาสินค้า"
													name="otop_price"></td>
												<td style="padding-left: 10px">บาท</td>
											</tr>
											<tr>
												<td style="padding: 15px">เบอร์โทรศัพท์ <font
													color="red" size="3">*</font></td>
												<td><input id="otop_tel" data-mask="000-000-0000"
													class="form-control" placeholder="ระบุเบอร์โทรศัพท์"></td>
											</tr>
											<tr>
												<td style="padding: 15px">รายละเอียด <font color="red"
													size="3">*</font></td>
												<td><input id="otop_description" maxlength="100"
													class="form-control" placeholder="ระบุรายละเอียด"
													name="otop_description"></td>
											</tr>
											<tr>
												<td style="padding: 15px">ละดิจูด</td>
												<td><input id="otop_latitute" class="form-control"
													data-mask="00.0000000" placeholder="ระบุละดิจูด"
													name="otop_latitute"></td>
											</tr>
											<tr>
												<td style="padding: 15px">ลองจิจูด</td>
												<td><input id="otop_longitute" data-mask="00.0000000"
													class="form-control" placeholder="ระบุลองจิจูด"
													name="otop_longitute"></td>
											</tr>
											<tr>
												<td></td>
												<td align="center" style="padding: 15px">
													<button style="width: 100px" type="reset"
														class="btn btn-warning">ล้างข้อมูล</button> <input
													style="width: 100px" type="button" class="btn btn-success"
													value="บันทึก" onclick="createOtop()" />
												</td>
											</tr>
										</table>
									</form>
								</div>
								<div class="tab-pane fade" id="editOtop">
									<form role="form">
										<%
											Object edituserid = session.getAttribute("edituser");
										%>
										<input type="hidden" id="editUserId" value="<%=edituserid%>">
										<input type="hidden" id="editOtopId">
										<table width="50%" align="center">
											<tr>
												<td style="padding: 15px">ชื่อสินค้า <font color="red"
													size="3">*</font></td>
												<td><input id="editotop_name" maxlength="50"
													class="form-control" placeholder="" name="editotop_name"
													required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">ราคา <font color="red"
													size="3">*</font></td>
												<td><input id="editotop_price" data-mask="0000"
													class="form-control" placeholder="ระบุราคาสินค้า" name="editotop_price"></td>
												<td style="padding-left: 10px">บาท</td>
											</tr>
											<tr>
												<td style="padding: 15px">เบอร์โทรศัพท์ <font
													color="red" size="3">*</font></td>
												<td><input id="editotop_tel" data-mask="000-000-0000"
													class="form-control" placeholder="ระบุเบอร์โทรศัพท์"
													name="editotop_tel"></td>
											</tr>
											<tr>
												<td style="padding: 15px">รายละเอียด <font color="red"
													size="3">*</font></td>
												<td><input id="editotop_description" maxlength="100"
													class="form-control" placeholder="ระบุรายละเอียด"></td>
											</tr>
											<tr>
												<td style="padding: 15px">ละดิจูด <font
													color="red" size="3">*</font></td>
												<td><input id="editotop_latitute" class="form-control"
													data-mask="00.0000000" placeholder="ระบุละดิจูด"
													name="editotop_latitute"></td>
											</tr>
											<tr>
												<td style="padding: 15px">ลองจิจูด <font
													color="red" size="3">*</font></td>
												<td><input id="editotop_longitute" class="form-control"
													data-mask="00.0000000" placeholder="ระบุลองจิจูด"
													name="editotop_longitute"></td>
											</tr>
											<tr>
												<td></td>
												<td align="center" style="padding: 15px"><a
													href="#listOtop" data-toggle="tab"><button
															style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
													<input style="width: 100px" type="button"
													class="btn btn-success" value="บันทึก" onclick="editOtop()" /></td>
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
	<!-- Mask plug in -->
	<script src="../NanglaeGov/js/jquery.mask.js"></script>
	<script src="../NanglaeGov/js/jquery.mask.min.js"></script>
</body>

</html>
