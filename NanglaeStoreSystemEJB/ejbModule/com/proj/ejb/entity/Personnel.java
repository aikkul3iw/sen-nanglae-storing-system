package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Personnel implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long per_id;

	private String report = "Html";


	private String per_title;
	private String per_firstname;
	private String per_lastname;
	private String per_position;
	private double per_salary;
	private String per_tel_number;
	private String per_address;
	private String per_email;
	private String per_picture;
	private int per_year;

	public long getPer_id() {
		return per_id;
	}

	public void setPer_id(long per_id) {
		this.per_id = per_id;
	}

	public String getPer_title() {
		return per_title;
	}

	public void setPer_title(String per_title) {
		this.per_title = per_title;
	}

	public String getPer_firstname() {
		return per_firstname;
	}

	public void setPer_firstname(String per_firstname) {
		this.per_firstname = per_firstname;
	}

	public String getPer_lastname() {
		return per_lastname;
	}

	public void setPer_lastname(String per_lastname) {
		this.per_lastname = per_lastname;
	}

	public String getPer_position() {
		return per_position;
	}

	public void setPer_position(String per_position) {
		this.per_position = per_position;
	}

	public double getPer_salary() {
		return per_salary;
	}

	public void setPer_salary(double per_salary) {
		this.per_salary = per_salary;
	}

	public String getPer_tel_number() {
		return per_tel_number;
	}

	public void setPer_tel_number(String per_tel_number) {
		this.per_tel_number = per_tel_number;
	}

	public String getPer_address() {
		return per_address;
	}

	public void setPer_address(String per_address) {
		this.per_address = per_address;
	}

	public String getPer_email() {
		return per_email;
	}

	public void setPer_email(String per_email) {
		this.per_email = per_email;
	}

	public String getPer_picture() {
		return per_picture;
	}

	public void setPer_picture(String per_picture) {
		this.per_picture = per_picture;
	}

	public int getPer_year() {
		return per_year;
	}

	public void setPer_year(int per_year) {
		this.per_year = per_year;
	}

	public String getReport() {
		return report;
	}

	public void setReport(String report) {
		this.report = report;
	}

}
