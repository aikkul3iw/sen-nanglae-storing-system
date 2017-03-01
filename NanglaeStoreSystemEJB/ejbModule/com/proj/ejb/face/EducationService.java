package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Education;

public interface EducationService {
	public void save(Education edu);
	public void update(Education edu);
	public void delete(long edu_id);
	public Education findEducationById(long edu_id);
	//public Education findEducationByName(int edu_name);
	public List<Education> listAllEducation();

}
