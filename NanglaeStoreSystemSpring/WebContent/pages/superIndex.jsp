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

<!-- Custom CSS -->
<link href="../NanglaeGov/dist/css/sb-admin-2.css" rel="stylesheet">
<link href="../NanglaeGov/dist/css/shop-homepage.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="../NanglaeGov/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/funnel.js"></script>
<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
<link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>							
<style type="text/css">
#chartdiv {
	width		: 100%;
	height		: 500px;
	font-size	: 11px;
}					
</style>
<script type='text/javascript' src="../NanglaeGov/js/jquery.js"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawChart);

	var year = new Date().getFullYear();
	//alert(year);

	var totalThai = 0;
	var totalOther = 0;
	var totalChinese = 0;
	var totalAllNation = 0;
	$("#loader").show();
	$.ajax({
		url : "../NanglaeGov/listPopulation1.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				totalThai += data[i].pop_thai_nation_m
						+ data[i].pop_thai_nation_f;
				totalChinese += data[i].pop_chinese_nation_m
						+ data[i].pop_chinese_nation_f;
				totalOther += data[i].pop_other_nation_m
						+ data[i].pop_other_nation_f;
				
			}
			totalAllNation = totalThai + totalChinese + totalOther;
		},
		error : function(data, status, er) {
			alert('error');
			$("#loader").hide();
		}
	});

	function drawChart() {

		var data = google.visualization.arrayToDataTable([
				[ 'สัญชาติ', 'จำนวน(คน)' ], [ 'ไทย', totalThai ],
				[ 'จีน', totalChinese ], [ 'อื่นๆ', totalOther ], ]);
		var options = {
			title : 'สัดส่วนประชากรตามสัญชาติ(ทั้งหมด ' + totalAllNation
					+ ' คน)'
		};

		var chart = new google.visualization.PieChart(document
				.getElementById('piechart'));

		chart.draw(data, options);
	}
</script>
<script type='text/javascript'>


	function getVillageAmount() {
		var villageAmount = 0;
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listVillage.do",
					type : "POST",
					success : function(data) {
						var htmlvillageAmount = '';
						for (var i = 0; i < data.length; i++) {
							villageAmount++;
						}
						htmlvillageAmount += "<div class=\"col-xs-9 text-right\">";
						htmlvillageAmount += "<div class=\"huge\">"
								+ villageAmount + "</div>";
						htmlvillageAmount += "<div>หมู่บ้าน</div></div>";
						var htmlvillageLink = '';
						htmlvillageLink += "<a href=\"village.html\">";
						htmlvillageLink += "<div class=\"panel-footer\">";
						htmlvillageLink += "<span class=\"pull-left\">ดูหมู่บ้านทั้งหมด</span> <span class=\"pull-right\"><i class=\"fa fa-arrow-circle-right\"></i></span>";
						htmlvillageLink += "<div class=\"clearfix\"></div>";
						htmlvillageLink += "</div>";
						htmlvillageLink += "</a>";
						$('#villageAmount').html(htmlvillageAmount);
						$('#villageLink').html(htmlvillageLink);
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
	function getListTourism() {
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listTourism.do",
					type : "POST",
					success : function(data) {
						var htmlTourAmount = '';
						var tourAmount = 0;
						for (var i = 0; i < data.length; i++) {
							tourAmount++;
						}
						htmlTourAmount += "<div class=\"col-xs-9 text-right\">";
						htmlTourAmount += "<div class=\"huge\">" + tourAmount
								+ "</div>";
						htmlTourAmount += "<div>สถานที่ท่องเที่ยว</div>";
						htmlTourAmount += "</div>";
						var htmlTourLink = '';
						htmlTourLink += "<a href=\"tourism.html\">";
						htmlTourLink += "<div class=\"panel-footer\">";
						htmlTourLink += "<span class=\"pull-left\">ข้อมูลสถานที่ท่องเที่ยว</span>";
						htmlTourLink += "<span class=\"pull-right\"><i class=\"fa fa-arrow-circle-right\"></i></span>";
						htmlTourLink += "<div class=\"clearfix\"></div></div></a>";
						$('#TourAmount').html(htmlTourAmount);
						$('#TourLink').html(htmlTourLink);
						$("#loader").hide();
					},
					error : function(data, status, er) {
						alert('error');
						$("#loader").hide();
					}
				});
	}
</script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawVisualization);
	var popPerVil = '';
	var testData = [['หมู่บ้าน', 'ชาย', 'หญิง', 'รวม']];
      $.ajax({
			url : "../NanglaeGov/listPopulation1.do",
			type : "POST",
			success : function(data) {
				for (var i = 0; i < data.length; i++) {
					var allMale = 0;
					var allFemale = 0;
					var allPop = 0;
					allMale = data[i].pop_thai_nation_m+data[i].pop_chinese_nation_m+data[i].pop_other_nation_m;
					allFemale = data[i].pop_thai_nation_f+data[i].pop_chinese_nation_f+data[i].pop_other_nation_f;
					allPop = allMale+allFemale;
					var popData = [[data[i].location.vil_name,allMale,allFemale,allPop]];
					testData = testData.concat(popData);
				}
				//alert(popPerVil);
				$("#loader").hide();
			},
			error : function(data, status, er) {
				alert('error');
				$("#loader").hide();
			}
		});
      
      function drawVisualization() {
        // Some raw data (not necessarily accurate)
        var data = google.visualization.arrayToDataTable(testData);

    var options = {
      title : 'ประชากรในแต่ละหมู่บ้าน',
      vAxis: {title: 'จำนวน(คน)'},
      hAxis: {title: 'หมู่บ้าน'},
      seriesType: 'bars',
      series: {5: {type: 'line'}}
    };

    var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
    chart.draw(data, options);
  }
    </script>
</head>

<body onload="getVillageAmount();getListTourism();">

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
					class="navbar-brand" href="index.do">เทศบาลตำบลนางแล</a>
			</div>
			<!-- /.navbar-header -->

			<ul class="nav navbar-top-links navbar-right">
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

			<div class="navbar-default sidebar" role="navigation">
				<div class="sidebar-nav navbar-collapse">
					<ul class="nav" id="side-menu">
						<li><a href="#"><i class="fa fa-child fa-fw"></i> บุคคล<span
								class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="superPersonnel.do">บุคลากร</a></li>
								<li><a href="superPopulation.do">ประชากร</a></li>
								<li><a href="superLabor.do">แรงงาน</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="fa fa-road fa-fw"></i>
								สาธารณูปโภค<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="superTransport.do">ระบบคมนาคมขนส่ง</a></li>
								<li><a href="superElectric.do">ระบบไฟฟ้า</a></li>
								<li><a href="superPipeline.do">ระบบประปา</a></li>
								<li><a href="superDrainange.do">ระบบระบายน้ำ</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="fa fa-home fa-fw"></i>
								สาธารณุปการ<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="#">เคหะ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="superVillage.do">หมู่บ้าน</a></li>
										<li><a href="superIndustry.do">การอุตสาหกรรม</a></li>
										<li><a href="superEducation.do">การศึกษา</a></li>
										<li><a href="superReligion.do">การศาสนา</a></li>
										<li><a href="superCommerce.do">การพาณิชย์</a></li>
										<li><a href="superTourism.do">แหล่งท่องเที่ยว</a></li>
									</ul> <!-- /.nav-third-level --></li>
								<li><a href="#">บริการ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="superHealth.do">การสาธารสุข</a></li>
										<li><a href="superSecurity.do">ความปลอดภัยในชีวิตและทรัพย์สิน</a>
										</li>
										<li><a href="superGroup.do">กลุ่มในชุมชน</a></li>
										<li><a href="superService.do">ศูนย์บริการประชาชน</a></li>
										<li><a href="superInventory.do">การคลัง</a></li>
									</ul> <!-- /.nav-third-level --></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="#"><i class="glyphicon glyphicon-leaf"></i>
								ธรรมชาติและสิ่งแวดล้อม<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
								<li><a href="superAgriculture.do">การเกษตรกรรม</a></li>
								<li><a href="#">ทรัพยากรธรรมชาติ<span class="fa arrow"></span></a>
									<ul class="nav nav-third-level">
										<li><a href="superWaterresource.do">ทรัพยากรณ์น้ำ</a></li>
										<li><a href="superLandresource.do">ทรัพยากรณ์ดิน</a></li>
										<li><a href="superForrestresource.do">ทรัพยากรณ์ป่าไม้</a></li>
									</ul></li>
								<li><a href="superPolution.do">มลพิษ</a></li>
							</ul> <!-- /.nav-second-level --></li>
						<li><a href="copy.do"><i class="fa fa-copy"></i>
								คัดลอกข้อมูล</a></li>
						<li><a href="createUser.do"><i class="glyphicon glyphicon-user"></i>
								สร้างผู้ใช้งาน</a></li>
					</ul>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
		</nav>

		<div id="page-wrapper" style="background-color: #d7f0f5">
			<div class="row">
				<header class="business-header">
					<div class="row carousel-holder">

						<div class="col-md-12">
							<div id="carousel-example-generic" class="carousel slide"
								data-ride="carousel">
								<ol class="carousel-indicators">
									<li data-target="#carousel-example-generic" data-slide-to="0"
										class="active"></li>
									<li data-target="#carousel-example-generic" data-slide-to="1"></li>
									<li data-target="#carousel-example-generic" data-slide-to="2"></li>
								</ol>
								<div class="carousel-inner">
									<div class="item active">
										<img class="slide-image" src="../NanglaeGov/images/banner.jpg" alt="">
									</div>
									<div class="item">
										<img class="slide-image" src="../NanglaeGov/images/banner.jpg" alt="">
									</div>
									<div class="item">
										<img class="slide-image" src="../NanglaeGov/images/banner.jpg" alt="">
									</div>
								</div>
								<a class="left carousel-control"
									href="#carousel-example-generic" data-slide="prev"> <span
									class="glyphicon glyphicon-chevron-left"></span>
								</a> <a class="right carousel-control"
									href="#carousel-example-generic" data-slide="next"> <span
									class="glyphicon glyphicon-chevron-right"></span>
								</a>
							</div>
							</br> </br>
						</div>

					</div>

				</header>
				<!-- /.col-lg-12 -->
			</div>
			<div id="chart_div" style="width: 900px; height: 500px;"></div>
			<div id="piechart" style="width: 900px; height: 500px;"></div>
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->

	<!-- jQuery -->
	<script src="../NanglaeGov/vendor/jquery/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="../NanglaeGov/vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="../NanglaeGov/vendor/metisMenu/metisMenu.min.js"></script>

	<!-- Morris Charts JavaScript -->
	<script src="../NanglaeGov/vendor/raphael/raphael.min.js"></script>
	<script src="../NanglaeGov/vendor/morrisjs/morris.min.js"></script>
	<script src="../NanglaeGov/data/morris-data.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="../NanglaeGov/dist/js/sb-admin-2.js"></script>

</body>

</html>
