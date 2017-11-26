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
<link href="../NanglaeGov/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="../NanglaeGov/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

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
<script
	src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
<link rel="stylesheet"
	href="https://www.amcharts.com/lib/3/plugins/export/export.css"
	type="text/css" media="all" />
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
<style type="text/css">
#chartdiv {
	width: 100%;
	height: 500px;
	font-size: 11px;
}
</style>
<script type='text/javascript' src="../NanglaeGov/js/jquery.js"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	function numberWithCommas(x) {
		var parts = x.toString().split(".");
		parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return parts.join(".");
	}
</script>
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
			title : 'สัดส่วนประชากรตามสัญชาติ(ทั้งหมด '
					+ numberWithCommas(totalAllNation) + ' คน)'
		};

		var chart = new google.visualization.PieChart(document
				.getElementById('piechart'));

		chart.draw(data, options);
	}
</script>
<script type='text/javascript'>
	function getVillageList() {
		var villageAmount = 0;
		$("#loader").show();
		$
				.ajax({
					url : "../NanglaeGov/listVillage.do",
					type : "POST",
					success : function(data) {
						var villageList = '';
						var count = 0;
						for (var i = 0; i < data.length; i++) {
							villageList += "<a href=\"#\" class=\"list-group-item\"></i> บ้าน"
									+ data[i].vil_name
									+ "<span class=\"pull-right text-muted small\"><em>หมู่ที่ "
									+ data[i].vil_number + "</em></span></a>";
							count++;
							if (count == 10) {
								break;
							}
						}
						$('#villageList').html(villageList);
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
						var tourList = '';
						var count = 0;
						for (var i = 0; i < data.length; i++) {
							var imgSrc = '';
							alert(imgSrc);
							$
									.ajax({
										url : "../NanglaeGov/listPictureByTour.do?owner="
												+ data[i].tour_id,
										type : "POST",
										success : function(data) {
											for (var j = 0; j < data.length; j++) {
												imgSrc = data[j].pic_name;
												
											}alert(j + "img: " + imgSrc);
										},
										error : function(data, status, er) {
											alert('error');
											$("#loader").hide();
										}
									});
							
							var imgSide = "";
							var imgPanel = "";
							if (count % 2 == 0) {
								imgSide = "chat-img pull-left";
								imgPanel = "left clearfix";
							} else {
								imgSide = "chat-img pull-right";
								imgPanel = "right clearfix";
							}
							tourList += "<ul class=\"chat\"><li class=\""+imgPanel+"\"><span class=\""+imgSide+"\">"
									+ "<img src=\'../NanglaeGov/images/110412.jpg\' /></span>"
									+ "<div class=\"chat-body clearfix\"><div class=\"header\">"
									+ "<strong class=\"primary-font\">"
									+ data[i].tour_name
									+ "</strong> <small class=\"pull-right text-muted\">"
									+ "<i class=\"fa fa-home fa-fw\"></i>บ้าน"
									+ data[i].location.vil_name
									+ "</small></div>"
									+ "<p>"
									+ data[i].tour_description
									+ "</p></div></li></ul>";
							count++;
						}
						$('#tourList').html(tourList);
						$("#loader").hide();
					},
					error : function(data, status, er) {
						alert('error');
						$("#loader").hide();
					}
				});
	}
</script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawVisualization);
	var popPerVil = '';
	var testData = [ [ 'หมู่บ้าน', 'ชาย', 'หญิง', 'รวม' ] ];
	var allpopshow = 0;
	$.ajax({
		url : "../NanglaeGov/listPopulation1.do",
		type : "POST",
		success : function(data) {
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
				var popData = [ [ data[i].location.vil_name, allMale,
						allFemale, allPop ] ];
				testData = testData.concat(popData);
			}
			allpopshow = allPop;
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
			title : 'ประชากรในแต่ละหมู่บ้าน(' + numberWithCommas(allpopshow)
					+ " คน)",
			vAxis : {
				title : 'จำนวน(คน)'
			},
			hAxis : {
				title : 'หมู่บ้าน'
			},
			seriesType : 'bars',
			series : {
				5 : {
					type : 'line'
				}
			}
		};

		var chart = new google.visualization.ComboChart(document
				.getElementById('chart_div'));
		chart.draw(data, options);
	}
</script>
</head>

<body onload="getVillageList();getListTourism();">

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
					out.println("ยินดีต้อนรับ    " + Name);
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

			<%@include file="superMenu.jsp"%>
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
										<img class="slide-image"
											src="../NanglaeGov/image/banner_nanglae.jpg" alt="">
									</div>
									<div class="item">
										<img class="slide-image"
											src="../NanglaeGov/image/banner-nanglae2.jpg" alt="">
									</div>
									<div class="item">
										<img class="slide-image"
											src="../NanglaeGov/image/banner-nanglae3.jpg" alt="">
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
						</div>
					</div>
				</header>
			</div>
			<br> <br>
			<div class="row">
				<div class="col-lg-8">
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-bar-chart-o fa-fw"></i> ประชากรในแต่ละหมู่บ้าน
						</div>
						<div class="panel-body">
							<div id="chart_div" style="height: 300px;"></div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-bar-chart-o fa-fw"></i> ประชากรแบ่งตามสัญชาติ
						</div>
						<div class="panel-body">
							<div class="row">
								<div id="piechart" style="height: 300px;"></div>
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-clock-o fa-fw"></i> Responsive Timeline
						</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
							<ul class="timeline">
								<li>
									<div class="timeline-badge">
										<i class="fa fa-check"></i>
									</div>
									<div class="timeline-panel">
										<div class="timeline-heading">
											<h4 class="timeline-title">Lorem ipsum dolor</h4>
											<p>
												<small class="text-muted"><i class="fa fa-clock-o"></i>
													11 hours ago via Twitter</small>
											</p>
										</div>
										<div class="timeline-body">
											<p>Lorem ipsum dolor sit amet, consectetur adipisicing
												elit. Libero laboriosam dolor perspiciatis omnis
												exercitationem. Beatae, officia pariatur? Est cum veniam
												excepturi. Maiores praesentium, porro voluptas suscipit
												facere rem dicta, debitis.</p>
										</div>
									</div>
								</li>
								<li class="timeline-inverted">
									<div class="timeline-badge warning">
										<i class="fa fa-credit-card"></i>
									</div>
									<div class="timeline-panel">
										<div class="timeline-heading">
											<h4 class="timeline-title">Lorem ipsum dolor</h4>
										</div>
										<div class="timeline-body">
											<p>Lorem ipsum dolor sit amet, consectetur adipisicing
												elit. Autem dolorem quibusdam, tenetur commodi provident
												cumque magni voluptatem libero, quis rerum. Fugiat esse
												debitis optio, tempore. Animi officiis alias, officia
												repellendus.</p>
											<p>Lorem ipsum dolor sit amet, consectetur adipisicing
												elit. Laudantium maiores odit qui est tempora eos, nostrum
												provident explicabo dignissimos debitis vel! Adipisci eius
												voluptates, ad aut recusandae minus eaque facere.</p>
										</div>
									</div>
								</li>
								<li>
									<div class="timeline-badge danger">
										<i class="fa fa-bomb"></i>
									</div>
									<div class="timeline-panel">
										<div class="timeline-heading">
											<h4 class="timeline-title">Lorem ipsum dolor</h4>
										</div>
										<div class="timeline-body">
											<p>Lorem ipsum dolor sit amet, consectetur adipisicing
												elit. Repellendus numquam facilis enim eaque, tenetur nam id
												qui vel velit similique nihil iure molestias aliquam,
												voluptatem totam quaerat, magni commodi quisquam.</p>
										</div>
									</div>
								</li>
								<li class="timeline-inverted">
									<div class="timeline-panel">
										<div class="timeline-heading">
											<h4 class="timeline-title">Lorem ipsum dolor</h4>
										</div>
										<div class="timeline-body">
											<p>Lorem ipsum dolor sit amet, consectetur adipisicing
												elit. Voluptates est quaerat asperiores sapiente, eligendi,
												nihil. Itaque quos, alias sapiente rerum quas odit! Aperiam
												officiis quidem delectus libero, omnis ut debitis!</p>
										</div>
									</div>
								</li>
								<li>
									<div class="timeline-badge info">
										<i class="fa fa-save"></i>
									</div>
									<div class="timeline-panel">
										<div class="timeline-heading">
											<h4 class="timeline-title">Lorem ipsum dolor</h4>
										</div>
										<div class="timeline-body">
											<p>Lorem ipsum dolor sit amet, consectetur adipisicing
												elit. Nobis minus modi quam ipsum alias at est molestiae
												excepturi delectus nesciunt, quibusdam debitis amet, beatae
												consequuntur impedit nulla qui! Laborum, atque.</p>
											<hr>
											<div class="btn-group">
												<button type="button"
													class="btn btn-primary btn-sm dropdown-toggle"
													data-toggle="dropdown">
													<i class="fa fa-gear"></i> <span class="caret"></span>
												</button>
												<ul class="dropdown-menu" role="menu">
													<li><a href="#">Action</a></li>
													<li><a href="#">Another action</a></li>
													<li><a href="#">Something else here</a></li>
													<li class="divider"></li>
													<li><a href="#">Separated link</a></li>
												</ul>
											</div>
										</div>
									</div>
								</li>
								<li>
									<div class="timeline-panel">
										<div class="timeline-heading">
											<h4 class="timeline-title">Lorem ipsum dolor</h4>
										</div>
										<div class="timeline-body">
											<p>Lorem ipsum dolor sit amet, consectetur adipisicing
												elit. Sequi fuga odio quibusdam. Iure expedita, incidunt
												unde quis nam! Quod, quisquam. Officia quam qui adipisci
												quas consequuntur nostrum sequi. Consequuntur, commodi.</p>
										</div>
									</div>
								</li>
								<li class="timeline-inverted">
									<div class="timeline-badge success">
										<i class="fa fa-graduation-cap"></i>
									</div>
									<div class="timeline-panel">
										<div class="timeline-heading">
											<h4 class="timeline-title">Lorem ipsum dolor</h4>
										</div>
										<div class="timeline-body">
											<p>Lorem ipsum dolor sit amet, consectetur adipisicing
												elit. Deserunt obcaecati, quaerat tempore officia voluptas
												debitis consectetur culpa amet, accusamus dolorum fugiat,
												animi dicta aperiam, enim incidunt quisquam maxime neque
												eaque.</p>
										</div>
									</div>
								</li>
							</ul>
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-8 -->
				<div class="col-lg-4">
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-home fa-fw"></i> หมู่บ้าน
						</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
							<div class="list-group">
								<div id="villageList"></div>
							</div>
							<!-- /.list-group -->
							<a href="superVillage.do" class="btn btn-default btn-block">ดูข้อมูลทั้งหมด</a>
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->

					<div class="chat-panel panel panel-default">
						<div class="panel-heading">
							<i class="glyphicon glyphicon-tent"></i> แหล่งท่องเที่ยว
						</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
							<div id="tourList"></div>
						</div>
						<!-- /.panel-body -->
						<div class="panel-footer">
							<div class="input-group">
								<input id="btn-input" type="text" class="form-control input-sm"
									placeholder="Type your message here..." /> <span
									class="input-group-btn">
									<button class="btn btn-warning btn-sm" id="btn-chat">
										Send</button>
								</span>
							</div>
						</div>
						<!-- /.panel-footer -->
					</div>
					<!-- /.panel .chat-panel -->
				</div>
				<!-- /.col-lg-4 -->
			</div>
			<!-- /.row -->
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
	<!-- Mask plug in -->
	<script src="../NanglaeGov/js/jquery.mask.js"></script>
	<script src="../NanglaeGov/js/jquery.mask.min.js"></script>
</body>

</html>
