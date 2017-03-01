package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.LandResource;

public interface LandResourceService {
	public void save(LandResource land);

	public void update(LandResource land);

	public void delete(long id);

	public LandResource findLandResourceById(long id);

	public List<LandResource> listAllLandResource();
}
