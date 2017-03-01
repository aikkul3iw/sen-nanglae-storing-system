package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Resource implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)

	private long rsc_id;

	private String rsc_name;
	private String rsc_type;
	private String rsc_multi_type;
	private String rsc_description;
	private int rsc_year;

	public long getRsc_id() {
		return rsc_id;
	}

	public void setRsc_id(long rsc_id) {
		this.rsc_id = rsc_id;
	}

	public String getRsc_name() {
		return rsc_name;
	}

	public void setRsc_name(String rsc_name) {
		this.rsc_name = rsc_name;
	}

	public String getRsc_type() {
		return rsc_type;
	}

	public void setRsc_type(String rsc_type) {
		this.rsc_type = rsc_type;
	}

	public String getRsc_multi_type() {
		return rsc_multi_type;
	}

	public void setRsc_multi_type(String rsc_multi_type) {
		this.rsc_multi_type = rsc_multi_type;
	}

	public String getRsc_description() {
		return rsc_description;
	}

	public void setRsc_description(String rsc_description) {
		this.rsc_description = rsc_description;
	}

	public int getRsc_year() {
		return rsc_year;
	}

	public void setRsc_year(int rsc_year) {
		this.rsc_year = rsc_year;
	}

}
