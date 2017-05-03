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
	function numberWithCommas(x) {
		var parts = x.toString().split(".");
		parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return parts.join(".");
	}
	function listInventory() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listInventory.do",
					type : "POST",
					success : function(data) {
						var htmls = '';
						var html = '';
						var totalIncome = 0;
						var totalOutcome = 0;
						var balance = 0;
						for (var i = 0; i < data.length; i++) {
							if(data[i].ivn_year == year){
							totalIncome += data[i].ivn_collect
									+ data[i].ivn_gov_provide
									+ data[i].ivn_gor_purchase;
							totalOutcome += data[i].inv_outcome;
							html += "<tr>";
							html += "<td>"
									+ data[i].ivn_year
									+ "</td>"
									+ "<td>"
									+ numberWithCommas(data[i].ivn_collect)
									+ "</td>"
									+ "<td>"
									+ numberWithCommas(data[i].ivn_gov_provide)
									+ "</td>"
									+ "<td>"
									+ numberWithCommas(data[i].ivn_gor_purchase)
									+ "</td>"
									+ "<td>"
									+ numberWithCommas(data[i].inv_outcome)
									+ "</td>"

							html += "</tr>";
							}
						}
						balance = totalOutcome - totalIncome;
						htmls += "<tr>";
						htmls += "<th style=\"text-align: left\" colspan=\"2\">รายรับจริง</th>";
						var fixed_totalIncome = parseFloat(totalIncome)
								.toFixed(2);
						htmls += "<th style=\"text-align: right\" colspan=\"3\">"
								+ numberWithCommas(fixed_totalIncome) + "</th>";
						htmls += "<th colspan=\"2\">บาท</th>"
						htmls += "</tr>";
						htmls += "<tr>";
						htmls += "<th style=\"text-align: left\" colspan=\"2\">รายจ่ายจริง</th>";
						htmls += "<th style=\"text-align: right\" colspan=\"3\">"
								+ numberWithCommas(totalOutcome) + "</th>";
						htmls += "<th colspan=\"2\">บาท</th>"
						htmls += "</tr>";
						htmls += "<tr>";
						htmls += "<th style=\"text-align: left\" colspan=\"2\">เงินสะสมคงเหลือ</th>";
						var checkBalance = (balance < 0) ? balance * -1
								: balance;
						var fixed_checkBalance = parseFloat(checkBalance)
								.toFixed(2);
						htmls += "<th style=\"text-align: right\" colspan=\"3\">"
								+ numberWithCommas(fixed_checkBalance)
								+ "</th>";
						htmls += "<th colspan=\"2\">บาท</th>"
						htmls += "</tr>";
						
						$('#listInventorys').html(html);
						$("#resultTable").DataTable({});
						$('#listInventoryss').html(htmls);
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
	function createInventory() {
		$("#loader").show();
		if ($('#ivn_year').val() == "") {
			document.getElementById('ivn_year').style.borderColor = "red";
			return false;
		} else if ($('#ivn_collect').val() == "") {
			document.getElementById('ivn_collect').style.borderColor = "red";
			return false;
		} else if ($('#ivn_gov_provide').val() == "") {
			document.getElementById('ivn_gov_provide').style.borderColor = "red";
			return false;
		} else if ($('#ivn_gor_purchase').val() == "") {
			document.getElementById('ivn_gor_purchase').style.borderColor = "red";
			return false;
		} else if ($('#inv_outcome').val() == "") {
			document.getElementById('inv_outcome').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				ivn_id : 0,
				ivn_year : $('#ivn_year').val(),
				ivn_collect : $('#ivn_collect').val(),
				ivn_gov_provide : $('#ivn_gov_provide').val(),
				ivn_gor_purchase : $('#ivn_gor_purchase').val(),
				inv_outcome : $('#inv_outcome').val()

			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/saveInventory.do",
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
	function deleteInventory() {
		var id = document.getElementById("ivn_id").value;
		var obj = {
			ivn_id : id

		};
		$.ajax({
			url : "../NanglaeGov/deleteInventory.do",
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
	function editInventory() {
		var obj = {
			ivn_id : $('#editIvnId').val(),
			ivn_year : $("#editIvnYear").val(),
			ivn_collect : $('#editIvnCollect').val(),
			ivn_gov_provide : $('#editIvnGovProvide').val(),
			ivn_gor_purchase : $('#editIvnGorPurchase').val(),
			inv_outcome : $('#editInvOutcome').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveInventory.do",
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
	function setEditInventory(ivn_id) {

		var obj = {
			ivn_id : ivn_id
		};

		$.ajax({
			url : "../NanglaeGov/findInventory.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editIvnId").val(data.ivn_id);
				$("#editIvnYear").val(data.ivn_year);
				$("#editIvnCollect").val(data.ivn_collect);
				$("#editIvnGovProvide").val(data.ivn_gov_provide);
				$("#editIvnGorPurchase").val(data.ivn_gor_purchase);
				$("#editInvOutcome").val(data.inv_outcome);
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
</script>
</head>

<body onload="listInventory();">

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
					<h1 class="page-header">การคลัง</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.panel-heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#listInven" data-toggle="tab">ข้อมูลการคลัง</a>
								</li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->
								<div class="tab-content">
									<div class="tab-pane fade in active" id="listInven">
										<div class="table-responsive">
											<table id="resultTable"
												class="table table-striped table-bordered table-hover">
<!-- Start change table -->
												<thead>
													<tr>
														<th>ปีงบประมาณ</th>
														<th>รายได้จัดเก็บเอง</th>
														<th>รายได้ที่รัฐจัดสรรให้</th>
														<th>เงินอุดหนุนจากรัฐบาล</th>
														<th>รายจ่าย</th>
													</tr>
												</thead>
												<tbody id="listInventorys">
												</tbody>
<!-- End change table -->
											</table>
										</div>
										<div class="table-responsive">
											<table id="resultTables"
												class="table table-striped table-bordered table-hover">
<!-- Start change table2 -->
												<thead>
													
												</thead>
												<tbody id="listInventoryss">
												</tbody>
<!-- End change table2 -->
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
