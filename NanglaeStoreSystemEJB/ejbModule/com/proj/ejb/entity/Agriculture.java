package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Agriculture implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long agi_id;

	private String agi_name;
	private double agi_area;
	private String agi_description;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore
	private Village location;

	public long getAgi_id() {
		return agi_id;
	}

	public void setAgi_id(long agi_id) {
		this.agi_id = agi_id;
	}

	public String getAgi_name() {
		return agi_name;
	}

	public void setAgi_name(String agi_name) {
		this.agi_name = agi_name;
	}

	public double getAgi_area() {
		return agi_area;
	}

	public void setAgi_area(double agi_area) {
		this.agi_area = agi_area;
	}

	public String getAgi_description() {
		return agi_description;
	}

	public void setAgi_description(String agi_description) {
		this.agi_description = agi_description;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}

}
