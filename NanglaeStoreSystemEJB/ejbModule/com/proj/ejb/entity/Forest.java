package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Forest implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long frs_id;

	private String frs_type;
	private String frs_usage;

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

	public String getFrs_usage() {
		return frs_usage;
	}

	public void setFrs_usage(String frs_usage) {
		this.frs_usage = frs_usage;
	}

	public String getFrs_type() {
		return frs_type;
	}

	public void setFrs_type(String frs_type) {
		this.frs_type = frs_type;
	}

}
