function copyData() {
	$("#loader").show();
	
	//copy Village
	/*$.ajax({
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
							//alert('errorVillage2');
							$("#loader").hide();
						}
					});
				}
			}
		},
		error : function(data, status, er) {
			//alert('errorVillage1');
			$("#loader").hide();
		}
	});

	//copy Agriculture
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
							//alert('errorAgi2');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('errorAgi1');
			$("#loader").hide();
		}
	});
	
	//copy Commerce
	$.ajax({
		url : "../listCommerce.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].com_year == $('#oldYear').val()) {
				var objCommerce = {
						com_id : 0,
						com_year : $('#newYear').val(),
						com_name : data[i].com_name,
						com_type : data[i].com_type,
						com_house_number : data[i].com_house_number,
						com_description : data[i].com_description

					};
				var vil_id = data[i].location.vil_id;
					//alert(JSON.stringify(obj));
					$.ajax({
						url : "../saveCommerce.do?id="+vil_id,
						type : "POST",
						dataType : "JSON",
						data : JSON.stringify(objCommerce),
						contentType : "application/json",
						mimeType : "application/json",
						success : function(data) {
							//alert('success');
							$("#loader").hide();
							location.reload();
						},
						error : function(data, status, er) {
							//alert('error');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});*/
	
	//copy Drainage
	$.ajax({
		url : "../listDrainage.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].drain_year == $('#oldYear').val()) {
				var objDrainage = {
						drain_id : 0,
						drain_year : $('#newYear').val(),
						drain_name : data[i].drain_name,
						drain_location_connected : data[i].drain_location_connected
					};
				var drain_id = data[i].location.vil_id;
					//alert(JSON.stringify(obj));
					$.ajax({
						url : "../saveDrainage.do?id=" + drain_id,
						type : "POST",
						dataType : "JSON",
						data : JSON.stringify(objDrainage),
						contentType : "application/json",
						mimeType : "application/json",
						success : function(data) {
							//alert('success');
							$("#loader").hide();
							location.reload();
						},
						error : function(data, status, er) {
							//alert('error');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});
	
	//copy Education
	/*$.ajax({
		url : "../listEducation.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].edu_year == $('#oldYear').val()) {
				var objEducation = {
						edu_id : 0,
						edu_year : $('#newYear').val(),
						edu_name : data[i].edu_name,
						edu_type : data[i].edu_type,
						student : data[i].student

					};
				var edu_id = data[i].location.vil_id;
					$.ajax({
						url : "../saveEducation.do?id=" + edu_id,
						type : "POST",
						dataType : "JSON",
						data : JSON.stringify(objEducation),
						contentType : "application/json",
						mimeType : "application/json",
						success : function(data) {
							$("#loader").hide();
							location.reload();
						},
						error : function(data, status, er) {
							//alert('error');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});
	
	//copy Electricity
	$.ajax({
		url : "../listElectricity.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].elec_year == $('#oldYear').val()) {
				var obj = {
						elec_id : 0,
						elec_year : $('#newYear').val(),
						elec_area : data[i].elec_area,
						elec_status : data[i].elec_status

					};
				var elect_id = data[i].location.vil_id;
					//alert(JSON.stringify(obj));
					$.ajax({
						url : "../saveElectricity.do?id=" + elect_id,
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
							//alert('error');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});
	
	//copy Forest
	$.ajax({
		url : "../listForest.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].frs_year == $('#oldYear').val()) {
				var obj = {
						frs_id : 0,
						frs_year : $('#newYear').val(),
						frs_name : data[i].frs_name,
						frs_usage : data[i].frs_usage

					};
				var frs_id = data[i].location.vil_id;
					//alert(JSON.stringify(obj));
					$.ajax({
						url : "../saveForest.do?id=" + frs_id,
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
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});
	
	//copy Group
	$.ajax({
		url : "../listLocalg.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].grp_year == $('#oldYear').val()) {
				var obj = {
						grp_id : 0,
						grp_year : $('#newYear').val(),
						grp_name : data[i].grp_name,
						grp_member : data[i].grp_member,
						grp_area : data[i].grp_area

					};
					$.ajax({
						url : "../saveLocalg.do",
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
							//alert('error');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});
	
	//copy Health
	$.ajax({
		url : "../listHealth.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].hlt_year == $('#oldYear').val()) {
				var obj = {
						hlt_id : 0,
						hlt_year : $('#newYear').val(),
						hlt_name : data[i].hlt_name,
						hlt_service_area : data[i].hlt_service_area

					};
				var hlt_id = data[i].location.vil_id;
					//alert(JSON.stringify(obj));
					$.ajax({
						url : "../saveHealth.do?id=" + hlt_id,
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
							//alert('error');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});
	
	//copy Industry
	$.ajax({
		url : "../listIndustry.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].ins_year == $('#oldYear').val()) {
				var obj = {
						ins_id : 0,
						ins_year : $('#newYear').val(),
						ins_name : data[i].ins_name,
						ins_size : data[i].ins_size,
						ins_type : data[i].ins_type,
						ins_labor : data[i].ins_labor

					};
				var ins_id = data[i].location.vil_id;
					//alert(JSON.stringify(obj));
					$.ajax({
						url : "../saveIndustry.do?id=" + ins_id,
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
							//alert('error');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});
	
	//copy Inventory
	$.ajax({
		url : "../listInventory.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].ivn_year == $('#oldYear').val()) {
				var obj = {
						ivn_id : 0,
						ivn_year : $('#newYear').val(),
						ivn_collect : data[i].ivn_collect,
						ivn_gov_provide : data[i].ivn_gov_provide,
						ivn_gor_purchase : data[i].ivn_gor_purchase,
						inv_outcome : data[i].inv_outcome

					};
					//alert(JSON.stringify(obj));
					$.ajax({
						url : "../saveInventory.do",
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
							//alert('error');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});
	
	//copy Labor
	$.ajax({
		url : "../listLabor.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].lab_year == $('#oldYear').val()) {
				var obj = {
						lab_id : 0,
						lab_year : $('#newYear').val(),
						lab_type : data[i].lab_type,
						lab_amount : data[i].lab_amount,
						lab_work : data[i].lab_work
					};
					$.ajax({
						url : "../saveLabor.do",
						type : "POST",
						dataType : "JSON",
						data : JSON.stringify(obj),
						contentType : "application/json",
						mimeType : "application/json",
						success : function(data) {
							$("#loader").hide();
							location.reload();
						},
						error : function(data, status, er) {
							//alert('error');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});
	
	//copy Land
	$.ajax({
		url : "../listLandResource.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].land_year == $('#oldYear').val()) {
				var obj = {
						land_id : 0,
						land_year : $('#newYear').val(),
						land_name : data[i].land_name,
						land_usage : data[i].land_usage
					};
					//alert(JSON.stringify(obj));
					$.ajax({
						url : "../saveLandResource.do",
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
							//alert('error');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});
	
	//copy Personnel
	
	//copy Pipeline
	$.ajax({
		url : "../listPipeline.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].pipe_year == $('#oldYear').val()) {
				var obj = {
						pipe_id : 0,
						pipe_year : $('#newYear').val(),
						pipe_system : data[i].pipe_system,
						pipe_use_from : data[i].pipe_use_from

					};
				var pipe_id = data[i].location.vil_id;
					//alert(JSON.stringify(obj));
					$.ajax({
						url : "../savePipeline.do?id=" + pipe_id,
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
							//alert('error');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});
	
	//copy Population
	
	//copy Religion
	$.ajax({
		url : "../listReligion.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].rel_year == $('#oldYear').val()) {
				var obj = {
						rel_id : 0,
						rel_year : $('#newYear').val(),
						rel_name : data[i].rel_name,
						rel_type : data[i].rel_type

					};
				var rel_id = data[i].location.vil_id;
					//alert(JSON.stringify(obj));
					$.ajax({
						url : "../saveReligion.do?id=" + rel_id,
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
							//alert('error');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});
	
	//copy Security
	$.ajax({
		url : "../listLASucrity.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].sec_year == $('#oldYear').val()) {
				var obj = {
						sec_id : 0,
						sec_year : $('#newYear').val(),
						sec_name : data[i].sec_name,
						sec_member : data[i].sec_member

					};
					//alert(JSON.stringify(obj));
					$.ajax({
						url : "../saveLASucrity.do",
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
							//alert('error');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});
	
	//copy Service
	$.ajax({
		url : "../listService.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].ser_year == $('#oldYear').val()) {
				var obj = {
		    			ser_id : 0,
		    			ser_year : $('#newYear').val(),
		    			ser_name : data[i].ser_name,
		    			ser_capacity : data[i].ser_capacity
		    		};
		    		$.ajax({
		    			url : "../saveService.do",
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
		    				//alert('error');
		    				$("#loader").hide();
		    			}
		    		});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});
	
	//copy Tourism
	$.ajax({
		url : "../listTourism.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].tour_year == $('#oldYear').val()) {
				var obj = {
						tour_id : 0,
						tour_year : $('#newYear').val(),
						tour_name : data[i].tour_name,
						tour_description : data[i].tour_description

					};
				var tour_id = data[i].location.vil_id;
					//alert(JSON.stringify(obj));
					$.ajax({
						url : "../saveTourism.do?id=" + tour_id,
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
							//alert('error');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});
	
	//copy Transport
	$.ajax({
		url : "../listTransport.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].tran_year == $('#oldYear').val()) {
				var obj = {
						tran_id : 0,
						tran_year : $('#newYear').val(),
						tran_name : data[i].tran_name,
						type : data[i].type,
						description : data[i].description
					};
					//alert(JSON.stringify(obj));
					$.ajax({
						url : "../saveTransport.do",
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
							//alert('error');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});
	
	//copy Water
	$.ajax({
		url : "../listWater.do",
		type : "POST",
		success : function(data) {
			for (var i = 0; i < data.length; i++) {
				if (data[i].water_year == $('#oldYear').val()) {
				var obj = {
						water_id : 0,
						water_year : $('#newYear').val(),
						water_name : data[i].water_name,
						water_type : data[i].water_type

					};
				var water_id = data[i].location.vil_id;
					//alert(JSON.stringify(obj));
					$.ajax({
						url : "../saveWater.do?id=" + water_id,
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
							//alert('error');
							$("#loader").hide();
						}
					});
				}
			}
			$("#loader").hide();
		},
		error : function(data, status, er) {
			//alert('error');
			$("#loader").hide();
		}
	});*/
	
	//End of copy
}
