package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Village;
import com.proj.ejb.face.VillageService;

@Stateless
@Remote(VillageService.class)
public class VillageServiceBean implements VillageService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Village vil) {
		// TODO Auto-generated method stub
		this.em.persist(vil);
	}

	@Override
	public Village findVillageById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(Village.class, id);
	}

	@Override
	public void update(Village vil) {
		// TODO Auto-generated method stub
		this.em.merge(vil);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		Village vil = findVillageById(id);
		if (vil != null) {
			em.remove(vil);
		}
	}

	@Override
	public List<Village> listAllVillage() {
		// TODO Auto-generated method stub
		List<Village> list = em.createQuery("SELECT vil FROM Village vil ORDER BY vil.vil_number").getResultList();
		return list;
	}

}
