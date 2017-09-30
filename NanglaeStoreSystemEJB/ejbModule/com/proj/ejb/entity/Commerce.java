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
public class Commerce implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long com_id;

	private String com_name;
	private String com_type;
	private String com_house_number;
	private String com_description;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore
	private Village location;

	public long getCom_id() {
		return com_id;
	}

	public void setCom_id(long com_id) {
		this.com_id = com_id;
	}

	public String getCom_name() {
		return com_name;
	}

	public void setCom_name(String com_name) {
		this.com_name = com_name;
	}

	public String getCom_type() {
		return com_type;
	}

	public void setCom_type(String com_type) {
		this.com_type = com_type;
	}

	public String getCom_house_number() {
		return com_house_number;
	}

	public void setCom_house_number(String com_house_number) {
		this.com_house_number = com_house_number;
	}

	public String getCom_description() {
		return com_description;
	}

	public void setCom_description(String com_description) {
		this.com_description = com_description;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}

}
