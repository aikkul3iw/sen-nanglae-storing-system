package com.proj.ejb.face;

import java.util.List;
import com.proj.ejb.entity.Resource;

public interface ResourceService {

	public void save(Resource r);

	public void update(Resource r);

	public void delete(long id);

	public Resource findResourceById(long id);

	public List<Resource> listAllResource();

}
