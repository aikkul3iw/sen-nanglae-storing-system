package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Restaurant implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long restaurantId;

	private String res_name;
	private String res_menu;
	private double latitute;
	private double longitute;
	private String houseId;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore
	private Village location;

	public long getRestaurantId() {
		return restaurantId;
	}

	public void setRestaurantId(long restaurantId) {
		this.restaurantId = restaurantId;
	}

	public String getRes_name() {
		return res_name;
	}

	public void setRes_name(String res_name) {
		this.res_name = res_name;
	}

	public String getRes_menu() {
		return res_menu;
	}

	public void setRes_menu(String res_menu) {
		this.res_menu = res_menu;
	}

	public double getLatitute() {
		return latitute;
	}

	public void setLatitute(double latitute) {
		this.latitute = latitute;
	}

	public double getLongitute() {
		return longitute;
	}

	public void setLongitute(double longitute) {
		this.longitute = longitute;
	}

	public String getHouseId() {
		return houseId;
	}

	public void setHouseId(String houseId) {
		this.houseId = houseId;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}

}
