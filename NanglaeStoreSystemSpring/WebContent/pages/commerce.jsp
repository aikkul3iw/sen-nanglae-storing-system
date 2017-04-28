<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>www.Nanglae.com</title>

<!-- Bootstrap Core CSS -->
<link href="../NanglaeGov/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="../NanglaeGov/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

<!-- DataTables CSS -->
<link href="../NanglaeGov/vendor/datatables-plugins/dataTables.bootstrap.css"
	rel="stylesheet">

<!-- DataTables Responsive CSS -->
<link href="../NanglaeGov/vendor/datatables-responsive/dataTables.responsive.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="../NanglaeGov/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="../NanglaeGov/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script type='text/javascript' src="../NanglaeGov/js/jquery.js"></script>
<script type='text/javascript'>
	function listCommerce() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listCommerce.do",
					type : "POST",
					success : function(data) {
						var html = '';

						for (var i = 0; i < data.length; i++) {
							html += "<tr>";
							html += "<td>"
									+ data[i].com_year
									+ "</td>"
									+ "<td>"
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
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button data-toggle=\"modal\" data-id="
									+ data[i].com_id
									+ " onclick=\"openDeleteModal(this);\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>";
							html += "</tr>";
						}
						$('#listCommerces').html(html);
						$("#resultTable").DataTable({

							dom : 'Bfrtip',
							buttons : [ {
								extend : 'pdfHtml5',
								exportOptions : {
									columns : [ 0, 1, 2, 3, 4 ]
								},
								customize : function(doc) {
									doc.defaultStyle['font'] = 'THSarabun';
								}
							},'excelHtml5'
							 ]
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
	function createCommerce() {
		$("#loader").show();
		var obj = {
			com_id : 0,
			com_year : $('#com_year').val(),
			com_name : $('#com_name').val(),
			com_type : $('#com_type').val(),
			com_house_number : $('#com_house_number').val(),
			com_description : $('#com_description').val()

		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveCommerce.do?id=" + $("#villageSelect").val(),
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert('success');
				$("#loader").hide();
				location.reload();
			},
			error : function(data, status, er) {
				alert('error');
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
	function deleteCommerce() {
		var id = document.getElementById("com_id").value;
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
	}
	function editCommerce() {
		var obj = {
			com_id : $("#editComId").val(),
			com_year : $('#editComYear').val(),
			com_name : $('#editComName').val(),
			com_type : $('#editComType').val(),
			com_house_number : $('#editComHouseNumber').val(),
			com_description : $('#editComDescription').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveCommerce.do?id=" + $("#editVillageSelect").val(),
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert('success');
				location.reload();
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
				$("#editComYear").val(data.com_year);
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

<body onload="listCommerce();listVillage();editVillageSelect();">

	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.html">เทศบาลตำบลนางแล</a>
			</div>
			<!-- /.navbar-header -->

			<ul class="nav navbar-top-links navbar-right">
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"> <i
						class="fa fa-envelope fa-fw"></i> <i class="fa fa-caret-down"></i>
				</a>
					<ul class="dropdown-menu dropdown-messages">
						<li><a href="#">
								<div>
									<strong>John Smith</strong> <span class="pull-right text-muted">
										<em>Yesterday</em>
									</span>
								</div>
								<div>Lorem ipsum dolor sit amet, consectetur adipiscing
									elit. Pellentesque eleifend...</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<strong>John Smith</strong> <span class="pull-right text-muted">
										<em>Yesterday</em>
									</span>
								</div>
								<div>Lorem ipsum dolor sit amet, consectetur adipiscing
									elit. Pellentesque eleifend...</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<strong>John Smith</strong> <span class="pull-right text-muted">
										<em>Yesterday</em>
									</span>
								</div>
								<div>Lorem ipsum dolor sit amet, consectetur adipiscing
									elit. Pellentesque eleifend...</div>
						</a></li>
						<li class="divider"></li>
						<li><a class="text-center" href="#"> <strong>Read
									All Messages</strong> <i class="fa fa-angle-right"></i>
						</a></li>
					</ul> <!-- /.dropdown-messages --></li>
				<!-- /.dropdown -->
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"> <i class="fa fa-tasks fa-fw"></i>
						<i class="fa fa-caret-down"></i>
				</a>
					<ul class="dropdown-menu dropdown-tasks">
						<li><a href="#">
								<div>
									<p>
										<strong>Task 1</strong> <span class="pull-right text-muted">40%
											Complete</span>
									</p>
									<div class="progress progress-striped active">
										<div class="progress-bar progress-bar-success"
											role="progressbar" aria-valuenow="40" aria-valuemin="0"
											aria-valuemax="100" style="width: 40%">
											<span class="sr-only">40% Complete (success)</span>
										</div>
									</div>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<p>
										<strong>Task 2</strong> <span class="pull-right text-muted">20%
											Complete</span>
									</p>
									<div class="progress progress-striped active">
										<div class="progress-bar progress-bar-info" role="progressbar"
											aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"
											style="width: 20%">
											<span class="sr-only">20% Complete</span>
										</div>
									</div>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<p>
										<strong>Task 3</strong> <span class="pull-right text-muted">60%
											Complete</span>
									</p>
									<div class="progress progress-striped active">
										<div class="progress-bar progress-bar-warning"
											role="progressbar" aria-valuenow="60" aria-valuemin="0"
											aria-valuemax="100" style="width: 60%">
											<span class="sr-only">60% Complete (warning)</span>
										</div>
									</div>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<p>
										<strong>Task 4</strong> <span class="pull-right text-muted">80%
											Complete</span>
									</p>
									<div class="progress progress-striped active">
										<div class="progress-bar progress-bar-danger"
											role="progressbar" aria-valuenow="80" aria-valuemin="0"
											aria-valuemax="100" style="width: 80%">
											<span class="sr-only">80% Complete (danger)</span>
										</div>
									</div>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a class="text-center" href="#"> <strong>See
									All Tasks</strong> <i class="fa fa-angle-right"></i>
						</a></li>
					</ul> <!-- /.dropdown-tasks --></li>
				<!-- /.dropdown -->
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"> <i class="fa fa-bell fa-fw"></i>
						<i class="fa fa-caret-down"></i>
				</a>
					<ul class="dropdown-menu dropdown-alerts">
						<li><a href="#">
								<div>
									<i class="fa fa-comment fa-fw"></i> New Comment <span
										class="pull-right text-muted small">4 minutes ago</span>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<i class="fa fa-twitter fa-fw"></i> 3 New Followers <span
										class="pull-right text-muted small">12 minutes ago</span>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<i class="fa fa-envelope fa-fw"></i> Message Sent <span
										class="pull-right text-muted small">4 minutes ago</span>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<i class="fa fa-tasks fa-fw"></i> New Task <span
										class="pull-right text-muted small">4 minutes ago</span>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a href="#">
								<div>
									<i class="fa fa-upload fa-fw"></i> Server Rebooted <span
										class="pull-right text-muted small">4 minutes ago</span>
								</div>
						</a></li>
						<li class="divider"></li>
						<li><a class="text-center" href="#"> <strong>See
									All Alerts</strong> <i class="fa fa-angle-right"></i>
						</a></li>
					</ul> <!-- /.dropdown-alerts --></li>
				<!-- /.dropdown -->
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
						<li><a href="login.html"><i class="fa fa-sign-out fa-fw"></i>
								ออกจากระบบ</a></li>
					</ul> <!-- /.dropdown-user --></li>
				<!-- /.dropdown -->
			</ul>
			<!-- /.navbar-top-links -->

			<!-- / .menu slide bar -->
			<%@include file="menu.jsp" %>
		</nav>
		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">การพาณิชย์</h1>
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
									data-toggle="tab">ข้อมูลการพาณิชย์</a></li>
								<li><a href="#addCommerce" data-toggle="tab">เพิ่มการพาณิชย์</a>
								</li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->

								<div class="tab-content">
									<div class="tab-pane fade in active" id="listCommerce">
										พ.ศ. <select>
											<option value="2558">2558</option>
											<option value="2559">2559</option>
										</select> <br> <br>
										<div class="table-responsive">
											<table id="resultTable"
												class="table table-striped table-bordered table-hover">
<!-- Start change table -->
												<thead>
													<tr>
														<th>ปีที่ข้อมูล</th>
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
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input id="com_year" maxlength="4"
														class="form-control" placeholder="" value="2558"
														name="vil-year"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">ชื่อ</td>
													<td><input id="com_name" maxlength="100"
														class="form-control" placeholder="ระบุชื่อการพาณิชย์"
														name="vil-number" required="true"></td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ประเภท</td>
													<td><select id="com_type" class="form-control"
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
													<td><input id="com_house_number" maxlength="7"
														class="form-control" placeholder="ระบุเลขที่ตั้ง"
														name="vil-number" required="true"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">หมู่บ้านที่ตั้ง</td>
													<td><select id="villageSelect" class="form-control"
														placeholder="" name="vil-name" required="true">

													</select></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">รายละเอียด</td>
													<td><textarea id="com_description" maxlength="255"
															class="form-control"
															placeholder="ระบุรายละเอียดเพิ่มเติม" name="vil-number"
															required="true"></textarea></td>

												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px">
														<button style="width: 100px" type="reset"
															class="btn btn-warning">ล้างข้อมูล</button> <input
														style="width: 100px" type="button" class="btn btn-success"
														value="บันทึก" onclick="createCommerce()" />
													</td>
												</tr>
											</table>
										</form>
									</div>
									<!-- Start modal -->
									<div>
										<div class="modal fade" id="DeleteModal" tabindex="-1"
											role="dialog" aria-labelledby="myModalLabel"
											aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<button type="button" class="close" data-dismiss="modal"
															aria-hidden="true">&times;</button>
														<h4 class="modal-title" id="H3">-----
															ยืนยันการลบข้อมูล !! -----</h4>
													</div>
													<div class="modal-body">
														<p>คุณต้องการลบข้อมูลชุดนี้?</p>
														<input type="hidden" name="com_id" id="com_id" value="" />
													</div>

													<div class="modal-footer">
														<button type="button" class="btn btn-default"
															data-dismiss="modal">ยกเลิก</button>
														<button type="button" id="deleteCommerce"
															class="btn btn-danger" onclick="deleteCommerce();">ลบข้อมูล</button>

													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- End modal -->
									<div class="tab-pane fade" id="editCommerce">
										<form role="form">
											<input type="hidden" id="editComId">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input id="editComYear" maxlength="4"
														class="form-control" placeholder="" value="2558"
														name="vil-year"></td>
												</tr>
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
		<script src="../NanglaeGov/vendor/datatables/js/jquery.dataTables.min.js"></script>
		<script
			src="https://cdn.datatables.net/buttons/1.2.4/js/dataTables.buttons.min.js"></script>
		<script
			src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.24/build/pdfmake.min.js"></script>
		<script src="../NanglaeGov/vendor/datatables/js/vfs_fonts.js"></script>
		<script
			src="//cdn.datatables.net/buttons/1.2.4/js/buttons.html5.min.js"></script>
		<script
			src="//cdn.datatables.net/buttons/1.2.4/js/buttons.print.min.js"></script>
		<script src="../NanglaeGov/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
		<script src="../NanglaeGov/vendor/datatables-responsive/dataTables.responsive.js"></script>
		<script
			src="https://cdn.datatables.net/buttons/1.2.4/js/buttons.bootstrap.min.js"></script>
		<script
			src="//cdn.datatables.net/buttons/1.2.4/js/buttons.colVis.min.js"></script>
		<script
			src="//cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>

		<!-- Custom Theme JavaScript -->
		<script src="../NanglaeGov/dist/js/sb-admin-2.js"></script>

		<!-- Page-Level Demo Scripts - Tables - Use for reference -->
		<script>
			function openDeleteModal(id) {
				$('#com_id').val($(id).data('id'));
				$('#DeleteModal').modal('show');
			}
		</script>
</body>

</html>
