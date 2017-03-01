package com.proj.ejb.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Inventory implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long ivn_id;

	private int ivn_year;
	private double ivn_collect;
	private double ivn_gov_provide;
	private double ivn_gor_purchase;
	private double inv_outcome;

	public long getIvn_id() {
		return ivn_id;
	}

	public void setIvn_id(long ivn_id) {
		this.ivn_id = ivn_id;
	}

	public int getIvn_year() {
		return ivn_year;
	}

	public void setIvn_year(int ivn_year) {
		this.ivn_year = ivn_year;
	}

	public double getIvn_collect() {
		return ivn_collect;
	}

	public void setIvn_collect(double ivn_collect) {
		this.ivn_collect = ivn_collect;
	}

	public double getIvn_gov_provide() {
		return ivn_gov_provide;
	}

	public void setIvn_gov_provide(double ivn_gov_provide) {
		this.ivn_gov_provide = ivn_gov_provide;
	}

	public double getIvn_gor_purchase() {
		return ivn_gor_purchase;
	}

	public void setIvn_gor_purchase(double ivn_gor_purchase) {
		this.ivn_gor_purchase = ivn_gor_purchase;
	}

	public double getInv_outcome() {
		return inv_outcome;
	}

	public void setInv_outcome(double inv_outcome) {
		this.inv_outcome = inv_outcome;
	}

}
