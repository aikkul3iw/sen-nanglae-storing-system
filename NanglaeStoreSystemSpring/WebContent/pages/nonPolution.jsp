<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.1.1/jquery-confirm.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.1.1/jquery-confirm.min.js"></script>


<script type='text/javascript'>
	function listPolution() {
		$("#loader").show();

		$
				.ajax({
					url : "../NanglaeGov/listPolution.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {

							var id = data[i].pol_id;
							function loader() {
								document.getElementById("myLink").innerHTML = id;
							}

							html += "<tr>";
							html += "<td>"
									+ data[i].pol_year
									+ "</td>"
									+ "<td>"
									+ data[i].pol_name
									+ "</td>"
									+ "<td>"
									+ data[i].pol_effect
									+ "</td>"
									+ "<td>"
									+ data[i].pol_area
									+ "</td>"

							html += "</tr>";
						}
						$('#listPolutions').html(html);
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
	function createPolution() {
		$("#loader").show();
		if ($('#pol_year').val() == "") {
			document.getElementById('pol_year').style.borderColor = "red";
			return false;
		} else if ($('#pol_name').val() == "") {
			document.getElementById('pol_name').style.borderColor = "red";
			return false;
		} else if ($('#pol_effect').val() == "") {
			document.getElementById('pol_effect').style.borderColor = "red";
			return false;
		} else if ($('#pol_area').val() == "") {
			document.getElementById('pol_area').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				pol_id : 0,
				pol_year : $('#pol_year').val(),
				pol_name : $('#pol_name').val(),
				pol_effect : $('#pol_effect').val(),
				pol_area : $('#pol_area').val()
			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/savePolution.do",
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

	function deletePolution() {
		var id = document.getElementById("pol_id").value;

		var obj = {
			pol_id : id
		};

		$.ajax({
			url : "../NanglaeGov/deletePolution.do",
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
	}
	function editPolution() {
		var obj = {
			pol_id : $('#editPolId').val(),
			pol_year : $('#editPolYear').val(),
			pol_name : $('#editPolName').val(),
			pol_effect : $('#editPolEffect').val(),
			pol_area : $('#editPolArea').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/savePolution.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				location.reload();
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}

	function setEditPolution(pol_id) {

		var obj = {
			pol_id : pol_id
		};

		$.ajax({
			url : "../NanglaeGov/findPolution.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editPolId").val(data.pol_id);
				$("#editPolYear").val(data.pol_year);
				$("#editPolName").val(data.pol_name);
				$("#editPolEffect").val(data.pol_effect);
				$("#editPolArea").val(data.pol_area);
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
</script>
</head>

<body onload="listPolution()">

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
	</div>
	<div id="page-wrapper" style="background-color: #d7f0f5">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">มลพิษ</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.panel-heading -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#listPolution" data-toggle="tab">ข้อมูลมลพิษ</a>
							</li>
						</ul>
						<div class="panel-body">

							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane fade in active" id="listPolution">
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
														<th>ปีที่ข้อมูล</th>
														<th>มลพิษ</th>
														<th>ผลกระทบ</th>
														<th>พิ้นที่ได้รับผลกระทบ</th>
													</tr>
												</thead>
												<tbody id="listPolutions">
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
			$('#pol_id').val($(id).data('id'));
			$('#DeleteModal').modal('show');
		}
	</script>

</body>

</html>