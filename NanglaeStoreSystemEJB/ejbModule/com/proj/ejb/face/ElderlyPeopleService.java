package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.ElderlyPeople;

public interface ElderlyPeopleService {
	public void save(ElderlyPeople elder);

	public void update(ElderlyPeople elder);

	public void delete(long id);

	public ElderlyPeople findElderlyPeopleById(long id);

	public List<ElderlyPeople> listAllElderlyPeople();
}
