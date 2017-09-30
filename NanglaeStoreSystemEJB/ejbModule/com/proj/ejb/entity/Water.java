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
public class Water implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long water_id;

	private String water_name;
	private String water_type;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore

	private Village location;

	public long getWater_id() {
		return water_id;
	}

	public void setWater_id(long water_id) {
		this.water_id = water_id;
	}

	public String getWater_name() {
		return water_name;
	}

	public void setWater_name(String water_name) {
		this.water_name = water_name;
	}

	public String getWater_type() {
		return water_type;
	}

	public void setWater_type(String water_type) {
		this.water_type = water_type;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}

}
