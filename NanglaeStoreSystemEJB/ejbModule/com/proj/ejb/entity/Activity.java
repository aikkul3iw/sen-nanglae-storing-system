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
	private String atv_action;
	private String atv_date;
	private String atv_old;
	private String atv_new;

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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getAtv_old() {
		return atv_old;
	}

	public void setAtv_old(String atv_old) {
		this.atv_old = atv_old;
	}

	public String getAtv_new() {
		return atv_new;
	}

	public void setAtv_new(String atv_new) {
		this.atv_new = atv_new;
	}

	public String getAtv_action() {
		return atv_action;
	}

	public void setAtv_action(String atv_action) {
		this.atv_action = atv_action;
	}

	public String getAtv_date() {
		return atv_date;
	}

	public void setAtv_date(String atv_date) {
		this.atv_date = atv_date;
	}
	
	

}
