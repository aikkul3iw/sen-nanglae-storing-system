package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Agriculture;

public interface AgricultureService {
	public void save(Agriculture act);

	public void update(Agriculture act);

	public void delete(long id);

	public Agriculture findAgricultureById(long id);

	public List<Agriculture> listAllAgriculture();
}
