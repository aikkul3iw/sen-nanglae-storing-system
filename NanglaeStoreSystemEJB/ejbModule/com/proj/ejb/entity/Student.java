package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Student implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long studentId;

	private int stu_year;
	private int stu_male;
	private int stu_female;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore

	private Education location;

	public long getStudentId() {
		return studentId;
	}

	public void setStudentId(long studentId) {
		this.studentId = studentId;
	}

	public int getStu_year() {
		return stu_year;
	}

	public void setStu_year(int stu_year) {
		this.stu_year = stu_year;
	}

	public int getStu_male() {
		return stu_male;
	}

	public void setStu_male(int stu_male) {
		this.stu_male = stu_male;
	}

	public int getStu_female() {
		return stu_female;
	}

	public void setStu_female(int stu_female) {
		this.stu_female = stu_female;
	}

	public Education getLocation() {
		return location;
	}

	public void setLocation(Education location) {
		this.location = location;
	}


}