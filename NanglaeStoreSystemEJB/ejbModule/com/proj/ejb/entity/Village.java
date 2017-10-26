package com.proj.ejb.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.codehaus.jackson.annotate.JsonIgnore;

@Entity
public class Village implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long vil_id;

	private int vil_number;
	private String vil_name;
	private String vil_chief;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Agriculture> agricultures;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<AIDSpatients> AIDSpatients;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	@JsonIgnore
	private List<Disabled> disableds;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<ElderlyPeople> elderlyPeoples;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<LandResource> landResources;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Otop> otops;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Restaurant> restaurants;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Commerce> commerces;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Drainage> drainages;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Pipeline> pipelines;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Water> waters;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Education> educations;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Electricity> electricitys;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Industry> industrys;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Population1> population1s;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Religion> religions;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Tourism> tourisms;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Health> health;

	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Forest> forest;

	public long getVil_id() {
		return vil_id;
	}

	public void setVil_id(long vil_id) {
		this.vil_id = vil_id;
	}

	public int getVil_number() {
		return vil_number;
	}

	public void setVil_number(int vil_number) {
		this.vil_number = vil_number;
	}

	public String getVil_name() {
		return vil_name;
	}

	public void setVil_name(String vil_name) {
		this.vil_name = vil_name;
	}

	public String getVil_chief() {
		return vil_chief;
	}

	public void setVil_chief(String vil_chief) {
		this.vil_chief = vil_chief;
	}
}
