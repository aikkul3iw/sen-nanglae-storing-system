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
							html += "<tr>";
							html += "<td>"
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
						$('#listPersonnels').html(html);
						$("#resultTable").DataTable({language: {
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
					$("#loader").hide();
				},
				error : function(data, status, er) {
					alert('ไม่สามารถโหลดข้อมูลได้');
					$("#loader").hide();
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

			<%@include file="nonMenu.jsp" %>
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
