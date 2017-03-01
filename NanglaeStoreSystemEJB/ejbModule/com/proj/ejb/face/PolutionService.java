package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Polution;

public interface PolutionService {
	public void save(Polution pol);

	public void update(Polution pol);

	public void delete(long id);

	public Polution findPolutionById(long id);

	public List<Polution> listAllPolution();
}
