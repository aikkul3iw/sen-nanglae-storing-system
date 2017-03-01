package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Forest;

public interface ForestService {
	public void save(Forest frs);
	public void update(Forest frs);
	public void delete(long frs_id);
	public Forest findForestById(long frs_id);
	//public Education findEducationByName(int edu_name);
	public List<Forest> listAllForest();

}
