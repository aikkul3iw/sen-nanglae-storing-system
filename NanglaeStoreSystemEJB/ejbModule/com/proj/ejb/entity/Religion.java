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
public class Religion implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long rel_id;

	private String rel_name;
	private String rel_type;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore
	private Village location;

	public long getRel_id() {
		return rel_id;
	}

	public void setRel_id(long rel_id) {
		this.rel_id = rel_id;
	}

	public String getRel_name() {
		return rel_name;
	}

	public void setRel_name(String rel_name) {
		this.rel_name = rel_name;
	}

	public String getRel_type() {
		return rel_type;
	}

	public void setRel_type(String rel_type) {
		this.rel_type = rel_type;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}

}
