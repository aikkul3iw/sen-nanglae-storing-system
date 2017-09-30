package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class LASucrity implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long sec_id;

	private String sec_name;
	private int sec_member;
	private String sec_unit;

	public long getSec_id() {
		return sec_id;
	}

	public void setSec_id(long sec_id) {
		this.sec_id = sec_id;
	}

	public String getSec_name() {
		return sec_name;
	}

	public void setSec_name(String sec_name) {
		this.sec_name = sec_name;
	}

	public int getSec_member() {
		return sec_member;
	}

	public void setSec_member(int sec_member) {
		this.sec_member = sec_member;
	}

	public String getSec_unit() {
		return sec_unit;
	}

	public void setSec_unit(String sec_unit) {
		this.sec_unit = sec_unit;
	}

}
