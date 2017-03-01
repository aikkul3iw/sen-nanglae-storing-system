package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Service implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)

	private long ser_id;

	private String ser_name;
	private String ser_capacity;
	private int ser_year;

	public long getSer_id() {
		return ser_id;
	}

	public void setSer_id(long ser_id) {
		this.ser_id = ser_id;
	}

	public String getSer_name() {
		return ser_name;
	}

	public void setSer_name(String ser_name) {
		this.ser_name = ser_name;
	}

	public String getSer_capacity() {
		return ser_capacity;
	}

	public void setSer_capacity(String ser_capacity) {
		this.ser_capacity = ser_capacity;
	}

	public int getSer_year() {
		return ser_year;
	}

	public void setSer_year(int ser_year) {
		this.ser_year = ser_year;
	}

}
