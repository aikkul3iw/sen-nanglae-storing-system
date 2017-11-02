package com.proj.ejb.entity;

import java.io.Serializable;
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
public class User implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long user_id;

	private String username;
	private String password;
	private String role;

	// map with personnel
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore
	private Personnel location;

	@OneToMany(mappedBy = "user", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Activity> activities;

	public Personnel getLocation() {
		return location;
	}

	public void setLocation(Personnel location) {
		this.location = location;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public long getUser_id() {
		return user_id;
	}

	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
