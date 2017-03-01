package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Drainage;

public interface DrainageService {
	public void save(Drainage drn);

	public void update(Drainage drn);

	public void delete(long id);

	public Drainage findDrainageById(long id);

	public List<Drainage> listAllDrainage();
}
