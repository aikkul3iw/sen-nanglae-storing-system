package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Tourism implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long tour_id;

	private String tour_name;
	private String tour_description;
	private int tour_year;
	private double latitute;
	private double longitute;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore
	private Village location;

	public long getTour_id() {
		return tour_id;
	}

	public void setTour_id(long tour_id) {
		this.tour_id = tour_id;
	}

	public String getTour_name() {
		return tour_name;
	}

	public void setTour_name(String tour_name) {
		this.tour_name = tour_name;
	}

	public String getTour_description() {
		return tour_description;
	}

	public void setTour_description(String tour_description) {
		this.tour_description = tour_description;
	}

	public int getTour_year() {
		return tour_year;
	}

	public void setTour_year(int tour_year) {
		this.tour_year = tour_year;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
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

}
