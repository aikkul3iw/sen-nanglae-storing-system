package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Polution implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long pol_id;
	
	private String pol_name;
	private String pol_effect;
	private String pol_area;
	private String pol_year;
	public long getPol_id() {
		return pol_id;
	}
	public void setPol_id(long pol_id) {
		this.pol_id = pol_id;
	}
	public String getPol_name() {
		return pol_name;
	}
	public void setPol_name(String pol_name) {
		this.pol_name = pol_name;
	}
	public String getPol_effect() {
		return pol_effect;
	}
	public void setPol_effect(String pol_effect) {
		this.pol_effect = pol_effect;
	}
	public String getPol_area() {
		return pol_area;
	}
	public void setPol_area(String pol_area) {
		this.pol_area = pol_area;
	}
	public String getPol_year() {
		return pol_year;
	}
	public void setPol_year(String pol_year) {
		this.pol_year = pol_year;
	}
	
	
}
