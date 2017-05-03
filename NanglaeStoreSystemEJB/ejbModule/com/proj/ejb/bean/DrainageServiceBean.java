package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Drainage;
import com.proj.ejb.face.DrainageService;

@Stateless
@Remote(DrainageService.class)
public class DrainageServiceBean implements DrainageService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Drainage drn) {
		// TODO Auto-generated method stub
		this.em.persist(drn);
	}

	@Override
	public void update(Drainage drn) {
		// TODO Auto-generated method stub
		this.em.merge(drn);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		Drainage drn = findDrainageById(id);
		if (drn != null) {
			em.remove(drn);
		}
	}

	@Override
	public Drainage findDrainageById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(Drainage.class, id);
	}

	@Override
	public List<Drainage> listAllDrainage() {
		// TODO Auto-generated method stub
		List<Drainage> list = em.createQuery("SELECT drn FROM Drainage drn ORDER BY drn.drain_year DESC").getResultList();
		return list;
	}

}
