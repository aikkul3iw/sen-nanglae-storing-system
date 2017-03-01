package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import org.codehaus.jackson.annotate.JsonIgnore;

@Entity
public class Education implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long edu_id;

	private String edu_name;
	private String edu_type;
	private int student;
	private int edu_year;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore
	
	private Village location;

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

	public int getEdu_year() {
		return edu_year;
	}

	public void setEdu_year(int edu_year) {
		this.edu_year = edu_year;
	}

	public int getStudent() {
		return student;
	}

	public void setStudent(int student) {
		this.student = student;
	}
	
}
