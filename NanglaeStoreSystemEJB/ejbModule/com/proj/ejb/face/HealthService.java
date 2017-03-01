package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Health;

public interface HealthService {
	public void save(Health hlt);
	public void update(Health hlt);
	public void delete(long hlt_id);
	public Health findHealthById(long hlt_id);
	//public Health findHealthByName(int hlt_name);
	public List<Health> listAllHealth();

}
