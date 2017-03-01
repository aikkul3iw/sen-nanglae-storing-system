package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Tourism;

public interface TourismService {
	public void save(Tourism tour);
	public void update(Tourism tour);
	public void delete(long tour_id);
	public Tourism findTourismById(long tour_id);
	public List<Tourism> listAllTourism();

}
