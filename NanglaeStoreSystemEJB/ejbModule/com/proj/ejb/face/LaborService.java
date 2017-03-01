package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Labor;

public interface LaborService {
	public void save(Labor lab);
	public void update(Labor lab);
	public void delete(long lab_id);
	public Labor findLaborById(long lab_id);
	public List<Labor> listAllLabor();

}
