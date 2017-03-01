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
public class Industry implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long ins_id;

	private String ins_name;
	private String ins_size;
	private String ins_type;
	private int ins_labor;
	private int ins_year;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore
	
	private Village location;

	public long getIns_id() {
		return ins_id;
	}

	public void setIns_id(long ins_id) {
		this.ins_id = ins_id;
	}

	public String getIns_name() {
		return ins_name;
	}

	public void setIns_name(String ins_name) {
		this.ins_name = ins_name;
	}

	public String getIns_size() {
		return ins_size;
	}

	public void setIns_size(String ins_size) {
		this.ins_size = ins_size;
	}

	public int getIns_labor() {
		return ins_labor;
	}

	public void setIns_labor(int ins_labor) {
		this.ins_labor = ins_labor;
	}

	public String getIns_type() {
		return ins_type;
	}

	public void setIns_type(String ins_type) {
		this.ins_type = ins_type;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}

	public int getIns_year() {
		return ins_year;
	}

	public void setIns_year(int ins_year) {
		this.ins_year = ins_year;
	}

}
