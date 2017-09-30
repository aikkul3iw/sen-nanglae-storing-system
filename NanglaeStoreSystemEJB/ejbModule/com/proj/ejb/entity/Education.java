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
public class Education implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long edu_id;

	private String edu_name;
	private String edu_type;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore

	private Village location;
	
	@OneToMany(mappedBy = "location", cascade = { CascadeType.ALL })
	// @JsonIgnore
	private List<Student> students;

	public long getEdu_id() {
		return edu_id;
	}

	public void setEdu_id(long edu_id) {
		this.edu_id = edu_id;
	}

	public String getEdu_name() {
		return edu_name;
	}

	public void setEdu_name(String edu_name) {
		this.edu_name = edu_name;
	}

	public String getEdu_type() {
		return edu_type;
	}

	public void setEdu_type(String edu_type) {
		this.edu_type = edu_type;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}

}
