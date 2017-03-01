package com.proj.ejb.face;


import java.util.List;

import com.proj.ejb.entity.Localg;



public interface LocalgService {
	public void save(Localg g);
	public void update(Localg g);
	public void delete(long id);
	public Localg findLocalgById(long id);
	public List<Localg>listAllLocalg();
}
