package com.proj.ejb.face;

import java.util.List;
import com.proj.ejb.entity.Village;

public interface VillageService {
	public void save(Village vil);

	public Village findVillageById(long id);

	public void update(Village vil);

	public void delete(long id);

	public List<Village> listAllVillage();
}
