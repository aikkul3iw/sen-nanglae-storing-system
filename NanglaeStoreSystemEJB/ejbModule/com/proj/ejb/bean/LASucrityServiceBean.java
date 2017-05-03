package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Localg;
import com.proj.ejb.entity.LASucrity;
import com.proj.ejb.face.LocalgService;
import com.proj.ejb.face.LASucrityService;

@Stateless
@Remote(LASucrityService.class)

public class LASucrityServiceBean implements LASucrityService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(LASucrity l) {
		this.em.persist(l);
	}

	@Override
	public void update(LASucrity l) {
		this.em.merge(l);
	}

	@Override
	public void delete(long id) {
		LASucrity l = findLASucrityById(id);
		if (l != null) {
			em.remove(l);
		}
	}

	@Override
	public LASucrity findLASucrityById(long id) {
		return this.em.find(LASucrity.class, id);
	}

	@Override
	public List<LASucrity> listAllLASucrity() {
		List<LASucrity> list = em.createQuery("SELECT g FROM LASucrity g ORDER BY g.sec_year DESC").getResultList();
		return list;
	}
}
