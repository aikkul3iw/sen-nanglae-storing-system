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
	private String drain_description;

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

	public String getDrain_description() {
		return drain_description;
	}

	public void setDrain_description(String drain_description) {
		this.drain_description = drain_description;
	}

}
