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
public class Pipeline implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long pipe_id;

	private int pipe_year;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore
	
	private Village location;

	private String pipe_system;
	private String pipe_use_from;

	public long getPipe_id() {
		return pipe_id;
	}

	public void setPipe_id(long pipe_id) {
		this.pipe_id = pipe_id;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}

	public String getPipe_use_from() {
		return pipe_use_from;
	}

	public void setPipe_use_from(String pipe_use_from) {
		this.pipe_use_from = pipe_use_from;
	}

	public int getPipe_year() {
		return pipe_year;
	}

	public void setPipe_year(int pipe_year) {
		this.pipe_year = pipe_year;
	}

	public String getPipe_system() {
		return pipe_system;
	}

	public void setPipe_system(String pipe_system) {
		this.pipe_system = pipe_system;
	}

}
