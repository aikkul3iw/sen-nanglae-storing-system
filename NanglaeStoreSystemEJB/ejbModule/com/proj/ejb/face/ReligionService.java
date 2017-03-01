package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Religion;

public interface ReligionService {
	public void save(Religion rel);
	public void update(Religion rel);
	public void delete(long rel_id);
	public Religion findReligionById(long rel_id);
	public List<Religion> listAllReligion();

}
