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
	private String sec_member;
	private int sec_year;

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

	public String getSec_member() {
		return sec_member;
	}

	public void setSec_member(String sec_member) {
		this.sec_member = sec_member;
	}

	public int getSec_year() {
		return sec_year;
	}

	public void setSec_year(int sec_year) {
		this.sec_year = sec_year;
	}

}
