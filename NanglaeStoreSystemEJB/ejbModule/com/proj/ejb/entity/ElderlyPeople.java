package com.proj.ejb.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import org.codehaus.jackson.annotate.JsonIgnore;

@Entity
public class ElderlyPeople implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long elderPeId;

	private String titles;
	private String firstName;
	private String lastName;
	private String gender;
	private String idCard;
	private String birthday;
	private String age;
	private String address1;
	private String address2;
	private String tel;
	private String regisDate;
	private String allowanceStartDate;
	private String offspringTitle;
	private String offspringFirstname;
	private String offspringLastname;
	private String offspringIdCard;
	private String allowanceEndDate;
	private String remark;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)

	public long getElderPeId() {
		return elderPeId;
	}

	public void setElderPeId(long elderPeId) {
		this.elderPeId = elderPeId;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getTitles() {
		return titles;
	}

	public void setTitles(String titles) {
		this.titles = titles;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
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

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getOffspringTitle() {
		return offspringTitle;
	}

	public void setOffspringTitle(String offspringTitle) {
		this.offspringTitle = offspringTitle;
	}

	public String getOffspringFirstname() {
		return offspringFirstname;
	}

	public void setOffspringFirstname(String offspringFirstname) {
		this.offspringFirstname = offspringFirstname;
	}

	public String getOffspringLastname() {
		return offspringLastname;
	}

	public void setOffspringLastname(String offspringLastname) {
		this.offspringLastname = offspringLastname;
	}

	public String getOffspringIdCard() {
		return offspringIdCard;
	}

	public void setOffspringIdCard(String offspringIdCard) {
		this.offspringIdCard = offspringIdCard;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
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

	public String getAllowanceEndDate() {
		return allowanceEndDate;
	}

	public void setAllowanceEndDate(String allowanceEndDate) {
		this.allowanceEndDate = allowanceEndDate;
	}
	

}
