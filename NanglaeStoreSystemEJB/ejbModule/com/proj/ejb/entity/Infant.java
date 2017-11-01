package com.proj.ejb.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Infant implements Serializable{
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long inf_id;
	
	private String inf_name;
	private int inf_idCard;
	private Date inf_birthDay;
	private String inf_fatherName;
	private String inf_fatherIdCard;
	private String inf_motherName;
	private String inf_motherIdCard;
	private String inf_guardianName;
	public long getInf_id() {
		return inf_id;
	}
	public void setInf_id(long inf_id) {
		this.inf_id = inf_id;
	}
	public String getInf_name() {
		return inf_name;
	}
	public void setInf_name(String inf_name) {
		this.inf_name = inf_name;
	}
	public int getInf_idCard() {
		return inf_idCard;
	}
	public void setInf_idCard(int inf_idCard) {
		this.inf_idCard = inf_idCard;
	}
	public Date getInf_birthDay() {
		return inf_birthDay;
	}
	public void setInf_birthDay(Date inf_birthDay) {
		this.inf_birthDay = inf_birthDay;
	}
	public String getInf_fatherName() {
		return inf_fatherName;
	}
	public void setInf_fatherName(String inf_fatherName) {
		this.inf_fatherName = inf_fatherName;
	}
	public String getInf_fatherIdCard() {
		return inf_fatherIdCard;
	}
	public void setInf_fatherIdCard(String inf_fatherIdCard) {
		this.inf_fatherIdCard = inf_fatherIdCard;
	}
	public String getInf_motherName() {
		return inf_motherName;
	}
	public void setInf_motherName(String inf_motherName) {
		this.inf_motherName = inf_motherName;
	}
	public String getInf_motherIdCard() {
		return inf_motherIdCard;
	}
	public void setInf_motherIdCard(String inf_motherIdCard) {
		this.inf_motherIdCard = inf_motherIdCard;
	}
	public String getInf_guardianName() {
		return inf_guardianName;
	}
	public void setInf_guardianName(String inf_guardianName) {
		this.inf_guardianName = inf_guardianName;
	}
	
	
}
