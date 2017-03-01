package com.proj.ejb.face;

import java.util.List;
import com.proj.ejb.entity.Personnel;

public interface PersonnelService {
	public void save(Personnel psn);

	public Personnel findPersonnelById(long id);

	public void update(Personnel psn);

	public void delete(long id);

	public List<Personnel> listAllPersonnel();
}
