package com.proj.ejb.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Activity implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long atv_id;

	private String atv_data;
	private String atc_action;
	private Date atv_date;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore
	private User user;

	public long getAtv_id() {
		return atv_id;
	}

	public void setAtv_id(long atv_id) {
		this.atv_id = atv_id;
	}

	public String getAtv_data() {
		return atv_data;
	}

	public void setAtv_data(String atv_data) {
		this.atv_data = atv_data;
	}

	public String getAtc_action() {
		return atc_action;
	}

	public void setAtc_action(String atc_action) {
		this.atc_action = atc_action;
	}

	public Date getAtv_date() {
		return atv_date;
	}

	public void setAtv_date(Date atv_date) {
		this.atv_date = atv_date;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	

}
