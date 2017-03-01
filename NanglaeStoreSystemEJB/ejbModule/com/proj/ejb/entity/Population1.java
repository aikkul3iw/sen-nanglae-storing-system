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
public class Population1 implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long pop_id;

	private long pop_house_amount;
	private long pop_thai_nation_m;
	private long pop_thai_nation_f;
	private long pop_chinese_nation_m;
	private long pop_chinese_nation_f;
	private long pop_other_nation_m;
	private long pop_other_nation_f;
	private long pop_elect15_m;
	private long pop_elect15_f;
	private long pop_elect18_m;
	private long pop_elect18_f;
	private long pop_elect20_m;
	private long pop_elect20_f;
	private long pop_military_select_reg;
	private long pop_military_select_join;
	private int pop_year;

	// map with village
	@ManyToOne(fetch = FetchType.EAGER)
	// @JsonIgnore
	private Village location;

	public long getPop_id() {
		return pop_id;
	}

	public void setPop_id(long pop_id) {
		this.pop_id = pop_id;
	}

	public long getPop_thai_nation_m() {
		return pop_thai_nation_m;
	}

	public void setPop_thai_nation_m(long pop_thai_nation_m) {
		this.pop_thai_nation_m = pop_thai_nation_m;
	}

	public long getPop_thai_nation_f() {
		return pop_thai_nation_f;
	}

	public void setPop_thai_nation_f(long pop_thai_nation_f) {
		this.pop_thai_nation_f = pop_thai_nation_f;
	}

	public long getPop_chinese_nation_m() {
		return pop_chinese_nation_m;
	}

	public void setPop_chinese_nation_m(long pop_chinese_nation_m) {
		this.pop_chinese_nation_m = pop_chinese_nation_m;
	}

	public long getPop_chinese_nation_f() {
		return pop_chinese_nation_f;
	}

	public void setPop_chinese_nation_f(long pop_chinese_nation_f) {
		this.pop_chinese_nation_f = pop_chinese_nation_f;
	}

	public long getPop_other_nation_m() {
		return pop_other_nation_m;
	}

	public void setPop_other_nation_m(long pop_other_nation_m) {
		this.pop_other_nation_m = pop_other_nation_m;
	}

	public long getPop_other_nation_f() {
		return pop_other_nation_f;
	}

	public void setPop_other_nation_f(long pop_other_nation_f) {
		this.pop_other_nation_f = pop_other_nation_f;
	}

	public long getPop_elect15_m() {
		return pop_elect15_m;
	}

	public void setPop_elect15_m(long pop_elect15_m) {
		this.pop_elect15_m = pop_elect15_m;
	}

	public long getPop_elect15_f() {
		return pop_elect15_f;
	}

	public void setPop_elect15_f(long pop_elect15_f) {
		this.pop_elect15_f = pop_elect15_f;
	}

	public long getPop_elect18_m() {
		return pop_elect18_m;
	}

	public void setPop_elect18_m(long pop_elect18_m) {
		this.pop_elect18_m = pop_elect18_m;
	}

	public long getPop_elect18_f() {
		return pop_elect18_f;
	}

	public void setPop_elect18_f(long pop_elect18_f) {
		this.pop_elect18_f = pop_elect18_f;
	}

	public long getPop_elect20_m() {
		return pop_elect20_m;
	}

	public void setPop_elect20_m(long pop_elect20_m) {
		this.pop_elect20_m = pop_elect20_m;
	}

	public long getPop_elect20_f() {
		return pop_elect20_f;
	}

	public void setPop_elect20_f(long pop_elect20_f) {
		this.pop_elect20_f = pop_elect20_f;
	}

	public long getPop_military_select_reg() {
		return pop_military_select_reg;
	}

	public void setPop_military_select_reg(long pop_military_select_reg) {
		this.pop_military_select_reg = pop_military_select_reg;
	}

	public long getPop_military_select_join() {
		return pop_military_select_join;
	}

	public void setPop_military_select_join(long pop_military_select_join) {
		this.pop_military_select_join = pop_military_select_join;
	}

	public Village getLocation() {
		return location;
	}

	public void setLocation(Village location) {
		this.location = location;
	}

	public int getPop_year() {
		return pop_year;
	}

	public void setPop_year(int pop_year) {
		this.pop_year = pop_year;
	}

	public long getPop_house_amount() {
		return pop_house_amount;
	}

	public void setPop_house_amount(long pop_house_amount) {
		this.pop_house_amount = pop_house_amount;
	}

}
