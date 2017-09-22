package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class ElderlyPeople implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long elderPeId;

	private String name;
	private String gender;
	private int idCard;
	private String birthday;
	private int age;
	private String houseId;
	private String address;
	private String tel;
	private String regisDate;
	private String allowanceStartDate;
	private String descendant;
	private String allowanceEndDate;
	private String remark;

	public long getElderPeId() {
		return elderPeId;
	}

	public void setElderPeId(long elderPeId) {
		this.elderPeId = elderPeId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getIdCard() {
		return idCard;
	}

	public void setIdCard(int idCard) {
		this.idCard = idCard;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getHouseId() {
		return houseId;
	}

	public void setHouseId(String houseId) {
		this.houseId = houseId;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getRegisDate() {
		return regisDate;
	}

	public void setRegisDate(String regisDate) {
		this.regisDate = regisDate;
	}

	public String getAllowanceStartDate() {
		return allowanceStartDate;
	}

	public void setAllowanceStartDate(String allowanceStartDate) {
		this.allowanceStartDate = allowanceStartDate;
	}

	public String getDescendant() {
		return descendant;
	}

	public void setDescendant(String descendant) {
		this.descendant = descendant;
	}

	public String getAllowanceEndDate() {
		return allowanceEndDate;
	}

	public void setAllowanceEndDate(String allowanceEndDate) {
		this.allowanceEndDate = allowanceEndDate;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
