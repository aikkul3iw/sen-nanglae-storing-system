package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Electricity;

public interface ElectricityService {
	public void save(Electricity e);
	public void update(Electricity e);
	public void delete(long id);
	public Electricity findElectricityById(long id);
	public List<Electricity> listAllElectricity();
	
}
