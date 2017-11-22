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

	
	function listRestaurant() {
		$("#loader").show();

		$
				.ajax({
					url : "../NanglaeGov/listRestaurant.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {

							var id = data[i].restaurantId;

							html += "<tr>";
							html += "<td>"
									+ data[i].res_name
									+ "</td>"
									+ "<td>"
									+ data[i].res_menu
									+ "</td>"
									+ "<td>"
									+ data[i].latitute
									+ "</td>"
									+ "<td>"
									+ data[i].longitute
									+ "</td>"
									+ "<td>"
									+ data[i].houseId
									+ "</td>"
									+ "<td>"
									+ "หมู่ที่ "
									+ data[i].location.vil_number
									+ " บ้าน"
									+ data[i].location.vil_name
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editRestaurant\" data-toggle=\"tab\" onclick=\"setEditRestaurant("
									+ data[i].restaurantId
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteRestaurant("
									+ data[i].restaurantId
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"

							html += "</tr>";
						}
						$('#listRestaurant').html(html);
						$(document).ready(function() {
							var table = $('#resultTable').DataTable({
								lengthChange : false,
								buttons : ['excel',{extend : 'pdf',exportOptions : {
								columns : [ 0, 1, 2, 3, 4, 5, 6 ]},customize : function(doc) {
								doc.defaultStyle['font'] = 'THSarabun';
										}
									},
								],language: {
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
	function createRestaurant() {
		$("#loader").show();
		if ($('#res_name').val() == "") {
			document.getElementById('res_name').style.borderColor = "red";
			return false;
		} else if ($('#res_menu').val() == "") {
			document.getElementById('res_menu').style.borderColor = "red";
			return false;
		} else if ($('#latitute').val() == "") {
			document.getElementById('latitute').style.borderColor = "red";
			return false;
		} else if ($('#longitute').val() == "") {
			document.getElementById('longitute').style.borderColor = "red";
			return false;
		} else if ($('#houseId').val() == "") {
			document.getElementById('houseId').style.borderColor = "red";
			return false;
		}  else {
			var obj = {
					restaurantId : 0,
					res_name : $('#res_name').val(),
					res_menu : $('#res_menu').val(),
					latitute : $('#latitute').val(),
					longitute : $('#longitute').val(),
					houseId : $('#houseId').val()
			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/saveRestaurant.do?id=" + $("#villageSelect").val(),
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

	function deleteRestaurant(restaurantId) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
		var id = restaurantId;
		var obj = {
				restaurantId : id
		};

		$.ajax({
			url : "../NanglaeGov/deleteRestaurant.do",
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
	function editRestaurant() {
		var obj = {
				restaurantId : $('#editRestaurantId').val(),
				res_name : $('#editres_name').val(),
				res_menu : $('#editres_menu').val(),
				latitute : $('#editlatitute').val(),
				longitute : $('#editlongitute').val(),
				houseId : $('#edithouseId').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveRestaurant.do?id=" + $("#editVillageSelect").val(),
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

	function setEditRestaurant(restaurantId) {

		var obj = {
				restaurantId : restaurantId
		};

		$.ajax({
			url : "../NanglaeGov/findRestaurant.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editRestaurantId").val(data.restaurantId);
				$("#editres_name").val(data.res_name);
				$("#editres_menu").val(data.res_menu);
				$("#editlatitute").val(data.latitute);
				$("#editlongitute").val(data.longitute);
				$("#edithouseId").val(data.houseId);
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

<body onload="listRestaurant();listVillage();editVillageSelect();">

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

			<%@include file="userMenu.jsp" %>
		</nav>
	</div>
	<div id="page-wrapper" style="background-color: #d7f0f5">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Restaurant</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.panel-heading -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#listResInfor" data-toggle="tab">ข้อมูล ร้านอาหาร</a>
							</li>
							<li><a href="#addRestaurant" data-toggle="tab">เพิ่ม ร้านอาหาร</a>
							</li>
						</ul>
						<div class="panel-body">

							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane fade in active" id="listResInfor">
									<div class="table-responsive">
										<table id="resultTable"
											class="table table-striped table-bordered table-hover">
<!-- Start change table -->
												<thead>
													<tr>
														<th>ชื่อ</th>
														<th>เมนูแนะนำ</th>
														<th>ละติจูด</th>
														<th>ลองจิจูด</th>
														<th>เลขที่ตั้ง</th>
														<th>หมูบ้านที่ตั้งที่ตั้ง</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listRestaurant">
												</tbody>
<!-- End change table -->
										</table>
									</div>
								</div>
								<div class="tab-pane fade" id="addRestaurant">
									<form role="form">
										<table width="70%" align="center">
											<tr>
												<td style="padding: 15px">ชื่อ</td>
												<td><input id="res_name" maxlength="50"
													class="form-control" placeholder="" name="res_name"
													required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">เมนูแนะนำ</td>
												<td><input id="res_menu" maxlength="10"
														class="form-control" placeholder=""
														name="res_menu" required="true"></td>
											</tr>
											
											<tr>
												<td style="padding: 15px">ละดิจูด</td>
												<td><input id="latitute" maxlength="100"
														class="form-control" placeholder=""
														name="latitute" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">ลองติจูด</td>
												<td><input id="longitute" maxlength="100"
														class="form-control" placeholder=""
														name="longitute" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">เลขที่ตั้ง</td>
												<td><input id="houseId" maxlength="100"
														class="form-control" placeholder=""
														name="houseId" required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">หมูบ้านที่ตั้ง</td>
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
													value="บันทึก" onclick="createRestaurant()" />
												</td>
											</tr>
										</table>
									</form>
								</div>
								<div class="tab-pane fade" id="editRestaurant">
									<form role="form">
										<input type="hidden" id="editRestaurantId">
										<table width="65%" align="center">
											<tr>
												<td style="padding: 15px">ชื่อ</td>
												<td><input id="editres_name" maxlength="50"
													class="form-control" placeholder="" name="editres_name"
													required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">เมนูแนะนำ</td>
												<td><input id="editres_menu" maxlength="10"
														class="form-control" placeholder=""
														name="editres_menu" required="true"></td>
											</tr>
											
											<tr>
												<td style="padding: 15px">ละดิจูด</td>
												<td><input id="editlatitute" maxlength="100"
														class="form-control" placeholder=""
														name="editlatitute" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">ลองติจูด</td>
												<td><input id="editlongitute" maxlength="100"
														class="form-control" placeholder=""
														name="editlongitute" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">เลขที่ตั้ง</td>
												<td><input id="edithouseId" maxlength="100"
														class="form-control" placeholder=""
														name="edithouseId" required="true"></td>
											</tr>
											<tr>
												<td align="pull-right" style="padding: 15px">หมูบ้านที่ตั้ง</td>
												<td><select id="editVillageSelect" class="form-control"
													name="edu-location">
												</select></td>
											</tr>
											
											<tr>
												<td></td>
												<td align="center" style="padding: 15px"><a
													href="#listResInfor" data-toggle="tab"><button
															style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
													<input style="width: 100px" type="button"
													class="btn btn-success" value="บันทึก"
													onclick="editRestaurant()" /></td>
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
