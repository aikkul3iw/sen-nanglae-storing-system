package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class AIDSpatients implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long AIDSpatientsId;

	private String name;
	private String gender;
	private int idCard;
	private String birthday;
	private int age;
	private String houseId;
	private String address;
	private String tel;
	private String regisDate;
	private String donateSartDate;
	private String donateEndDate;
	private String remark;

	public long getAIDSpatientsId() {
		return AIDSpatientsId;
	}

	public void setAIDSpatientsId(long aIDSpatientsId) {
		AIDSpatientsId = aIDSpatientsId;
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

	public String getDonateSartDate() {
		return donateSartDate;
	}

	public void setDonateSartDate(String donateSartDate) {
		this.donateSartDate = donateSartDate;
	}

	public String getDonateEndDate() {
		return donateEndDate;
	}

	public void setDonateEndDate(String donateEndDate) {
		this.donateEndDate = donateEndDate;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
