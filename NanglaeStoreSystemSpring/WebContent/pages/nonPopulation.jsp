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
	function numberWithCommas(x) {
		var parts = x.toString().split(".");
		parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return parts.join(".");
	}
	function listPopulation1() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listPopulation1.do",
					type : "POST",
					success : function(data) {
						var html = '';
						var html2 = '';
						var totalAllPopMale = 0;
						var totalAllPopFemale = 0;
						var totalAllPop = 0;
						var totalAllPopHouse = 0;
						for (var i = 0; i < data.length; i++) {
							var allMale = 0;
							var allFemale = 0;
							var allPop = 0;
							allMale = data[i].pop_thai_nation_m
									+ data[i].pop_chinese_nation_m
									+ data[i].pop_other_nation_m;
							allFemale = data[i].pop_thai_nation_f
									+ data[i].pop_chinese_nation_f
									+ data[i].pop_other_nation_f;
							allPop = allMale + allFemale;
							totalAllPopMale += data[i].pop_thai_nation_m
									+ data[i].pop_chinese_nation_m
									+ data[i].pop_other_nation_m;
							totalAllPopFemale += data[i].pop_thai_nation_f
									+ data[i].pop_chinese_nation_f
									+ data[i].pop_other_nation_f;
							totalAllPop += allPop;
							totalAllPopHouse += data[i].pop_house_amount;
							html += "<tr>";
							html += "<td>"
									+ data[i].pop_year
									+ "</td>"
									+ "<td>"
									+ data[i].location.vil_number
									+ "</td>"
									+ "<td>"
									+ data[i].location.vil_name
									+ "</td>"
									+ "<td>"
									+ allMale
									+ "</td>"
									+ "<td>"
									+ allFemale
									+ "</td>"
									+ "<td>"
									+ allPop
									+ "</td>"
									+ "<td>"
									+ "<center>"
									+ data[i].pop_house_amount
									+ "</center>"
									+ "</td>"

							html += "</tr>";
							
						}
						html2 += "<tr>";
						html2 += "<td>" + numberWithCommas(totalAllPopMale)
								+ "</td>";
						html2 += "<td>" + numberWithCommas(totalAllPopFemale)
								+ "</td>";
						html2 += "<td>" + numberWithCommas(totalAllPop)
								+ "</td>";
						html2 += "<td>"
								+ numberWithCommas(totalAllPopHouse)
								+ "</td>";
						html2 += "<tr>";
								
						$('#listPopulation11').html(html);
						$("#resultTable").DataTable({});
						$('#resultlistPopulation11').html(html2);
						$("#resultTable1").DataTable({});
						$("#loader").hide();
					},
					error : function(data, status, er) {
						alert('error');
						$("#loader").hide();
					}
				});
	}
	function listPopulationByNation() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listPopulation1.do",
					type : "POST",
					success : function(data) {
						var html3 = '';
						var html4 = '';
						
						var totalThaiM = 0;
						var totalThaiF = 0;
						var totalThai = 0;
						var totalOtherM = 0;
						var totalOtherF = 0;
						var totalOther = 0;
						var totalChineseM = 0;
						var totalChineseF = 0;
						var totalChinese = 0;
						var totalAllNationM = 0;
						var totalAllNationF = 0;
						var totalAllNation = 0;
						for (var i = 0; i < data.length; i++) {
							var thaiAll = 0;
							var otherAll = 0;
							var chineseAll = 0;
							var allM = 0;
							var allF = 0;
							var allPopNation = 0;
							thaiAll = data[i].pop_thai_nation_m
									+ data[i].pop_thai_nation_f;
							chineseAll = data[i].pop_chinese_nation_m
									+ data[i].pop_chinese_nation_f;
							otherAll = data[i].pop_other_nation_m
									+ data[i].pop_other_nation_f;
							allM = data[i].pop_thai_nation_m
									+ data[i].pop_chinese_nation_m
									+ data[i].pop_other_nation_m;
							allF = data[i].pop_thai_nation_f
									+ data[i].pop_chinese_nation_f
									+ data[i].pop_other_nation_f;
							allPopNation = allM + allF;

							totalThaiM += data[i].pop_thai_nation_m;
							totalThaiF += data[i].pop_thai_nation_f;
							totalThai += data[i].pop_thai_nation_m
									+ data[i].pop_thai_nation_f;
							totalOtherM += data[i].pop_other_nation_m;
							totalOtherF += data[i].pop_other_nation_f;
							totalOther += data[i].pop_other_nation_m
									+ data[i].pop_other_nation_f;
							totalChineseM += data[i].pop_chinese_nation_m;
							totalChineseF += data[i].pop_chinese_nation_f;
							totalChinese += data[i].pop_chinese_nation_m
									+ data[i].pop_chinese_nation_f;
							totalAllNationM += allM;
							totalAllNationF += allF;
							totalAllNation += allPopNation;

							html3 += "<tr>";
							html3 += "<td>"
									+ data[i].pop_year
									+ "</td>"
									+ "<td>"
									+ data[i].location.vil_number
									+ "</td>"
									+ "<td>"
									+ data[i].location.vil_name
									+ "</td>"
									+ "<td>"
									+ data[i].pop_other_nation_m
									+ "</td>"
									+ "<td>"
									+ data[i].pop_other_nation_f
									+ "</td>"
									+ "<td>"
									+ otherAll
									+ "</td>"
									+ "<td>"
									+ data[i].pop_thai_nation_m
									+ "</td>"
									+ "<td>"
									+ data[i].pop_thai_nation_f
									+ "</td>"
									+ "<td>"
									+ thaiAll
									+ "</td>"
									+ "<td>"
									+ data[i].pop_chinese_nation_m
									+ "</td>"
									+ "<td>"
									+ data[i].pop_chinese_nation_f
									+ "</td>"
									+ "<td>"
									+ chineseAll
									+ "</td>"
									+ "<td>"
									+ allM
									+ "</td>"
									+ "<td>"
									+ allF
									+ "</td>"
									+ "<td>"
									+ allPopNation
									+ "</td>"
							html3 += "</tr>";
						}
						html4 += "<tr>";
						html4 += "<td>" + numberWithCommas(totalOtherM)
								+ "</td>";
						html4 += "<td>" + numberWithCommas(totalOtherF)
								+ "</td>";
						html4 += "<td>" + numberWithCommas(totalOther) + "</td>";
						html4 += "<td>" + numberWithCommas(totalThaiM) + "</td>";
						html4 += "<td>" + numberWithCommas(totalThaiF) + "</td>";
						html4 += "<td>" + numberWithCommas(totalThai) + "</td>";
						html4 += "<td>" + numberWithCommas(totalChineseM)
								+ "</td>";
						html4 += "<td>" + numberWithCommas(totalChineseF)
								+ "</td>";
						html4 += "<td>" + numberWithCommas(totalChinese)
								+ "</td>";
						html4 += "<td>" + numberWithCommas(totalAllNationM)
								+ "</td>";
						html4 += "<td>" + numberWithCommas(totalAllNationF)
								+ "</td>";
						html4 += "<td>" + numberWithCommas(totalAllNation)
								+ "</td>";
						html4 += "</tr>";
								
						$('#listPopulation12').html(html3);
						$("#resultTable2-1").DataTable({});
						$('#resultlistPopulation12').html(html4);
						$("#resultTable2-2").DataTable({});
						$("#loader").hide();
					},
					error : function(data, status, er) {
						alert('error');
						$("#loader").hide();
					}
				});
	}
	function listPopulationByElection() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listPopulation1.do",
					type : "POST",
					success : function(data) {
						var html5 = '';
						var html6 = '';
						var totalElect15M = 0;
						var totalElect15F = 0;
						var totalElect15 = 0;
						var totalElect18M = 0;
						var totalElect18F = 0;
						var totalElect18 = 0;
						var totalElect20M = 0;
						var totalElect20F = 0;
						var totalElect20 = 0;
						var totalMilReg = 0;
						var totalMilJoin = 0;
						for (var i = 0; i < data.length; i++) {
							var all15 = 0;
							var all18 = 0;
							var all20 = 0;
							all15 = data[i].pop_elect15_m
									+ data[i].pop_elect15_f;
							all18 = data[i].pop_elect18_m
									+ data[i].pop_elect18_f;
							all20 = data[i].pop_elect20_m
									+ data[i].pop_elect20_f;
							totalElect15M += data[i].pop_elect15_m;
							totalElect15F += data[i].pop_elect15_f;
							totalElect15 += all15;
							totalElect18M += data[i].pop_elect18_m;
							totalElect18F += data[i].pop_elect18_f;
							totalElect18 += all18;
							totalElect20M += data[i].pop_elect20_m;
							totalElect20F += data[i].pop_elect20_f;
							totalElect20 += all20;
							totalMilReg += data[i].pop_military_select_reg;
							totalMilJoin += data[i].pop_military_select_join;
							html5 += "<tr>";
							html5 += "<td>"
									+ data[i].pop_year
									+ "</td>"
									+ "<td>"
									+ data[i].location.vil_number
									+ "</td>"
									+ "<td>"
									+ data[i].location.vil_name
									+ "</td>"
									+ "<td>"
									+ data[i].pop_elect15_m
									+ "</td>"
									+ "<td>"
									+ data[i].pop_elect15_f
									+ "</td>"
									+ "<td>"
									+ all15
									+ "</td>"
									+ "<td>"
									+ data[i].pop_elect18_m
									+ "</td>"
									+ "<td>"
									+ data[i].pop_elect18_f
									+ "</td>"
									+ "<td>"
									+ all18
									+ "</td>"
									+ "<td>"
									+ data[i].pop_elect20_m
									+ "</td>"
									+ "<td>"
									+ data[i].pop_elect20_f
									+ "</td>"
									+ "<td>"
									+ all20
									+ "</td>"
									+ "<td>"
									+ "<center>"
									+ data[i].pop_military_select_reg
									+ "</center>"
									+ "</td>"
									+ "<td>"
									+ "<center>"
									+ data[i].pop_military_select_join
									+ "</center>"
									+ "</td>"
							html5 += "</tr>";
						}
						html6 += "<tr>";
						html6 += "<td>" + numberWithCommas(totalElect15M)
								+ "</td>";
						html6 += "<td>" + numberWithCommas(totalElect15F)
								+ "</td>";
						html6 += "<td>" + numberWithCommas(totalElect15)
								+ "</td>";
						html6 += "<td>" + numberWithCommas(totalElect18M)
								+ "</td>";
						html6 += "<td>" + numberWithCommas(totalElect18F)
								+ "</td>";
						html6 += "<td>" + numberWithCommas(totalElect18)
								+ "</td>";
						html6 += "<td>" + numberWithCommas(totalElect20M)
								+ "</td>";
						html6 += "<td>" + numberWithCommas(totalElect20F)
								+ "</td>";
						html6 += "<td>" + numberWithCommas(totalElect20)
								+ "</td>";
						html6 += "<td>" + numberWithCommas(totalMilReg)
								+ "</td>";
						html6 += "<td>" + numberWithCommas(totalMilJoin)
								+ "</td>";
						html6 += "</tr>";
								
								$('#listPopulation13').html(html5);
								$("#resultTable3-1").DataTable({});
								$('#resultlistPopulation13').html(html6);
								$("#resultTable3-2").DataTable({});
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
	function createPopulation1() {
		$("#loader").show();
		if ($('#pop_year').val() == "") {
			document.getElementById('pop_year').style.borderColor = "red";
			return false;
		} else if ($('#pop_house_amount').val() == "") {
			document.getElementById('pop_house_amount').style.borderColor = "red";
			return false;
		} else if ($('#pop_thai_nation_m').val() == "") {
			document.getElementById('pop_thai_nation_m').style.borderColor = "red";
			return false;
		} else if ($('#pop_thai_nation_f').val() == "") {
			document.getElementById('pop_thai_nation_f').style.borderColor = "red";
			return false;
		} else if ($('#pop_chinese_nation_m').val() == "") {
			document.getElementById('pop_chinese_nation_m').style.borderColor = "red";
			return false;
		} else if ($('#pop_chinese_nation_f').val() == "") {
			document.getElementById('pop_chinese_nation_f').style.borderColor = "red";
			return false;
		} else if ($('#pop_other_nation_m').val() == "") {
			document.getElementById('pop_other_nation_m').style.borderColor = "red";
			return false;
		} else if ($('#pop_other_nation_f').val() == "") {
			document.getElementById('pop_other_nation_f').style.borderColor = "red";
			return false;
		} else if ($('#pop_elect15_m').val() == "") {
			document.getElementById('pop_elect15_m').style.borderColor = "red";
			return false;
		} else if ($('#pop_elect15_f').val() == "") {
			document.getElementById('pop_elect15_f').style.borderColor = "red";
			return false;
		} else if ($('#pop_elect18_m').val() == "") {
			document.getElementById('pop_elect18_m').style.borderColor = "red";
			return false;
		} else if ($('#pop_elect18_f').val() == "") {
			document.getElementById('pop_elect18_f').style.borderColor = "red";
			return false;
		} else if ($('#pop_elect20_m').val() == "") {
			document.getElementById('pop_elect20_m').style.borderColor = "red";
			return false;
		} else if ($('#pop_elect20_f').val() == "") {
			document.getElementById('pop_elect20_f').style.borderColor = "red";
			return false;
		} else if ($('#pop_military_select_reg').val() == "") {
			document.getElementById('pop_military_select_reg').style.borderColor = "red";
			return false;
		} else if ($('#pop_military_select_join').val() == "") {
			document.getElementById('pop_military_select_join').style.borderColor = "red";
			return false;
		} else {
			var obj = {
				pop_id : 0,
				pop_year : $('#pop_year').val(),
				pop_house_amount : $('#pop_house_amount').val(),
				pop_thai_nation_m : $('#pop_thai_nation_m').val(),
				pop_thai_nation_f : $('#pop_thai_nation_f').val(),
				pop_chinese_nation_m : $('#pop_chinese_nation_m').val(),
				pop_chinese_nation_f : $('#pop_chinese_nation_f').val(),
				pop_other_nation_m : $('#pop_other_nation_m').val(),
				pop_other_nation_f : $('#pop_other_nation_f').val(),
				pop_elect15_m : $('#pop_elect15_m').val(),
				pop_elect15_f : $('#pop_elect15_f').val(),
				pop_elect18_m : $('#pop_elect18_m').val(),
				pop_elect18_f : $('#pop_elect18_f').val(),
				pop_elect20_m : $('#pop_elect20_m').val(),
				pop_elect20_f : $('#pop_elect20_f').val(),
				pop_military_select_reg : $('#pop_military_select_reg').val(),
				pop_military_select_join : $('#pop_military_select_join').val()

			};
			//alert(JSON.stringify(obj));
			$.ajax({
				url : "../NanglaeGov/savePopulation1.do?id=" + $("#villageSelect").val(),
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
	function deletePopulation1() {
		var id = document.getElementById("pop_id").value;
		var obj = {
			pop_id : id

		};
		$.ajax({
			url : "../NanglaeGov/deletePopulation1.do",
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
	function editPopulation1() {
		var obj = {
			pop_id : $("#editPopId").val(),
			pop_year : $('#editPopYear').val(),
			pop_house_amount : $('#editPopHouseAmount').val(),
			pop_thai_nation_m : $('#editPopThaiNationMale').val(),
			pop_thai_nation_f : $('#editPopThaiNationFemale').val(),
			pop_chinese_nation_m : $('#editPopChineseNationMale').val(),
			pop_chinese_nation_f : $('#editPopChineseNationFemale').val(),
			pop_other_nation_m : $('#editPopOtherNationMale').val(),
			pop_other_nation_f : $('#editPopOtherNationFemale').val(),
			pop_elect15_m : $('#editPopElect15Male').val(),
			pop_elect15_f : $('#editPopElect15Female').val(),
			pop_elect18_m : $('#editPopElect18Male').val(),
			pop_elect18_f : $('#editPopElect18Female').val(),
			pop_elect20_m : $('#editPopElect20Male').val(),
			pop_elect20_f : $('#editPopElect20Female').val(),
			pop_military_select_reg : $('#editPopMilitarySelectReg').val(),
			pop_military_select_join : $('#editPopMilitarySelectJoin').val()
		};
		//alert(JSON.stringify(obj));
		$.ajax({
			url : "../NanglaeGov/savePopulation1.do?id=" + $("#editVillageSelect").val(),
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
	function setEditPopulation1(pop_id) {

		var obj = {
			pop_id : pop_id
		};

		$
				.ajax({
					url : "../NanglaeGov/findPopulation1.do",
					type : "POST",
					dataType : "JSON",
					data : JSON.stringify(obj),
					contentType : "application/json",
					mimeType : "application/json",
					success : function(data) {
						//alert(JSON.stringify(data));
						$("#editPopId").val(data.pop_id);
						$("#editPopYear").val(data.pop_year);
						$("#editPopHouseAmount").val(data.pop_house_amount);
						$("#editPopThaiNationMale").val(data.pop_thai_nation_m);
						$("#editPopThaiNationFemale").val(
								data.pop_thai_nation_f);
						$("#editPopChineseNationMale").val(
								data.pop_chinese_nation_m);
						$("#editPopChineseNationFemale").val(
								data.pop_chinese_nation_f);
						$("#editPopOtherNationMale").val(
								data.pop_other_nation_m);
						$("#editPopOtherNationFemale").val(
								data.pop_other_nation_f);
						$("#editPopElect15Male").val(data.pop_elect15_m);
						$("#editPopElect15Female").val(data.pop_elect15_f);
						$("#editPopElect18Male").val(data.pop_elect18_m);
						$("#editPopElect18Female").val(data.pop_elect18_f);
						$("#editPopElect20Male").val(data.pop_elect20_m);
						$("#editPopElect20Female").val(data.pop_elect20_f);
						$("#editPopMilitarySelectReg").val(
								data.pop_military_select_reg);
						$("#editPopMilitarySelectJoin").val(
								data.pop_military_select_join);
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

<body
	onload="listVillage();listPopulation1();listPopulationByNation();listPopulationByElection();editVillageSelect();">

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
					<h1 class="page-header">ประชากร</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.panel-heading -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-body">
							<ul class="nav nav-tabs">
								<li class="active"><a href="#listAllPop" data-toggle="tab">สถิติประชากรทั้งหมด</a>
								</li>
								<li><a href="#listNationPop" data-toggle="tab">สถิติประชากรแบ่งตามสัญชาติ</a>
								</li>
								<li><a href="#listElectionPop" data-toggle="tab">สถิติประชากรแบ่งตามเลือกตั้ง</a>
								</li>
								<li><a href="#listAgePop" data-toggle="tab">สถิติประชากรแบ่งตามอายุ</a>
								</li>
							</ul>
							<div class="panel-body">

								<!-- Tab panes -->
								<div class="tab-content">
									<div class="tab-pane fade in active" id="listAllPop">
										พ.ศ. <select>
											<option value="2558">2558</option>
											<option value="2559">2559</option>
										</select> <br>
										<br>
										<div class="table-responsive">
											<table id="resultTable"
												class="table table-striped table-bordered table-hover">
<!-- Start change table1 -->
												<thead>
													  <tr>
														<th rowspan="2">ปีข้อมูล</th>
														<th rowspan="2">หมู่ที่</th>
														<th rowspan="2">ชื่อหมู่บ้าน</th>
														<th style="text-align: center;" colspan="3">ประชากร</th>
														<th rowspan="2">ครัวเรือน</th>
													</tr>
													<tr>
														<th>ชาย</th>
														<th>หญิง</th>
														<th>รวม</th>
													</tr> 
												
												</thead>
												<tbody id="listPopulation11">
												</tbody>
<!-- End change table1 -->
											</table>
										</div>
										
										<div class="table-responsive">
											<table id="resultTable1"
												class="table table-striped table-bordered table-hover">
<!-- Start change result table1 -->
												<thead>
													<tr>
														<th>ชาย</th>
														<th>หญิง</th>
														<th>รวม</th>
														<th>ครัวเรือน</th>
													</tr>
												</thead>
												<tbody id="resultlistPopulation11">
												</tbody>
<!-- End change result table1 -->
											</table>
										</div>
										
									</div>
									<div class="tab-pane fade" id="listNationPop">
										พ.ศ. <select>
											<option value="2558">2558</option>
											<option value="2559">2559</option>
										</select> <br>
										<br>
										<div class="table-responsive">
											<table id="resultTable2-1"
												class="table table-striped table-bordered table-hover">
<!-- Start change table2 -->
												<thead>
													  <tr>
														<th rowspan="2">ปีข้อมูล</th>
														<th rowspan="2">หมู่ที่</th>
														<th rowspan="2">ชื่อหมู่บ้าน</th>
														<th style="text-align: center;" colspan="3">สัญชาติที่ไม่ใช่สัญชาติไทย</th>
														<th style="text-align: center;" colspan="3">สัญชาติไทย</th>
														<th style="text-align: center;" colspan="3">สัญชาติจีน</th>
														<th style="text-align: center;" colspan="3">ทุกสัญชาติ</th>
													</tr>
													<tr>
														<th>ชาย</th>
														<th>หญิง</th>
														<th>รวม</th>
														<th>ชาย</th>
														<th>หญิง</th>
														<th>รวม</th>
														<th>ชาย</th>
														<th>หญิง</th>
														<th>รวม</th>
														<th>ชาย</th>
														<th>หญิง</th>
														<th>รวม</th>
													</tr> 
												
												</thead>
												<tbody id="listPopulation12">
												</tbody>
<!-- End change table2 -->
											</table>
										</div>
										<div class="table-responsive">
											<table id="resultTable2-2"
												class="table table-striped table-bordered table-hover">
<!-- Start change result table2 -->
												<thead>
													<tr>
														<th style="text-align: center;" colspan="3">สัญชาติที่ไม่ใช่สัญชาติไทย</th>
														<th style="text-align: center;" colspan="3">สัญชาติไทย</th>
														<th style="text-align: center;" colspan="3">สัญชาติจีน</th>
														<th style="text-align: center;" colspan="3">ทุกสัญชาติ</th>
													</tr>
													<tr>
														<th>ชาย</th>
														<th>หญิง</th>
														<th>รวม</th>
														<th>ชาย</th>
														<th>หญิง</th>
														<th>รวม</th>
														<th>ชาย</th>
														<th>หญิง</th>
														<th>รวม</th>
														<th>ชาย</th>
														<th>หญิง</th>
														<th>รวม</th>
													</tr>
												</thead>
												<tbody id="resultlistPopulation12">
												</tbody>
<!-- End change result table2 -->
											</table>
										</div>
									</div>
									
									<div class="tab-pane fade" id="listElectionPop">
										พ.ศ. <select>
											<option value="2558">2558</option>
											<option value="2559">2559</option>
										</select> <br>
										<br>
										<div class="table-responsive">
											<table id="resultTable3-1"
												class="table table-striped table-bordered table-hover">
<!-- Start change table3 -->
												<thead>
													  <tr>
														<th rowspan="2">ปีข้อมูล</th>
														<th rowspan="2">หมู่ที่</th>
														<th rowspan="2">ชื่อหมู่บ้าน</th>
														<th style="text-align: center;" colspan="3">บุคคลมีสิทธิ์เลือกตั้งอายุ 15 ปี</th>
														<th style="text-align: center;" colspan="3">บุคคลมีสิทธิ์เลือกตั้งอายุ 18 ปี</th>
														<th style="text-align: center;" colspan="3">บุคคลมีสิทธิ์เลือกตั้งอายุ 20 ปี</th>
														<th style="text-align: center;" rowspan="2">บุคคลที่ต้องขึ้นทะเบียนทหาร</th>
														<th style="text-align: center;" rowspan="2">บุคคลที่ต้องเข้ารับเกณฑ์ทหาร</th>
													</tr>
													<tr>
														<th>ชาย</th>
														<th>หญิง</th>
														<th>รวม</th>
														<th>ชาย</th>
														<th>หญิง</th>
														<th>รวม</th>
														<th>ชาย</th>
														<th>หญิง</th>
														<th>รวม</th>
													</tr> 
												
												</thead>
												<tbody id="listPopulation13">
												</tbody>
<!-- End change table3 -->
											</table>
										</div>
										<div class="table-responsive">
											<table id="resultTable3-2"
												class="table table-striped table-bordered table-hover">
<!-- Start change result table3 -->
												<thead>
													<tr>
														<th style="text-align: center;" colspan="3">บุคคลมีสิทธิ์เลือกตั้งอายุ 15 ปี</th>
														<th style="text-align: center;" colspan="3">บุคคลมีสิทธิ์เลือกตั้งอายุ 18 ปี</th>
														<th style="text-align: center;" colspan="3">บุคคลมีสิทธิ์เลือกตั้งอายุ 20 ปี</th>
														<th style="text-align: center;" rowspan="2">บุคคลที่ต้องขึ้นทะเบียนทหาร</th>
														<th style="text-align: center;" rowspan="2">บุคคลที่ต้องเข้ารับเกณฑ์ทหาร</th>
													</tr>
													<tr>
														<th>ชาย</th>
														<th>หญิง</th>
														<th>รวม</th>
														<th>ชาย</th>
														<th>หญิง</th>
														<th>รวม</th>
														<th>ชาย</th>
														<th>หญิง</th>
														<th>รวม</th>
													</tr>
												</thead>
												<tbody id="resultlistPopulation13">
												</tbody>
<!-- End change result table3 -->
											</table>
										</div>
									</div>
									<div class="tab-pane fade" id="listAgePop">
										พ.ศ. <select>
											<option value="2558">2558</option>
											<option value="2559">2559</option>
										</select> <br>
										<br>
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover">
												<thead>
													<tr>
														<th><center>
																ช่วงอายุ</b>
															</center></th>
														<th><center>
																ชาย</b>
															</center></th>
														<th><center>
																หญิง</b>
															</center></th>
														<th><center>
																รวม</b>
															</center></th>
														<th><center>
																ช่วงอายุ</b>
															</center></th>
														<th><center>
																ชาย</b>
															</center></th>
														<th><center>
																หญิง</b>
															</center></th>
														<th><center>
																รวม</b>
															</center></th>
													</tr>

												</thead>
												<tbody>
													<tr>
														<td><center>
																<b>น้อยกว่า 1 ปี</b>
															</center></td>
														<td><center>40</center></td>
														<td><center>45</center></td>
														<td><center>85</center></td>
														<td><center>
																<b>1 ปี</b>
															</center></td>
														<td><center>50</center></td>
														<td><center>51</center></td>
														<td><center>101</center></td>

													</tr>
													<tr>
														<td><center>
																<b>น้อยกว่า 2 ปี</b>
															</center></td>
														<td><center>59</center></td>
														<td><center>47</center></td>
														<td><center>106</center></td>
														<td><center>
																<b>3 ปี</b>
															</center></td>
														<td><center>57</center></td>
														<td><center>41</center></td>
														<td><center>98</center></td>


													</tr>
													<tr>
														<td><center>
																<b>น้อยกว่า 4 ปี</b>
															</center></td>
														<td><center>52</center></td>
														<td><center>46</center></td>
														<td><center>97</center></td>
														<td><center>
																<b>5 ปี</b>
															</center></td>
														<td><center>57</center></td>
														<td><center>38</center></td>
														<td><center>95</center></td>
													</tr>
													<tr>
														<td><center>
																<b>น้อยกว่า 6 ปี</b>
															</center></td>
														<td><center>53</center></td>
														<td><center>46</center></td>
														<td><center>85</center></td>
														<td><center>
																<b>7 ปี</b>
															</center></td>
														<td><center>42</center></td>
														<td><center>48</center></td>
														<td><center>90</center></td>
													</tr>

													<tr>
														<td><center>
																<b>น้อยกว่า 8 ปี</b>
															</center></td>
														<td><center>46</center></td>
														<td><center>40</center></td>
														<td><center>86</center></td>
														<td><center>
																<b>9 ปี</b>
															</center></td>
														<td><center>52</center></td>
														<td><center>47</center></td>
														<td><center>99</center></td>

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
		<script
			src="//cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>

		<!-- Custom Theme JavaScript -->
		<script src="../NanglaeGov/dist/js/sb-admin-2.js"></script>

		<!-- Page-Level Demo Scripts - Tables - Use for reference -->
		<script>
			
			function openDeleteModal(id) {
				$('#pop_id').val($(id).data('id'));
				$('#DeleteModal').modal('show');
			}
		</script>
</body>

</html>
