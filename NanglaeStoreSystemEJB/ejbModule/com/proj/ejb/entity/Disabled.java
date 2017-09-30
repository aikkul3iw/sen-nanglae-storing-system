package com.proj.ejb.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Disabled implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long DisabledId;
	
	private String title;
	private String firstName;
	private String lastNane;
	private String gender;
	private int idCard;
	private Date birthday;
	private int age;
	private String disableType;
	private Date diableIdCardEndDate;
	private String address1;
	private String address2;
	private String tel1;
	private String tel2;
	private Date regisDate;
	private Date allowanceStartDate;
	private String offspringTitle;
	private String offspringFirstname;
	private String offspringLastname;
	private String offspringIdCard;
	private String allowanceEndDate;
	private String remark;

	public long getDisabledId() {
		return DisabledId;
	}

	public void setDisabledId(long disabledId) {
		DisabledId = disabledId;
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

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getDisableType() {
		return disableType;
	}

	public void setDisableType(String disableType) {
		this.disableType = disableType;
	}

	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastNane() {
		return lastNane;
	}

	public void setLastNane(String lastNane) {
		this.lastNane = lastNane;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public Date getDiableIdCardEndDate() {
		return diableIdCardEndDate;
	}

	public void setDiableIdCardEndDate(Date diableIdCardEndDate) {
		this.diableIdCardEndDate = diableIdCardEndDate;
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

	public Date getRegisDate() {
		return regisDate;
	}

	public void setRegisDate(Date regisDate) {
		this.regisDate = regisDate;
	}

	public Date getAllowanceStartDate() {
		return allowanceStartDate;
	}

	public void setAllowanceStartDate(Date allowanceStartDate) {
		this.allowanceStartDate = allowanceStartDate;
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
