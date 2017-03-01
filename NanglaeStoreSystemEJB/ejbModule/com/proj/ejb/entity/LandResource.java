package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class LandResource implements Serializable{
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long land_id;
	
	private String land_name;
	private String land_usage;
	private int land_year;
	
	public long getLand_id() {
		return land_id;
	}
	public void setLand_id(long land_id) {
		this.land_id = land_id;
	}
	public String getLand_name() {
		return land_name;
	}
	public void setLand_name(String land_name) {
		this.land_name = land_name;
	}
	public String getLand_usage() {
		return land_usage;
	}
	public void setLand_usage(String land_usage) {
		this.land_usage = land_usage;
	}
	public int getLand_year() {
		return land_year;
	}
	public void setLand_year(int land_year) {
		this.land_year = land_year;
	}
	
	
}
