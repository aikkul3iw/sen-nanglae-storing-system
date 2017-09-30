package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class LandResource implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long land_id;

	private String land_type;
	private String land_usage;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore

	private Village location;

	public long getLand_id() {
		return land_id;
	}

	public void setLand_id(long land_id) {
		this.land_id = land_id;
	}

	public String getLand_usage() {
		return land_usage;
	}

	public void setLand_usage(String land_usage) {
		this.land_usage = land_usage;
	}

	public String getLand_type() {
		return land_type;
	}

	public void setLand_type(String land_type) {
		this.land_type = land_type;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}

}
