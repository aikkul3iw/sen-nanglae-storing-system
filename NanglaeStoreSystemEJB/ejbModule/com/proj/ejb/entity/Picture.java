package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Picture implements Serializable{
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long pic_id;
	private String pic_name;
	
	@ManyToOne(fetch = FetchType.EAGER)
	private Tourism tour_owner;

	public long getPic_id() {
		return pic_id;
	}

	public void setPic_id(long pic_id) {
		this.pic_id = pic_id;
	}

	public String getPic_name() {
		return pic_name;
	}

	public void setPic_name(String pic_name) {
		this.pic_name = pic_name;
	}

	public Tourism getTour_owner() {
		return tour_owner;
	}

	public void setTour_owner(Tourism tour_owner) {
		this.tour_owner = tour_owner;
	}


	

}
