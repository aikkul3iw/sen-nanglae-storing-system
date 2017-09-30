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

	private String pipe_system;
	private String pipe_description;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore

	private Village location;

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

	public String getPipe_description() {
		return pipe_description;
	}

	public void setPipe_description(String pipe_description) {
		this.pipe_description = pipe_description;
	}

	public String getPipe_system() {
		return pipe_system;
	}

	public void setPipe_system(String pipe_system) {
		this.pipe_system = pipe_system;
	}

}
