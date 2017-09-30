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
	private String grp_descripton;
	private String grp_unit;

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

	public String getGrp_descripton() {
		return grp_descripton;
	}

	public void setGrp_descripton(String grp_descripton) {
		this.grp_descripton = grp_descripton;
	}

	public String getGrp_unit() {
		return grp_unit;
	}

	public void setGrp_unit(String grp_unit) {
		this.grp_unit = grp_unit;
	}

}
