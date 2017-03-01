package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Water;

public interface WaterService {
	public void save(Water wt);

	public void update(Water wt);

	public void delete(long id);

	public Water findWaterById(long id);

	public List<Water> listAllWater();
}
