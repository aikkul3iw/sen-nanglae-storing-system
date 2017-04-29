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
<link
	href="https://cdn.datatables.net/1.10.15/css/dataTables.bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.datatables.net/buttons/1.3.1/css/buttons.bootstrap.min.css"
	rel="stylesheet">


<script type='text/javascript' src="../NanglaeGov/js/jquery.js"></script>
<script type='text/javascript'>
	function listVillage() {
		$("#loader").show();
		$.ajax({
			url : "../NanglaeGov/listVillage.do",
			type : "POST",
			success : function(data) {
				var html = '';
				var year =  document.getElementById("selectedYear").value;
				for (var i = 0; i < data.length; i++) {
					if(data[i].vil_year == year){
					html += "<tr>";
					html += "<td>" + data[i].vil_year + "</td>" + "<td>"
							+ data[i].vil_number + "</td>" + "<td>"
							+ data[i].vil_name + "</td>" + "<td>"
							+ data[i].vil_chief + "</td>"
							+ "<td style=\"text-align: center;\"><button href=\"#editVillage\" data-toggle=\"tab\" onclick=\"setEditVillage("+ data[i].vil_id + ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteVillage("+data[i].vil_id+");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"
							
					html += "</tr>";
					}
				}
				$('#listVillages').html(html);
				$(document).ready(function() {
				    var table = $('#resultTable').DataTable( {
				        lengthChange: false,
				        buttons: [ 'copy', 'excel', {extend:'pdf',
				        	
							customize : function(doc) {
								doc.defaultStyle['font'] = 'THSarabun';
							}}, 'colvis']
				        });
				    table.buttons().container()
			        .appendTo( '#page-wrapper .col-sm-6:eq(0)' );
				} );

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
	function createVillage() {
		if ($('#vil_year').val() == "") {
			document.getElementById('vil_year').style.borderColor = "red";
			return false;
		} else if ($('#vil_number').val() == "") {
			document.getElementById('vil_number').style.borderColor = "red";
			return false;
		} else if ($('#vil_name').val() == "") {
			document.getElementById('vil_name').style.borderColor = "red";
			return false;
		} else if ($('#vil_chief').val() == "") {
			document.getElementById('vil_chief').style.borderColor = "red";
			return false;
		} else {
		$("#loader").show();
		var errDetectMsg = 'ไม่สามารถบันทึกข้อมูลได้';
		var errDetec = false;
		var obj = {
			vil_id : 0,
			vil_year : $('#vil_year').val(),
			vil_name : $('#vil_name').val(),
			vil_number : $('#vil_number').val(),
			vil_chief : $('#vil_chief').val()
		};
		$.ajax({
			url : "../NanglaeGov/saveVillage.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				swal({
					  title: 'บันทึกข้อมูลสำเร็จ',
					  type: 'success'
					}).then(function () {
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
	function deleteVillage(vil_id) {
		swal({
			  title: 'Are you sure?',
			  text: "You won't be able to revert this!",
			  type: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: 'Yes, delete it!'
			}).then(function () {
				var id = vil_id;
				var obj = {
					vil_id : id
				};
				$.ajax({
					url : "../NanglaeGov/deleteVillage.do",
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
	function editVillage() {
		var obj = {
			vil_id : $("#editVilId").val(),
			vil_year : $('#editVilYear').val(),
			vil_name : $('#editVilName').val(),
			vil_number : $('#editVilNumber').val(),
			vil_chief : $('#editVilChief').val()
		};

		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveVillage.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				swal({
					  title: 'บันทึกข้อมูลสำเร็จ',
					  type: 'success'
					}).then(function () {
						location.reload();
					});
			},
			error : function(data, status, er) {
				alert('ไม่สามารถบันทึกข้อมูลได้');
			}
		});
	}
	function setEditVillage(vil_id) {

		var obj = {
			vil_id : vil_id
		};

		$.ajax({
			url : "../NanglaeGov/findVillage.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editVilId").val(data.vil_id);
				$("#editVilYear").val(data.vil_year);
				$("#editVilName").val(data.vil_name);
				$("#editVilNumber").val(data.vil_number);
				$("#editVilChief").val(data.vil_chief);
			},
			error : function(data, status, er) {
				alert('ไม่สามารถโหลดข้อมูลได้');
			}
		});
	}
</script>
<script type="text/javascript">
  function validate() {
  if(vilForm.vil-number.value.length==0){
   document.getElementById("vil_number").innerHTML="this is invalid name ";
  	}
  }
  </script>
</head>

<body onload="listVillage()">

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
					class="navbar-brand" href="index.do">เทศบาลตำบลนางแล</a>
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

			<div class="navbar-default sidebar" role="navigation">
				<div class="sidebar-nav navbar-collapse">
					<ul class="nav" id="side-menu">
						<li><a href="#"><i class="fa fa-child fa-fw"></i> บุคคล<span
								class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="personnel.do">บุคลากร</a></li>
								<li><a href="population.do">ประชากร</a></li>
								<li><a href="labor.do">แรงงาน</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="fa fa-road fa-fw"></i>
								สาธารณูปโภค<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="transport.do">ระบบคมนาคมขนส่ง</a></li>
								<li><a href="electric.do">ระบบไฟฟ้า</a></li>
								<li><a href="pipeline.do">ระบบประปา</a></li>
								<li><a href="drainange.do">ระบบระบายน้ำ</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="fa fa-home fa-fw"></i>
								สาธารณุปการ<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="#">เคหะ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="village.do">หมู่บ้าน</a></li>
										<li><a href="industry.do">การอุตสาหกรรม</a></li>
										<li><a href="education.do">การศึกษา</a></li>
										<li><a href="religion.do">การศาสนา</a></li>
										<li><a href="commerce.do">การพาณิชย์</a></li>
										<li><a href="tourism.do">แหล่งท่องเที่ยว</a></li>
									</ul> <!-- /.nav-third-level --></li>
								<li><a href="#">บริการ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="health.do">การสาธารสุข</a></li>
										<li><a href="security.do">ความปลอดภัยในชีวิตและทรัพย์สิน</a>
										</li>
										<li><a href="group.do">กลุ่มในชุมชน</a></li>
										<li><a href="service.do">ศูนย์บริการประชาชน</a></li>
										<li><a href="inventory.do">การคลัง</a></li>
									</ul> <!-- /.nav-third-level --></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="glyphicon glyphicon-leaf"></i>
								ธรรมชาติและสิ่งแวดล้อม<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="agriculture.do">การเกษตรกรรม</a></li>
								<li><a href="#">ทรัพยากรธรรมชาติ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="waterresource.do">ทรัพยากรณ์น้ำ</a></li>
										<li><a href="landresource.do">ทรัพยากรณ์ดิน</a></li>
										<li><a href="forrestresource.do">ทรัพยากรณ์ป่าไม้</a></li>
									</ul></li>
								<li><a href="polution.do">มลพิษ</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="copy.do"><i class="fa fa-copy"></i>
								คัดลอกข้อมูล</a></li>
					</ul>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
		</nav>
		<div id="page-wrapper" style="background-color: #d7f0f5">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">หมู่บ้าน</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.panel-heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#listVillage" data-toggle="tab">รายชื่อหมู่บ้าน</a>
								</li>
								<li><a href="#addVillage" data-toggle="tab">เพิ่มหมู่บ้าน</a>
								</li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->
								<div class="tab-content">
									<div class="tab-pane fade in active" id="listVillage">

										<form>
											พ.ศ. <select id="selectedYear" onchange='listVillage()'>
												<option value="2558">2558</option>
												<option value="2559">2559</option>
											</select>
										</form>
										<br>
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover"
												id="resultTable">
												<!-- Start change table -->
												<thead>
													<tr>
														<th>ปีข้อมูล</th>
														<th>หมู่ที่</th>
														<th>ชื่อหมู่บ้าน</th>
														<th>ชื่อกำนัน/ผู้ใหญ่บ้าน</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listVillages">
												</tbody>
												<!-- End change table -->
											</table>
										</div>
									</div>
									<div class="tab-pane fade" id="addVillage">
										<form role="form" name="vilForm" id="formCreate">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input class="form-control" placeholder=""
														value="2558" maxlength="4" id="vil_year" name="vil-year"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">หมู่ที่</td>
													<td><input class="form-control"
														placeholder="ระบุเลขที่หมู่บ้าน" name="vil-number"
														maxlength="2" id="vil_number" required onblur="validate()"></td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ชื่อหมู่บ้าน</td>
													<td><input class="form-control"
														placeholder="ระบุชื่อหมู่บ้าน" name="vil-name"
														maxlength="50" id="vil_name" required></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ชื่อกำนัน/ผู้ใหญ่บ้าน</td>
													<td><input class="form-control"
														placeholder="ระบุชื่อผู้ใหญ่บ้าน" name="vilChief"
														maxlength="50" id="vil_chief" required></td>
												</tr>

												<tr>
													<td></td>
													<td>
														<div class="form-group">
															<div class="col-md-9 col-md-offset-3">
																<div id="messages"></div>
															</div>
														</div>
													</td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px">
														<button style="width: 100px" type="reset"
															class="btn btn-warning">ล้างข้อมูล</button> <input
														style="width: 100px" type="button" value="บันทึก"
														onclick="createVillage()" class="btn btn-success" />
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
														<input type="hidden" name="vil_id" id="vil_id" value="" />
													</div>

													<div class="modal-footer">
														<button type="button" class="btn btn-default"
															data-dismiss="modal">ยกเลิก</button>
														<button type="button" id="deleteVillage"
															class="btn btn-danger" onclick="deleteVillage();">ลบข้อมูล</button>

													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- End modal -->
									<div class="tab-pane fade" id="editVillage">
										<form role="form">
											<input type="hidden" id="editVilId">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input class="form-control" placeholder=""
														value="2558" maxlength="4" id="editVilYear"
														name="vil-year"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">หมู่ที่</td>
													<td><input class="form-control" placeholder=""
														name="vil-number" maxlength="2" id="editVilNumber"
														required=""></td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ชื่อหมู่บ้าน</td>
													<td><input class="form-control" placeholder=""
														name="vil-name" maxlength="50" id="editVilName"
														required=""></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ชื่อกำนัน/ผู้ใหญ่บ้าน</td>
													<td><input class="form-control" placeholder=""
														name="vilChief" maxlength="50" id="editVilChief"
														required=""></td>
												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px"><a
														href="#listVillage" data-toggle="tab"><button
																style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
														<input style="width: 100px" type="button" value="บันทึก"
														onclick="editVillage()" class="btn btn-success" /></td>
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
		<script
			src="https://cdn.datatables.net/buttons/1.2.4/js/dataTables.buttons.min.js"></script>
		<script
			src="//cdn.rawgit.com/bpampuch/pdfmake/0.1.24/build/pdfmake.min.js"></script>
		<script src="../NanglaeGov/vendor/datatables/js/vfs_fonts.js"></script>
		<script
			src="//cdn.datatables.net/buttons/1.2.4/js/buttons.html5.min.js"></script>
		<script
			src="//cdn.datatables.net/buttons/1.2.4/js/buttons.print.min.js"></script>
		<script
			src="../NanglaeGov/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
		<script
			src="../NanglaeGov/vendor/datatables-responsive/dataTables.responsive.js"></script>
		<script
			src="https://cdn.datatables.net/buttons/1.2.4/js/buttons.bootstrap.min.js"></script>
		<script
			src="//cdn.datatables.net/buttons/1.2.4/js/buttons.colVis.min.js"></script>
		<script
			src="//cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>

		<!-- Custom Theme JavaScript -->
		<script src="../NanglaeGov/dist/js/sb-admin-2.js"></script>
		<script src="../NanglaeGov/js/sweetalert2.min.js"></script>


</body>

</html>
