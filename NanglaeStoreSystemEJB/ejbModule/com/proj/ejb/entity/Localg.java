package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Localg implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long grp_id;

	private String grp_name;
	private String grp_member;
	private String grp_area;
	private int grp_year;

	public long getGrp_id() {
		return grp_id;
	}

	public void setGrp_id(long grp_id) {
		this.grp_id = grp_id;
	}

	public String getGrp_name() {
		return grp_name;
	}

	public void setGrp_name(String grp_name) {
		this.grp_name = grp_name;
	}

	public String getGrp_member() {
		return grp_member;
	}

	public void setGrp_member(String grp_member) {
		this.grp_member = grp_member;
	}

	public String getGrp_area() {
		return grp_area;
	}

	public void setGrp_area(String grp_area) {
		this.grp_area = grp_area;
	}

	public int getGrp_year() {
		return grp_year;
	}

	public void setGrp_year(int grp_year) {
		this.grp_year = grp_year;
	}

}
