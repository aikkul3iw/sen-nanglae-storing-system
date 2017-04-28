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

<title>เทศบาลตำบลนางแล</title>

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
	function listWater() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listWater.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {
							html += "<tr>";
							html += "<td>"
									+ data[i].water_year
									+ "</td>"
									+ "<td>"
									+ data[i].water_name
									+ "</td>"
									+ "<td>"
									+ data[i].water_type
									+ "</td>"
									+ "<td>"
									+ "หมู่ที่ "
									+ data[i].location.vil_number
									+ " บ้าน"
									+ data[i].location.vil_name
									+ "</td>"

							html += "</tr>";
						}
						$('#listWaters').html(html);
						$("#resultTable").DataTable({});
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
	function createWater() {
		$("#loader").show();
		if ($('#water_year').val() == "") {
			document.getElementById('water_year').style.borderColor = "red";
			return false;
		} else if ($('#water_name').val() == "") {
			document.getElementById('water_name').style.borderColor = "red";
			return false;
		} else if ($('#water_type').val() == "") {
			document.getElementById('water_type').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				water_id : 0,
				water_year : $('#water_year').val(),
				water_name : $('#water_name').val(),
				water_type : $('#water_type').val()

			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/saveWater.do?id=" + $("#villageSelect").val(),
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
	function deleteWater() {
		var id = document.getElementById("water_id").value;
		var obj = {
			water_id : id

		};
		$.ajax({
			url : "../NanglaeGov/deleteWater.do",
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
	function editWater() {
		var obj = {
			water_id : $("#editId").val(),
			water_year : $('#editWaterYear').val(),
			water_name : $('#editWaterName').val(),
			water_type : $('#editWaterType').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveWater.do?id=" + $("#editVillageSelect").val(),
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
	function setEditWater(water_id) {

		var obj = {
			water_id : water_id
		};

		$.ajax({
			url : "../NanglaeGov/findWater.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editId").val(data.water_id);
				$("#editWaterYear").val(data.water_year);
				$("#editWaterName").val(data.water_name);
				$("#editWaterType").val(data.water_type);
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

<body onload="listWater();listVillage();editVillageSelect();">

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
										<li><a href="nonForrestresource.do">ทรัพยากรณ์ป่าไม้</a></li>
									</ul></li>
								<li><a href="nonPolution.do">มลพิษ</a></li>
							</ul> <!-- /.nav-second-level --></li>
					</ul>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
			<!-- /.navbar-static-side -->
		</nav>
	</div>
	<div id="page-wrapper" style="background-color: #d7f0f5">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">ทรัพยากรน้ำ</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.panel-heading -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#listResourceWater"
								data-toggle="tab">ทรัพยากรน้ำ</a></li>
						</ul>
						<div class="panel-body">

							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane fade in active" id="listResourceWater">
									พ.ศ. <select>
										<option value="2558">2558</option>
										<option value="2559">2559</option>
									</select> <br>
									<br>
									<div class="table-responsive">
										<table id="resultTable"
											class="table table-striped table-bordered table-hover">
<!-- Start change table -->
												<thead>
													<tr>
														<th>ปีข้อมูล</th>
														<th>ชื่อแหล่งน้ำ</th>
														<th>ประเภท</th>
														<th>ที่ตั้ง</th>
													</tr>
												</thead>
												<tbody id="listWaters">
												</tbody>
<!-- End change table -->
										</table>
									</div>
								</div>
								<div class="tab-pane fade" id="listResourceSoli">
									พ.ศ. <select>
										<option value="2558">2558</option>
										<option value="2559">2559</option>
									</select> <br>
									<br>
									<div class="table-responsive">
										<table class="table table-striped table-bordered table-hover">
											<thead>
												<tr>
													<th>ดิน</th>
													<th>บริเวรที่ตั้ง</th>
													<th>การใช้ประโยนช์</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>ดินแดงปนดิ</td>
													<td>ทิศตะวันตกบริเวรป่าสงวน</td>
													<td>พื้นที่ทำการเกษตร</td>
												</tr>
												<tr>
													<td>ดินร่วนปนทราย</td>
													<td>ทิศตะวันตกบริเวรป่าสงวน</td>
													<td>พื้นที่ทำการเกษตร</td>
												</tr>
												<tr>
													<td>ดินที่สูงที่ราบสูง</td>
													<td>ทิศตะวันตกบริเวรป่าสงวน</td>
													<td>พื้นที่ทำการเกษตร</td>
												</tr>
												<tr>
													<td>ดินปนหิน</td>
													<td>ทิศตะวันตกบริเวรป่าสงวน</td>
													<td>พื้นที่ทำการเกษตร</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<div class="tab-pane fade" id="listResourceWood">
									พ.ศ. <select>
										<option value="2558">2558</option>
										<option value="2559">2559</option>
									</select> <br>
									<br>
									<div class="table-responsive">
										<table class="table table-striped table-bordered table-hover">
											<thead>
												<tr>
													<th>ป่าไม้</th>
													<th>บริเวรที่ตั้ง</th>
													<th>การใช้ประโยนช์</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>ป่าสงวนแห่งชาติ</td>
													<td>หมู่ที่ 7</td>
													<td>แหล่งต้นน้ำ และทรัพยากรที่อุดมสมบูรณ์</td>
												</tr>
											</tbody>
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
	<script src="//cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="../NanglaeGov/dist/js/sb-admin-2.js"></script>

	<!-- Page-Level Demo Scripts - Tables - Use for reference -->
	<script>
		$(document).ready(function() {
			$('#dataTables-example').DataTable({
				responsive : true
			});
		});

		function openDeleteModal(id) {
			$('#water_id').val($(id).data('id'));
			$('#DeleteModal').modal('show');
		}
	</script>

</body>

</html>
