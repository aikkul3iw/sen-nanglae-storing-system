package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.LASucrity;

public interface LASucrityService {
	public void save(LASucrity l);
	public void update(LASucrity l);
	public void delete(long id);
	public LASucrity findLASucrityById(long id);
	public List<LASucrity> listAllLASucrity();
	
	
}
