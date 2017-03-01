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
public class Drainage implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long drain_id;

	private String drain_name;
	private int drain_year;
	private String drain_location_connected;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore
	private Village location;

	public long getDrain_id() {
		return drain_id;
	}

	public void setDrain_id(long drain_id) {
		this.drain_id = drain_id;
	}

	public String getDrain_name() {
		return drain_name;
	}

	public void setDrain_name(String drain_name) {
		this.drain_name = drain_name;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}

	public String getDrain_location_connected() {
		return drain_location_connected;
	}

	public void setDrain_location_connected(String drain_location_connected) {
		this.drain_location_connected = drain_location_connected;
	}

	public int getDrain_year() {
		return drain_year;
	}

	public void setDrain_year(int drain_year) {
		this.drain_year = drain_year;
	}

}
