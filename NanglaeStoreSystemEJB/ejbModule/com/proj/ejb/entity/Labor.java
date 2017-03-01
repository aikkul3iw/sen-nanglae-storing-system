package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Labor implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long lab_id;

	private String lab_type;
	private String lab_work;
	private int lab_amount;
	private int lab_year;

	public long getLab_id() {
		return lab_id;
	}

	public void setLab_id(long lab_id) {
		this.lab_id = lab_id;
	}

	public String getLab_type() {
		return lab_type;
	}

	public void setLab_type(String lab_type) {
		this.lab_type = lab_type;
	}

	public int getLab_amount() {
		return lab_amount;
	}

	public void setLab_amount(int lab_amount) {
		this.lab_amount = lab_amount;
	}

	public int getLab_year() {
		return lab_year;
	}

	public void setLab_year(int lab_year) {
		this.lab_year = lab_year;
	}

	public String getLab_work() {
		return lab_work;
	}

	public void setLab_work(String lab_work) {
		this.lab_work = lab_work;
	}

}
