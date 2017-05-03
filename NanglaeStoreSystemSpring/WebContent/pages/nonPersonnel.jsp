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
	function listPersonnel() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listPersonnel.do",
					type : "POST",
					success : function(data) {
						var successMsg = '';
						var errorMsg = '';
						var html = '';
						for (var i = 0; i < data.length; i++) {
							if(data[i].per_year == year){
							html += "<tr>";
							html += "<td>"
									+ data[i].per_year
									+ "</td>"
									+ "<td>"
									+ data[i].per_title
									+ data[i].per_firstname
									+ " "
									+ data[i].per_lastname
									+ "</td>"
									+ "<td>"
									+ data[i].per_position
									+ "</td>"
							html += "</tr>";
							}
						}
						$('#listPersonnels').html(html);
						$("#resultTable").DataTable({});
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
	function createPersonnel() {
		$("#loader").show();
		if ($('#per_year').val() == "") {
			document.getElementById('per_year').style.borderColor = "red";
			return false;
		} else if ($('#per_title').val() == "") {
			document.getElementById('per_title').style.borderColor = "red";
			return false;
		} else if ($('#per_firstname').val() == "") {
			document.getElementById('per_firstname').style.borderColor = "red";
			return false;
		} else if ($('#per_lastname').val() == "") {
			document.getElementById('per_lastname').style.borderColor = "red";
			return false;
		} else if ($('#per_position').val() == "") {
			document.getElementById('per_position').style.borderColor = "red";
			return false;
		} else if ($('#per_salary').val() == "") {
			document.getElementById('per_salary').style.borderColor = "red";
			return false;
		} else if ($('#per_tel_number').val() == "") {
			document.getElementById('per_tel_number').style.borderColor = "red";
			return false;
		} else if ($('#per_address').val() == "") {
			document.getElementById('per_address').style.borderColor = "red";
			return false;
		} else if ($('#per_email').val() == "") {
			document.getElementById('per_email').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				per_id : 0,
				per_year : $('#per_year').val(),
				per_title : $('#per_title').val(),
				per_firstname : $('#per_firstname').val(),
				per_lastname : $('#per_lastname').val(),
				per_position : $('#per_position').val(),
				per_salary : $('#per_salary').val(),
				per_tel_number : $('#per_tel_number').val(),
				per_address : $('#per_address').val(),
				per_email : $('#per_email').val(),
				per_picture : $('#per_picture').val()
			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/savePersonnel.do",
				type : "POST",
				dataType : "JSON",
				data : JSON.stringify(obj),
				contentType : "application/json",
				mimeType : "application/json",
				success : function(data) {
					//alert('บันทึกข้อมูลเสร็จสิ้น');
					successMsg = "บันทึกข้อมูลเสร้จสิ้น";
					$("#loader").hide();
					location.reload();
				},
				error : function(data, status, er) {
					alert('ไม่สามารถบันทึกข้อมูลได้');
					$("#loader").hide();
				}
			});
		}
	}
	function deletePersonnel() {
		var id = document.getElementById("per_id").value;
		var obj = {
			per_id : id

		};
		$.ajax({
			url : "../NanglaeGov/deletePersonnel.do",
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
	function editPersonnel() {
		var obj = {
			per_id : $("#editPerId").val(),
			per_year : $('#editPerYear').val(),
			per_title : $('#editPerTitle').val(),
			per_firstname : $('#editPerFirstname').val(),
			per_lastname : $('#editPerLastname').val(),
			per_position : $('#editPerPosition').val(),
			per_salary : $('#editPerSalary').val(),
			per_tel_number : $('#editPerTelNumber').val(),
			per_address : $('#editPerAddress').val(),
			per_email : $('#editPerEmail').val(),
			per_picture : $('#editPerPicture').val()
		};

		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/savePersonnel.do",
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
	function setEditPersonnel(per_id) {

		var obj = {
			per_id : per_id
		};

		$.ajax({
			url : "../NanglaeGov/findPersonnel.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editPerId").val(data.per_id);
				$("#editPerYear").val(data.per_year);
				$("#editPerTitle").val(data.per_title);
				$("#editPerFirstname").val(data.per_firstname);
				$("#editPerLastname").val(data.per_lastname);
				$("#editPerPosition").val(data.per_position);
				$("#editPerSalary").val(data.per_salary);
				$("#editPerTelNumber").val(data.per_tel_number);
				$("#editPerAddress").val(data.per_address);
				$("#editPerEmail").val(data.per_email);
				$("#editPerPicture").val(data.per_picture);
			},
			error : function(data, status, er) {
				alert('ไม่สามารถโหลดข้อมูลได้');
			}
		});
	}
</script>
</head>

<body onload="listPersonnel();">

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
				<h1 class="page-header">บุคลากร</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.panel-heading -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#listPersonnel"
								data-toggle="tab">รายชื่อบุคลากร</a></li>
						</ul>
						<div class="panel-body">

							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane fade in active" id="listPersonnel">

									<div class="table-responsive">
										<table class="table table-striped table-bordered table-hover"
											id="resultTable">
<!-- Start change table -->
												<thead>
													<tr>	
														<th>ปีที่บันทึกข้อมูล</th>
														<th>ชื่อ</th>
														<th>ตำแหน่ง</th>
													</tr>
												</thead>
												<tbody id="listPersonnels">
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

	<!-- Page-Level Demo Scripts - Tables - Use for reference -->
	<script>	
	$(document).ready(function(){
		  $('.date').mask('00/00/0000');
		  $('.time').mask('00:00:00');
		  $('.date_time').mask('00/00/0000 00:00:00');
		  $('.cep').mask('00000-000');
		  $('.phone').mask('0000-0000');
		  $('.phone_with_ddd').mask('(00) 0000-0000');
		  $('.phone_us').mask('(000) 000-0000');
		  $('.mixed').mask('AAA 000-S0S');
		  $('.cpf').mask('000.000.000-00', {reverse: true});
		  $('.cnpj').mask('00.000.000/0000-00', {reverse: true});
		  $('.money').mask('000.000.000.000.000,00', {reverse: true});
		  $('.money2').mask("#.##0,00", {reverse: true});
		  $('.ip_address').mask('0ZZ.0ZZ.0ZZ.0ZZ', {
		    translation: {
		      'Z': {
		        pattern: /[0-9]/, optional: true
		      }
		    }
		  });
		  $('.ip_address').mask('099.099.099.099');
		  $('.percent').mask('##0,00%', {reverse: true});
		  $('.clear-if-not-match').mask("00/00/0000", {clearIfNotMatch: true});
		  $('.placeholder').mask("00/00/0000", {placeholder: "__/__/____"});
		  $('.fallback').mask("00r00r0000", {
		      translation: {
		        'r': {
		          pattern: /[\/]/,
		          fallback: '/'
		        },
		        placeholder: "__/__/____"
		      }
		    });
		  $('.selectonfocus').mask("00/00/0000", {selectOnFocus: true});
		});
	
	function openDeleteModal(id) {
			$('#per_id').val($(id).data('id'));
			$('#DeleteModal').modal('show');
		}
	</script>

</body>

</html>
