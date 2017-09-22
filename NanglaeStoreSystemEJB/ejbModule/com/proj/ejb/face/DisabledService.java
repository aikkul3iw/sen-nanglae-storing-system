package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Disabled;

public interface DisabledService {
	public void save(Disabled disabled);

	public void update(Disabled disabled);

	public void delete(long id);

	public Disabled findDisabledById(long id);

	public List<Disabled> listAllDisabled();
}
