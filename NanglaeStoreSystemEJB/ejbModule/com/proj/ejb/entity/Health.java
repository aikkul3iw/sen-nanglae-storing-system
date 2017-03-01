package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Health implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long hlt_id;

	private String hlt_name;
	private String hlt_type;
	private String hlt_service_area;
	private int hlt_year;
	
	// map with village
		@ManyToOne(fetch = FetchType.EAGER)
		// @JsonIgnore
		
		private Village location;

	public long getHlt_id() {
		return hlt_id;
	}

	public void setHlt_id(long hlt_id) {
		this.hlt_id = hlt_id;
	}

	public String getHlt_name() {
		return hlt_name;
	}

	public void setHlt_name(String hlt_name) {
		this.hlt_name = hlt_name;
	}

	public String getHlt_type() {
		return hlt_type;
	}

	public void setHlt_type(String hlt_type) {
		this.hlt_type = hlt_type;
	}

	public String getHlt_service_area() {
		return hlt_service_area;
	}

	public void setHlt_service_area(String hlt_service_area) {
		this.hlt_service_area = hlt_service_area;
	}

	public int getHlt_year() {
		return hlt_year;
	}

	public void setHlt_year(int hlt_year) {
		this.hlt_year = hlt_year;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}
	
	

}
