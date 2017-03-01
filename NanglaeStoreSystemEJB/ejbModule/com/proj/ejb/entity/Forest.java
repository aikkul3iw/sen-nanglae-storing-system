package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Forest implements Serializable{

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long frs_id;

	private String frs_name;
	private String frs_usage;
	private int frs_year;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore
	private Village location;

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}

	public long getFrs_id() {
		return frs_id;
	}

	public void setFrs_id(long frs_id) {
		this.frs_id = frs_id;
	}

	public String getFrs_name() {
		return frs_name;
	}

	public void setFrs_name(String frs_name) {
		this.frs_name = frs_name;
	}

	public String getFrs_usage() {
		return frs_usage;
	}

	public void setFrs_usage(String frs_usage) {
		this.frs_usage = frs_usage;
	}

	public int getFrs_year() {
		return frs_year;
	}

	public void setFrs_year(int frs_year) {
		this.frs_year = frs_year;
	}

}
