package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Service;

public interface ServiceService {
	public void save(Service g);
	public void update(Service g);
	public void delete(long id);
	public Service findServiceById(long id);
	public List<Service> listAllService();
	
}
