package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Population1;

public interface Population1Service {
	public void save(Population1 pop);
	public void update(Population1 pop);
	public void delete(long pop_id);
	public Population1 findPopulation1ById(long pop_id);
	public List<Population1> listAllPopulation1();

}
