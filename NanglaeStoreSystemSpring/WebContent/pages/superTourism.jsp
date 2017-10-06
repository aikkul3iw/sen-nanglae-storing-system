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

 <style>
       #map {
        height: 400px;
        width: 100%;
       }
    </style>

<script type='text/javascript' src="../NanglaeGov/js/jquery.js"></script>
<script type="text/javascript">
</script>
<script type='text/javascript'>
	function getCurrentYear(){
	var year = new Date();
	document.getElementById("tour_year").value=(year.getFullYear()+543);
	}
	
	function listTourism() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listTourism.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {
							html += "<tr>";
							html += "<td>"
									+ data[i].tour_year
									+ "</td>"
									+ "<td>"
									+ data[i].tour_name
									+ "</td>"
									+ "<td>"
									+ data[i].tour_description
									+ "</td>"
									+ "<td>"
									+ "หมู่ที่ "
									+ data[i].location.vil_number
									+ " บ้าน"
									+ data[i].location.vil_name
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editTourism\" data-toggle=\"tab\" onclick=\"setEditTourism("
									+ data[i].tour_id
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteTourism("
									+ data[i].tour_id
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"

							html += "</tr>";
						}
						$('#listTourisms').html(html);
						$(document).ready(function() {
							var table = $('#resultTable').DataTable({
								lengthChange : false,
								buttons : ['excel',{extend : 'pdf',exportOptions : {
								columns : [ 0, 1, 2, 3 ]},customize : function(doc) {
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

	function listPictureByTour(tour_id) {
		var id = tour_id;
		$("#loader").show();
		$.ajax({
					url : "../NanglaeGov/listPictureByTour.do?owner="+id,
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {
							html += "<img src=\"../NanglaeGov/images/"+data[i].pic_name+"\" height=\"250\" width=\"250\">";
							//alert(data[i].pic_name);
							//alert(html);
							
						}
						$('#listPicture').html(html);
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
	function createTourism() {
		$("#loader").show();
		if ($('#tour_year').val() == "") {
			document.getElementById('tour_year').style.borderColor = "red";
			return false;
		} else if ($('#tour_name').val() == "") {
			document.getElementById('tour_name').style.borderColor = "red";
			return false;
		} else if ($('#tour_description').val() == "") {
			document.getElementById('tour_description').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				tour_id : 0,
				tour_year : $('#tour_year').val(),
				tour_name : $('#tour_name').val(),
				tour_description : $('#tour_description').val(),
				latitute : $('#latitute').val(),
				longitute : $('#longitute').val()

			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/saveTourism.do?id=" + $("#villageSelect").val(),
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
	function deleteTourism(tour_id) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
		var id = tour_id;
		var obj = {
			tour_id : id

		};
		$.ajax({
			url : "../NanglaeGov/deleteTourism.do",
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
	function editTourism() {
		var obj = {
			tour_id : $("#editTourId").val(),
			tour_year : $('#editTourYear').val(),
			tour_name : $('#editTourName').val(),
			tour_description : $('#editTourDescription').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveTourism.do?id=" + $("#editVillageSelect").val(),
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
	function setEditTourism(tour_id) {

		var obj = {
			tour_id : tour_id
		};

		$.ajax({
			url : "../NanglaeGov/findTourism.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editTourId").val(data.tour_id);
				$("#editTourYear").val(data.tour_year);
				$("#editTourName").val(data.tour_name);
				$("#editTourDescription").val(data.tour_description);
				$('#editVillageSelect').val(data.location.vil_id);
				initMap(data.latitute, data.longitute);
				listPictureByTour(data.tour_id);
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

<body onload="listTourism();listVillage();editVillageSelect();getCurrentYear()">

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
					<h1 class="page-header">แหล่งท่องเที่ยว</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.panel-heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#listTourism" data-toggle="tab">ข้อมูลแหล่งท่องเที่ยว</a>
								</li>
								<li><a href="#addTourism" data-toggle="tab">เพิ่มแหล่งท่องเที่ยว</a>
								</li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->
								<div class="tab-content">
									<div class="tab-pane fade in active" id="listTourism">
										<div class="table-responsive">
											<table id="resultTable"
												class="table table-striped table-bordered table-hover">
<!-- Start change table -->
												<thead>
													<tr>
														<th>ปีที่บันทึกข้อมูล</th>
														<th>แหล่งท่องเที่ยว</th>
														<th>รายละเอียด</th>
														<th>ที่ตั้ง</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listTourisms">
												</tbody>
<!-- End change table -->
											</table>
										</div>
									</div>
									<div class="tab-pane fade" id="addTourism">
										<form role="form">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input class="form-control" maxlength="4"
														id="tour_year" placeholder="" id="cyear" value="" name="vil-year"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">ชื่อ</td>
													<td><input class="form-control" maxlength="100"
														id="tour_name" placeholder="ระบุชื่อสถานที่ท่องเที่ยว"
														name="vil-number" required="true"></td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ที่ตั้ง</td>
													<td><select class="form-control" id="villageSelect"
														placeholder="" name="vil-name" required="true">

													</select></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ละติจูต</td>
													<td><input class="form-control" maxlength="100"
														id="latitute" placeholder="ระบุละติจูต"
														name="vil-number" required="true"></td>
												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ลองจิจูต</td>
													<td><input class="form-control" maxlength="100"
														id="longitute" placeholder="ระบุลองจิจูต"
														name="vil-number" required="true"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">รายละเอียด</td>
													<td><textarea class="form-control" maxlength="255"
															id="tour_description"
															placeholder="ระบุรายละเอียดเพิ่มเติม" name="vil-number"
															required="true"></textarea></td>

												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px">
														<button style="width: 100px" type="reset"
															class="btn btn-warning">ล้างข้อมูล</button> <input
														style="width: 100px" type="button" class="btn btn-success"
														value="บันทึก" onclick="createTourism()" />
													</td>
												</tr>
											</table>
										</form>
										
										<form method="POST" action="../NanglaeGov/UploadServlet2" enctype="multipart/form-data">
											File to upload: <input type="file" name="file">
		 									Name: <input type="text" name="name">
 											<input type="submit" value="Upload"> Press here to upload the file!
										</form>	
									</div>
									<div class="tab-pane fade" id="editTourism">
										<form role="form">
											<input type="hidden" id="editTourId">
											<table width="50%" align="center">
												<tr>
													<td align="pull-right" style="padding: 15px">ปีข้อมูล</td>
													<td><input class="form-control" maxlength="4"
														id="editTourYear" placeholder="" value="2558"
														name="vil-year"></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">ชื่อ</td>
													<td><input class="form-control" maxlength="100"
														id="editTourName" placeholder="" name="vil-number"
														required="true"></td>

												</tr>
												<tr>
													<td align="pull-right" style="padding: 15px">ที่ตั้ง</td>
													<td><select class="form-control"
														id="editVillageSelect" placeholder="" name="vil-name"
														required="true">

													</select></td>
												</tr>
												<tr>

													<td align="pull-right" style="padding: 15px">รายละเอียด</td>
													<td><textarea class="form-control" maxlength="255"
															id="editTourDescription" placeholder="" name="vil-number"
															required="true"></textarea></td>

												</tr>
												<tr>
													<td></td>
													<td align="center" style="padding: 15px"><a
														href="#listTourism" data-toggle="tab"><button
																style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
														<input style="width: 100px" type="button"
														class="btn btn-success" value="บันทึก"
														onclick="editTourism()" /></td>
												</tr>
											</table>
										</form>
										<div id="map"></div>
										<div id="listPicture"></div>
										<br>
										<form method="POST" action="../NanglaeGov/UploadServlet2" enctype="multipart/form-data">
											File to upload: <input type="file" name="file">
		 									<input type="hidden" id="editTourId" value="" name="tourId">
 											<input type="submit" value="Upload"> Press here to upload the file!
										</form>	
    <script>
      function initMap(mLat,Mlng) {
        var uluru = {lat: parseFloat(mLat), lng: parseFloat(Mlng)};
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 13,
          center: uluru
        });
        var marker = new google.maps.Marker({
          position: uluru,
          map: map
        });
      }
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBGOq_1nH02n0cz1ncKIJ2zNZhPwIYWvBw&callback=initMap">
    </script>
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
