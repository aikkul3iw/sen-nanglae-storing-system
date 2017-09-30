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
	private String hlt_description;

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

	public String getHlt_description() {
		return hlt_description;
	}

	public void setHlt_description(String hlt_description) {
		this.hlt_description = hlt_description;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}

}
