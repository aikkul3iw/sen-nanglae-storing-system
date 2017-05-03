package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.LandResource;
import com.proj.ejb.face.LandResourceService;

@Stateless
@Remote(LandResourceService.class)
public class LandResourceServiceBean implements LandResourceService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(LandResource act) {
		// TODO Auto-generated method stub
		this.em.persist(act);
	}

	@Override
	public void update(LandResource act) {
		// TODO Auto-generated method stub
		this.em.merge(act);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		LandResource act = findLandResourceById(id);
		if (act != null) {
			em.remove(act);
		}
	}

	@Override
	public LandResource findLandResourceById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(LandResource.class, id);
	}

	@Override
	public List<LandResource> listAllLandResource() {
		// TODO Auto-generated method stub
		List<LandResource> list = em.createQuery("SELECT land FROM LandResource land ORDER BY land.land_year DESC").getResultList();
		return list;
	}

}
