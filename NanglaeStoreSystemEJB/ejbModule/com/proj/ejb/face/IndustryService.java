package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Industry;

public interface IndustryService {
	public void save(Industry ins);
	public void update(Industry ins);
	public void delete(long ins_id);
	public Industry findIndustryById(long ins_id);
	//public Industry findIndustryByName(int ins_name);
	public List<Industry> listAllIndustry();

}
