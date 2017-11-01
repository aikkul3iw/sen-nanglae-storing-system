package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Infant;

public interface InfantService {
	public void save(Infant ins);
	public void update(Infant ins);
	public void delete(long ins_id);
	public Infant findInfantById(long ins_id);
	public List<Infant> listAllInfant();
}
