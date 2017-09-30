package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Transport implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long tran_id;

	private String tran_name;
	private String description;
	private String type;

	public long getTran_id() {
		return tran_id;
	}

	public void setTran_id(long tran_id) {
		this.tran_id = tran_id;
	}

	public String getTran_name() {
		return tran_name;
	}

	public void setTran_name(String tran_name) {
		this.tran_name = tran_name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
