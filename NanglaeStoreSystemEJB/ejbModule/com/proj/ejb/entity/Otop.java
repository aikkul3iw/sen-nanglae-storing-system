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

import org.codehaus.jackson.annotate.JsonIgnore;

@Entity
public class Otop implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long otopId;

	private String otop_name;
	private String tel;
	private double otop_price;
	private String otop_description;
	private double latitute;
	private double longitute;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore
	private Village location;

	@OneToMany(mappedBy = "tour_owner", cascade = { CascadeType.ALL })
	@JsonIgnore
	private List<Picture> picture;

	public long getOtopId() {
		return otopId;
	}

	public void setOtopId(long otopId) {
		this.otopId = otopId;
	}

	public String getOtop_name() {
		return otop_name;
	}

	public void setOtop_name(String otop_name) {
		this.otop_name = otop_name;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public double getOtop_price() {
		return otop_price;
	}

	public void setOtop_price(double otop_price) {
		this.otop_price = otop_price;
	}

	public String getOtop_description() {
		return otop_description;
	}

	public void setOtop_description(String otop_description) {
		this.otop_description = otop_description;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}

	public List<Picture> getPicture() {
		return picture;
	}

	public void setPicture(List<Picture> picture) {
		this.picture = picture;
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
