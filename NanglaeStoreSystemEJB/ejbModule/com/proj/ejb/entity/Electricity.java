package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import org.codehaus.jackson.annotate.JsonIgnore;

@Entity
public class Electricity implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long elec_id;

	private String elec_area;
	private int elec_year;
	private String elec_status;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore

	private Village location;

	public long getElec_id() {
		return elec_id;
	}

	public void setElec_id(long elec_id) {
		this.elec_id = elec_id;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}

	public String getElec_area() {
		return elec_area;
	}

	public void setElec_area(String elec_area) {
		this.elec_area = elec_area;
	}

	public int getElec_year() {
		return elec_year;
	}

	public void setElec_year(int elec_year) {
		this.elec_year = elec_year;
	}

	public String getElec_status() {
		return elec_status;
	}

	public void setElec_status(String elec_status) {
		this.elec_status = elec_status;
	}

}
