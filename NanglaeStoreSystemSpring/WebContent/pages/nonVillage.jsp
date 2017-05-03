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
var year = new Date().getFullYear()+543;
	function listVillage() {
		$("#loader").show();
		$.ajax({
			url : "../NanglaeGov/listVillage.do",
			type : "POST",
			success : function(data) {
				var html = '';
				for (var i = 0; i < data.length; i++) {
					if(data[i].vil_year == year){
					html += "<tr>";
					html += "<td>" + data[i].vil_year + "</td>" + "<td>"
							+ data[i].vil_number + "</td>" + "<td>"
							+ data[i].vil_name + "</td>" + "<td>"
							+ data[i].vil_chief + "</td>"
							
					html += "</tr>";
					}
				}
				$('#listVillages').html(html);
				$('#resultTable').DataTable({});
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
				//alert('บันทึกข้อมูลเสร็จสิ้น');
				$("#loader").hide();
				location.reload();
				
			},
			error : function(data, status, er) {
				alert(errDetectMsg);
				$("#loader").hide();
			}
		});
		}
	}
	function deleteVillage() {
		var id = document.getElementById("vil_id").value;
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
				//alert('บันทึกข้อมูลเสร็จสิ้น');
				location.reload();
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

<body onload="listVillage();">

	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0;background-color: #98c3e8">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<img src="../NanglaeGov/images/logo-nanglae.png"><a class="navbar-brand"
					href="index.do">เทศบาลตำบลนางแล</a>
			</div>
			<!-- /.navbar-header -->

			<ul class="nav navbar-top-links navbar-right">
				<div class="container-fluid">
					<div class="collapse navbar-collapse"
						id="bs-example-navbar-collapse-1">
						<div class="navbar-form navbar-right">
							<a href="login.do"><button class="btn btn-primary">เข้าสู่ระบบ</button></a>
						</div>
					</div>
				</div>
			</ul>

			<div class="navbar-default sidebar" role="navigation">
				<div class="sidebar-nav navbar-collapse">
					<ul class="nav" id="side-menu">
						<li><a href="#"><i class="fa fa-child fa-fw"></i> บุคคล<span
								class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="nonPersonnel.do">บุคลากร</a></li>
								<li><a href="nonPopulation.do">ประชากร</a></li>
								<li><a href="nonLabor.do">แรงงาน</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="fa fa-home fa-fw"></i>
								สาธารณูปโภค<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="nonTransport.do">ระบบคมนาคมขนส่ง</a></li>
								<li><a href="nonElectric.do">ระบบไฟฟ้า</a></li>
								<li><a href="nonPipeline.do">ระบบประปา</a></li>
								<li><a href="nonDrainage.do">ระบบระบายน้ำ</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="fa fa-road fa-fw"></i>
								สาธารณุปการ<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="#">เคหะ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="nonVillage.do">หมู่บ้าน</a></li>
										<li><a href="nonIndustry.do">การอุตสาหกรรม</a></li>
										<li><a href="nonEducation.do">การศึกษา</a></li>
										<li><a href="nonReligion.do">การศาสนา</a></li>
										<li><a href="nonCommerce.do">การพาณิชย์</a></li>
										<li><a href="nonTourism.do">แหล่งท่องเที่ยว</a></li>
									</ul> <!-- /.nav-third-level --></li>
								<li><a href="#">บริการ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="nonHealth.do">การสาธารสุข</a></li>
										<li><a href="nonSecurity.do">ความปลอดภัยในชีวิตและทรัพย์สิน</a>
										</li>
										<li><a href="nonGroup.do">กลุ่มในชุมชน</a></li>
										<li><a href="nonService.do">ศูนย์บริการประชาชน</a></li>
										<li><a href="nonInventory.do">การคลัง</a></li>
									</ul> <!-- /.nav-third-level --></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="fa fa-tree fa-fw"></i>
								ธรรมชาติและสิ่งแวดล้อม<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="nonAgriculture.do">การเกษตรกรรม</a></li>
								<li><a href="#">ทรัพยากรธรรมชาติ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="nonWaterresource.do">ทรัพยากรณ์น้ำ</a></li>
										<li><a href="nonLandresource.do">ทรัพยากรณ์ดิน</a></li>
										<li><a href="nonForestresource.do">ทรัพยากรณ์ป่าไม้</a></li>
									</ul></li>
								<li><a href="nonPolution.do">มลพิษ</a></li>
							</ul> <!-- /.nav-second-level --></li>
					</ul>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
			<!-- /.navbar-static-side -->
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
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->
								<div class="tab-content">
									<div class="tab-pane fade in active" id="listVillage">
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
													</tr>
												</thead>
												<tbody id="listVillages">
												</tbody>
												<!-- End change table -->
											</table>
										</div>
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
