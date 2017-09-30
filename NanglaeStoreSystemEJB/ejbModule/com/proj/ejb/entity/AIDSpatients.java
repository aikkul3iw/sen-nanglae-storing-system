package com.proj.ejb.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class AIDSpatients implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long AIDSpatientsId;

	private String title;
	private String firstName;
	private String lastName;
	private String gender;
	private int idCard;
	private Date birthday;
	private int age;
	private String address1;
	private String address2;
	private String tel;
	private Date regisDate;
	private Date allowanceSartDate;
	private String offspringTitle;
	private String offspringFirstname;
	private String offspringLastname;
	private String offspringIdCard;
	private Date allowanceEndDate;
	private String remark;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore
	private Village location;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public long getAIDSpatientsId() {
		return AIDSpatientsId;
	}

	public void setAIDSpatientsId(long aIDSpatientsId) {
		AIDSpatientsId = aIDSpatientsId;
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

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
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

	public Date getRegisDate() {
		return regisDate;
	}

	public void setRegisDate(Date regisDate) {
		this.regisDate = regisDate;
	}

	public Date getAllowanceSartDate() {
		return allowanceSartDate;
	}

	public void setAllowanceSartDate(Date allowanceSartDate) {
		this.allowanceSartDate = allowanceSartDate;
	}

	public Date getAllowanceEndDate() {
		return allowanceEndDate;
	}

	public void setAllowanceEndDate(Date allowanceEndDate) {
		this.allowanceEndDate = allowanceEndDate;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}

}
