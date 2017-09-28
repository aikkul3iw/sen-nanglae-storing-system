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
	private String address1;
	private String address2;
	private String tel1;
	private String tel2;
	private String regisDate;
	private String donateSartDate;
	private String offspring;
	private String offspringIdCard;
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

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getTel1() {
		return tel1;
	}

	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}

	public String getTel2() {
		return tel2;
	}

	public void setTel2(String tel2) {
		this.tel2 = tel2;
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

	public String getOffspring() {
		return offspring;
	}

	public void setOffspring(String offspring) {
		this.offspring = offspring;
	}

	public String getOffspringIdCard() {
		return offspringIdCard;
	}

	public void setOffspringIdCard(String offspringIdCard) {
		this.offspringIdCard = offspringIdCard;
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
