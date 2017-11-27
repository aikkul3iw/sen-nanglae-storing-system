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
	private int grp_member;
	private String unit;

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

	public int getGrp_member() {
		return grp_member;
	}

	public void setGrp_member(int grp_member) {
		this.grp_member = grp_member;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

}
