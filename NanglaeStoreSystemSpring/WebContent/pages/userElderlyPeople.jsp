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

	
	function listElderlyPeople() {
		$("#loader").show();

		$
				.ajax({
					url : "../NanglaeGov/listElderlyPeople.do",
					type : "POST",
					success : function(data) {
						var html = '';
						for (var i = 0; i < data.length; i++) {

							var id = data[i].elderPeId;

							html += "<tr>";
							html += "<td>"
									+ data[i].titles+data[i].firstName+" "+data[i].lastname
									+ "</td>"
									+ "<td>"
									+ data[i].age
									+ "</td>"
									+ "<td>"
									+ data[i].address1
									+ "</td>"
									+ "<td style=\"text-align: center;\"><button href=\"#editElderlyPeople\" data-toggle=\"tab\" onclick=\"setEditElderlyPeople("
									+ data[i].elderPeId
									+ ");\" class=\"btn btn-warning\"><i class=\"fa fa-wrench\"></i></button>&nbsp;&nbsp;<button  onclick=\"deleteElderlyPeople("
									+ data[i].elderPeId
									+ ");\" class=\"btn btn-danger\"><i class=\"fa fa-trash-o\"></i></button></td>"

							html += "</tr>";
						}
						$('#listElderlyPeoples').html(html);
						$(document).ready(function() {
							var table = $('#resultTable').DataTable({
								lengthChange : false,
								buttons : ['excel',{extend : 'pdf',exportOptions : {
								columns : [ 0, 1, 2, 3, 4, 5 ]},customize : function(doc) {
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
	function createElderlyPeople() {
		$("#loader").show();
		if ($('#title').val() == "") {
			document.getElementById('title').style.borderColor = "red";
			return false;
		} else if ($('#firstname').val() == "") {
			document.getElementById('firstname').style.borderColor = "red";
			return false;
		} else if ($('#lastname').val() == "") {
			document.getElementById('lastname').style.borderColor = "red";
			return false;
		} else if ($('#gender').val() == "") {
			document.getElementById('gender').style.borderColor = "red";
			return false;
		} else if ($('#idCard').val() == "") {
			document.getElementById('idCard').style.borderColor = "red";
			return false;
		} else if ($('#birthday').val() == "") {
			document.getElementById('birthday').style.borderColor = "red";
			return false;
		} else if ($('#age').val() == "") {
			document.getElementById('age').style.borderColor = "red";
			return false;
		} else if ($('#address1').val() == "") {
			document.getElementById('address1').style.borderColor = "red";
			return false;
		} else if ($('#address2').val() == "") {
			document.getElementById('address2').style.borderColor = "red";
			return false;
		} else if ($('#tel').val() == "") {
			document.getElementById('tel').style.borderColor = "red";
			return false;
		} else if ($('#regisDate').val() == "") {
			document.getElementById('regisDate').style.borderColor = "red";
			return false;
		} else if ($('#allowanceStartDate').val() == "") {
			document.getElementById('allowanceStartDate').style.borderColor = "red";
			return false;
		} else if ($('#offspringTitle').val() == "") {
			document.getElementById('offspringTitle').style.borderColor = "red";
			return false;
		} else if ($('#offspringFirstname').val() == "") {
			document.getElementById('offspringFirstname').style.borderColor = "red";
			return false;
		} else if ($('#offspringLastname').val() == "") {
			document.getElementById('offspringLastname').style.borderColor = "red";
			return false;
		} else if ($('#offspringIdCard').val() == "") {
			document.getElementById('offspringIdCard').style.borderColor = "red";
			return false;
		} else if ($('#allowanceEndDate').val() == "") {
			document.getElementById('allowanceEndDate').style.borderColor = "red";
			return false;
		} else if ($('#remark').val() == "") {
			document.getElementById('remark').style.borderColor = "red";
			return false;
		} else {
			
			var obj = {
					elderPeId : 0,
					titles : $('#titles').val(),
					firstName : $('#firstname').val(),
					lastName : $('#lastname').val(),
					gender : $('#gender').val(),
					idCard : $('#idCard').val(),
					birthday : $('#birthday').val(),
					age : $('#age').val(),
					address1 : $('#address1').val(),
					address2 : $('#aaddress2').val(),
					tel : $('#tel').val(),
					regisDate : $('#regisDate').val(),
					allowanceStartDate : $('#allowanceStartDate').val(),
					offspringTitle : $('#offspringTitle').val(),
					offspringFirstname : $('#offspringFirstname').val(),
					offspringLastname : $('#offspringLastname').val(),
					offspringIdCard : $('#offspringIdCard').val(),
					allowanceEndDate : $('#allowanceEndDate').val(),
					remark : $('#remark').val()
			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/saveElderlyPeople.do?user="+$('#userId').val(),
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

	function deleteElderlyPeople(elderPeId) {
		swal({
			title : 'คุณต้องการลบข้อมูลหรือไม่?',
			type : 'warning',
			showCancelButton : true,
			confirmButtonColor : '#3085d6',
			cancelButtonColor : '#d33',
			confirmButtonText : 'ตกลง',
			cancelButtonText : 'ยกเลิก'
		}).then(function() {
		var id = elderPeId;
		var obj = {
				elderPeId : id
		};

		$.ajax({
			url : "../NanglaeGov/deleteElderlyPeople.do",
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
	function editElderlyPeople() {
		var obj = {
				elderPeId : $('#editElderlyPeopleId').val(),
				titles : $('#edittitle').val(),
				firstName : $('#editfirstname').val(),
				lastName : $('#editlastname').val(),
				gender : $('#editgender').val(),
				idCard : $('#editidCard').val(),
				birthday : $('#editbirthday').val(),
				age : $('#editage').val(),
				address1 : $('#editaddress1').val(),
				address2 : $('#editaddress2').val(),
				tel : $('#edittel').val(),
				regisDate : $('#editregisDate').val(),
				allowanceStartDate : $('#editallowanceStartDate').val(),
				offspringTitle : $('#editoffspringTitle').val(),
				offspringFirstname : $('#editoffspringFirstname').val(),
				offspringLastname : $('#editoffspringLastname').val(),
				offspringIdCard : $('#editoffspringIdCard').val(),
				allowanceEndDate : $('#editallowanceEndDate').val(),
				remark : $('#editremark').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/saveElderlyPeople.do?editUserId="+$('#editUserId').val(),
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

	function setEditElderlyPeople(elderPeId) {

		var obj = {
				elderPeId : elderPeId
		};

		$.ajax({
			url : "../NanglaeGov/findElderlyPeople.do",
			type : "POST",
			dataType : "JSON",
			data : JSON.stringify(obj),
			contentType : "application/json",
			mimeType : "application/json",
			success : function(data) {
				//alert(JSON.stringify(data));
				$("#editElderlyPeopleId").val(data.elderPeId);
				$("#edittitle").val(data.titles);
				$("#editfirstname").val(data.firstName);
				$("#editlastname").val(data.lastName);
				$("#editgender").val(data.gender);
				$("#editidCard").val(data.idCard);
				$("#editbirthday").val(data.birthday);
				$("#editage").val(data.age);
				$("#editaddress1").val(data.address1);
				$("#editaddress2").val(data.address2);
				$("#edittel").val(data.tel);
				$("#editregisDate").val(data.regisDate);
				$("#editallowanceStartDate").val(data.allowanceStartDate);
				$("#editoffspringTitle").val(data.offspringTitle);
				$("#editoffspringFirstname").val(data.offspringFirstname);
				$("#editoffspringLastname").val(data.offspringLastname);
				$("#editoffspringIdCard").val(data.offspringIdCard);
				$("#editallowanceEndDate").val(data.allowanceEndDate);
				$("#editremark").val(data.remark);
			},
			error : function(data, status, er) {
				alert('error');
			}
		});
	}
</script>
</head>

<body onload="listElderlyPeople()">

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

			<%@include file="userMenu.jsp" %>
		</nav>
	</div>
	<div id="page-wrapper" style="background-color: #d7f0f5">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">ผู้สูงอายุ</h1>
			</div>
			<!-- /.col-lg-12 -->
		</div>
		<!-- /.panel-heading -->
		<div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<div class="panel-body">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#listElderlyPeople" data-toggle="tab">ข้อมูล ผู้สูงอายุ</a>
							</li>
							<li><a href="#addElderlyPeople" data-toggle="tab">เพิ่ม ผู้สูงอายุ</a>
							</li>
						</ul>
						<div class="panel-body">

							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane fade in active" id="listElderlyPeople">
									<div class="table-responsive">
										<table id="resultTable"
											class="table table-striped table-bordered table-hover">
<!-- Start change table -->
												<thead>
													<tr>
														<th>ชื่อ</th>
														<th>อายุ</th>
														<th>ที่อยู่</th>
														<th style="text-align: center;">ตัวเลือก</th>
													</tr>
												</thead>
												<tbody id="listElderlyPeoples">
												</tbody>
<!-- End change table -->
										</table>
									</div>
								</div>
								<div class="tab-pane fade" id="addElderlyPeople">
									<form role="form">
										<table width="70%" align="center">
											<tr>
												<td></td>	
												<td><select id="titles" class="form-control">
												  <option value="นาย">นาย</option>
												  <option value="นางสาว">นางสาว</option>
												  <option value="นาง">นาง</option>
												</select></td>
											</tr>
											<tr>
												<td style="padding: 15px">ชื่อ</td>
												<td><input id="firstname" maxlength="50"
													class="form-control" placeholder="" name="firstname"
													required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">นามสกุล</td>
												<td><input id="lastname" maxlength="50"
														class="form-control" placeholder=""
														name="lastname" required="true"></td>
											</tr>
											<tr>
												<td></td>
												<td>
													<select id="gender"  class="form-control">
													  <option value="volvo">ชาย</option>
													  <option value="saab">หญิง</option>
													</select>
												</td>
											</tr>
											<tr>
												<td style="padding: 15px">เลขบัตรประชาชน</td>
												<td><input id="idCard" maxlength="13"
														class="form-control" placeholder=""
														name="idCard" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">วันเกิด</td>
												<td><input type="date" id="birthday"class="form-control"
														name="birthday" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">อายุ</td>
												<td><input id="age" maxlength="100"
														class="form-control" placeholder=""
														name="age" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">ที่อยู่ตามทะเบียนบ้าน</td>
												<td><input id="address1" maxlength="100"
														class="form-control" placeholder=""
														name="address1" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">ที่อยู่ปัจจุบัน</td>
												<td><input id="aaddress2" maxlength="100"
														class="form-control" placeholder=""
														name="address2" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">เบอร์โทร</td>
												<td><input id="tel" maxlength="20"
														class="form-control" placeholder=""
														name="tel" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">วันที่ขึ้นทะเบียนผู้สูงอายุ</td>
												<td><input type="date" id="regisDate"
														class="form-control"
														name="regisDate" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">วันที่เริ่มได้รับเงินสงเคราะห์</td>
												<td><input type="date" id="allowanceStartDate"
														class="form-control"
														name="allowanceStartDate" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">ชื่อของทายาท</td>
												<td>
													<select id="offspringTitle"  class="form-control">
													  <option value="volvo">ด.ช.</option>
													  <option value="saab">ด.ญ.</option>
													  <option value="mercedes">นาย</option>
													  <option value="audi">นางสาว</option>
													  <option value="audi">นาง</option>
													</select>
												</td>
											</tr>
											<tr>
												<td style="padding: 15px">ชื่อ</td>
												<td><input id="offspringFirstname" maxlength="50"
													class="form-control" placeholder="" name="offspringFirstname"
													required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">นามสกุล</td>
												<td><input id="offspringLastname" maxlength="50"
														class="form-control" placeholder=""
														name="offspringLastname" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">เลขบัตรประชาชน</td>
												<td><input id="offspringIdCard" maxlength="13"
														class="form-control" placeholder=""
														name="offspringIdCard" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">วันสิ้นสุดรับเงินสงเคราะห์</td>
												<td><input type="date" id="allowanceEndDate"
														class="form-control"
														name="allowanceEndDate" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">หมายเหตุ</td>
												<td><textarea type="date" id="remark"
														class="form-control"
														name="remark" required="true"></textarea></td>
											</tr>
											
											<tr>
												<td></td>
												<td align="center" style="padding: 15px">
													<button style="width: 100px" type="reset"
														class="btn btn-warning">ล้างข้อมูล</button> <input
													style="width: 100px" type="button" class="btn btn-success"
													value="บันทึก" onclick="createElderlyPeople()" />
												</td>
											</tr>
										</table>
									</form>
								</div>
								<div class="tab-pane fade" id="editElderlyPeople">
									<form role="form">
										<input type="hidden" id="editElderlyPeopleId">
										<table width="65%" align="center">
											<tr>
												<td></td>	
												<td><select id="edittitle" class="form-control">
												  <option value="นาย">นาย</option>
												  <option value="นางสาว">นางสาว</option>
												  <option value="นาง">นาง</option>
												</select></td>
											</tr>
											<tr>
												<td style="padding: 15px">ชื่อ</td>
												<td><input id="editfirstname" maxlength="50"
													class="form-control" placeholder="" name="editfirstname"
													required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">นามสกุล</td>
												<td><input id="editlastname" maxlength="50"
														class="form-control" placeholder=""
														name="editlastname" required="true"></td>
											</tr>
											<tr>
												<td></td>
												<td>
													<select id="editgender"  class="form-control">
													  <option value="volvo">ชาย</option>
													  <option value="saab">หญิง</option>
													</select>
												</td>
											</tr>
											<tr>
												<td style="padding: 15px">เลขบัตรประชาชน</td>
												<td><input id="editidCard" maxlength="13"
														class="form-control" placeholder=""
														name="editidCard" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">วันเกิด</td>
												<td><input type="date" id="editbirthday"class="form-control"
														name="editbirthday" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">อายุ</td>
												<td><input id="editage" maxlength="100"
														class="form-control" placeholder=""
														name="editage" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">ที่อยู่ตามทะเบียนบ้าน</td>
												<td><input id="editaddress1" maxlength="100"
														class="form-control" placeholder=""
														name="editaddress1" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">ที่อยู่ปัจจุบัน</td>
												<td><input id="editaddress2" maxlength="100"
														class="form-control" placeholder=""
														name="editaddress2" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">เบอร์โทร</td>
												<td><input id="edittel" maxlength="20"
														class="form-control" placeholder=""
														name="edittel" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">วันที่ขึ้นทะเบียนผู้สูงอายุ</td>
												<td><input type="date" id="editregisDate"
														class="form-control"
														name="editregisDate" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">วันที่เริ่มได้รับเงินสงเคราะห์</td>
												<td><input type="date" id="editallowanceStartDate"
														class="form-control"
														name="editallowanceStartDate" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">ชื่อของทายาท</td>
												<td>
													<select id="editoffspringTitle"  class="form-control">
													  <option value="volvo">ด.ช.</option>
													  <option value="saab">ด.ญ.</option>
													  <option value="mercedes">นาย</option>
													  <option value="audi">นางสาว</option>
													  <option value="audi">นาง</option>
													</select>
												</td>
											</tr>
											<tr>
												<td style="padding: 15px">ชื่อ</td>
												<td><input id="editoffspringFirstname" maxlength="50"
													class="form-control" placeholder="" name="editoffspringFirstname"
													required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">นามสกุล</td>
												<td><input id="editoffspringLastname" maxlength="50"
														class="form-control" placeholder=""
														name="editoffspringLastname" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">เลขบัตรประชาชน</td>
												<td><input id="editoffspringIdCard" maxlength="13"
														class="form-control" placeholder=""
														name="editoffspringIdCard" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">วันสิ้นสุดรับเงินสงเคราะห์</td>
												<td><input type="date" id="editallowanceEndDate"
														class="form-control"
														name="editallowanceEndDate" required="true"></td>
											</tr>
											<tr>
												<td style="padding: 15px">หมายเหตุ</td>
												<td><textarea type="date" id="editremark"
														class="form-control"
														name="editremark" required="true"></textarea></td>
											</tr>
											<tr>
												<td></td>
												<td align="center" style="padding: 15px"><a
													href="#listElderlyPeople" data-toggle="tab"><button
															style="width: 100px" class="btn btn-danger">ยกเลิก</button></a>
													<input style="width: 100px" type="button"
													class="btn btn-success" value="บันทึก"
													onclick="editElderlyPeople()" /></td>
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
