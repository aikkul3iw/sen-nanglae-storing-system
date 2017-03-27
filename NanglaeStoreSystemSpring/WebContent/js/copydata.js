function copyData() {
	$("#loader").show();
	$.ajax({
		url : "../listVillage.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].vil_year == $('#oldYear').val()) {
					var objVillage = {
						vil_id : 0,
						vil_year : $('#newYear').val(),
						vil_name : data[i].vil_name,
						vil_number : data[i].vil_number,
						vil_chief : data[i].vil_chief
					};
					$.ajax({
						url : "../saveVillage.do",
						type : "POST",
						dataType : "JSON",
						data : JSON.stringify(objVillage),
						contentType : "application/json",
						mimeType : "application/json",
						success : function(data) {
							$("#loader").hide();
							location.reload();

						},
						error : function(data, status, er) {
							alert('errorVillage2');
							$("#loader").hide();
						}
					});
				}
			}
		},
		error : function(data, status, er) {
			alert('errorVillage1');
			$("#loader").hide();
		}
	});

	$.ajax({
		url : "../listAgriculture.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].agi_year == $('#oldYear').val()) {
					var objAgriculture = {
						agi_id : 0,
						agi_year : $('#newYear').val(),
						agi_name : data[i].agi_name,
						agi_area : data[i].agi_area,
						agi_description : data[i].agi_description
					};
					$.ajax({
						url : "../saveAgriculture.do",
						type : "POST",
						dataType : "JSON",
						data : JSON.stringify(objAgriculture),
						contentType : "application/json",
						mimeType : "application/json",
						success : function(data) {
							$("#loader").hide();
							location.reload();
						},
						error : function(data, status, er) {
							alert('errorAgi2');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			alert('errorAgi1');
			$("#loader").hide();
		}
	});
}
